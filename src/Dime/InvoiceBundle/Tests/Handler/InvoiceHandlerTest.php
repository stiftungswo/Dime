<?php

namespace Dime\InvoiceBundle\Tests\Handler;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\Activity;
use Dime\EmployeeBundle\Entity\Employee;
use Dime\InvoiceBundle\Entity\Invoice;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\InvoiceBundle\Handler\InvoiceHandler;
use Dime\OfferBundle\Entity\Offer;
use Dime\OfferBundle\Entity\OfferDiscount;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\Service;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Swo\CustomerBundle\Entity\Company;

use Faker;
use Money\Money;
use ReflectionClass;

class InvoiceHandlerTest extends KernelTestCase
{

    /**
     * @var \Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * {@inheritDoc}
     */

    // according to https://symfony.com/doc/current/testing/doctrine.html
    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    // HELPER METHODS
    protected function createScaffoldTestData()
    {
        $activity = new Activity();
        $customer = new Company();
        $employee = new Employee();
        $faker = Faker\Factory::create();
        $invoice = new Invoice();
        $offer = new Offer();
        $offer_discount = new OfferDiscount();
        $project = new Project();
        $service = new Service();
        $timeslice = new Timeslice();

        $customer->setName($faker->company);
        $customer->setChargeable(true);

        $project->setName($faker->word);
        $project->setDescription($faker->paragraph);
        $project->setCustomer($customer);
        $project->setAccountant($employee);

        $offer_discount->setOffer($offer);
        $offer_discount->setName($faker->word);
        $offer->addOfferDiscount($offer_discount);

        $employee->setUsername($faker->userName);
        $employee->setUsernameCanonical($faker->userName);
        $employee->setEmail($faker->email);
        $employee->setEmailCanonical($faker->email);
        $employee->setEnabled(true);
        $employee->setPassword($faker->password);
        $employee->setFirstname($faker->firstName);
        $employee->setLastname($faker->lastName);

        $service->setName($faker->word);
        $service->setAlias($faker->words(3, true));
        $service->setDescription($faker->paragraph);
        $service->setChargeable(true);
        $service->setVat(0.077);

        $rate_unit_type = $this->em->getRepository('DimeTimetrackerBundle:RateUnitType')
            ->find('h');

        $activity->setProject($project);
        $activity->setService($service);
        $activity->setDescription($faker->sentence);
        $activity->setRateValue(Money::CHF($faker->randomNumber(3)));
        $activity->setChargeable(true);
        $activity->setVat(0.077);
        $activity->setRateUnit('CHF/h');
        $activity->setRateUnitType($rate_unit_type);

        $timeslice->setActivity($activity);
        $timeslice->setEmployee($employee);
        $timeslice->setValue(3600);

        $invoice->setProject($project);
        $invoice->setCustomer($customer);
        $invoice->setAccountant($employee);
        $invoice->setName($faker->word);
        $invoice->setAlias($faker->words(3, true));
        $invoice->setDescription($faker->paragraph);

        $entities = ['customer' => $customer, 'employee' => $employee, 'service' => $service,
            'project' => $project, 'offer' => $offer, 'offer_discount' => $offer_discount,
            'activity' => $activity, 'timeslice' => $timeslice, 'invoice' => $invoice];

        foreach ($entities as $key => $entity) {
            $this->em->persist($entity);
            $this->em->flush();
        }

        return $entities;
    }

    protected function removeScaffoldData($entities)
    {
        foreach (array_reverse($entities) as $key => $entity) {
            // need to remove a few things before we can remove certain objects
            if ($key == 'timeslice') {
                /** @var Timeslice $entity */
                $entity->setEmployee(null);
                $this->em->persist($entity);
            }

            if ($key == 'project' || $key == 'invoice') {
                /** @var Project|Invoice $entity */
                $entity->setAccountant(null);
                $this->em->persist($entity);
            }

            $this->em->remove($entity);
            $this->em->flush();
        }
    }

    protected function getInvoiceHandlerMock($employee)
    {
        $mock = $this->getMockBuilder(InvoiceHandler::class)
            ->setMethods(['getCurrentUser'])
            ->disableOriginalConstructor()->getMock();
        $this->setProtectedProperty(
            $mock,
            'repository',
            $this->em->getRepository('DimeInvoiceBundle:Invoice')
        );
        $this->setProtectedProperty($mock, 'om', $this->em);
        $mock->method('getCurrentUser')->willReturn($employee);

        return $mock;
    }

    protected function setProtectedProperty($object, $property, $value)
    {
        $reflection = new ReflectionClass($object);
        $reflection_property = $reflection->getProperty($property);
        $reflection_property->setAccessible(true);
        $reflection_property->setValue($object, $value);
    }

