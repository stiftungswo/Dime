<?php

namespace Swo\CustomerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\RateGroup;
use Doctrine\Common\Collections\ArrayCollection;
use PHPUnit\Framework\TestCase;
use Swo\CustomerBundle\Entity\Address;
use Swo\CustomerBundle\Entity\Company;
use Swo\CustomerBundle\Entity\Person;
use Swo\CustomerBundle\Entity\Phone;
use Dime\TimetrackerBundle\Entity\Tag;

class CompanyTest extends TestCase
{
    public function testPhoneNumbers()
    {
        // company has by default no phone numbers
        $company = new Company();
        $this->assertEquals(0, count($company->getPhoneNumbers()));

        // but we can add one
        $phone = new Phone();
        $company->addPhoneNumber($phone);
        $this->assertEquals(1, count($company->getPhoneNumbers()));

        // and remove it
        $company->removePhoneNumber($phone);
        $this->assertEquals(0, count($company->getPhoneNumbers()));

        // and it's also possible to pass an Array
        $company->setPhoneNumbers(new ArrayCollection([$phone]));
        $this->assertEquals(1, count($company->getPhoneNumbers()));
    }

    public function getSetRateGroup()
    {
        $company = new Company();
        $rateGroup = new RateGroup();
        $company->setRateGroup($rateGroup);
        $this->assertEquals($rateGroup, $company->getRateGroup());
        $company->setRateGroup(null);
        $this->assertNull($company->getRateGroup());
    }

    public function testAddresses()
    {
        // company has by default no addresses
        $company = new Company();
        $this->assertEquals(0, count($company->getAddresses()));
    
        // but we can add one
        $address = new Address();
        $company->addAddress($address);
        $this->assertEquals(1, count($company->getAddresses()));
    
        // and remove it
        $company->removeAddress($address);
        $this->assertEquals(0, count($company->getAddresses()));
    
        // and it's also possible to pass an Array
        $company->setAddresses(new ArrayCollection([$address]));
        $this->assertEquals(1, count($company->getAddresses()));
    }

    public function testPersons()
    {
        // company has by default no persons
        $company = new Company();
        $this->assertEquals(0, count($company->getPersons()));

        // but we can add one
        $person = new Person();
        $company->addPerson($person);
        $this->assertEquals(1, count($company->getPersons()));

        // and remove it
        $company->removePerson($person);
        $this->assertEquals(0, count($company->getPersons()));

        // and it's also possible to pass an Array
        $company->setPersons(new ArrayCollection([$person]));
        $this->assertEquals(1, count($company->getPersons()));
    }
    
    public function testGetSetName()
    {
        $company = new Company();
        $company->setName('Name');
        $this->assertEquals('Name', $company->getName());
    }

    public function testGetSetChargeable()
    {
        $company = new Company();
        $this->assertTrue($company->isChargeable());
        $company->setChargeable(false);
        $this->assertFalse($company->isChargeable());
    }

    public function testGetSetHideForBusiness()
    {
        $company = new Company();
        $this->assertFalse($company->getHideForBusiness());
        $company->setHideForBusiness(true);
        $this->assertTrue($company->getHideForBusiness());
    }

    public function testTags()
    {
        // company has by default no tags
        $company = new Company();
        $this->assertEquals(0, count($company->getTags()));
        // but we can add one
        $tag = new Tag();
        $company->addTag($tag);
        $this->assertEquals(1, count($company->getTags()));
        // and remove it
        $company->removeTag($tag);
        $this->assertEquals(0, count($company->getTags()));
        // and it's also possible to pass an Array
        $company->setTags(new ArrayCollection([$tag]));
        $this->assertEquals(1, count($company->getTags()));
    }
}
