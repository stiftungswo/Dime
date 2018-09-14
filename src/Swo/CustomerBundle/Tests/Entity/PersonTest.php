<?php
/**
 * Created by PhpStorm.
 * User: joni
 * Date: 14.09.18
 * Time: 15:28
 */

namespace Swo\CustomerBundle\Tests\Entity;

use PHPUnit\Framework\TestCase;
use Swo\CustomerBundle\Entity\Company;
use Swo\CustomerBundle\Entity\Person;
use Swo\CustomerBundle\Entity\Phone;

class PersonTest extends TestCase
{
    public function testGetSetAlias()
    {
        $person = new Person();
        $newAlias = 'new-alias';
        $this->assertNull($person->getAlias());
        $person->setAlias($newAlias);
        $this->assertEquals($newAlias, $person->getAlias());
    }

    public function testGetSetCompany()
    {
        $person = new Person();
        $company = new Company();
        $this->assertNull($person->getCompany());
        $person->setCompany($company);
        $this->assertEquals($company, $person->getCompany());
    }

    public function testGetSetSalutation()
    {
        $person = new Person();
        $salutation = 'salutation';
        $this->assertNull($person->getSalutation());
        $person->setSalutation($salutation);
        $this->assertEquals($salutation, $person->getSalutation());
    }

    public function testGetSetFirstName()
    {
        $person = new Person();
        $firstName = 'firstName';
        $this->assertNull($person->getFirstName());
        $person->setFirstName($firstName);
        $this->assertEquals($firstName, $person->getFirstName());
    }

    public function testGetSetLastName()
    {
        $person = new Person();
        $lastName = 'lastName';
        $this->assertNull($person->getLastName());
        $person->setLastName($lastName);
        $this->assertEquals($lastName, $person->getLastName());
    }

    public function testGetSetFullName()
    {
        $person = new Person();
        $fullName = 'fullName';
        $this->assertNull($person->getFullName());
        $person->setFullName($fullName);
        $this->assertEquals($fullName, $person->getFullName());
    }

    public function testGetSetPhones()
    {
        $person = new Person();
        $phone = new Phone();
        $this->assertNull($person->getPhones());
        $person->setPhones($phone);
        $this->assertEquals($phone, $person->getPhones());
    }
}
