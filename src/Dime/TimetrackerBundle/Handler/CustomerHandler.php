<?php

namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Entity\Customer;
use Dime\TimetrackerBundle\Entity\CustomerRepository;
use Dime\TimetrackerBundle\Entity\Tag;
use Doctrine\ORM\QueryBuilder;

class CustomerHandler extends GenericHandler
{

    /**
     * @param array $filter
     *
     * @return Customer[]
     */
    public function getFilteredCustomers(array $filter)
    {
        $filter = array_filter($filter);

        /** @var CustomerRepository $customerRepo */
        $customerRepo = $this->repository;
        $qb = $customerRepo->createQueryBuilder('c');

        if (isset($filter['systemCustomer']) && $filter['systemCustomer']) {
            $qb->andWhere($qb->expr()->eq('c.systemCustomer', 1));
        }

        if (isset($filter['search']) && $filter['search']) {
            $or = $qb->expr()->orX();
            $or->add($qb->expr()->like('c.id', ':search'));
            $or->add($qb->expr()->like('c.name', ':search'));
            $qb->setParameter('search', '%' . $filter['search'] . '%');
            $qb->andWhere($or);
        }

        if (isset($filter['withTags'])) {
            $qb->innerJoin('c.tags', 'tags');
        }

        /** @var Customer[] $result */
        $result = $qb->getQuery()->getResult();

        if (isset($filter['withTags'])) {
            $tags = array_map('intval', explode(',', $filter['withTags']));
            $filteredCustomers = [];
            foreach ($result as $customer) {
                foreach ($tags as $tagId) {
                    $found = false;
                    /** @var Tag $tag */
                    foreach ($customer->getTags() as $tag) {
                        if ($tag->getId() === $tagId) {
                            $found = true;
                        }
                    }
                    if (!$found) {
                        continue 2; // skip this customer
                    }
                }
                $filteredCustomers[] = $customer;
            }
            $result = $filteredCustomers;
        }

        return $result;
    }

    /**
     * @param array $customer
     *
     * @return Customer[]
     */
    public function checkForDuplicateCustomer(array $customer)
    {
        [
            'name'     => $name,
            'company'  => $company,
            'email'    => $email,
            'fullname' => $fullname,
        ] = $customer;

        /** @var QueryBuilder $qb */
        $qb = $this->repository->createQueryBuilder('c');
        $qb->where(
            $qb->expr()->orX(
                $qb->expr()->like('c.name', $qb->expr()->literal($name)),
                $qb->expr()->like('c.company', $qb->expr()->literal($company)),
                $qb->expr()->like('c.email', $qb->expr()->literal($email)),
                $qb->expr()->like('c.fullname', $qb->expr()->literal($fullname))
            )
        );

        $result = $qb->getQuery()->getResult();

        return $result;
    }
}
