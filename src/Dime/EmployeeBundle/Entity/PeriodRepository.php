<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;


use Carbon\Carbon;
use Dime\TimetrackerBundle\Entity\EntityRepository;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Doctrine\ORM\QueryBuilder;

class PeriodRepository extends EntityRepository
{

	/**
	 * Add different filter option to query
	 *
	 * @param array        $filter
	 * @param QueryBuilder $qb
	 *
	 * @return EntityRepository
	 */
	public function filter(array $filter, QueryBuilder $qb = null)
	{
		if ($qb == null) {
			$qb = $this->builder;
		}

		if ($filter != null) {
			foreach ($filter as $key => $value) {
				$value = $this->interpretComplexQuery($key, $value);
				switch($key) {
				case 'date':
					$this->scopeByDate($value, $qb);
					break;
				case 'search':
					$this->search($value, $qb);
					break;
				case 'timeslice':
					$this->scopeByTimeslice($value, $qb);
					break;
				case 'holiday':
					$this->scopeByHoliday($value, $qb);
					break;
				default:
					$this->scopeByField($key, $value, $qb);
				}
			}
		}
		return $this;
	}

	public function scopeByTimeslice(Timeslice $slice, QueryBuilder $qb = null)
	{
		if ($qb == null) {
			$qb = $this->builder;
		}
		$aliases = $qb->getRootAliases();
		$alias = array_shift($aliases);


		$qb->andWhere(
			$qb->expr()->lte($alias . '.start', ':time'),
			$qb->expr()->gte($alias . '.end', ':time')
		);
		$qb->setParameter('time', $slice->getStartedAt());
	}

	public function scopeByHoliday(Holiday $day, QueryBuilder $qb = null)
	{
		if ($qb == null) {
			$qb = $this->builder;
		}
		$aliases = $qb->getRootAliases();
		$alias = array_shift($aliases);


		$qb->andWhere(
			$qb->expr()->lte($alias . '.start', ':time'),
			$qb->expr()->gte($alias . '.end', ':time')
		);
		$qb->setParameter('time', $day->getDate());
	}

	/**
	 *
	 * @param string       $text
	 * @param QueryBuilder $qb
	 *
	 * @return QueryBuilder
	 */
	public function search($text, QueryBuilder $qb = null)
	{
		return $this;
	}

	public function findAllTakenHolidays($date, $employeeId)
	{
		if(isset($date)) {
			$dates = explode(',', $date);
			if(count($dates) == 2) {
				$startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0,0,0);
				$endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(0,0,0)->addDay();
			} else {
				throw new HttpInvalidParamException('invalid date passed');
			}
		} else {
			throw new HttpInvalidParamException('no date passed');
		}

		return $this->getEntityManager()
			->createQuery('select ts.value from DimeTimetrackerBundle:Timeslice ts
							LEFT JOIN DimeTimetrackerBundle:Activity av WITH ts.activity = av.id
							where (ts.user = :employeeid AND av.project=27) AND
							(ts.startedAt >= :startdate AND ts.stoppedAt <= :enddate)')
			->setParameters(['employeeid' => $employeeId, 'startdate' => $startDate, 'enddate' => $endDate])
			->getResult();
	}
}