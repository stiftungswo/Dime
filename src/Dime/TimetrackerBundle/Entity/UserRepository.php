<?php

namespace Dime\TimetrackerBundle\Entity;

use Doctrine\ORM\QueryBuilder;

/**
 * UserRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class UserRepository extends EntityRepository
{
    /**
     *
     * @param string $text
     * @param QueryBuilder $qb
     *
     * @return UserRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }

    /**
     *
     * @param                   $date
     * @param QueryBuilder $qb
     *
     * @return UserRepository
     */
    public function scopeByDate($date, QueryBuilder $qb = null)
    {
        return $this;
    }

    /**
     * @param $value
     * @param $qb
     *
     * @return $this
     */
    public function scopeByFullname($value, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);
        $value = str_replace('*', '%', $value);
        if (strpos($value, ' ') !== false) {
            $fullname = str_split($value, strpos($value, ' '));
            if (is_array($fullname)) {
                $firstname = trim($fullname[0]);
                $lastname = trim($fullname[1]);
            } else {
                $firstname = $fullname;
                $lastname = null;
            }
        } else {
            $firstname = $value;
            $lastname = null;
        }

        if (!$lastname) {
            $qb->Where(
                $qb->expr()->like($alias . '.firstname', ':param')
            );
            $qb->orWhere(
                $qb->expr()->like($alias . '.lastname', ':param')
            );
            $qb->setParameter('param', $firstname);
        } else {
            $qb->Where(
                $qb->expr()->like($alias . '.firstname', ':firstname')
            );
            $qb->andWhere(
                $qb->expr()->like($alias . '.lastname', ':lastname')
            );
            $qb->setParameter('firstname', $firstname);
            $qb->setParameter('lastname', $lastname);
        }

        return $this;
    }

    /**
     * Add different filter option to query
     *
     * @param array $filter
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
                    case 'fullname':
                        $this->scopeByFullname($value, $qb);
                        break;
                    default:
                        $this->scopeByField($key, $value, $qb);
                        break;
                }
            }
        }
        return $this;
    }
}
