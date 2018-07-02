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

    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    public function testGetSetChargeable()
    {
        // get and set name
        $customer = new Customer();
        $this->assertEquals(true, $customer->isChargeable());
        $customer->setChargeable(false);
        $this->assertEquals(false, $customer->isChargeable());
        // same result with the getter
        $this->assertEquals(false, $customer->getChargeable());
    }

    public function testGetSetName()
    {
        // get and set name
        $customer = new Customer();
        $this->assertEquals(null, $customer->getName());
        $customer->setName('neuer Name');
        $this->assertEquals('neuer Name', $customer->getName());
    }

    public function testGetSetAlias()
    {
        // get and set Alias
        $customer = new Customer();
        $this->assertEquals(null, $customer->getAlias());
        $customer->setAlias('neuer Alias');
        $this->assertEquals('neuer Alias', $customer->getAlias());
    }

    public function testToString()
    {
        // should return name
        $customer = new Customer();
        $customer->setName('thats a name');
        $this->assertEquals('thats a name', (string)$customer);

        // should return id if name null
        $customer = new Customer();
        $this->assertEquals(null, $customer->getName());
        $this->assertEquals('', (string)$customer);

        $rand_id = rand(1, 20);
        $customer = $this->em->getRepository('DimeTimetrackerBundle:Customer')->find($rand_id);
        $customer->setName(null);
        $this->assertEquals(null, $customer->getName());
        $this->assertEquals((string)$rand_id, (string)$customer);
    }

    public function testTags()
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

    public function testGetSetRateGroup()
    {
        // get and set rate group
        $customer = new Customer();
        $rate_group = new RateGroup();
        $this->assertEquals(null, $customer->getRateGroup());
        $customer->setRateGroup($rate_group);
        $this->assertEquals($rate_group, $customer->getRateGroup());
    }

    public function testSetCreatedAt()
    {
        // no possibility to verify because no getter method
        $project = new Customer();
        $dt = new \DateTime();
        $project->setCreatedAt($dt);
    }

    public function testSetUpdatedAt()
    {
        // no possibility to verify because no getter method
        $project = new Customer();
        $dt = new \DateTime();
        $project->setUpdatedAt($dt);
    }

    public function testGetSetAddress()
    {
        // get and set rate group
        $customer = new Customer();
        $address = new Address();
        $this->assertEquals(null, $customer->getAddress());
        $customer->setAddress($address);
        $this->assertEquals($address, $customer->getAddress());
    }

    public function testGetSetPhones()
    {
        // get and set rate group
        $customer = new Customer();
        $phone = new Phone();
        $this->assertEquals(null, $customer->getPhones());
        $customer->setPhones($phone);
        $this->assertEquals($phone, $customer->getPhones());
    }

    public function testGetSetCompany()
    {
        // get and set Company
        $customer = new Customer();
        $this->assertEquals(null, $customer->getCompany());
        $customer->setCompany('neuer Company');
        $this->assertEquals('neuer Company', $customer->getCompany());
    }

    public function testGetSetDepartment()
    {
        // get and set Department
        $customer = new Customer();
        $this->assertEquals(null, $customer->getDepartment());
        $customer->setDepartment('neuer Department');
        $this->assertEquals('neuer Department', $customer->getDepartment());
    }

    public function testGetSetFullname()
    {
        // get and set Fullname
        $customer = new Customer();
        $this->assertEquals(null, $customer->getFullname());
        $customer->setFullname('neuer Fullname');
        $this->assertEquals('neuer Fullname', $customer->getFullname());
    }

    public function testGetSetSalutation()
    {
        // get and set Salutation
        $customer = new Customer();
        $this->assertEquals(null, $customer->getSalutation());
        $customer->setSalutation('neuer Salutation');
        $this->assertEquals('neuer Salutation', $customer->getSalutation());
    }
}
