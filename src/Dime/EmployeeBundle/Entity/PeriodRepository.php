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
                switch ($key) {
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

    /**
     * Find all taken holiday from an employee.
     *
     * @param $date
     * @param $employeeId
     * @return mixed
     * @throws HttpInvalidParamException
     */
    public function findAllTakenHolidays($date, $employeeId)
    {
        if (isset($date)) {
            $dates = explode(',', $date);
            if (count($dates) == 2) {
                $startDate = Carbon::createFromFormat('Y-m-d', $dates[0])->setTime(0, 0, 0);
                $endDate = Carbon::createFromFormat('Y-m-d', $dates[1])->setTime(0, 0, 0)->addDay();
            } else {
                throw new HttpInvalidParamException('invalid date passed');
            }
        } else {
            throw new HttpInvalidParamException('no date passed');
        }

        $vacationProjectId = $this->getEntityManager()
            ->createQuery('SELECT project.id FROM DimeTimetrackerBundle:Setting setting INNER JOIN DimeTimetrackerBundle:Project project WITH setting.value = project.alias where setting.name = :settingname')
            ->setParameters(['settingname' => 'Ferien'])
            ->getResult();

        if (sizeof($vacationProjectId) > 0 && $vacationProjectId[0]['id'] != null) {
            return $this->getEntityManager()
                ->createQuery('SELECT ts.value FROM DimeTimetrackerBundle:Timeslice ts
								LEFT JOIN DimeTimetrackerBundle:Activity av WITH ts.activity = av.id
								WHERE (ts.employee = :employeeid AND av.project = :projectid) AND
								(ts.startedAt >= :startdate AND ts.stoppedAt <= :enddate)')
                ->setParameters(['employeeid' => $employeeId, 'startdate' => $startDate, 'enddate' => $endDate, 'projectid' => (string)$vacationProjectId[0]['id']])
                ->getResult();
        } else {
            return null;
        }
    }
}
