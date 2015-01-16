<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\Query\ResultSetMapping;

/**
 * TimesliceRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class TimesliceRepository extends EntityRepository
{

    /**
     * Scope by search text.
     * Search not possible.
     *
     * @param string $text            
     * @param QueryBuilder $qb            
     *
     * @return TimesliceRepository
     *
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }

    public function scopeByLatest(QueryBuilder $qb =null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->orderBy($alias.'.startedAt', 'DESC');
        $qb->setMaxResults(1);
        return $this;
    }

    /**
     * Scope by date,
     * Not implemented yet.
     *
     * @param
     *            $date
     * @param QueryBuilder $qb            
     *
     * @return TimesliceRepository
     *
     */
    public function scopeByDate($date, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

	    if (is_array($date) && count($date) == 1) {
		    $date = array_shift($date);
	    }

	    if(is_string($date)){
		    $datetmp = preg_split('#,#', $date);
		    if(is_array($datetmp)){
			    $date = $datetmp;
		    }
	    }

        if (is_array($date)) {
            $qb->andWhere(
                $qb->expr()->orX(
                    $qb->expr()->between($alias . '.startedAt', ':from', ':to'),
                    $qb->expr()->andX(
                        $qb->expr()->isNull($alias . '.startedAt'),
                        $qb->expr()->between($alias . '.createdAt', ':from', ':to')
                    )
                )
            );
            $qb->setParameter('from', $date[0] . ' 00:00:00');
            $qb->setParameter('to', $date[1] . ' 23:59:59');
        } else {
            $qb->andWhere(
                $qb->expr()->orX(
                    $qb->expr()->like($alias . '.startedAt', ':date'),
                    $qb->expr()->andX(
                        $qb->expr()->isNull($alias . '.startedAt'),
                        $qb->expr()->like($alias . '.createdAt', ':date')
                    )
                )
            );
            $qb->setParameter('date', $date . '%');
        }
        return $this;
    }

    /**
     * Scope by user.
     *
     * @param
     *            $user
     * @param \Doctrine\ORM\QueryBuilder $qb            
     *
     * @return TimesliceRepository
     *
     */
    public function scopeByUser($user, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);
        if (! $this->existsJoinAlias($qb, 'a')) {
            $qb->leftJoin($alias . '.activity', 'a');
        }
        $qb->andWhere($qb->expr()
            ->eq("a.user", ":user"));
        $qb->setParameter(":user", $user);
        return $this;
    }

    public function scopeByActivityData(array $data, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);
        if (! empty($data)) {
            if (! $this->existsJoinAlias($qb, 'a')) {
                $qb->leftJoin($alias . '.activity', 'a');
            }
            $allowed = $this->getEntityManager()
                ->getRepository('DimeTimetrackerBundle:Activity')
                ->allowedFields();
            foreach ($data as $field => $value) {
                if (in_array($field, $allowed)) {
                    $qb->andWhere($qb->expr()
                        ->eq("a." . $field, ":" . $field));
                    $qb->setParameter(":" . $field, $value);
                }
            }
        }
        return $this;
    }

    /**
     * Filter by assigned tag
     *
     * @param integer|string $tagIdOrName            
     * @param \Doctrine\ORM\QueryBuilder $qb            
     *
     * @return \Doctrine\ORM\QueryBuilder
     *
     */
    public function scopeWithTag($tagIdOrName, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);
        if (! $this->existsJoinAlias($qb, 'x')) {
            $qb->innerJoin($alias . '.tags', 'x', 'WITH', is_numeric($tagIdOrName) ? 'x.id = :tag' : 'x.name = :tag');
        }
        $qb->setParameter('tag', $tagIdOrName);
        return $this;
    }

    /**
     * Filter by not-assigned tag
     *
     * @param integer|string $tagIdOrName            
     * @param \Doctrine\ORM\QueryBuilder $qb            
     *
     * @return \Doctrine\ORM\QueryBuilder
     *
     */
    public function scopeWithoutTag($tagIdOrName, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);
        $qb2 = clone $qb;
        $qb2->resetDqlParts();
        $qb->andWhere($qb->expr()
            ->notIn($alias . '.id', $qb2->select('t2.id')
            ->from('Dime\TimetrackerBundle\Entity\Timeslice', 't2')
            ->join('t2.tags', 'x2')
            ->where(is_numeric($tagIdOrName) ? 'x2.id = :tag' : 'x2.name = :tag')
            ->getDQL()));
        $qb->setParameter('tag', $tagIdOrName);
        return $this;
    }

    /**
     * Add different filter option to query
     *
     * @param array $filter            
     * @param \Doctrine\ORM\QueryBuilder $qb            
     *
     * @return TimesliceRepository
     *
     */
    public function filter(array $filter, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
        if ($filter != null) {
            $activity_data = array();
            foreach ($filter as $key => $value) {
                switch ($key) {
                    case 'date':
                        $this->scopeByDate($value, $qb);
                        break;
                    case 'customer':
                        $activity_data[$key] = $value;
                        break;
                    case 'project':
                        $activity_data[$key] = $value;
                        break;
                    case 'service':
                        $activity_data[$key] = $value;
                        break;
                    case 'withTags':
                        $this->scopeWithTags($value, $qb);
                        break;
                    case 'withoutTags':
                        $this->scopeWithoutTags($value, $qb);
                        break;
                    case 'latest' :
                        $this->scopeByLatest($qb);
                        break;
                    default:
                        $this->scopeByField($key, $value, $qb);
                }
            }
            if (! empty($activity_data)) {
                $this->scopeByActivityData($activity_data, $qb);
            }
        }
        return $this;
    }

    /**
     * Fetch all activities id where a timeslice has stoppedAt is NULL and value is '0'.
     * This query is a native one, because Doctrine DQL can not fetch only the activity_id.
     *
     * @param $date, Date            
     * @return array, list of activity ids
     *        
     */
    public function fetchActivityIdsByDate($date)
    {
        $rsm = new ResultSetMapping();
        $rsm->addScalarResult('activity_id', 'activity');
        $sql = 'SELECT DISTINCT t.activity_id FROM timeslices t WHERE t.started_at LIKE :date';
        $query = $this->getEntityManager()
            ->createNativeQuery($sql, $rsm)
            ->setParameter('date', $date . '%');
        return array_map("array_pop", $query->getResult());
    }

    /**
     * Fetch all activities id where a timeslice has stoppedAt is NULL and value is '0'.
     * This query is a native one, because Doctrine DQL can not fetch only the activity_id.
     *
     * @param
     *            $from
     * @param
     *            $to
     * @return array, list of activity ids
     *        
     */
    public function fetchActivityIdsByDateRange($from, $to)
    {
        $rsm = new ResultSetMapping();
        $rsm->addScalarResult('activity_id', 'activity');
        $sql = 'SELECT DISTINCT t.activity_id FROM timeslices t WHERE t.started_at BETWEEN ? AND ?';
        $query = $this->getEntityManager()
            ->createNativeQuery($sql, $rsm)
            ->setParameter(1, $from)
            ->setParameter(2, $to);
        return array_map("array_pop", $query->getResult());
    }

    /**
     * Fetch all activities id where a timeslice has stoppedAt is NULL and value is '0'.
     * This query is a native one, because Doctrine DQL can not fetch only the activity_id.
     *
     * @return array, list of activity ids
     *        
     */
    public function fetchRunningActivityIds()
    {
        $rsm = new ResultSetMapping();
        $rsm->addScalarResult('activity_id', 'activity');
        $sql = 'SELECT DISTINCT t.activity_id FROM timeslices t WHERE t.stopped_at IS NULL AND t.value = 0';
        $query = $this->getEntityManager()->createNativeQuery($sql, $rsm);
        return array_map("array_pop", $query->getResult());
    }
}