<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\Rate;
use Dime\TimetrackerBundle\Entity\RateGroup;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Service;
use PHPUnit\Framework\TestCase;

class RateTest extends TestCase
{

    function testGetSetRateGroup()
    {
        // get and set rate group
        $rate = new Rate();
        $rate_group = new RateGroup();
        $this->assertNull($rate->getRateGroup());
        $rate->setRateGroup($rate_group);
        $this->assertEquals($rate_group, $rate->getRateGroup());
    }

    function testGetSetRateUnit()
    {
        // get and set RateUnit
        $rate = new Rate();
        $this->assertNull($rate->getRateUnit());
        $rate->setRateUnit('neuer RateUnit');
        $this->assertEquals('neuer RateUnit', $rate->getRateUnit());
    }

    function testGetSetService()
    {
        // get and set rate group
        $rate = new Rate();
        $service = new Service();
        $this->assertNull($rate->getService());
        $rate->setService($service);
        $this->assertEquals($service, $rate->getService());
    }

    function testGetSetRateValue()
    {
        // get and set RateValue
        $rate = new Rate();
        $this->assertNull($rate->getRateValue());
        $rate->setRateValue('neuer RateValue');
        $this->assertEquals('neuer RateValue', $rate->getRateValue());
    }

    function testSetCreatedAt()
    {
        // get and set created at
        $rate = new Rate();
        $dt = new \DateTime();
        $this->assertNull($rate->getCreatedAt());
        $rate->setCreatedAt($dt);
        $this->assertEquals($dt, $rate->getCreatedAt());
    }

    function testSetUpdatedAt()
    {
        // get and set updated at
        $rate = new Rate();
        $dt = new \DateTime();
        $this->assertNull($rate->getUpdatedAt());
        $rate->setUpdatedAt($dt);
        $this->assertEquals($dt, $rate->getUpdatedAt());
    }

    function testGetSetRateUnitType()
    {
        // get and set rate group
        $rate = new Rate();
        $rate_unit_type = new RateUnitType();
        $this->assertNull($rate->getRateUnitType());
        $rate->setRateUnitType($rate_unit_type);
        $this->assertEquals($rate_unit_type, $rate->getRateUnitType());
    }
}
