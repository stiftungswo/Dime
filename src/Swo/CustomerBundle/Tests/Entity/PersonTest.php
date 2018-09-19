<?php

namespace Swo\CustomerBundle\Tests\Entity;

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

    public function testGetSetAddress()
    {
        // returns null if address is null as well as company
        $person = new Person();
        $this->assertNull($person->getAddress());

        // returns own address even if company is set
        $address = new Address();
        $company = new Company();
        $company_address = new Address();
        $company->setAddress($company_address);
        $person->setCompany($company);
        $person->setAddress($address);
        $this->assertEquals($address, $person->getAddress());

        // returns address of the company if own address is null
        $person2 = new Person();
        $person2->setCompany($company);
        $this->assertEquals($company_address, $person2->getAddress());
    }
}
