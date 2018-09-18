<?php

namespace Swo\CustomerBundle\Tests\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use PHPUnit\Framework\TestCase;
use Swo\CustomerBundle\Entity\Company;
use Swo\CustomerBundle\Entity\Person;
use Swo\CustomerBundle\Entity\Phone;

class PhoneTest extends TestCase
{
    public function testGetSetPhoneNumber()
    {
        $phone = new Phone();
        $phone->setNumber('0345678901');
        $this->assertEquals('0345678901', $phone->getNumber());
    }

    public function testGetSetType()
    {
        $phone = new Phone();
        $phone->setType('mobile');
        $this->assertEquals('mobile', $phone->getType());
    }

    public function testGetSetCompany()
    {
        $phone = new Phone();
        $company = new Company();
        $phone->setCompany($company);
        $this->assertEquals($company, $phone->getCompany());
    }

    public function testPersons()
    {
        // phone has by default no persons
        $phone = new Phone();
        $this->assertEquals(0, count($phone->getPersons()));

        // but we can add one
        $person = new Person();
        $phone->addPerson($person);
        $this->assertEquals(1, count($phone->getPersons()));

        // and remove it
        $phone->removePerson($person);
        $this->assertEquals(0, count($phone->getPersons()));

        // and it's also possible to pass an Array
        $phone->setPersons(new ArrayCollection([$person]));
        $this->assertEquals(1, count($phone->getPersons()));
    }
}
