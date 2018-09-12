<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\EmployeeBundle\Entity\Holiday;
use Dime\EmployeeBundle\Entity\Period;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Carbon\Carbon;

class PeriodHandler extends GenericHandler
{
    /**
     * Get a list of all taken holiday between start and end date.
     *
     * @param $date start and end date
     * @param $employeeId id of employeee
     *
     * @return array
     */
    public function allTakenHolidays($date, $employeeId)
    {
        return  $this->repository->findAllTakenHolidays($date, $employeeId);
    }

    /**
     * Get a list of Period entities.
     *
     * @param array $params The Parameters from the ParamFetcherInterface
     *
     * @return array
     */
    public function all($params = array())
    {
        $periods = parent::all($params);
        $periods = $this->calculateTimesAndHolidays($periods);

        return $periods;
    }

    /**
     * Post Period entity, creates a new Period entity.
     *
     * @param array $parameters
     *
     * @return DimeEntityInterface
     *
     */
    public function post(array $parameters)
    {
        $period = parent::post($parameters);
        $periods = $this->calculateTimesAndHolidays(array($period));

        return $periods[0];
    }


    /**
     * Replace data of a Period entity.
     *
     * @param DimeEntityInterface $entity
     * @param array               $parameters
     *
     * @return DimeEntityInterface
     */
    public function put(DimeEntityInterface $entity, array $parameters)
    {
        $period = parent::put($entity, $parameters);
        $periods = $this->calculateTimesAndHolidays(array($period));

        return $periods[0];
    }

    /**
     * Takes an array of periods and passes it to the calculation of used holidays and theoretical work time until today
     *
     * @param array $periods
     * @return array
     */
    private function calculateTimesAndHolidays(array $periods)
    {
        // prefetch the holidays to not do it for each request
        $holidayEntityClass = 'Dime\EmployeeBundle\Entity\Holiday';
        $holidayAlias = 'h';
        $holidayRepository = $this->getRepositoryFromEntity($holidayEntityClass, $holidayAlias);

        // get holidays
        /** @var Holiday[] $holidays */
        $holidays = $holidayRepository->getCurrentQueryBuilder()->getQuery()->getResult();

        for ($i = 0; $i < count($periods); $i++) {
            $period = $periods[$i];
            $period = $this->setTimeTillToday($period, $holidays);
            $periods[$i] = $this->setHolidayBalance($period);
        }

        return $periods;
    }

    /**
     * Add time till today Period entities.
     *
     * @param Period $period
     * @param array $holidays
     * @return Period
     */
    private function setTimeTillToday(Period $period, array $holidays)
    {
        if ($period->getPensum() && $period->getStart() instanceof Carbon) {
            $dateToday = Carbon::today();

            //if date today is older than end date, use end date
            if ($dateToday > $period->getEnd()) {
                $dateToday = $period->getEnd();
            }

            $holidaysTillToday = 0;

            // get all holiday duration between period start date and date today
            foreach ($holidays as $holiday) {
                if ($holiday->getDate() <= $dateToday && $holiday->getDate() >= $period->getStart()) {
                    $holidaysTillToday += $holiday->getDuration();
                }
            }

            $weekdays = ($period->getStart()->diffInWeekdays($dateToday->addDay()));
            $seconds = $weekdays * RateUnitType::$DayInSeconds;

            $realTime = $period->getRealTime();
            $targetTime = ($seconds - $holidaysTillToday) * $period->getPensum();

            $period->setTimeTillToday($realTime - $targetTime);
        }

        return $period;
    }

    /**
     * Sets the balance of vacations based on the vacation budget and already booked vacations
     *
     * @param Period $period
     * @return Period
     */
    private function setHolidayBalance(Period $period)
    {
        $this->repository->createCurrentQueryBuilder($this->alias);

        // returns its result in seconds
        $taken_holidays = $this->repository
            ->findAllTakenHolidays(
                $period->getStart()->toDateString() . ',' . $period->getEnd()->toDateString(),
                $period->getEmployee()->getId()
            );

        $taken_holiday_value = array_sum(array_column($taken_holidays, 'value'));
        $holiday_balance = $period->getPeriodVacationBudget() - $taken_holiday_value;
        $period->setHolidayBalance($holiday_balance);

        return $period;
    }
}
