<?php

namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

/**
 * UserRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class UserRepository extends EntityRepository
{
    /**
     *
     * @param string            $text
     * @param QueryBuilder      $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     */
    public function search($text, QueryBuilder $qb)
    {
        return $qb;
    }

    /**
     *
     * @param                   $date
     * @param QueryBuilder      $qb
     *
     * @return \Doctrine\ORM\QueryBuilder
     */
    public function scopeByDate($date, QueryBuilder $qb)
    {
        return $qb;
    }

}
