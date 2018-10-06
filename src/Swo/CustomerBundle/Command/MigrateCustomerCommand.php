<?php

namespace Swo\CustomerBundle\Command;

use Dime\OfferBundle\Entity\Offer;
use Dime\TimetrackerBundle\Entity\Customer as OldCustomer;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Handler\CustomerHandler;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\QueryBuilder;
use Swo\CommonsBundle\Entity\Address as OldAddress;
use Swo\CustomerBundle\Entity\Address as NewAddress;
use Swo\CustomerBundle\Entity\Company;
use Swo\CustomerBundle\Entity\Customer as NewCustomer;
use Swo\CustomerBundle\Entity\Person;
use Swo\CustomerBundle\Entity\Phone;
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
                /** @var OldCustomer $customer */

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
                $oldAddress = $customer->getAddress();
                $address = $this->createAddressIfValid($oldAddress, isset($company) ? $company : $person, $entityManager, $output);
                $output->writeln("Kunde mit der ID " . $customer->getId() . ' erfolgreich als neuer Kunde mit der ID ' . $person->getId() . ' erfasst.');

                // we need to fetch the projects, invoices and offers for this customer
                // and change out the stuff

                // start with offer
                $offerQb = $entityManager->getRepository('DimeOfferBundle:Offer')->createQueryBuilder('o');
                $result = $offerQb->where(
                    $offerQb->expr()->eq('o.old_customer', $offerQb->expr()->literal($customer->getId()))
                )->getQuery()->getResult();

                if (!empty($result)) {
                    // doctrine hydrated the object, so we can iterate over the offers
                    foreach ($result as $offer) {
                        /** @var Offer $offer */
                        // create new address if address from offer differs from the customer
                        if ($offer->getOldAddress()->getId() != $customer->getAddress()->getId()) {
                            $oldAddress = $offer->getOldAddress();
                            $offerAddress = $this->createAddressIfValid($oldAddress, isset($company) ? $company : $person, $entityManager, $output);
                        }

                        // attach new customer and address to offer
                        $offer->setAddress(isset($offerAddress) ? $offerAddress : $address);
                        $offer->setCustomer($person);
                        $entityManager->persist($offer);
                        $entityManager->flush();

                        if (is_null($address)) {
                            $output->writeln('Achtung: Kunde mit der alten ID ' . $customer->getId() . ' hatte weder auf sich selber noch auf der Offerte eine Addresse gesetzt! Bitte nachträglich eine gültige Addresse erfassen und bei Offerte ' . $offer->getId() . ' anhängen.');
                        } else {
                            $output->writeln('Offerte '  . $offer->getid() . ' erfolgreich mit Addresse ' . $address->getId() . ' assoziiert.');
                        }
                        $output->writeln('Offerte '  . $offer->getid() . ' erfolgreich mit Person ' . $person->getId() . ' assoziiert.');
                    }
                }

                // continue with project
                $projectQb = $entityManager->getRepository('DimeTimetrackerBundle:Project')->createQueryBuilder('o');
                $result = $projectQb->where(
                    $projectQb->expr()->eq('o.old_customer', $projectQb->expr()->literal($customer->getId()))
                )->getQuery()->getResult();

                if (!empty($result)) {
                    foreach ($result as $project) {
                        // attach new customer and address to project
                        /** @var Project $project */
                        $project->setAddress($address);
                        $project->setCustomer($person);
                        $entityManager->persist($project);
                        $entityManager->flush();

                        if (is_null($address)) {
                            $output->writeln('Achtung: Kunde mit der alten ID ' . $customer->getId() . ' hatte keine Addresse gesetzt! Bitte nachträglich eine gültige Addresse erfassen und bei Projekt ' . $project->getId() . ' anhängen.');
                        } else {
                            $output->writeln('Projekt '  . $project->getid() . ' erfolgreich mit Addresse ' . $address->getId() . ' assoziiert.');
                        }
                        $output->writeln('Projekt '  . $project->getid() . ' erfolgreich mit Person ' . $person->getId() . ' assoziiert.');
                    }
                }

                // end with invoice
                $invoiceQb = $entityManager->getRepository('DimeInvoiceBundle:Invoice')->createQueryBuilder('o');
                $result = $invoiceQb->where(
                    $invoiceQb->expr()->eq('o.old_customer', $invoiceQb->expr()->literal($customer->getId()))
                )->getQuery()->getResult();

                if (!empty($result)) {
                    foreach ($result as $invoice) {
                        // attach new customer and address to project
                        /** @var \Dime\InvoiceBundle\Entity\Invoice $invoice */
                        $invoice->setAddress($address);
                        $invoice->setCustomer($person);
                        $entityManager->persist($invoice);
                        $entityManager->flush();

                        if (is_null($address)) {
                            $output->writeln('Achtung: Kunde mit der alten ID ' . $customer->getId() . ' hatte keine Addresse gesetzt! Bitte nachträglich eine gültige Addresse erfassen und bei Rechnung ' . $invoice->getId() . ' anhängen.');
                        } else {
                            $output->writeln('Rechnung '  . $invoice->getid() . ' erfolgreich mit Addresse ' . $address->getId() . ' assoziiert.');
                        }
                        $output->writeln('Rechnung '  . $invoice->getid() . ' erfolgreich mit Person ' . $person->getId() . ' assoziiert.');
                    }
                }

                $output->writeln("Alle Daten von Kunde " . $customer->getId() . ' wurden erfolgreich migriert!');

            } catch (\Exception $e) {
                $output->writeln("Kunde mit der ID " . $customer->getId() . ' konnte nicht migriert werden. Bitte manuell prüfen.');
                $output->writeln($e->getMessage());
            }
        }
    }

    private function createAddressIfValid(OldAddress $oldAddress, NewCustomer $newCustomer, EntityManager $entityManager, OutputInterface $output)
    {
        if (empty($newCustomer->getAddresses()->toArray())) {
            // create new address
            $output->writeln('Keine Addressen für Kunde ' . $newCustomer . ' gefunden.');
            return $this->createAddress($oldAddress, $newCustomer, $entityManager, $output);
        } else {
            // convert addresses to array, unset the customer id and check if any difference is there
            $oldAddressArray = array(
                "street" => $oldAddress->getStreet(),
                "supplement" => $oldAddress->getSupplement(),
                "postcode" => $oldAddress->getPlz(),
                "city" => $oldAddress->getCity(),
                "country" => $oldAddress->getCountry(),
            );

            foreach($newCustomer->getAddresses()->toArray() as $address) {
                /** @var NewAddress $address */
                $newAddressArray = array(
                    "street" => $address->getStreet(),
                    "supplement" => $address->getSupplement(),
                    "postcode" => $address->getPostcode(),
                    "city" => $address->getCity(),
                    "country" => $address->getCountry(),
                );

                if ($oldAddressArray == $newAddressArray) {
                    $output->writeln('Alte Adresse ' . $oldAddress->getId() . ' war bereits für Kunde ' . $newCustomer->getId() . ' erfasst. Retourniere neue Adresse ' . $address->getId());
                    return $address;
                }
            }
            return $this->createAddress($oldAddress, $newCustomer, $entityManager, $output);
        }
    }

    private function createAddress(OldAddress $oldAddress, NewCustomer $newCustomer, EntityManager $entityManager, OutputInterface $output) {
        if (!is_null($oldAddress->getStreet()) && !is_null($oldAddress->getPlz()) && !is_null($oldAddress->getCity())) {
            $address = new NewAddress();
            $address->setStreet($oldAddress->getStreet());
            $address->setSupplement($oldAddress->getSupplement());
            $address->setPostcode($oldAddress->getPlz());
            $address->setCity($oldAddress->getCity());
            $address->setCountry($oldAddress->getCountry());
            $address->setCustomer($newCustomer);

            $entityManager->persist($address);
            $entityManager->flush();

            $newCustomer->addAddress($address);
            $entityManager->persist($newCustomer);
            $entityManager->flush();

            $output->writeln('Neue Adresse mit der ID ' . $address->getId() . ' für Kunde ' . $newCustomer->getId() . ' erstellt.');
            return $address;
        } else {
            $output->writeln('Achtung: Die alte Adresse mit der ID ' . $oldAddress->getId() . ' hatte entweder keine Strasse, keine PLZ oder keine Ortschaft gesetzt. Bitte überprüfen.');
            return null;
        }
    }
}
