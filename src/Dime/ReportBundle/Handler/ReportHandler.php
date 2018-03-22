<?php
/**
 * Author: Till Wegmüller
 * Date: 6/11/15
 * Dime
 */

namespace Dime\ReportBundle\Handler;

use Dime\TimetrackerBundle\Entity\ProjectComment;
use Dime\TimetrackerBundle\Entity\ProjectCommentRepository;
use Money\Money;
use Carbon\Carbon;
use Dime\InvoiceBundle\Entity\Invoice;
use Dime\ReportBundle\Entity\ExpenseReport;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Handler\AbstractHandler;
use Doctrine\Common\Collections\Criteria;
use HttpInvalidParamException;
use Symfony\Component\Config\Definition\Exception\Exception;
use Symfony\Component\Validator\Constraints\DateTime;

class ReportHandler extends AbstractHandler
{


    public function getExpenseReport(array $params)
    {
        $this->repository->createCurrentQueryBuilder($this->alias);

        // Filter
        if ($this->hasParams($params)) {
            $this->repository->filter($this->cleanParameterBag($params));
        }

        // check required params
        if (!isset($params['project']) && !isset($params['employee'])) {
            die('Projekt oder Mitarbeiter muss angegeben werden um einen Report zu erstellen.');
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
        foreach ($tmpResults as $tmpResult) {
            $slice = new Timeslice();
            $slice->setValue($tmpResult[1])
                ->setStartedAt($tmpResult['startedAt'])
                ->setActivity($this->om->getRepository('DimeTimetrackerBundle:Activity')->find($tmpResult[2]));
            $result[] = $slice;
        }
        $report = new ExpenseReport();
        $report->setTimeslices($result);
        if (isset($params['project'])) {
            $report->setProject($this->container->get('dime.project.handler')->get($params['project']));
        }
        if (isset($params['user'])) {
            $report->setUser($this->container->get('dime.user.handler')->get($params['user']));
        }
        if (isset($params['employee'])) {
            $report->setEmployee($this->container->get('dime.user.handler')->get($params['employee']));
        }
        if (isset($params['date'])) {
            $date = explode(',', $params['date']);
            if (is_array($date)) {
                $report->setStart(Carbon::createFromFormat('Y-m-d', $date[0]));
                $report->setEnd(Carbon::createFromFormat('Y-m-d', $date[1]));
            } else {
                $report->setStart($date);
            }
        }
        return $report;
    }

    public function getExpensesReportComments(array $params)
    {
        if (isset($params['project'])) {
            /** @var ProjectCommentRepository $projectCommentRepository */
            $projectCommentRepository = $this->om->getRepository('DimeTimetrackerBundle:ProjectComment');
            $queryBuilder = $projectCommentRepository
                ->createQueryBuilder('project_comment')
                ->where('project_comment.project = :project')
                ->setParameter('project', $params['project']);

            if (isset($params['date'])) {
                list($from, $to) = explode(',', $params['date']);

                $queryBuilder->andWhere('project_comment.date BETWEEN :from AND :to')
                    ->setParameter('from', Carbon::parse($from))
                    ->setParameter('to', Carbon::parse($to));
            }

            /** @var ProjectComment[] $comments */
            $comments = $queryBuilder->getQuery()->getResult();

            return $comments;
        } else {
            return [];
        }
    }

    public function getZiviWeekReport(array $params)
    {
        $this->repository->createCurrentQueryBuilder($this->alias);


        // Filter
        if ($this->hasParams($params)) {
            $this->repository->filter($this->cleanParameterBag($params));
        }

        $this->repository->getCurrentQueryBuilder()
            ->Select(''.$this->alias.'.value')
            ->addSelect($this->alias.'.startedAt')
            ->addSelect('IDENTITY('.$this->alias.'.employee)')
            ->addSelect('IDENTITY('.$this->alias.'.activity)')
            ->leftJoin($this->alias.'.activity', 'act')
            ->andWhere('act.rateUnitType != :noChange')
            ->setParameter('noChange', 'a')
        ;

        $tmpResults = $this->repository->getCurrentQueryBuilder()->getQuery()->getResult();
        $result = array();
        foreach ($tmpResults as $tmpResult) {
            $slice = new Timeslice();
            $slice->setValue($tmpResult['value'])
                ->setStartedAt($tmpResult['startedAt'])
                ->setStandardUnit(RateUnitType::$Hourly)
                ->setActivity($this->om->getRepository('DimeTimetrackerBundle:Activity')->find($tmpResult[2]));
            //Works around an Issue Where Employee Id Of a Timeslice is NULL in DB.
            //TODO Fix employee_id NULL in Database. For now assume that NULL means Default Employee.
            if (isset($tmpResult[1])) {
                $slice->setEmployee($this->om->getRepository('DimeEmployeeBundle:Employee')->find($tmpResult[1]));
            } else {
                $slice->setEmployee($this->om->getRepository('DimeEmployeeBundle:Employee')->find(1));
            }
            $result[] = $slice;
        }
        $report = new ExpenseReport();
        $report->setTimeslices($result);
        return $report;
    }

    /**
     * generate report with hours per service for each project in a given timeframe
     *
     * @param string $date
     * @return array
     * @throws HttpInvalidParamException
     */
    public function getServicehoursReport($date)
    {

        // date filter
        if (isset($date)) {
            $dates = explode(',', $date);
            if (count($dates) == 2) {
                $startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0, 0, 0);
                $endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(0, 0, 0)->addDay()->subSecond();
            } else {
                throw new HttpInvalidParamException('invalid date passed');
            }
        } else {
            throw new HttpInvalidParamException('no date passed');
        }

        /** @var Project[] $projects */
        $projects = $this->om->getRepository('DimeTimetrackerBundle:Project')->findAll();

        $report = [
            'projects' => []
        ];
        $listofactivities = [];
        $activitytotal = [];

        foreach ($projects as $project) {
            $projectdata = [];
            $projectdata['name'] = $project->getName();
            if ($project->getProjectCategory()) {
                $projectdata['projectCategory'] = $project->getProjectCategory()->getName();
                $projectdata['projectCategoryId'] = $project->getProjectCategory()->getId();
            } else {
                $projectdata['projectCategory'] = '';
                $projectdata['projectCategoryId'] = '';
            }

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
            foreach ($timeslices as $slice) {
                $activityalias = $slice->getActivity()->getAlias();

                $listofactivities[] = $slice->getActivity()->getAlias();

                // Summe der activities pro Projekt
                if (isset($activities[$activityalias])) {
                    $activities[$activityalias] += (int) $slice->getValue();
                } else {
                    $activities[$activityalias] = (int) $slice->getValue();
                }

                // Total pro Activity über alle Projekte
                if (isset($activitytotal[$activityalias])) {
                    $activitytotal[$activityalias] += (int) $slice->getValue();
                } else {
                    $activitytotal[$activityalias] = (int) $slice->getValue();
                }

                // Total pro Projekt
                $projecttotal += (int) $slice->getValue();
            }

            //only add projects that have time tracked
            if ($projecttotal > 0) {
                $projectdata['activities'] = $activities;
                $projectdata['total'] = $projecttotal;
                $report['projects'][] = $projectdata;
            }
        }

        usort($report['projects'], function ($a, $b) {
            return ($a['name'] < $b['name']) ? -1 : 1;
        });

        // activitylist is only needed because AngularDart's ng-repeat does not support iterating over maps :/
        $report['total']['activitylist'] = array_values(array_unique($listofactivities));
        $report['total']['activities'] = $activitytotal;

        return $report;
    }

