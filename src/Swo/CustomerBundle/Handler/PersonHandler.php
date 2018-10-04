<?php

namespace Swo\CustomerBundle\Handler;

use Dime\TimetrackerBundle\Handler\GenericHandler;
use Doctrine\ORM\QueryBuilder;
use Swo\CustomerBundle\Entity\Person;

class PersonHandler extends GenericHandler
{
    /**
     * @param array $person
     * @return bool
     */
    public function checkForDuplicatePerson(array $person)
    {
        [
            'firstName' => $firstName,
            'lastName' => $lastName,
            'company' => $company,
            'email' => $email
        ] = $person;

        /** @var QueryBuilder $qb */
        $qb = $this->repository->createQueryBuilder('p');

        $conditions = [];

        if (!empty(trim($firstName))) {
            $conditions[] = $qb->expr()->like('p.firstName', $qb->expr()->literal(trim($firstName)));
        }

        if (!empty(trim($lastName))) {
            $conditions[] = $qb->expr()->like('p.lastName', $qb->expr()->literal(trim($lastName)));
        }

        if (!empty(trim($email))) {
            $conditions[] = $qb->expr()->like('p.email', $qb->expr()->literal(trim($email)));
        }

        if (!empty(trim($company))) {
            $conditions[] = $qb->leftJoin('p.company', 'c')->expr()->like('c.name', $qb->expr()->literal(trim($company)));
        }

        if (empty($conditions)) {
            return false;
        }

        $qb->where($qb->expr()->andX(...$conditions));
        $result = $qb->getQuery()->getResult();
        return !empty($result);
    }

    public function doImport(array $persons)
    {
        $addressHandler = $this->container->get('swo.address.handler');
        $companyHandler = $this->container->get('swo.company.handler');
        $phoneHandler = $this->container->get('swo.phone.handler');
        $createdPersons = [];

        foreach ($persons as $person) {
            // take out phones, addresses and the company property
            $phones = $person['phoneNumbers'];
            unset($person['phoneNumbers']);
            $addresses = $person['addresses'];
            unset($person['addresses']);

            $company = null;
            if (!is_null($person['company'])) {
                $company = $person['company']['name'];
                unset($person['company']);
            }

            // check if company is existing and if yes, associate it to the person
            if (!is_null($company)) {
                /** @var QueryBuilder $companyQb */
                $companyQb = $companyHandler->repository->createQueryBuilder('c');
                $result = $companyQb->where(
                    $companyQb->expr()->eq('c.name', $companyQb->expr()->literal(trim($company)))
                )
                    ->getQuery()->getOneOrNullResult();
                if (!is_null($result)) {
                    $person['company'] = $result->getId();
                }
            }

            // create new person
            /** @var Person $newPerson */
            $newPerson = $this->post($person);

            // create new phones and addresses
            foreach ($addresses as $address) {
                $address['customer'] = $newPerson->getId();
                $addressHandler->post($address);
            }

            // create new phones and addresses
            foreach ($phones as $phone) {
                $phone['customer'] = $newPerson->getId();
                $phoneHandler->post($phone);
            }

            $createdPersons[] = $newPerson;
        }

        return $createdPersons;
    }
}
