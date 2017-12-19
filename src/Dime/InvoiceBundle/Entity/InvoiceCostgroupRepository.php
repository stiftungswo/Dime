<?php

namespace Dime\InvoiceBundle\Entity;

use Dime\TimetrackerBundle\Entity\EntityRepository;
use Doctrine\ORM\QueryBuilder;

class InvoiceCostgroupRepository extends EntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string            $text
     * @param QueryBuilder      $qb
     *
	 * @return InvoiceDiscountRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }

}
