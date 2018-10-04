<?php

namespace Swo\CustomerBundle\Command;

use Dime\TimetrackerBundle\Entity\Customer;
use Dime\TimetrackerBundle\Handler\CustomerHandler;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\QueryBuilder;
use Swo\CustomerBundle\Entity\Address as NewAddress;
use Swo\CustomerBundle\Entity\Company;
use Swo\CustomerBundle\Entity\Person;
use Swo\CustomerBundle\Entity\Phone;
use Swo\CustomerBundle\Handler\PersonHandler;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class MigrateCustomerCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            // the name of the command
        ->setName('customers:migrate')
        ->setDescription('Migrates the Customers from the customers Table to new Person entities');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        // outputs multiple lines to the console (adding "\n" at the end of each line)
        $output->writeln([
            'Customer Migration Command',
            '============',
            '',
        ]);

        // fetch all customers
        /** @var CustomerHandler $customerHandler */
        $customerHandler = $this->getContainer()->get('dime.customer.handler');
        /** @var EntityManager $entityManager */
        $entityManager = $this->getContainer()->get('doctrine')->getManager();

        $customers = $customerHandler->all();

        foreach ($customers as $customer) {
            try {
                /** @var Customer $customer */

                // if existing customer has company field filled out, check if we have this company already
                // if not, create it, otherwise use the existing one
                if (!is_null($customer->getCompany())) {
                    /** @var QueryBuilder $companyQb */
                    $companyName = trim($customer->getCompany()) . ' (Migriert)';
                    $companyQb = $entityManager->getRepository('SwoCustomerBundle:Company')->createQueryBuilder('c');
                    $result = $companyQb->where(
                        $companyQb->expr()->eq('c.name', $companyQb->expr()->literal($companyName))
                    )
                        ->getQuery()->getOneOrNullResult();
                    if (is_null($result)) {
                        $company = new Company();
                        $company->setName($customer->getCompany() . ' (Migriert)');
                        $company->setRateGroup($customer->getRateGroup());
                        $company->setChargeable($customer->getChargeable());
                        $company->setHideForBusiness(!$customer->isSystemCustomer());

                        $entityManager->persist($company);
                        $entityManager->flush();
                    } else {
                        $company = $result;
                    }
                }

                // create new company person
                if (is_null($customer->getFullname())) {
                    $parts = explode(' ', $customer->getName());
                } else {
                    $parts = explode(' ', $customer->getFullname());
                }
                $lastName = array_pop($parts);
                $firstName = array(implode(' ', $parts), $lastName);

                $person = new Person();
                $person->setSalutation($customer->getSalutation());
                $person->setFirstName($firstName[0]);
                $person->setLastName($lastName . ' (Migriert)');
                $person->setEmail($customer->getEmail());
                $person->setComment($customer->getComment());

                if (is_null($customer->getCompany())) {
                    $person->setRateGroup($customer->getRateGroup());
                    $person->setChargeable($customer->getChargeable());
                    $person->setHideForBusiness(!$customer->isSystemCustomer());
                } else {
                    $person->setCompany($company);
                }

                $entityManager->persist($person);
                $entityManager->flush();

                // create new direct number if set
                if (!is_null($customer->getPhone())) {
                    $phone = new Phone();
                    $phone->setNumber($customer->getPhone());
                    $phone->setCategory(2);
                    $phone->setCustomer($person);

                    $entityManager->persist($phone);
                    $entityManager->flush();
                }

                // create new mobile number if set
                if (!is_null($customer->getMobilephone())) {
                    $phone = new Phone();
                    $phone->setNumber($customer->getMobilephone());
                    $phone->setCategory(4);
                    $phone->setCustomer($person);

                    $entityManager->persist($phone);
                    $entityManager->flush();
                }

                // create new address
                $address = new NewAddress();
                $oldAddress = $customer->getAddress();

                if (!is_null($oldAddress->getStreet()) && !is_null($oldAddress->getPlz()) && !is_null($oldAddress->getCity())) {
                    $address->setStreet($oldAddress->getStreet());
                    $address->setSupplement($oldAddress->getSupplement());
                    $address->setPostcode($oldAddress->getPlz());
                    $address->setCity($oldAddress->getCity());
                    $address->setCountry($oldAddress->getCountry());
                    $address->setCustomer(!is_null($customer->getCompany()) ? $company : $person);

                    $entityManager->persist($address);
                }
                $entityManager->flush();

                $output->writeln("Kunde mit der ID " . $customer->getId() . ' erfolgreich als neuer Kunde erfasst.');

                // now the tricky part
                // we need to fetch the projects, invoices and offers for this customer
                //
            } catch (\Exception $e) {
                $output->writeln("Kunde mit der ID " . $customer->getId() . ' konnte nicht migriert werden. Bitte manuell prüfen.');
                $output->writeln($e->getMessage());
            }
        }
    }
}