    /**
     * generate report with hours per service for each project in a given timeframe
     *
     * @param string $date
     * @return array
     * @throws HttpInvalidParamException
     */
    public function getServicehoursReportAsCSV($date)
    {
        $data =  $this->getServicehoursReport($date);

        $rows = [];

        // title row
        if (isset($date)) {
            $dates = explode(',', $date);
            if (count($dates) == 2) {
                $startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0, 0, 0);
                $endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(0, 0, 0);
                $rows[] = $this->escapeCSV('Servicestunden Rapport ' . $startDate->format('d.m.Y') . ' - ' . $endDate->format('d.m.Y'));
            }
        }

        // header rows
        $row = [];
        $row[] = $this->escapeCSV('Projekt');
        $row[] = $this->escapeCSV('Tätigkeitsbereich ID');
        $row[] = $this->escapeCSV('Tätigkeitsbereich');
        foreach ($data['total']['activitylist'] as $activity) {
            if ($activity == '') {
                $row[] = 'DELETED_SERVICE';
            } else {
                $row[] = $this->escapeCSV($activity);
            }
        }
        $row[] = $this->escapeCSV('Total');
        $rows[] = implode(';', $row);

        // data rows
        foreach ($data['projects'] as $project) {
            $row = [];
            $row[] = $this->escapeCSV($project['name']);
            $row[] = $this->escapeCSV($project['projectCategoryId']);
            $row[] = $this->escapeCSV($project['projectCategory']);
            foreach ($data['total']['activitylist'] as $activity) {
                if (isset($project['activities'][$activity])) {
                    $row[] = round($project['activities'][$activity] / (60*60), 1);
                } else {
                    $row[] = '0';
                }
            }
            $row[] = round($project['total'] / (60*60), 1);
            $rows[] = implode(';', $row);
        }

