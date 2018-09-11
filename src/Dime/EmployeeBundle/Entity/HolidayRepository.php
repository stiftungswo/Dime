<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;

use Swo\CommonsBundle\Entity\AbstractEntityRepository;
use Doctrine\ORM\QueryBuilder;

class HolidayRepository extends AbstractEntityRepository
{

    /**
     *
     * @param string       $text
     * @param QueryBuilder $qb
     *
     * @return HolidayRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }
}
