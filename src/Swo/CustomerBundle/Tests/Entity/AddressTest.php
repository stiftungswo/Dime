<?php

namespace Swo\CustomerBundle\Tests\Entity;

use PHPUnit\Framework\TestCase;
use Doctrine\Common\Collections\ArrayCollection;
use Swo\CustomerBundle\Entity\Address;
use Swo\CustomerBundle\Entity\Company;
use Swo\CustomerBundle\Entity\Person;

class AddressTest extends TestCase
{
    public function testGetSetCompany()
    {
        $address = new Address();
        $company = new Company();
        $address->setCompany($company);
        $this->assertEquals($company, $address->getCompany());
        $address->setCompany(null);
        $this->assertNull($address->getCompany());
    }
    
    public function testPersons()
    {
        // address has by default no persons
        $address = new Address();
        $this->assertEquals(0, count($address->getPersons()));

        // but we can add one
        $person = new Person();
        $address->addPerson($person);
        $this->assertEquals(1, count($address->getPersons()));

        // and remove it
        $address->removePerson($person);
        $this->assertEquals(0, count($address->getPersons()));

        // and it's also possible to pass an Array
        $address->setPersons(new ArrayCollection([$person]));
        $this->assertEquals(1, count($address->getPersons()));
    }
    
    public function testGetSetStreet()
    {
        $address = new Address();
        $address->setStreet('Bahnstrasse 18b');
        $this->assertEquals('Bahnstrasse 18b', $address->getStreet());
    }

    public function testGetSetSupplement()
    {
        $address = new Address();
        $address->setSupplement('Postfach');
        $this->assertEquals('Postfach', $address->getSupplement());
    }

    public function testGetSetCity()
    {
        $address = new Address();
        $address->setCity('Schwerzenbach');
        $this->assertEquals('Schwerzenbach', $address->getCity());
    }

    public function testGetSetPostcode()
    {
        $address = new Address();
        $address->setPostcode(8603);
        $this->assertEquals(8603, $address->getPostcode());
    }

    public function testGetSetCountry()
    {
        $address = new Address();
        $address->setCountry('Schweiz');
        $this->assertEquals('Schweiz', $address->getCountry());
    }
}