        // footer rows
        $row = [];
        $row[] = $this->escapeCSV('Total');
        $row[] = $this->escapeCSV('');
        $row[] = $this->escapeCSV('');
        foreach ($data['total']['activitylist'] as $activity) {
            if (isset($data['total']['activities'][$activity])) {
                $row[] = round($data['total']['activities'][$activity] / (60*60), 1);
            } else {
                $row[] = '0';
            }
        }
        $row[] = $this->escapeCSV('');
        $rows[] = implode(';', $row);

        // summary rows
        $rows[] = '';
        $rows[] = $this->escapeCSV('Zusammenfassung Tätigkeitsbereiche');

        $categories = [];
        foreach ($data['projects'] as $project) {
            $id = $project['projectCategoryId'];
            $categories[$id][0] = '';
            $categories[$id][1] = $this->escapeCSV($project['projectCategoryId']);
            if ($project['projectCategory']) {
                $categories[$id][2] = $this->escapeCSV($project['projectCategory']);
            } else {
                $categories[$id][2] = $this->escapeCSV('Andere');
            }
            $idx = 3;
            foreach ($data['total']['activitylist'] as $activity) {
                if (!isset($categories[$id][$idx])) {
                    $categories[$id][$idx] = 0;
                }
                if (isset($project['activities'][$activity])) {
                    $categories[$id][$idx] += round($project['activities'][$activity] / (60*60), 1);
                }
                $idx++;
            }
            if (!isset($categories[$id][$idx])) {
                $categories[$id][$idx] = 0;
            }
            $categories[$id][$idx] = round($project['total'] / (60*60), 1);
        }

        foreach ($categories as $category) {
            $rows[] = implode(';', $category);
        }

