<?php

namespace Dime\InvoiceBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

/**
 * CostGroupRepository
 */
class CostGroupRepository extends EntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string            $text
     * @param QueryBuilder      $qb
     * @return CostGroupRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->like($alias . '.name', ':text_like'));
        $qb->setParameter('text_like', '%' . $text . '%');

        return $this;
    }
}
