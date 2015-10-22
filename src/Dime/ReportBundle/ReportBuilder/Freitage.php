<?php
/**
 * Author: Till Wegmüller
 * Date: 3/6/15
 * Dime
 */

namespace Dime\ReportBundle\ReportBuilder;


use Dime\TimetrackerBundle\Model\RateUnitType;
use Doctrine\ORM\QueryBuilder;
use Velvel\ReportBundle\Builder\BaseReportBuilder;

class Freitage extends BaseReportBuilder{

	/**
	 * Configures the query builder
	 *
	 * <code>
	 *      $queryBuilder
	 *          ->select('f.length')
	 *          ->from('Foo', 'f')
	 *          ->where($queryBuilder->expr()->gt('f.bar', ':min_bar'));
	 *
	 *      return $queryBuilder;
	 * </code>
	 *
	 * @param \Doctrine\ORM\QueryBuilder $queryBuilder Doctrine ORM query builder
	 *
	 * @return \Doctrine\ORM\QueryBuilder
	 */
	protected function configureBuilder(QueryBuilder $queryBuilder)
	{
		return $queryBuilder
			->select("CONCAT(u.firstname,  u.lastname) as Mitarbeiter")
			->addSelect('p.name AS Projekt')
			->addSelect('SUM(t.value) / :DayInSeconds as Tage')
			->from('DimeTimetrackerBundle:Timeslice', 't')
			->where('t.user IN (:users)')
			->andWhere('a.project IN (:projects)')
			->join('t.activity', 'a')
			->join('a.project', 'p')
			->join('t.user', 'u')
			->groupBy('t.user')
			->addGroupBy('a.project')
			->setParameter(':DayInSeconds', RateUnitType::$DayInSeconds)
		;
	}

	/**
	 * Configures query parameters
	 *
	 * <code>
	 *      $parameters = array(
	 *          'min_bar' => array(
	 *              'value' => 5, // default value of the min_bar
	 *              'type' => 'number' // form type
	 *              'options' => array(
	 *                  // array to be passed to the form type
	 *                  'label' => 'Min. bar',
	 *              ),
	 *              'validation' => new Date(),
	 *          ),
	 *      );
	 *
	 *      return $parameters;
	 * </code>
	 *
	 * @return array
	 */
	protected function configureParameters()
	{
		return array(
			'users' => array(
				'value' => array(
					$this->securityContext->getToken()
				),
				'type' => 'collection',
				'options' => array(
					'type' => 'entity',
					'options' => array(
						'class' => 'DimeTimetrackerBundle:User'
					),
				),
			),
			'projects' => array(
				'value' => array(
					'14',
					'16',
					'15',
					'17',
					'27',
					'32'
				),
				'type' => 'collection',
				'options' => array(
					'type' => 'entity',
					'options' => array(
						'class' => 'DimeTimetrackerBundle:Project'
					),
				),
			),
		);
	}

	/**
	 * Configures modifiers
	 *
	 * <code>
	 *      $modifiers = array(
	 *          'length' => array(
	 *              'method' => 'format',
	 *              'params' => array(
	 *                  'H:i;s'
	 *              ),
	 *          ),
	 *      );
	 *
	 *      return $modifiers;
	 *
	 * </code>
	 *
	 * @return array
	 */
	protected function configureModifiers()
	{
		return array();
	}
}