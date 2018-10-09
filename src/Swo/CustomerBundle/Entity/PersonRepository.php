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
        // currently not needed, frontend does the search stuff
        return $this;
    }
}
