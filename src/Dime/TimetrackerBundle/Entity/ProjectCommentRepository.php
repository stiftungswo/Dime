<?php

namespace Dime\TimetrackerBundle\Entity;

use Doctrine\ORM\QueryBuilder;
use Swo\CommonsBundle\Entity\AbstractEntityRepository;

class ProjectCommentRepository extends AbstractEntityRepository
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
