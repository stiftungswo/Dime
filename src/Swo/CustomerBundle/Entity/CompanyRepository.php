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
        // currently no need, frontend does the search stuff
        return $this;
    }
}
