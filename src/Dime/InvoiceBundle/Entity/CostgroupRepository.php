<?php

namespace Dime\InvoiceBundle\Entity;

use Doctrine\ORM\QueryBuilder;
use Swo\Commonsbundle\Entity\AbstractEntityRepository;

/**
 * CostgroupRepository
 */
class CostgroupRepository extends AbstractEntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string            $text
     * @param QueryBuilder      $qb
     * @return CostgroupRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->like($alias . '.description', ':text_like'));
        $qb->setParameter('text_like', '%' . $text . '%');

        return $this;
    }
}
