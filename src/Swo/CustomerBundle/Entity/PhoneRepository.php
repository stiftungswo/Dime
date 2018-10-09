<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

class PhoneRepository extends EntityRepository
{
    public function search($text, QueryBuilder $qb = null) : PhoneRepository
    {
        // currently not needed, frontend does the search stuff
        return $this;
    }
}
