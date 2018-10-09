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
        // currently not needed, frontend does the search stuff
        return $this;
    }
}
