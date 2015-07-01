<?php
/**
 * Author: Till Wegmüller
 * Date: 6/11/15
 * Dime
 */

namespace Dime\ReportBundle\Handler;

use Dime\ReportBundle\Entity\ExpenseReport;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Handler\AbstractHandler;

class ReportHandler extends AbstractHandler{


	public function getExpenseReport(array $params)
	{
		$this->repository->createCurrentQueryBuilder($this->alias);


		// Filter
		if($this->hasParams($params)) {
			$this->repository->filter($this->cleanParameterBag($params));
		}

		$this->repository->getCurrentQueryBuilder()
			->Select('SUM('.$this->alias.'.value)')
			->addSelect($this->alias.'.startedAt')
			->addSelect('IDENTITY('.$this->alias.'.activity)')
			->groupBy($this->alias.'.startedAt')
			->addGroupBy($this->alias.'.activity')
			->orderBy($this->alias.'.startedAt', 'ASC')
		;


		$tmpResults = $this->repository->getCurrentQueryBuilder()->getQuery()->getResult();
		$result = array();
		foreach($tmpResults as $tmpResult){
			$slice = new Timeslice();
			$slice->setValue($tmpResult[1])
				->setStartedAt($tmpResult['startedAt'])
				->setActivity($this->om->getRepository('DimeTimetrackerBundle:Activity')->find($tmpResult[2]));
			$result[] = $slice;
		}
		$report = new ExpenseReport();
		$report->setTimeslices($result);
		if(isset($params['project'])) {
			$report->setProject($this->container->get('dime.project.handler')->get($params['project']));
		}
		if(isset($params['user'])) {
			$report->setProject($this->container->get('dime.user.handler')->get($params['user']));
		}
		return $report;
	}

	public function getZiviWeekReport(array $params)
	{
		$this->repository->createCurrentQueryBuilder($this->alias);


		// Filter
		if($this->hasParams($params)) {
			$this->repository->filter($this->cleanParameterBag($params));
		}

		$this->repository->getCurrentQueryBuilder()
			->Select('SUM('.$this->alias.'.value)')
			->addSelect($this->alias.'.startedAt')
			->addSelect('IDENTITY('.$this->alias.'.user)')
			->addSelect('IDENTITY('.$this->alias.'.activity)')
			->leftJoin($this->alias.'.activity', 'act')
			->andWhere('act.rateUnitType != :noChange')
			->groupBy($this->alias.'.user')
			->addGroupBy($this->alias.'.startedAt')
			->setParameter('noChange', 'a')
		;

		$tmpResults = $this->repository->getCurrentQueryBuilder()->getQuery()->getResult();
		$result = array();
		foreach($tmpResults as $tmpResult){
			$slice = new Timeslice();
			$slice->setValue($tmpResult[1])
				->setStartedAt($tmpResult['startedAt'])
				->setStandardUnit('h')
				->setActivity($this->om->getRepository('DimeTimetrackerBundle:Activity')->find($tmpResult[3]))
				->setUser($this->om->getRepository('DimeEmployeeBundle:Employee')->find($tmpResult[2]));
			$result[] = $slice;
		}
		$report = new ExpenseReport();
		$report->setTimeslices($result);
		return $report;
	}

}