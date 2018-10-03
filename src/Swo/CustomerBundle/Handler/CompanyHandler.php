<?php

namespace Swo\CustomerBundle\Handler;

use Dime\TimetrackerBundle\Handler\GenericHandler;

class CompanyHandler extends GenericHandler
{
    /**
     * @param array $company
     * @return array|bool
     */
    public function checkForDuplicateCompany(array $company)
    {
        [
            'name' => $name,
            'email' => $email
        ] = $company;

        $qb = $this->repository->createQueryBuilder('c');

        $conditions = [];

        if (!empty(trim($name))) {
            $conditions[] = $qb->expr()->like('c.name', $qb->expr()->literal(trim($name)));
        }

        if (!empty(trim($email))) {
            $conditions[] = $qb->expr()->like('c.email', $qb->expr()->literal(trim($email)));
        }

        if (empty($conditions)) {
            return [];
        }

        $qb->where($qb->expr()->orX(...$conditions));
        $result = $qb->getQuery()->getResult();
        return !empty($result);
    }
}
