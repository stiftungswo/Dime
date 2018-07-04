<?php

namespace Dime\TimetrackerBundle\Entity;

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

    public function allowedFields()
    {
        return $this->allowed_fields;
    }

    /**
     * Simple search for description with like.
     *
     * @param string $text
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return ActivityRepository
     * @throws \Exception when $qb is null
     */
    public function search($text, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere(
            $qb->expr()->orX()->addMultiple(array(
                $qb->expr()->like($alias . '.description', ':text'),
                $qb->join($alias . '.service', 's', null, null, 's.id')->expr()->orX()->addMultiple(array(
                    $qb->expr()->like('s.name', ':text'),
                    $qb->expr()->like('s.alias', ':text')
                ))
            ))
        );
        $qb->setParameter('text', '%' . $text . '%');

        return $this;
    }

    /**
     * Search for the Virtual Property name
     *
     * @param string $name
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return ActivityRepository
     * @throws \Exception when $qb is null
     */
    public function name($name, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        if (strpos($name, '*') !== false) {
            $name = str_replace('*', '%', $name);
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere(
            $qb->join($alias . '.service', 's', null, null, 's.id')
                ->expr()->like('s.name', ':name')
        );
        $qb->setParameter('name', $name);

        return $this;
    }

    /**
     * Filter by customer id
     *
     * @param                            $id , integer
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return ActivityRepository
     */
    public function scopeByCustomer($id, QueryBuilder $qb = null)
    {
        return $this->scopeByField('customer', $id, $qb);
    }

    /**
     * Filter by project id
     *
     * @param                            $id , integer
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
     * @param                            $id , integer
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
     * @param integer|string $tagIdOrName
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return ActivityRepository
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
     * @param integer|string $tagIdOrName
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
     * @param array $filter
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
                $value = $this->interpretComplexQuery($key, $value);
                switch ($key) {
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
                    case 'name':
                        $this->name($value, $qb);
                        break;
                    default:
                        $this->scopeByField($key, $value, $qb);
                }
            }
        }
        return $this;
    }

    /**
     * @param $projectId
     *
     * @return array
     */
    public function findByProject($projectId)
    {
        return $this->findBy(array('project' => $projectId));
    }
}
