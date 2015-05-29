<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;


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
}