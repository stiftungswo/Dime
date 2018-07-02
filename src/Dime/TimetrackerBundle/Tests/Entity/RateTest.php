<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\Rate;
use Dime\TimetrackerBundle\Entity\RateGroup;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Service;

class RateTest extends KernelTestCase
{

    public function testGetSetRateGroup()
    {
        // get and set rate group
        $rate = new Rate();
        $rate_group = new RateGroup();
        $this->assertEquals(null, $rate->getRateGroup());
        $rate->setRateGroup($rate_group);
        $this->assertEquals($rate_group, $rate->getRateGroup());
    }

    public function testGetSetRateUnit()
    {
        // get and set RateUnit
        $rate = new Rate();
        $this->assertEquals(null, $rate->getRateUnit());
        $rate->setRateUnit('neuer RateUnit');
        $this->assertEquals('neuer RateUnit', $rate->getRateUnit());
    }

    public function testGetSetService()
    {
        // get and set rate group
        $rate = new Rate();
        $service = new Service();
        $this->assertEquals(null, $rate->getService());
        $rate->setService($service);
        $this->assertEquals($service, $rate->getService());
    }

    public function testGetSetRateValue()
    {
        // get and set RateValue
        $rate = new Rate();
        $this->assertEquals(null, $rate->getRateValue());
        $rate->setRateValue('neuer RateValue');
        $this->assertEquals('neuer RateValue', $rate->getRateValue());
    }

    public function testSetCreatedAt()
    {
        // no possibility to verify because no getter method
        $project = new Rate();
        $dt = new \DateTime();
        $project->setCreatedAt($dt);
    }

    public function testSetUpdatedAt()
    {
        // no possibility to verify because no getter method
        $project = new Rate();
        $dt = new \DateTime();
        $project->setUpdatedAt($dt);
    }

    public function testGetSetRateUnitType()
    {
        // get and set rate group
        $rate = new Rate();
        $rate_unit_type = new RateUnitType();
        $this->assertEquals(null, $rate->getRateUnitType());
        $rate->setRateUnitType($rate_unit_type);
        $this->assertEquals($rate_unit_type, $rate->getRateUnitType());
    }
}
