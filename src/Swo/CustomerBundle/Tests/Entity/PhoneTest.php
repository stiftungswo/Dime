<?php

namespace Swo\CustomerBundle\Tests\Entity;

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

    public function testGetSetCustomer()
    {
        $phone = new Phone();
        $company = new Company();
        $phone->setCustomer($company);
        $this->assertEquals($company, $phone->getCustomer());
    }

    public function testGetSetPhone()
    {
        $phone = new Phone();
        $person = new Person();
        $phone->setCustomer($person);
        $this->assertEquals($person, $phone->getCustomer());
    }
}
