<?php

namespace Dime\TimetrackerBundle\Entity;

use Doctrine\ORM\QueryBuilder;

/**
 * ProjectRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class ProjectRepository extends EntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string $text
     * @param QueryBuilder $qb
     * @return ProjectRepository
     * @throws \Exception when $qb is null and Repository has no QueryBuilder initialized
     */
    public function search($text, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->orX(
            $qb->expr()->like($alias . '.description', ':text_like'),
            $qb->expr()->like($alias . '.name', ':text_like'),
            $qb->expr()->eq($alias . '.alias', ':text')
        ));
        $qb->setParameter('text_like', '%' . $text . '%');
        $qb->setParameter('text', $text);

        return $this;
    }

    /**
     *
     * @param                   $date
     * @param QueryBuilder $qb
     *
     * @return ProjectRepository
     */
    public function scopeByDate($date, QueryBuilder $qb = null)
    {
        return $this;
    }

    public function findByCustomer($customerid)
    {
        return $this->findBy(array('customer' => $customerid));
    }

    /**
     * Filter by assigned tag
     *
     * @param integer|string $tagIdOrName
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return ProjectRepository
     * @throws \Exception when $qb is null and Repository has no QueryBuilder initialized
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
     * @return ProjectRepository
     * @throws \Exception when $qb is null and Repository has no QueryBuilder initialized
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
                    ->from('Dime\TimetrackerBundle\Entity\Project', 'p2')
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
     * @param array $filter
     * @param \Doctrine\ORM\QueryBuilder $qb
     *
     * @return ProjectRepository
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
