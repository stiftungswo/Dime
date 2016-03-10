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
	 * Get a list of Period entities.
	 *
	 * @param array $params The Parameters from the ParamFetcherInterface
	 *
	 * @return array
	 */
	public function all($params = array())
	{
		$periods = parent::all($params);
		$periods = $this->setTimeTillToday($periods);

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
		$periods = $this->setTimeTillToday(array($period));

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
		$periods = $this->setTimeTillToday(array($period));

		return $periods[0];
	}

	/**
	 * Add time till today Period entities.
	 *
	 * @param array $periods
	 * @return array
	 */
	private function setTimeTillToday(array $periods){
		//get holiday repository
		$holidayEntityClass = 'Dime\EmployeeBundle\Entity\Holiday';
		$holidayAlias = 'h';
		$holidayRepository = $this->getRepositoryFromEntity($holidayEntityClass, $holidayAlias);

		//get holidays
		$holidays = $holidayRepository->getCurrentQueryBuilder()->getQuery()->getResult();

		//set time till today
		for ($i = 0; $i < count($periods); $i++) {
			$period = $periods[$i];

			if($period->getPensum() && $period->getStart() instanceof Carbon ) {
				$dateToday = Carbon::today();

				//if date today is older than end date, use end date
				if ($dateToday > $period->getEnd()) {
					$dateToday = $period->getEnd();
				}

				$holidaysTillToday = 0;

				// get all holiday duration between period start date and date today
				foreach($holidays as $holiday){
					if($holiday->getDate() <= $dateToday && $holiday->getDate() >= $period->getStart()){
						$holidaysTillToday += $holiday->getDuration();
					}
				}

				$weekdays = ($period->getStart()->diffInWeekdays($dateToday->addDay()));
				$seconds = $weekdays * RateUnitType::$DayInSeconds;

				$realTime = $period->getRealTime();
				$targetTime = ($seconds - $holidaysTillToday) * $period->getPensum();

				$period->setTimeTillToday($realTime - $targetTime);
			}

			$periods[$i] = $period;
		}

		return $periods;
	}
}