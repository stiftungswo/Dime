<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\QueryBuilder;
use Swo\Commonsbundle\Entity\AbstractEntityRepository;

/**
 * AbstractCustomerRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
abstract class AbstractCustomerRepository extends AbstractEntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string $text
     * @param QueryBuilder $qb
     * @return AbstractCustomerRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->orX(
            $qb->expr()->like($alias . '.name', ':text_like'),
            $qb->expr()->eq($alias . '.alias', ':text')
        ));
        $qb->setParameter('text_like', '%' . $text . '%');
        $qb->setParameter('text', $text);

        return $this;
    }
}
