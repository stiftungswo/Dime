<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Customer;
use Dime\EmployeeBundle\Entity\Employee;
use Dime\InvoiceBundle\Entity\Invoice;
use Dime\OfferBundle\Entity\Offer;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\ProjectCategory;
use Dime\TimetrackerBundle\Entity\ProjectComment;
use Dime\TimetrackerBundle\Entity\RateGroup;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Tag;
use Dime\TimetrackerBundle\Entity\Timeslice;

use Doctrine\Common\Collections\ArrayCollection;
use Money\Money;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class ProjectTest extends KernelTestCase
{
    /**
     * @var \Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * {@inheritDoc}
     */

    // HELPERS
    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    protected function getRepo()
    {
        return $this->em->getRepository('DimeTimetrackerBundle:Project');
    }

    public function testGetCalculateCurrentPrice()
    {
        $rate_value = rand(0, 10);
        $charge = rand(0, 5000);

        // should contain nothing without a timeslice
        $activity = new Activity();
        $activity->setRateValue(Money::CHF($rate_value));
        $project = new Project();
        $project->setActivities(new ArrayCollection([$activity]));

        $this->assertEquals(Money::CHF(0), $project->calculateCurrentPrice());
        $this->assertEquals('0.00 CHF', $project->getCurrentPrice());

        // should contain something if it has a timeslice
        // important: does not test the logic in Activity#getCharge() for every scenario
        // so the multipliers below are not accurate for any scenario
        $timeslice = new Timeslice();
        $timeslice->setValue($charge);
        $activity->addTimeslice($timeslice);

        $result = Money::CHF($rate_value)->multiply($charge);
        $this->assertEquals(
            $result,
            $project->calculateCurrentPrice()
        );
        $this->assertEquals($result->format(true), $project->getCurrentPrice());
    }

    public function testGetRemainingBudgetPrice()
    {
        // should return null if project has no budget price
        $project = new Project();
        $project->setBudgetPrice(null);

        $this->assertNull($project->getRemainingBudgetPrice());

        // should return a subtraction from the used price and the budget price
        $rate_value = rand(1, 5);
        $charge = rand(0, 5000);
        $budget_price = rand(0, 25000);

        $timeslice = new Timeslice();
        $timeslice->setValue($charge);
        $activity = new Activity();
        $timeslice->setValue($charge);
        $activity->addTimeslice($timeslice);
        $activity->setRateValue(Money::CHF($rate_value));
        $project->setActivities(new ArrayCollection([$activity]));
        $project->setBudgetPrice(Money::CHF($budget_price));

        $result = Money::CHF($budget_price)->subtract(Money::CHF($rate_value)->multiply($charge));
        $this->assertEquals($result->format(true), $project->getRemainingBudgetPrice());
    }

    public function testGetCurrentTime()
    {
        // should not return anything if activity has no rateunittype
        $project = new Project();
        $activity = new Activity();
        $activity->setRateUnitType(null);
        $project->setActivities(new ArrayCollection([$activity]));

        $this->assertEquals('0.00 h', $project->getCurrentTime());

        // should not return anything if activity's rateunittype has symbol "a"
        $rate_unit_type = new RateUnitType();
        $rate_unit_type->setId('a');
        $activity->setRateUnitType($rate_unit_type);
        $project->setActivities(new ArrayCollection([$activity]));

        $this->assertEquals('0.00 h', $project->getCurrentTime());

        // should return a value
        $rand_num = rand(5, 35);
        $rate_unit_type->setId('h');
        $timeslice = new Timeslice();
        $timeslice->setValue($rand_num * 3600);
        $activity->addTimeslice($timeslice);

        $this->assertEquals(number_format($rand_num, 2) . ' h', $project->getCurrentTime());
    }

    public function testGetRemainingBudgetTime()
    {
        // should not return anything if project has no budget time
        $project = new Project();
        $project->setBudgetTime(null);

        $this->assertNull($project->getRemainingBudgetTime());

        // should return remaining budget time
        $budget_time = rand(5, 35);
        $booked_time = rand(1, 50);

        $rate_unit_type = new RateUnitType();
        $rate_unit_type->setId('h');
        $timeslice = new Timeslice();
        $timeslice->setValue($booked_time * 3600);
        $activity = new Activity();
        $activity->setRateUnitType($rate_unit_type);
        $activity->addTimeslice($timeslice);
        $project->setBudgetTime($budget_time);
        $project->setActivities(new ArrayCollection([$activity]));

        $expect = number_format($budget_time - $booked_time, 2) . ' h';
        $this->assertEquals($expect, $project->getRemainingBudgetTime());
    }

    public function testSerializeBudgetTime()
    {
        // should not return anything if project has no budget time
        $project = new Project();
        $project->setBudgetTime(null);

        $this->assertNull($project->serializeBudgetTime());

        // should return the value
        $value = rand(0, 678);
        $project->setBudgetTime($value);

        $this->assertEquals(
            number_format($value, 2) . ' h',
            $project->serializeBudgetTime()
        );
    }

    public function testSerializeBudgetPrice()
    {
        // should return nothing if project has no budget
        $project = new Project();
        $project->setBudgetPrice(null);

        $this->assertNull($project->serializeBudgetPrice());

        // should return nothing if project budget is 0
        $project->setBudgetPrice(0);

        $this->assertNull($project->serializeBudgetPrice());

        // should return budget price
        $value = rand(0, 456);
        $project->setBudgetPrice(Money::CHF($value));

        $this->assertEquals(Money::CHF($value)->format(true), $project->serializeBudgetPrice());
    }

    public function testGetSetIsChargeable()
    {
        // get and set chargeable
        $project = new Project();
        $this->assertNull($project->isChargeable());
        $project->setChargeable(true);
        $this->assertEquals(true, $project->isChargeable());
    }

    public function testGetSetCustomer()
    {
        // get and set customer
        $project = new Project();
        $project_category = new Customer();
        $this->assertNull($project->getOldCustomer());
        // TODO adapt to new Customer entity
        $project->setOldCustomer($project_category);
        $this->assertEquals($project_category, $project->getOldCustomer());
    }

    public function testGetSetName()
    {
        // get and set name
        $project = new Project();
        $this->assertNull($project->getName());
        $project->setName('name');
        $this->assertEquals('name', $project->getName());
    }

    public function testGetSetAlias()
    {
        // get and set name
        $project = new Project();
        $this->assertNull($project->getAlias());
        $project->setAlias('name');
        $this->assertEquals('name', $project->getAlias());
    }

    public function testGetSetStartedAt()
    {
        // get and set startedAt
        $dt = new \DateTime();
        $project = new Project();
        $this->assertNull($project->getstartedAt());
        $project->setstartedAt($dt);
        $this->assertEquals($dt, $project->getstartedAt());
    }

    public function testGetSetStoppedAt()
    {
        // get and set stoppedAt
        $dt = new \DateTime();
        $project = new Project();
        $this->assertNull($project->getstoppedAt());
        $project->setstoppedAt($dt);
        $this->assertEquals($dt, $project->getstoppedAt());
    }

    public function testGetSetDeadline()
    {
        // get and set Deadline
        $dt = new \DateTime();
        $project = new Project();
        $this->assertNull($project->getDeadline());
        $project->setDeadline($dt);
        $this->assertEquals($dt, $project->getDeadline());
    }

    public function testGetSetDescription()
    {
        // get and set description
        $project = new Project();
        $description = 'some description, really gud project trust me';
        $this->assertNull($project->getDescription());
        $project->setDescription($description);
        $this->assertEquals($description, $project->getDescription());
    }

    public function testGetSetBudgetPrice()
    {
        // get and set budget price
        $project = new Project();
        $money = Money::CHF(rand(0, 85000));
        $this->assertNull($project->getBudgetPrice());
        $project->setBudgetPrice($money);
        $this->assertEquals($money, $project->getBudgetPrice());
    }

    public function testGetSetFixedPrice()
    {
        // get and set fixed price
        $project = new Project();
        $money = Money::CHF(rand(0, 85000));
        $this->assertNull($project->getFixedPrice());
        $project->setFixedPrice($money);
        $this->assertEquals($money, $project->getFixedPrice());
        $this->assertEquals($money, $project->getBudgetPrice());
    }

    public function testSerializeFixedPrice()
    {
        // should not return anything if project has no fixed price
        $project = new Project();
        $project->setFixedPrice(null);

        $this->assertNull($project->serializeFixedPrice());

        // should return nothing if project price is 0
        $project->setFixedPrice(0);

        $this->assertNull($project->serializeFixedPrice());

        // should return the value
        $money = Money::CHF(rand(0, 85000));
        $project->setFixedPrice($money);

        $this->assertEquals($money->format(), $project->serializeFixedPrice());
    }

    public function testGetSetBudgetTime()
    {
        // get and set budget time
        $project = new Project();
        $this->assertNull($project->getBudgetTime());
        $project->setBudgetTime('3h');
        $this->assertEquals(3 * 3600, $project->getBudgetTime());
    }

    public function testToString()
    {
        // should return id if project has no name
        // use an object from the database in this case because we need an id
        $project = new Project();
        $project->setName(null);

        $this->assertEquals('', (string)$project);

        // should return name
        $project->setName('eh name');
        $this->assertEquals('eh name', (string)$project);
    }

    public function testTags()
    {
        // project has by default no tags
        $project = new Project();
        $this->assertEquals(0, count($project->getTags()));

        // but we can add one
        $tag = new Tag();
        $project->addTag($tag);
        $this->assertEquals(1, count($project->getTags()));

        // and remove it
        $project->removeTag($tag);
        $this->assertEquals(0, count($project->getTags()));

        // and it's also possible to pass an Array
        $project->setTags(new ArrayCollection([$tag]));
        $this->assertEquals(1, count($project->getTags()));
    }

    public function testGetSetRateGroup()
    {
        // get and set rate group
        $project = new Project();
        $rate_group = new RateGroup();
        $this->assertNull($project->getRateGroup());
        $project->setRateGroup($rate_group);
        $this->assertEquals($rate_group, $project->getRateGroup());
    }

    public function testSetCreatedAt()
    {
        // get and set created at
        $project = new Project();
        $dt = new \DateTime();
        $this->assertNull($project->getCreatedAt());
        $project->setCreatedAt($dt);
        $this->assertEquals($dt, $project->getCreatedAt());
    }

    public function testSetUpdatedAt()
    {
        // get and set updated at
        $project = new Project();
        $dt = new \DateTime();
        $this->assertNull($project->getUpdatedAt());
        $project->setUpdatedAt($dt);
        $this->assertEquals($dt, $project->getUpdatedAt());
    }

    public function testActivities()
    {
        // project has by default no activities
        $project = new Project();
        $this->assertEquals(0, count($project->getActivities()));

        // but we can add one
        $activity = new Activity();
        $project->addActivity($activity);
        $this->assertEquals(1, count($project->getActivities()));

        // and remove it
        $project->removeActivity($activity);
        $this->assertEquals(0, count($project->getActivities()));

        // and it's also possible to pass an Array
        $project->setActivities(new ArrayCollection([$activity]));
        $this->assertEquals(1, count($project->getActivities()));
    }

    public function testGetSetProjectCategory()
    {
        // get and set project category
        $project = new Project();
        $project_category = new ProjectCategory();
        $this->assertNull($project->getProjectCategory());
        $project->setProjectCategory($project_category);
        $this->assertEquals($project_category, $project->getProjectCategory());
    }

    public function testInvoices()
    {
        // project has by default no offers
        $project = new Project();
        $this->assertEquals(0, count($project->getInvoices()));

        // but we can add multiple ones
        $invoice = new Invoice();
        $project->setInvoices(new ArrayCollection([$invoice]));
        $this->assertEquals(1, count($project->getInvoices()));

        // we can add another one
        $project->addInvoice($invoice);
        $this->assertEquals(2, count($project->getInvoices()));

        // and remove it
        $project->removeInvoice($invoice);
        $this->assertEquals(1, count($project->getInvoices()));
    }

    public function testGetSetProjectComments()
    {
        // get and set project category
        $project = new Project();
        $project_comment = new ArrayCollection([new ProjectComment()]);
        $this->assertNull($project->getComments());
        $project->setComments($project_comment);
        $this->assertEquals($project_comment, $project->getComments());
    }

    public function testOffers()
    {
        // project has by default no offers
        $project = new Project();
        $this->assertEquals(0, count($project->getOffers()));

        // but we can add multiple ones
        $offer = new Offer();
        $project->setOffers(new ArrayCollection([$offer]));
        $this->assertEquals(1, count($project->getOffers()));

        // we can add another one
        $project->addOffer($offer);
        $this->assertEquals(2, count($project->getOffers()));

        // and remove it
        $project->removeOffer($offer);
        $this->assertEquals(1, count($project->getOffers()));
    }

    public function testGetSetAccountant()
    {
        // get and set project category
        $project = new Project();
        $employee = new Employee();
        $this->assertNull($project->getAccountant());
        $project->setAccountant($employee);
        $this->assertEquals($employee, $project->getAccountant());
    }

    protected function tearDown()
    {
        parent::tearDown();

        $this->em->close();
        $this->em = null; // avoid memory leaks
    }
}
