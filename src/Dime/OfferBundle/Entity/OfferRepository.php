<?php

namespace Dime\OfferBundle\Entity;

use Swo\CommonsBundle\Entity\AbstractEntityRepository;
use Doctrine\ORM\QueryBuilder;

/**
 * OfferRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class OfferRepository extends AbstractEntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string            $text
     * @param QueryBuilder      $qb
     * @return OfferRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        if ($qb == null) {
            $qb = $this->builder;
        }
    
        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);
    
        $qb->andWhere($qb->expr()->orX(
            $qb->expr()->like($alias . '.name', ':text_like')
        ));
        $qb->setParameter('text_like', '%' . $text . '%');
    
        return $this;
    }
    
    /**
     *
     * @param                   $date
     * @param QueryBuilder      $qb
     *
     * @return OfferRepository
     */
    public function scopeByDate($date, QueryBuilder $qb = null)
    {
        return $this;
    }
}
