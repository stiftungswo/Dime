<?php

namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;
/**
 * ActivityRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class ActivityRepository extends EntityRepository
{
    protected $allowed_fields = array('customer', 'project', 'service', 'user');

    public function allowedFields() {
        return $this->allowed_fields;
    }

    /**
     * Simple search for description with like.
     *
     * @param string                     $text
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     * @throws \Exception when $qb is null
     */
    public function search($text, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->like($alias . '.description', ':text'));
        $qb->setParameter('text', '%'  . $text . '%');

        return $this;
    }

    /**
     * Filter by date string or with array of 2 date strings.
     * TODO Filter by date - no datetime functions at the moment
     *
     * @param                            $date, date string or array with data string
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     * @throws \Exception when $qb is null
     */
    public function scopeByDate($date, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $timesliceRepository = $this->getEntityManager()->getRepository('DimeTimetrackerBundle:Timeslice');

        if (is_array($date)) {
            $ids = $timesliceRepository->fetchActivityIdsByDateRange($date[0], $date[1]);

            if (!empty($ids)) {
                $qb->andWhere(
                    $qb->expr()->orX(
                        $qb->expr()->between($alias . '.updatedAt', ':from', ':to'),
                        $qb->expr()->in($alias . '.id', $ids)
                    )
                );
            } else {
                $qb->andWhere(
                    $qb->expr()->between($alias . '.updatedAt', ':from', ':to')
                );
            }

            $qb->setParameter('from', $date[0]);
            $qb->setParameter('to', $date[1]);
        } else {
            $ids = $timesliceRepository->fetchActivityIdsByDate($date);

            if (!empty($ids)) {
                $qb->andWhere(
                    $qb->expr()->orX(
                        $qb->expr()->like($alias . '.updatedAt', ':date')
                        , $qb->expr()->in($alias . '.id', $ids)
                    )
                );
            } else {
                $qb->andWhere(
                    $qb->expr()->like($alias . '.updatedAt', ':date')
                );
            }


            $qb->setParameter('date', $date . '%');
        }

        //print($qb->getQuery()->getSQL());

        return $this;
    }

    /**
     * Filter active or non active activities. Active activities
     * has a timeslice where stoppedAt is null and duration is 0.
     *
     * @param                            $active, boolean
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     * @throws \Exception when $qb is null
     */
    public function scopeByActive($active, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $timesliceRepository = $this->getEntityManager()->getRepository('DimeTimetrackerBundle:Timeslice');
        $ids = $timesliceRepository->fetchRunningActivityIds();

        if ($active == 'true' || (is_bool($active) && $active)) {
            // empty id list, should produce no output on query
            if (empty($ids)) {
                $ids[] = 0;
            }
            $qb->andWhere(
                $qb->expr()->in('a.id', $ids)
            );
        } else {
            if (!empty($ids)) {
                $qb->andWhere(
                    $qb->expr()->notIn('a.id', $ids)
                );
            }
        }

        return $this;
    }

    /**
     * Filter by customer id
     *
     * @param                            $id, integer
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     */
    public function scopeByCustomer($id, QueryBuilder $qb = null)
    {
        return $this->scopeByField('customer', $id, $qb);
    }

    /**
     * Filter by project id
     *
     * @param                            $id, integer
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     */
    public function scopeByProject($id, QueryBuilder $qb = null)
    {
        return $this->scopeByField('project', $id, $qb);
    }

    /**
     * Filter by service id
     *
     * @param                            $id, integer
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     */
    public function scopeByService($id, QueryBuilder $qb = null)
    {
        return $this->scopeByField('service', $id, $qb);
    }

    /**
     * Filter by assigned tag
     *
     * @param integer|string             $tagIdOrName
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     */
    public function scopeWithTag($tagIdOrName, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        if (!$this->existsJoinAlias($qb, 'x')) {
            $qb->innerJoin(
                $alias . '.tags',
                'x',
                'WITH',
                is_numeric($tagIdOrName) ? 'x.id = :tag' : 'x.name = :tag'
            );
        }
        $qb->setParameter('tag', $tagIdOrName);
        return $this;
    }

    /**
     * Filter by not-assigned tag
     *
     * @param integer|string             $tagIdOrName
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
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

        $qb->andWhere(
            $qb->expr()->notIn(
                $alias . '.id',
                $qb2->select('a2.id')
                    ->from('Dime\TimetrackerBundle\Entity\Activity', 'a2')
                    ->join('a2.tags', 'x2')
                    ->where(is_numeric($tagIdOrName) ? 'x2.id = :tag' : 'x2.name = :tag')
                    ->getDQL()
            )
        );
        $qb->setParameter('tag', $tagIdOrName);

        return $this;
    }

    /**
     * Add different filter option to query
     *
     * @param array                      $filter
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return ActivityRepository
     */
    public function filter(array $filter, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        if ($filter != null) {
            foreach ($filter as $key => $value) {
                switch($key) {
                    case 'active':
                        $this->scopeByActive($value, $qb);
                        break;
                    case 'withTags':
                         $this->scopeWithTags($value, $qb);
                        break;
                    case 'withoutTags':
                        $this->scopeWithoutTags($value, $qb);
                        break;
                    case 'date':
                        $this->scopeByDate($value, $qb);
                        break;
                    case 'search':
                        $this->search($value, $qb);
                        break;
                    default:
                        $this->scopeByField($key, $value, $qb);
                }
            }
        }
        return $this;
    }
}
