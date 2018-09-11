<?php
/**
 * Created by PhpStorm.
 * User: Yves
 * Date: 29.01.2015
 * Time: 11:30
 */

namespace Dime\EmployeeBundle\Entity;

use Swo\CommonsBundle\Entity\AbstractEntityRepository;
use Doctrine\ORM\QueryBuilder;

/**
 * EmployeeRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class EmployeeRepository extends AbstractEntityRepository
{

    /**
     *
     * @param                   $date
     * @param QueryBuilder      $qb
     *
     * @return EmployeeRepository
     */
    public function scopeByDate($date, QueryBuilder $qb = null)
    {
        return $this;
    }

    /**
     * Filter by assigned tag
     *
     * @param integer|string             $tagIdOrName
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return EmployeeRepository
     */
    public function scopeWithTag($tagIdOrName, QueryBuilder $qb = null)
    {
        // Employee's (respectively User) don't have a tag
        return $this;
    }

    /**
     * Filter by not-assigned tag
     *
     * @param integer|string             $tagIdOrName
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return EmployeeRepository
     */
    public function scopeWithoutTag($tagIdOrName, QueryBuilder $qb = null)
    {
        // Employee's (respectively User) don't have a tag
        return $this;
    }

    /**
     * Add different filter option to query
     *
     * @param array                      $filter
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return EmployeeRepository
     */
    public function filter(array $filter, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        if ($filter != null) {
            foreach ($filter as $key => $value) {
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
                    default:
                        $this->scopeByField($key, $value, $qb);
                }
            }
        }
        return $this;
    }

    /**
     *
     * @param string $text
     * @param QueryBuilder $qb
     *
     * @return EmployeeRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }
}
