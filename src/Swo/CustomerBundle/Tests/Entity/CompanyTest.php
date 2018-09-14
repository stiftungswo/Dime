<?php
/**
 * Created by PhpStorm.
 * User: joni
 * Date: 14.09.18
 * Time: 13:55
 */

namespace Swo\CustomerBundle\Tests\Entity;

use PHPUnit\Framework\TestCase;
use Swo\CustomerBundle\Entity\Company;

class CompanyTest extends TestCase
{
    public function testGetSetAlias()
    {
        $company = new Company();
        $newAlias = 'new-alias';
        $this->assertNull($company->getAlias());
        $company->setAlias($newAlias);
        $this->assertEquals($newAlias, $company->getAlias());
    }

    public function testGetSetName()
    {
        $company = new Company();
        $newName = 'newName';
        $this->assertNull($company->getName());
        $company->setName($newName);
        $this->assertEquals($newName, $company->getName());
    }

    public function testGetSetDepartment()
    {
        $company = new Company();
        $newDepartment = 'newDepartment';
        $this->assertNull($company->getDepartment());
        $company->setDepartment($newDepartment);
        $this->assertEquals($newDepartment, $company->getDepartment());
    }
}