        return implode("\n", $rows);
    }

    /**
     * generate report with revenue infos for each project
     *
     * @return array
     * @throws HttpInvalidParamException
     */
    public function getRevenueReport($date)
    {

        /*
         * -> nur Projekte auswerten die verrechenbar sind
         *
         * name             Projektname
         * category         Kategorie (Tätigkeitsbereiche)
         * section          Kategorie (Geschäftsbereiche)
         * customer         Auftraggeber (Kunde)
         * date             Erstelldatum
         * year             Jahr (Aus Erstelldatum)
         * accountant       Verantwortung (Verantwortlicher Mitarbeiter)
         * aufwand          Aufwand (Erfasste Stunden die verrechnet werden können in CHF)
         * umsatz           Umsatz (Total bereits erstellte Rechnungen)
         * umsatz_erwartet  Erwarteter Umsatz (Total bereits erstellte Offerten)
         *
         */

        /** @var Project[] $projects */
        //$projects = $this->om->getRepository('DimeTimetrackerBundle:Project')->findBy(array('chargeable' => 1));



        // date filter
        if (isset($date)) {
            $dates = explode(',', $date);
            if (count($dates) == 2) {
                $startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0, 0, 0);
                $endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(23, 59, 59);
            } else {
                throw new HttpInvalidParamException('invalid date passed');
            }
        } else {
            throw new HttpInvalidParamException('no date passed');
        }

        //print("START DATE: ".$startDate);

        $filteredProjects = $this->om->getRepository('DimeTimetrackerBundle:Project')
            ->createQueryBuilder('project')
            ->where('project.createdAt >= :startDate AND project.createdAt < :endDate')
            ->setParameter('startDate', new \DateTime($startDate))
            ->setParameter('endDate', new \DateTime($endDate))
            ->andWhere('project.chargeable = :chargeable')
            ->setParameter('chargeable', 1)
            ->getQuery()
            ->getResult();

        //$filterResult = count($filteredProjects);

        //print("FILTER RESULT: ".$filterResult);

        $report = [];
        $listofactivities = [];
        $activitytotal = [];

        foreach ($filteredProjects as $project) {
            $data = [];
            $data['name'] = $project->getName();
            $data['category'] = ($project->getProjectCategory() != null ? $project->getProjectCategory()->getName() : '');
            $data['customer'] = ($project->getCustomer() != null ? $project->getCustomer()->getName() : '');
            $data['date'] = $project->getCreatedAt()->format('d.m.Y');
            $data['year'] = $project->getCreatedAt()->format('Y');
            $data['accountant'] = ($project->getAccountant() != null ? $project->getAccountant()->getFullname() : '');

            // Total der erfassten Stunden
            $data['aufwand'] = ($project->calculateCurrentPrice() != null ? $project->calculateCurrentPrice()->getAmount()/100 : 0);

            // Total der Rechnungen zusammenzählen
            $invoices = $project->getInvoices();
            $invoice_total = Money::CHF(0);
            $costgroups = [];
            if (count($invoices)) {
                $tmpCostgroups = [];
                /** @var $invoice Invoice */
                foreach ($invoices as $invoice) {
                    $invoice_total = $invoice_total->add($invoice->getTotal());
                    $tmpCostgroups[] = $invoice->getCostgroupDistribution();
                }
                $costgroups = $this->mergeCostgroups($tmpCostgroups);
            }
            $data['umsatz'] = ($invoice_total->getAmount()/100);

            // Total der Offerten zusammenzählen (= budget_price)
            $data['umsatz_erwartet'] = ($project->getBudgetPrice() != null ? $project->getBudgetPrice()->getAmount()/100 : 0);
            $data['costgroups'] = $costgroups;

            $report[] = $data;
        }

        $invoicesWithoutProjects = $this->om->getRepository('DimeInvoiceBundle:Invoice')
        ->createQueryBuilder('invoice')
        ->where('invoice.createdAt >= :startDate AND invoice.createdAt < :endDate')
        ->setParameter('startDate', new \DateTime($startDate))
        ->setParameter('endDate', new \DateTime($endDate))
        ->andWhere('invoice.project is NULL')
        ->getQuery()
        ->getResult();

        foreach ($invoicesWithoutProjects as $invoice) {
            $data = [];
            $data['name'] = $invoice->getName();
            $data['category'] = '';
            $data['customer'] = ($invoice->getCustomer() != null ? $invoice->getCustomer()->getName() : '');
            $data['date'] = $invoice->getCreatedAt()->format('d.m.Y');
            $data['year'] = $invoice->getCreatedAt()->format('Y');
            $data['accountant'] = ($invoice->getAccountant() != null ? $invoice->getAccountant()->getFullname() : '');
            $data['aufwand'] = '';
            $data['umsatz'] = ($invoice->getTotal()->getAmount()/100);
            $data['umsatz_erwartet'] = '';
            $data['costgroups'] = $this->mergeCostgroups([$invoice->getCostgroupDistribution()]);

            $report[] = $data;
        }
        return $report;
    }

    /**
     * Merges costgroups from multiple invoices
     *
     * @param array $groups
     *
     * @return array
     */
    private function mergeCostgroups(array $groups): array
    {
        $total = 0;
        $indexedGroup = [];
        foreach ($groups as $group) {
            foreach ($group as $item) {
                if (isset($indexedGroup[$item['number']])) {
                    $indexedGroup[$item['number']]['ratio'] += $item['ratio'];
                } else {
                    $indexedGroup[$item['number']] = $item;
                }
                $total += $item['ratio'];
            }
        }

        foreach ($indexedGroup as &$group) {
            $group['ratio'] /= $total;
        }


        return $indexedGroup;
    }

    private function escapeCSV(string $string): string
    {
        $string = utf8_decode($string);
        $string = str_replace('"', '""', $string);
        return '"'.$string.'"';
    }

    /**
     * generate report with revenue infos for each project in a given timeframe
     *
     * @return array
     * @throws HttpInvalidParamException
     */
    public function getRevenueReportAsCSV($date)
    {
        $data = $this->getRevenueReport($date);

        $costgroups = [];

        foreach ($data as $item) {
            foreach ($item['costgroups'] as $costgroup) {
                $costgroups[$costgroup['number']] = $costgroup;
            }
        }

        ksort($costgroups);

        // add separator info for excel
        $rows = ["sep=,"];

        // header rows
        $row = [];
        $row[] = $this->escapeCSV('Projekt / Rechnung');
        $row[] = $this->escapeCSV('Kategorie (Tätigkeitsbereich)');
        $row[] = $this->escapeCSV('Auftraggeber');
        $row[] = $this->escapeCSV('Start (Erstelldatum)');
        $row[] = $this->escapeCSV('Jahr');
        $row[] = $this->escapeCSV('Verantwortlich');
        $row[] = $this->escapeCSV('Aufwand CHF (Total bereits verbuchter Stunden)');
        $row[] = $this->escapeCSV('Umsatz CHF (Total gestellte Rechnungen)');
        $row[] = $this->escapeCSV('Umsatz erwartet CHF (Total gestellte Offerten)');

        foreach ($costgroups as $costgroup) {
            $row[] = $this->escapeCSV(sprintf("%s (%s)", $costgroup['description'], $costgroup['number']));
        }

        $rows[] = implode(',', $row);

        // order rows by year and accountant
        usort($data, function ($a, $b) {
            if ($a['year'] == $b['year']) {
                return strcmp($a['accountant'], $b['accountant']);
            }
            return ($a['year'] < $b['year']) ? 1 : -1;
        });

        // data rows
        foreach ($data as $project) {
            $row = [];
            $row[] = $this->escapeCSV($project['name']);
            $row[] = $this->escapeCSV($project['category']);
            $row[] = $this->escapeCSV($project['customer']);
            $row[] = $this->escapeCSV($project['date']);
            $row[] = $this->escapeCSV($project['year']);
            $row[] = $this->escapeCSV($project['accountant']);
            $row[] = $this->escapeCSV($project['aufwand']);
            $row[] = $this->escapeCSV($project['umsatz']);
            $row[] = $this->escapeCSV($project['umsatz_erwartet']);
            foreach ($costgroups as $costgroup) {
                if (isset($project['costgroups'][$costgroup['number']])) {
                    $value = $project['costgroups'][$costgroup['number']]['ratio'] * $project['umsatz'];
                    $row[] = $this->escapeCSV(round($value, 2));
                } else {
                    $row[] = $this->escapeCSV(0);
                }
            }
            $rows[] = implode(',', $row);
        }

        return implode("\n", $rows);
    }

    /**
     * generate report with time per employee for a project in a given timeframe
     *
     * @param int $projectId
     * @param string $date
     * @return array
     * @throws HttpInvalidParamException
     */
    public function getProjectemployeeReport($projectId, $date = null)
    {
        // check project
        $project = $this->om->getRepository('DimeTimetrackerBundle:Project')->find($projectId);
        if (!$project) {
            throw new Exception("Project not found!");
        }

        $report = [];
        $criteria = new Criteria();

        // collect activity Id's
        $activities = $project->getActivities();
        $activityIds = array();
        foreach ($activities as $activity) {
            $activityIds[] = $activity->getId();
        }
        $criteria->where($criteria->expr()->in('activity', $activityIds));

        // date filter
        if (isset($date)) {
            $dates = explode(',', $date);
            if (count($dates) > 1) {
                $startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0, 0, 0);
                $endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(0, 0, 0)->addDay();
            } else {
                // when only one date is set, we only show result from this day
                $startDate = Carbon::createFromFormat('Y-m-d', $date)->setTime(0, 0, 0);
                $endDate = Carbon::createFromFormat('Y-m-d', $date)->setTime(0, 0, 0)->addDay();
            }
            $criteria->andWhere($criteria->expr()->gte('startedAt', $startDate));
            $criteria->andWhere($criteria->expr()->lt('startedAt', $endDate));
        }

        // calculate sum by employee
        $timeslices = $this->om->getRepository('DimeTimetrackerBundle:Timeslice')->matching($criteria);
        $users = [];
        $total = 0;
        if ($timeslices) {
            /** @var $slice Timeslice */
            foreach ($timeslices as $slice) {
                if ($slice->getEmployee()) {
                    if (!isset($users[$slice->getEmployee()->getId()])) {
                        $users[$slice->getEmployee()->getId()] = 0;
                    }
                    $users[$slice->getEmployee()->getId()] += (int) $slice->getValue();
                    $total += (int) $slice->getValue();
                }
            }
        }

        // workaround because AngularDart's ng-repeat does not support iterating over maps :/
        $employees = [];
        foreach ($users as $id => $seconds) {
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