    // TESTS
    public function testCreateFromProject()
    {
        // seed provisional test data
        $entities = $this->createScaffoldTestData();
        $invoice_handler = $this->getInvoiceHandlerMock($entities['employee']);

        /*      */
        // it should create an invoice for the whole time span if no other invoice is present
        $entities['timeslice']->setStartedAt(new \DateTime('2001-01-01'));
        $entities['invoice']->setStart(new \DateTime('2010-01-01'));
        $entities['invoice']->setEnd(new \DateTime('2010-02-01'));
        $entities['invoice']->setProject(null);
        $this->em->persist($entities['timeslice']);
        $this->em->persist($entities['invoice']);
        $this->em->flush();

        $calculated_invoice = $invoice_handler->createFromProject($entities['project']);
        $this->assertEquals(
            $entities['timeslice']->getStartedAt(),
            $calculated_invoice->getStart()
        );
        $this->assertEquals(
            $entities['timeslice']->getStoppedAt(),
            $calculated_invoice->getEnd()
        );

        /*      */
        // it should create an invoice for the whole time span if existing invoice is missing the end date
        $calculated_invoice->setEnd(null);
        $this->em->persist($calculated_invoice);
        $this->em->flush();

        $new_calc = $invoice_handler->createFromProject($entities['project']);
        $this->assertEquals(
            $entities['timeslice']->getStartedAt(),
            $new_calc->getStart()
        );
        $this->assertEquals(
            $entities['timeslice']->getStoppedAt(),
            $new_calc->getEnd()
        );

        // remove this new invoice
        $this->em->remove($new_calc);
        $this->em->remove($calculated_invoice);

        /*      */
        // it should create an invoice, based on the end date from the last invoice
        // new end date should be the last date for the timeslice
        $entities['invoice']->setProject($entities['project']);
        $entities['timeslice']->setStartedAt(new \DateTime('2011-01-01'));
        $this->em->persist($entities['invoice']);
        $this->em->persist($entities['timeslice']);
        $this->em->flush();

        $calculated_invoice = $invoice_handler->createFromProject($entities['project']);
        $this->assertEquals(
            $entities['invoice']->getEnd()->addDay(),
            $calculated_invoice->getStart()
        );
        $this->assertEquals(
            $entities['timeslice']->getStoppedAt(),
            $calculated_invoice->getEnd()
        );

        // remove this invoice
        $this->em->remove($calculated_invoice);

        /*      */
        // it should take offer discount from existing offer
        $entities['offer']->setProject($entities['project']); //assign offer to project
        $this->em->persist($entities['offer']);
        $this->em->flush();

        $calculated_invoice = $invoice_handler->createFromProject($entities['project']);
        $this->assertEquals(1, count($calculated_invoice->getInvoiceDiscounts()));
        $this->assertEquals(
            $entities['offer_discount']->getName(),
            $calculated_invoice->getInvoiceDiscounts()[0]->getName()
        );
        $this->assertEquals(
            $entities['offer_discount']->getValue(),
            $calculated_invoice->getInvoiceDiscounts()[0]->getValue()
        );

        // remove this invoice
        $this->em->remove($calculated_invoice);

        /*      */
        // it should fill in invoice item if activity has a service assigned
        $entities['project']->addActivity($entities['activity']);
        $this->em->persist($entities['project']);
        $this->em->flush();

        $calculated_invoice = $invoice_handler->createFromProject($entities['project']);
        $this->assertEquals(1, count($calculated_invoice->getItems()));

        // remove invoice and item
        $this->em->remove($calculated_invoice->getItems()[0]);
        $this->em->remove($calculated_invoice);

        // remove all created data to keep the test database clean
        $this->removeScaffoldData($entities);
    }

    public function testUpdateInvoice()
    {
        $entities = $this->createScaffoldTestData();
        $invoice_handler = $this->getInvoiceHandlerMock($entities['employee']);

        /*      */
        // if invoice has an item, which is already associated to an activity, it should update
        $entities['project']->addActivity($entities['activity']);
        $invoice_item = new InvoiceItem();
        $invoice_item->setActivity($entities['activity']);
        $invoice_item->setName($entities['service']->getName());
        $invoice_item->setInvoice($entities['invoice']);
        $entities['invoice']->addItem($invoice_item);
        $entities['service']->setName('new name!');
        $this->em->persist($entities['invoice']);
        $this->em->persist($invoice_item);
        $this->em->persist($entities['service']);
        $this->em->persist($entities['activity']);
        $this->em->flush();

        $updated_invoice = $invoice_handler->updateInvoice($entities['invoice']);
        $this->assertEquals('new name!', $updated_invoice->getItems()[0]->getName());
        $this->assertEquals($entities['activity'], $updated_invoice->getItems()[0]->getActivity());

        // remove item from invoice and item itself
        $entities['invoice']->removeItem($invoice_item);
        $this->em->remove($invoice_item);
        $this->em->flush();

        /*      */
        // if invoice has no item for an activity, it should insert an item
        $this->assertEquals(0, count($entities['invoice']->getItems()));
        $updated_invoice = $invoice_handler->updateInvoice($entities['invoice']);
        $this->assertEquals($entities['activity'], $updated_invoice->getItems()[0]->getActivity());

        // remove all created data to keep the test database clean
        $this->removeScaffoldData($entities);
    }

    protected function tearDown()
    {
        parent::tearDown();

        $this->em->close();
        $this->em = null; // avoid memory leaks
    }
}
