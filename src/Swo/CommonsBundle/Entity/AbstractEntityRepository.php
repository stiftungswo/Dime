<?php

namespace Swo\CommonsBundle\Entity;

use Doctrine\ORM\EntityRepository as Base;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\ORM\QueryBuilder;

/**
 * Swo\CommonsBundle\Entity\AbstractEntityRepository
 *
 * Abstract repository to keep code clean.
 */
abstract class AbstractEntityRepository extends Base
{
    /**
     * @var QueryBuilder
     */
    protected $builder;

    /**
     * @abstract
     *
     * @param string $text
     * @param QueryBuilder $qb
     *
     * @return AbstractEntityRepository
     */
    abstract public function search($text, QueryBuilder $qb = null);

    /**
     * @abstract
     *
     * @param                   $date
     * @param QueryBuilder $qb
     *
     * @return AbstractEntityRepository
     * @throws \Exception when $qb is null and Repository has no QueryBuilder initialized
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

        if (is_string($date)) {
            $datetmp = preg_split('#,#', $date);
            if (is_array($datetmp) && count($datetmp) > 1) {
                $date = $datetmp;
            }
        }

        if (is_array($date)) {
            $qb->andWhere(
                $qb->expr()->orX(
                    $qb->expr()->between($alias . '.createdAt', ':from', ':to'),
                    $qb->expr()->between($alias . '.updatedAt', ':from', ':to')
                )
            );
            $qb->setParameter('from', $date[0] . ' 00:00:00');
            $qb->setParameter('to', $date[1] . ' 23:59:59');
        } else {
            $qb->andWhere(
                $qb->expr()->orX(
                    $qb->expr()->like($alias . '.createdAt', ':date'),
                    $qb->expr()->like($alias . '.updatedAt', ':date')
                )
            );
            $qb->setParameter('date', $date . '%');
        }
        return $this;
    }

    /**
     * Create a new current query builder
     *
     * @param string $alias
     * @return AbstractEntityRepository
     */
    public function createCurrentQueryBuilder($alias)
    {
        $this->builder = $this->createQueryBuilder($alias);
        return $this;
    }

    /**
     * Return the current query builder
     *
     * @return QueryBuilder
     */
    public function getCurrentQueryBuilder()
    {
        return $this->builder;
    }

    /**
     * Set the current query builder
     *
     * @param QueryBuilder $qb
     * @return AbstractEntityRepository
     */
    public function setCurrentQueryBuilder(QueryBuilder $qb)
    {
        $this->builder = $qb;
        return $this;
    }

    /**
     * Scope by any field with value
     *
     * @param $field
     * @param $value
     * @param QueryBuilder $qb
     * @return AbstractEntityRepository
     * @throws \Exception when $qb is null and Repository has no QueryBuilder initialized
     */
    public function scopeByField($field, $value, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);
        if (strpos($value, '*') !== false) {
            $value = str_replace('*', '%', $value);
            $qb->andWhere(
                $qb->expr()->like($alias . '.' . $field, ':' . $field)
            );
        } else {
            $qb->andWhere(
                $qb->expr()->eq($alias . '.' . $field, ':' . $field)
            );
        }

        $qb->setParameter($field, $value);

        return $this;
    }

    /**
     * Take a Parameter that has match= in its value and Construct the Query
     *
     * eg. fullname=match=* Results in not filtering
     * eg. fullname=match=Mar Results in a result where fullname is like %Mar%
     *
     * @param              $field
     * @param string $value
     *
     * @return string
     */
    public function interpretMatchQuery($field, $value)
    {
        $query = substr($value, (strpos($value, '=') + 1));
        if ($query !== '*') {
            $query = '*' . $query . '*';
        }
        return $query;
    }

    /**
     * Evaluates if given value contains the keyword "match" and passes it to interpretMatchQuery if found
     *
     * @param string $field
     * @param string $value
     * @return string
     */

    public function interpretComplexQuery($field, $value)
    {
        if (is_string($value)) {
            if (strpos($value, 'match') !== false) {
                $value = $this->interpretMatchQuery($field, $value);
            }
        }
        return $value;
    }

    /**
     * Add different filter option to query
     *
     * @param array $filter
     * @param QueryBuilder $qb
     *
     * @return AbstractEntityRepository
     * @throws \Exception when $qb is null and Repository has no QueryBuilder initialized
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
                    default:
                        $this->scopeByField($key, $value, $qb);
                }
            }
        }
        return $this;
    }

    /**
     * Check if a join alias already taken. getRootAliases() doesn't do this for me.
     *
     * @param \Doctrine\ORM\QueryBuilder $qb , QueryBuilder you want to check
     * @param                            $alias , alias string
     *
     * @return bool
     */
    public function existsJoinAlias(QueryBuilder $qb, $alias)
    {
        $result = false;

        foreach ($qb->getDQLPart('join') as $joins) {
            /** @var Join $j */
            foreach ($joins as $j) {
                if ($j->getAlias() == $alias) {
                    $result = true;
                    break;
                }
            }
            if ($result) {
                break;
            }
        }

        return $result;
    }

    /**
     * Executes scopeWithTag for one or more values. scopewithTag has to be implemented in the child class.
     *
     * @param mixed $tags Pass an array here. If the value is no array, then it'll wrap one around it.
     * @param QueryBuilder|null $qb
     * @return AbstractEntityRepository
     */
    protected function scopeWithTags($tags, QueryBuilder $qb = null)
    {
        if (false == is_array($tags)) {
            $tags = array($tags);
        }
        foreach ($tags as $tag) {
            $qb = $this->scopeWithTag($tag, $qb);
        }
        return $this;
    }

    /**
     * Executes scopeWithoutTag for one or more values. scopeWithoutTag has to implemented in the child class.
     *
     * @param mixed $tags Pass an array here. If the value is no array, then it'll wrap one around it.
     * @param QueryBuilder|null $qb
     * @return AbstractEntityRepository
     */
    protected function scopeWithoutTags($tags, QueryBuilder $qb = null)
    {
        if (false == is_array($tags)) {
            $tags = array($tags);
        }
        foreach ($tags as $tag) {
            $qb = $this->scopeWithoutTag($tag, $qb);
        }
        return $this;
    }
}
