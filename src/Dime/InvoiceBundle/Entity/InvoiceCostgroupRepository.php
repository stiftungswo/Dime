<?php

namespace Dime\InvoiceBundle\Entity;

use Swo\CommonsBundle\Entity\AbstractEntityRepository;
use Doctrine\ORM\QueryBuilder;

class InvoiceCostgroupRepository extends AbstractEntityRepository
{
    /**
     * Search for name or alias
     *
     * @param string            $text
     * @param QueryBuilder      $qb
     *
     * @return InvoiceCostgroupRepository
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }
}
