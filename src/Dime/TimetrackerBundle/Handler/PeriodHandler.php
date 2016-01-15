<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\TimetrackEvents;
use Doctrine\Common\Persistence\ObjectManager;
use FOS\UserBundle\Model\UserInterface;
use FOS\UserBundle\Model\UserManager;
use Symfony\Component\DependencyInjection\Container;
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
     * Get a list of Holiday entities.
     *
     * @param array $params The Parameters from the ParamFetcherInterface
     *
     * @return array
     */
    public function all($params = array())
    {
        $this->repository->createCurrentQueryBuilder($this->alias);

        // Filter
        if ($this->hasParams($params)) {
            $this->repository->filter($this->cleanParameterBag($params, false));
        }

        //Add Ordering
        $this->orderBy('id', 'ASC');
        $this->orderBy('updatedAt', 'ASC');

        $periods = $this->repository->getCurrentQueryBuilder()->getQuery()->getResult();

        //get holiday repository
        $holidayEntityClass = 'Dime\EmployeeBundle\Entity\Holiday';
        $holidayAlias = 'h';
        $holidayRepository = $this->getRepositoryFromEntity($holidayEntityClass, $holidayAlias);

        $holidays = $holidayRepository->getCurrentQueryBuilder()->getQuery()->getResult();

        //set time till today
        for ($i = 0; $i < count($periods); $i++) {
            $period = $periods[$i];

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
                $realTime = $period->getRealTime();
                $seconds = $weekdays * RateUnitType::$DayInSeconds;

                $period->setTimeTillToday(($realTime - ($seconds * $period->getPensum()) + $holidaysTillToday));
            }

            $periods[$i] = $period;
        }

        // Pagination
        return $periods;
    }
}
