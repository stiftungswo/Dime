<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

class CompanyRepository extends EntityRepository
{
    /**
     * @param string $text
     * @param QueryBuilder|null $qb
     * @return CompanyRepository
     */
    public function search($text, QueryBuilder $qb = null) : CompanyRepository
    {
        if (is_null($qb)) {
            $qb = $this->builder;
        }

        $aliases = $qb->getRootAliases();
        $alias = array_shift($aliases);

        $qb->andWhere($qb->expr()->like($alias . '.name', ':text_like'));
        $qb->setParameter('text_like', '%' . $text . '%');

        return $this;
    }
}
