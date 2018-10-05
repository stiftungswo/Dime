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
        $address->setCustomer($company);
        $this->assertEquals($company, $address->getCustomer());
        $address->setCustomer(null);
        $this->assertNull($address->getCustomer());
    }

    public function testGetSetPerson()
    {
        $address = new Address();
        $person = new Person();
        $address->setCustomer($person);
        $this->assertEquals($person, $address->getCustomer());
        $address->setCustomer(null);
        $this->assertNull($address->getCustomer());
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

    public function testGetSetDescription()
    {
        $address = new Address();
        $address->setDescription('Beschreibung');
        $this->assertEquals('Beschreibung', $address->getDescription());
    }
}