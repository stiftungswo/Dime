<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

class AddressRepository extends EntityRepository
{
    /**
     * @param string $text
     * @param QueryBuilder|null $qb
     * @return AddressRepository
     */
    public function search($text, QueryBuilder $qb = null) : AddressRepository
    {
        if (is_null($qb)) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->like($alias . '.street', ':text_like'));
        $qb->andWhere($qb->expr()->like($alias . '.city', ':text_like'));
        $qb->setParameter('text_like', '%' . $text . '%');

        return $this;
    }
}
