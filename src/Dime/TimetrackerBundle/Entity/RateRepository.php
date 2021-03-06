<?php

namespace Dime\TimetrackerBundle\Entity;

use Doctrine\ORM\QueryBuilder;

/**
 * ServiceRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class RateRepository extends EntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string $text
     * @param QueryBuilder $qb
     * @return RateRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }

    /**
     *
     * @param                   $date
     * @param QueryBuilder $qb
     *
     * @return RateRepository
     */
    public function scopeByDate($date, QueryBuilder $qb = null)
    {
        return $this;
    }
}
