<?php

namespace Dime\TimetrackerBundle\Entity;


use Doctrine\ORM\QueryBuilder;

class ProjectCommentRepository extends EntityRepository
{

    /**
     *
     * @param string $text
     * @param QueryBuilder $qb
     *
     * @return QueryBuilder
     */
    public function search($text, QueryBuilder $qb = null)
    {
        return $qb;
    }
}