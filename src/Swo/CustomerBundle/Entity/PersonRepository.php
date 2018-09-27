<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

class PersonRepository extends EntityRepository
{
    /**
     * @param string $text
     * @param QueryBuilder|null $qb
     * @return PersonRepository
     */
    public function search($text, QueryBuilder $qb = null) : PersonRepository
    {
        if (is_null($qb)) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->orX(
            $qb->expr()->like($alias . '.last_name', ':text_like'),
            $qb->expr()->eq($alias . '.first_name', ':text_like')
        ));
        $qb->setParameter('text_like', '%' . $text . '%');

        return $this;
    }
}
