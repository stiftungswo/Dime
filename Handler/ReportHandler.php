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
use Doctrine\Common\Collections\Criteria;
use HttpInvalidParamException;
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
	 * @param string $date
	 * @return array
	 * @throws HttpInvalidParamException
	 */
	public function getServicehoursReport($date) {

		// date filter
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

		$projects = $this->om->getRepository('DimeTimetrackerBundle:Project')->findAll();

		$report = [];
		$listofactivities = [];
		$activitytotal = [];

		foreach($projects as $project){
			$projectdata = [];
			$projectdata['name'] = $project->getName();
			$projectdata['projectCategory'] = $project->getProjectCategory();

			// alle timeslices im zeitraum ausser solche mit rateUnitType "a" (Anderes)
			$timeslices = $this->om->getRepository('DimeTimetrackerBundle:Timeslice')
				->createQueryBuilder('timeslice')
				->join('timeslice.activity', 'activity')
				->where('activity.project = :projectId')
				->andWhere('activity.rateUnitType != :other')
				->andWhere('timeslice.startedAt <= :endDate')
				->andWhere('timeslice.stoppedAt >= :startDate')
				->setParameter('projectId', $project->getId())
				->setParameter('other', 'a')
				->setParameter('startDate', new \DateTime($startDate))
				->setParameter('endDate', new \DateTime($endDate))
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

	/**
	 * generate report with hours per service for each project in a give timeframe
	 *
	 * @param string $date
	 * @return array
	 * @throws HttpInvalidParamException
	 */
	public function getServicehoursReportAsCSV($date) {
		$data =  $this->getServicehoursReport($date);

		function escapeCSV($string){
			$string = utf8_decode($string);
			$string = str_replace('"','""',$string);
			return '"'.$string.'"';
		}

		$rows = [];

		// title row
		if(isset($date)) {
			$dates = explode(',', $date);
			if(count($dates) == 2) {
				$startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0,0,0);
				$endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(0,0,0);
				$rows[] = escapeCSV('Servicestunden Rapport ' . $startDate->format('d.m.Y') . ' - ' . $endDate->format('d.m.Y'));
			}
		}

		// header rows
		$row = [];
		$row[] = escapeCSV('Projekt');
		$row[] = escapeCSV('Tätigkeitsbereich');
		foreach($data['total']['activitylist'] as $activity){
			$row[] = escapeCSV($activity);
		}
		$row[] = escapeCSV('Total');
		$rows[] = implode(';',$row);

		// data rows
		foreach($data['projects'] as $project){
			$row = [];
			$row[] = escapeCSV($project['name']);
			$row[] = escapeCSV($project['projectCategory']->getName());
			foreach($data['total']['activitylist'] as $activity){
				if(isset($project['activities'][$activity])){
					$row[] = round($project['activities'][$activity] / (60*60), 1);
				} else {
					$row[] = '0';
				}
			}
			$row[] = round($project['total'] / (60*60), 1);
			$rows[] = implode(';',$row);
		}

		// footer rows
		$row = [];
		$row[] = escapeCSV('Total');
		$row[] = escapeCSV(' ');
		foreach($data['total']['activitylist'] as $activity){
			if(isset($data['total']['activities'][$activity])){
				$row[] = round($data['total']['activities'][$activity] / (60*60), 1);
			} else {
				$row[] = '0';
			}
		}
		$row[] = escapeCSV('');
		$rows[] = implode(';',$row);

		return implode("\n", $rows);
	}

	/**
	 * generate report with time per employee for a project in a give timeframe
	 *
	 * @param int $projectId
	 * @param string $date
	 * @return array
	 * @throws HttpInvalidParamException
	 */
	public function getProjectemployeeReport($projectId, $date = null) {
		// check project
		$project = $this->om->getRepository('DimeTimetrackerBundle:Project')->find($projectId);
		if (!$project){
			throw new Exception("Project not found!");
		}

		$report = [];
		$criteria = new Criteria();

		// collect activity Id's
		$activities = $project->getActivities();
		$activityIds = array();
		foreach ($activities as $activity){
			$activityIds[] = $activity->getId();
		}
		$criteria->where($criteria->expr()->in('activity', $activityIds));

		// date filter
		if(isset($date)) {
			$dates = explode(',', $date);
			if(count($dates) > 1) {
				$startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0,0,0);
				$endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(0,0,0)->addDay();
			} else {
				// when only one date is set, we only show result from this day
				$startDate = Carbon::createFromFormat('Y-m-d', $date)->setTime(0,0,0);
				$endDate = Carbon::createFromFormat('Y-m-d', $date)->setTime(0,0,0)->addDay();
			}
			$criteria->andWhere($criteria->expr()->gte('startedAt', $startDate));
			$criteria->andWhere($criteria->expr()->lt('startedAt', $endDate));
		}

		// calculate sum by employee
		$timeslices = $this->om->getRepository('DimeTimetrackerBundle:Timeslice')->matching($criteria);
		$users = [];
		$total = 0;
		if ($timeslices){
			/** @var $slice Timeslice */
			foreach($timeslices as $slice){
				if($slice->getUser()){
					if (!isset($users[$slice->getUser()->getId()])){
						$users[$slice->getUser()->getId()] = 0;
					}
					$users[$slice->getUser()->getId()] += (int) $slice->getValue();
					$total += (int) $slice->getValue();
				}
			}
		}

		// workaround because AngularDart's ng-repeat does not support iterating over maps :/
		$employees = [];
		foreach($users as $id => $seconds){
			$employees[] = [
				'name' => $id,
				'user' => $this->om->getRepository('DimeEmployeeBundle:Employee')->find($id),
				'seconds' => $seconds
			];
		}

		$report['employees'] = $employees;
		$report['total'] = $total;
		return $report;
	}

}
