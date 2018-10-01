<?php

namespace Swo\CustomerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\RateGroup;
use Doctrine\Common\Collections\ArrayCollection;
use PHPUnit\Framework\TestCase;
use Swo\CustomerBundle\Entity\Address;
use Swo\CustomerBundle\Entity\Company;
use Swo\CustomerBundle\Entity\Person;
use Swo\CustomerBundle\Entity\Phone;

class PersonTest extends TestCase
{
    public function testGetSetSalutation()
    {
        $person = new Person();
        $person->setSalutation('Monsieur');
        $this->assertEquals('Monsieur', $person->getSalutation());
        $person->setSalutation(null);
        $this->assertNull($person->getSalutation());
    }
    
    public function testGetSetFirstName()
    {
        $person = new Person();
        $person->setFirstName('Christoph');
        $this->assertEquals('Christoph', $person->getFirstName());
    }
    
    public function testGetSetLastName()
    {
        $person = new Person();
        $person->setLastName('Stiefel');
        $this->assertEquals('Stiefel', $person->getLastName());
    }

    public function testPhoneNumbers()
    {
        // company has by default no phone numbers
        $person = new Person();
        $this->assertEquals(0, count($person->getPhoneNumbers()));

        // but we can add one
        $phone = new Phone();
        $person->addPhoneNumber($phone);
        $this->assertEquals(1, count($person->getPhoneNumbers()));

        // and remove it
        $person->removePhoneNumber($phone);
        $this->assertEquals(0, count($person->getPhoneNumbers()));

        // and it's also possible to pass an Array
        $person->setPhoneNumbers(new ArrayCollection([$phone]));
        $this->assertEquals(1, count($person->getPhoneNumbers()));
    }
    
    public function testGetSetCompany()
    {
        $person = new Person();
        $company = new Company();
        $person->setCompany($company);
        $this->assertEquals($company, $person->getCompany());
        $person->setCompany(null);
        $this->assertNull($person->getCompany());
    }

    public function testAddresses()
    {
        // person has by default no addresses
        $person = new Person();
        $this->assertEquals(0, count($person->getAddresses()));

        // but we can add one
        $address = new Address();
        $person->addAddress($address);
        $this->assertEquals(1, count($person->getAddresses()));

        // and remove it
        $person->removeAddress($address);
        $this->assertEquals(0, count($person->getAddresses()));

        // and it's also possible to pass an Array
        $person->setAddresses(new ArrayCollection([$address]));
        $this->assertEquals(1, count($person->getAddresses()));
    }

    public function testGetSetRateGroup()
    {
        $person = new Person();
        $rateGroup = new RateGroup();
        $this->assertNull($person->getRateGroup());
        $person->setRateGroup($rateGroup);
        $this->assertEquals($rateGroup, $person->getRateGroup());
    }

    public function testGetSetChargeable()
    {
        $person = new Person();
        $this->assertTrue($person->getChargeable());
        $person->setChargeable(false);
        $this->assertFalse($person->getChargeable());

        // should overtake value from company
        $company = new Company();
        $company->setChargeable(null);
        $this->assertNotNull($person->getChargeable());
        $person->setCompany($company);
        $this->assertNull($person->getChargeable());
    }

    public function testGetSetHideForBusiness()
    {
        $person = new Person();
        $this->assertFalse($person->getHideForBusiness());
        $person->setHideForBusiness(true);
        $this->assertTrue($person->getHideForBusiness());

        // should overtake value from company
        $company = new Company();
        $company->setHideForBusiness(null);
        $this->assertNotNull($person->getHideForBusiness());
        $person->setCompany($company);
        $this->assertNull($person->getHideForBusiness());
    }
}
