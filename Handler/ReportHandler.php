<?php
/**
 * Author: Till Wegmüller
 * Date: 6/11/15
 * Dime
 */

namespace Dime\ReportBundle\Handler;

use Carbon\Carbon;
use Dime\ReportBundle\Entity\ExpenseReport;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Handler\AbstractHandler;
use Symfony\Component\Config\Definition\Exception\Exception;

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
			$report->setUser($this->container->get('dime.user.handler')->get($params['user']));
		}
		if(isset($params['date'])) {
			$date = explode(',', $params['date']);
			if(is_array($date)) {
				$report->setStart(Carbon::createFromFormat('Y-m-d', $date[0]));
				$report->setEnd(Carbon::createFromFormat('Y-m-d', $date[1]));
			} else {
				$report->setStart($date);
			}
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
				->setActivity($this->om->getRepository('DimeTimetrackerBundle:Activity')->find($tmpResult[3]));
			//Works around an Issue Where User Id Of a Timeslice is NULL in DB.
			//TODO Fix user_id NULL in Database. For now assume that NULL means Default User.
			if(isset($tmpResult[2])) {
				$slice->setUser($this->om->getRepository('DimeEmployeeBundle:Employee')->find($tmpResult[2]));
			} else {
				$slice->setUser($this->om->getRepository('DimeEmployeeBundle:Employee')->find(1));
			}
			$result[] = $slice;
		}
		$report = new ExpenseReport();
		$report->setTimeslices($result);
		return $report;
	}

	/**
	 * generate report with hours per service for each project in a give timeframe
	 *
	 * @param int $year
	 * @return array
	 * @throws \HttpInvalidParamException
	 */
	public function getServicehoursReport($year) {

		if (!$year || $year < 1900){
			throw new Exception('Invalid year: '.$year);
		}

		$projects = $this->om->getRepository('DimeTimetrackerBundle:Project')->findAll();

		$report = array();
		$listofactivities = [];
		$activitytotal = [];

		foreach($projects as $project){
			$projectdata = [];
			$projectdata['name'] = $project->getName();

			// alle timeslices im zeitraum ausser solche mit rateUnitType "a" (Anderes)
			$timeslices = $this->om->getRepository('DimeTimetrackerBundle:Timeslice')
				->createQueryBuilder('timeslice')
				->join('timeslice.activity', 'activity')
				->where('activity.project = :projectId')
				->andWhere('activity.rateUnitType != :other')
				->andWhere('timeslice.startedAt <= :yearEnd')
				->andWhere('timeslice.stoppedAt >= :yearBegin')
				->setParameter('projectId', $project->getId())
				->setParameter('other', 'a')
				->setParameter('yearBegin', new \DateTime($year."-01-01"))
				->setParameter('yearEnd', new \DateTime($year."-12-31"))
				->getQuery()
				->getResult();

			$activities = array();
			$projecttotal = 0;
			foreach($timeslices as $slice){
				$activityalias = $slice->getActivity()->getAlias();

				$listofactivities[] = $slice->getActivity()->getAlias();

				// Summe der activities pro Projekt
				if (isset($activities[$activityalias])){
					$activities[$activityalias] += (int) $slice->getValue();
				} else {
					$activities[$activityalias] = (int) $slice->getValue();
				}

				// Total pro Activity über alle Projekte
				if (isset($activitytotal[$activityalias])){
					$activitytotal[$activityalias] += (int) $slice->getValue();
				} else {
					$activitytotal[$activityalias] = (int) $slice->getValue();
				}

				// Total pro Projekt
				$projecttotal += (int) $slice->getValue();
			}
			$projectdata['activities'] = $activities;
			$projectdata['total'] = $projecttotal;
			$report['projects'][] = $projectdata;
		}

		// activitylist is only needed because AngularDart's ng-repeat does not support iterating over maps :/
		$report['total']['activitylist'] = array_values(array_unique($listofactivities));
		$report['total']['activities'] = $activitytotal;

		return $report;
	}
}
