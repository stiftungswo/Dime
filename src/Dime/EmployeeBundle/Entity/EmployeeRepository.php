<?php
/**
 * Created by PhpStorm.
 * User: Yves
 * Date: 29.01.2015
 * Time: 11:30
 */

namespace Dime\EmployeeBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

/**
 * EmployeeRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class EmployeeRepository extends EntityRepository
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

    public function findByCustomer($customerid)
    {
        return $this->findBy(array('customer' => $customerid));
    }

    public function findByService($serviceId)
    {
        return $this->findBy(array('service' => $serviceId));
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
                $qb2->select('p2.id')
                    ->from('Dime\TimetrackerBundle\Entity\Employee', 'p2')
                    ->join('p2.tags', 'x2')
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
     * @return QueryBuilder
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }
}
