<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Swo\CommonsBundle\Entity\Address;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Entity\Customer;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Swo\CommonsBundle\Entity\Phone;
use Dime\TimetrackerBundle\Entity\RateGroup;
use Dime\TimetrackerBundle\Entity\Tag;

class CustomerTest extends KernelTestCase
{

    /**
     * @var \Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * {@inheritDoc}
     */

    function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    function testGetSetChargeable()
    {
        // get and set name
        $customer = new Customer();
        $this->assertEquals(true, $customer->isChargeable());
        $customer->setChargeable(false);
        $this->assertEquals(false, $customer->isChargeable());
        // same result with the getter
        $this->assertEquals(false, $customer->getChargeable());
    }

    function testGetSetName()
    {
        // get and set name
        $customer = new Customer();
        $this->assertNull($customer->getName());
        $customer->setName('neuer Name');
        $this->assertEquals('neuer Name', $customer->getName());
    }

    function testGetSetAlias()
    {
        // get and set Alias
        $customer = new Customer();
        $this->assertNull($customer->getAlias());
        $customer->setAlias('neuer Alias');
        $this->assertEquals('neuer Alias', $customer->getAlias());
    }

    function testToString()
    {
        // should return name
        $customer = new Customer();
        $customer->setName('thats a name');
        $this->assertEquals('thats a name', (string)$customer);

        // should return id if name null
        $customer = new Customer();
        $this->assertNull($customer->getName());
        $this->assertEquals('', (string)$customer);

        $rand_id = rand(1, 20);
        $customer = $this->em->getRepository('DimeTimetrackerBundle:Customer')->find($rand_id);
        $customer->setName(null);
        $this->assertNull($customer->getName());
        $this->assertEquals((string)$rand_id, (string)$customer);
    }

    function testTags()
    {
        // customer has by default no tags
        $customer = new Customer();
        $this->assertEquals(0, count($customer->getTags()));

        // but we can add one
        $tag = new Tag();
        $customer->addTag($tag);
        $this->assertEquals(1, count($customer->getTags()));

        // and remove it
        $customer->removeTag($tag);
        $this->assertEquals(0, count($customer->getTags()));

        // and it's also possible to pass an Array
        $customer->setTags(new ArrayCollection([$tag]));
        $this->assertEquals(1, count($customer->getTags()));
    }

    function testGetSetRateGroup()
    {
        // get and set rate group
        $customer = new Customer();
        $rate_group = new RateGroup();
        $this->assertNull($customer->getRateGroup());
        $customer->setRateGroup($rate_group);
        $this->assertEquals($rate_group, $customer->getRateGroup());
    }

    function testSetCreatedAt()
    {
        // get and set created at
        $customer = new Customer();
        $dt = new \DateTime();
        $this->assertNull($customer->getCreatedAt());
        $customer->setCreatedAt($dt);
        $this->assertEquals($dt, $customer->getCreatedAt());
    }

    function testSetUpdatedAt()
    {
        // get and set updated at
        $customer = new Customer();
        $dt = new \DateTime();
        $this->assertNull($customer->getUpdatedAt());
        $customer->setUpdatedAt($dt);
        $this->assertEquals($dt, $customer->getUpdatedAt());
    }

    function testGetSetAddress()
    {
        // get and set rate group
        $customer = new Customer();
        $address = new Address();
        $this->assertNull($customer->getAddress());
        $customer->setAddress($address);
        $this->assertEquals($address, $customer->getAddress());
    }

    function testGetSetPhones()
    {
        // get and set rate group
        $customer = new Customer();
        $phone = new Phone();
        $this->assertNull($customer->getPhones());
        $customer->setPhones($phone);
        $this->assertEquals($phone, $customer->getPhones());
    }

    function testGetSetCompany()
    {
        // get and set Company
        $customer = new Customer();
        $this->assertNull($customer->getCompany());
        $customer->setCompany('neuer Company');
        $this->assertEquals('neuer Company', $customer->getCompany());
    }

    function testGetSetDepartment()
    {
        // get and set Department
        $customer = new Customer();
        $this->assertNull($customer->getDepartment());
        $customer->setDepartment('neuer Department');
        $this->assertEquals('neuer Department', $customer->getDepartment());
    }

    function testGetSetFullname()
    {
        // get and set Fullname
        $customer = new Customer();
        $this->assertNull($customer->getFullname());
        $customer->setFullname('neuer Fullname');
        $this->assertEquals('neuer Fullname', $customer->getFullname());
    }

    function testGetSetSalutation()
    {
        // get and set Salutation
        $customer = new Customer();
        $this->assertNull($customer->getSalutation());
        $customer->setSalutation('neuer Salutation');
        $this->assertEquals('neuer Salutation', $customer->getSalutation());
    }

    protected function tearDown()
    {
        parent::tearDown();

        $this->em->close();
        $this->em = null; // avoid memory leaks
    }
}
