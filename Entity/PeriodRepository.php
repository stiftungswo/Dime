<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;


use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

class PeriodRepository extends EntityRepository
{

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