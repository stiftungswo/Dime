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

    public function testGetSetCategory()
    {
        $phone = new Phone();
        $phone->setCategory(5);
        $this->assertEquals(5, $phone->getCategory());
    }

    public function testGetSetCompany()
    {
        $phone = new Phone();
        $company = new Company();
        $phone->setCompany($company);
        $this->assertEquals($company, $phone->getCompany());
    }

    public function testGetSetPhone()
    {
        $phone = new Phone();
        $person = new Person();
        $phone->setPerson($person);
        $this->assertEquals($person, $phone->getPerson());
    }
}
