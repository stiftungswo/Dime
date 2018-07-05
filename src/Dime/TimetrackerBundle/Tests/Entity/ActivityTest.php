<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Customer;
use Doctrine\Common\Collections\ArrayCollection;
use Money\Money;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\Rate;
use Dime\TimetrackerBundle\Entity\RateGroup;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Service;
use Dime\TimetrackerBundle\Entity\Tag;
use PHPUnit\Framework\TestCase;
use Dime\TimetrackerBundle\Entity\Timeslice;

class ActivityTest extends TestCase
{

    function testGetValue()
    {
        // it should return 0 if no timeslices and value pure
        $activity = new Activity();
        $this->assertEquals(0, $activity->getValue(true));

        // it should return values in correct format
        $timeslice = new Timeslice();
        $timeslice->setValue(1);
        $rate_unit_type = new RateUnitType();
        $rate_unit_type->setId('h');
        $activity->setRateUnitType($rate_unit_type);
        $activity->addTimeslice($timeslice);

        $this->assertEquals(1, $activity->getValue());
    }

    function testUpdateEmptyRateFromDefault()
    {
        // it return itself if no service rate is assigned
        $activity = new Activity();
        $this->assertEquals($activity, $activity->updateEmptyRateFromDefault());

        // it should fill in values based on service rate
        $rate = new Rate();
        $rate_group = new RateGroup();
        $project = new Project();
        $service = new Service();

        $rate->setRateValue(Money::CHF(13000));
        $rate->setRateUnit('CHF/h');
        $rate->setRateUnitType('h');

        $project->setRateGroup($rate_group);
        $rate->setRateGroup($rate_group);
        $service->addRate($rate);
        $activity->setProject($project);
        $activity->setService($service);

        // set the relevant fields on zero
        // because on setService, it does already fill out those fields
        // but you can't check it through a getter
        $activity->setRateValue(null);
        $activity->setRateUnit(null);
        $activity->setRateUnitType(null);

        $activity->updateEmptyRateFromDefault();

        $activity->setService(null);
        $this->assertEquals(Money::CHF(13000), $activity->getRateValue());
        $this->assertEquals('CHF/h', $activity->getRateUnit());
        $this->assertEquals('h', $activity->getRateUnitType());
    }

    function testGetServiceRate()
    {
        // it should return null if no service is associated
        $activity = new Activity();
        $this->assertNull($activity->getServiceRate());

        // it should return rate through service
        $rate = new Rate();
        $rate_group = new RateGroup();
        $project = new Project();
        $service = new Service();

        $project->setRateGroup($rate_group);
        $rate->setRateGroup($rate_group);
        $service->addRate($rate);
        $activity->setProject($project);
        $activity->setService($service);

        $this->assertEquals($rate, $activity->getServiceRate());
    }

    function testGetCharge()
    {
        // it should return null if no rate value ist
        $activity = new Activity();
        $this->assertNull($activity->getCharge());

        // it should return calculated charge
        $activity->setRateValue(Money::CHF(100));
        $activity->setVat(0.1);
        $timeslice = new Timeslice();
        $timeslice->setValue(10);
        $activity->addTimeslice($timeslice);

        $this->assertEquals(Money::CHF(11.00), $activity->getCharge());
    }

    function testGetName()
    {
        // should return empty if either project or service are null
        $activity = new Activity();
        $project = new Project();
        $service = new Service();

        $activity->setProject($project);
        $this->assertEquals('', $activity->getName());

        // it should return a combination of service and project
        $activity->setProject($project);
        $activity->setService($service);
        $project->setName('PROJECT');
        $service->setName('YASUO');
        $this->assertEquals(' PROJECT - YASUO', $activity->getName());
    }

    function testGetAlias()
    {
        // it should return empty if no service is assigned
        $activity = new Activity();
        $this->assertEquals('', $activity->getAlias());

        // it should return alias of service
        $service = new Service();
        $project = new Project();
        $service->setAlias('this is an alias');
        $activity->setProject($project);
        $activity->setService($service);
        $this->assertEquals('this is an alias', $activity->getAlias());
    }

    function testSerializeValue()
    {
        // it should return value if no rate unit type is present
        $activity = new Activity();
        $this->assertEquals(0, $activity->serializeValue());

        // it should return serialized value
        $rate_unit_type = new RateUnitType();
        $rate_unit_type->setSymbol('h');
        $activity->setRateUnitType($rate_unit_type);
        $this->assertEquals('0h', $activity->serializeValue());
    }

    function testGetCalculatedVAT()
    {
        // it should return null if
        // - rateValue not instance of Money
        $activity = new Activity();
        $activity->setRateValue('abcdefghhwkq');
        $this->assertNull($activity->getCalculatedVAT());

        // - vat not numeric
        $activity->setRateValue(Money::CHF(15000));
        $activity->setVat('abcdfeg');
        $this->assertNull($activity->getCalculatedVAT());

        // it should calculate
        $timeslice = new Timeslice();
        $timeslice->setValue(1);
        $rate_unit_type = new RateUnitType();
        $rate_unit_type->setId('h');
        $activity->setRateUnitType($rate_unit_type);
        $activity->addTimeslice($timeslice);
        $activity->setVat(1);
        $this->assertEquals(Money::CHF(15000), $activity->getCalculatedVAT());
    }

    function testGetSetDescription()
    {
        // get and set Description
        $activity = new Activity();
        $this->assertNull($activity->getDescription());
        $activity->setDescription('neuer Description');
        $this->assertEquals('neuer Description', $activity->getDescription());
    }

    function testGetSetRateValue()
    {
        // it should return null if rate value and service are null
        $activity = new Activity();
        $this->assertNull($activity->getRateValue());

        // should get things from associated service
        $rate = new Rate();
        $rate_group = new RateGroup();
        $project = new Project();
        $service = new Service();

        $project->setRateGroup($rate_group);
        $rate->setRateGroup($rate_group);
        $service->addRate($rate);
        $activity->setProject($project);
        $activity->setService($service);
        $rate->setRateValue(Money::CHF(3500));

        $this->assertEquals(Money::CHF(3500), $activity->getRateValue());
    }

    function testGetCustomer()
    {
        $activity = new Activity();
        $project = new Project();
        $activity->setProject($project);
        $this->assertNull($activity->getCustomer());

        $customer = new Customer();
        $project->setCustomer($customer);
        $this->assertEquals($customer, $activity->getCustomer());
    }

    function testGetSetProject()
    {
        // get and set project
        $activity = new Activity();
        $project = new Project();
        $this->assertNull($activity->getProject());
        $activity->setProject($project);
        $this->assertEquals($project, $activity->getProject());
    }

    function testGetSetService()
    {
        // get and set service
        $activity = new Activity();
        $this->assertNull($activity->getService());

        $rate = new Rate();
        $rate_group = new RateGroup();
        $project = new Project();
        $service = new Service();

        $project->setRateGroup($rate_group);
        $rate->setRateGroup($rate_group);
        $service->addRate($rate);
        $activity->setProject($project);
        $activity->setService($service);

        $activity->setService($service);
        $this->assertEquals($service, $activity->getService());
    }

    function testGetAddTimeslices()
    {
        $activity = new Activity();
        $timeslice = new Timeslice();
        $this->assertEquals(new ArrayCollection([]), $activity->getTimeslices());
        $activity->addTimeslice($timeslice);
        $this->assertEquals(new ArrayCollection([$timeslice]), $activity->getTimeslices());
    }

    function testTags()
    {
        // activity has by default no tags
        $activity = new Activity();
        $this->assertEquals(0, count($activity->getTags()));

        // but we can add one
        $tag = new Tag();
        $activity->addTag($tag);
        $this->assertEquals(1, count($activity->getTags()));

        // and remove it
        $activity->removeTag($tag);
        $this->assertEquals(0, count($activity->getTags()));

        // and it's also possible to pass an Array
        $activity->setTags(new ArrayCollection([$tag]));
        $this->assertEquals(1, count($activity->getTags()));
    }

    function testGetChargeable()
    {
        // get and set Description
        $activity = new Activity();
        $this->assertNull($activity->isChargeable());
        $activity->setChargeable(false);
        $this->assertFalse($activity->isChargeable());
    }

    function testSerializeChargeable()
    {
        // there are multiple possibilities to get the chargeable value
        // based on the chargeable reference field
        // case 1: itself
        $activity = new Activity();
        $activity->setChargeableReference(0);
        $activity->setChargeable(true);
        $this->assertTrue($activity->serializeChargeable());

        // case 2: the project
        $activity->setChargeableReference(2);
        $activity->setChargeable(null);
        $this->assertNull($activity->serializeChargeable());

        $project = new Project();
        $project->setChargeable(false);
        $activity->setProject($project);
        $this->assertFalse($activity->serializeChargeable());

        // case 3: the customer
        $activity->setChargeableReference(3);
        $activity->setChargeable(null);
        $this->assertNull($activity->serializeChargeable());

        $customer = new Customer();
        $project = new Project();
        $customer->setChargeable(true);
        $project->setCustomer($customer);
        $activity->setProject($project);
        $this->assertTrue($activity->serializeChargeable());

        // case 4: the service
        $activity->setChargeableReference(1);
        $activity->setChargeable(null);
        $this->assertNull($activity->serializeChargeable());

        $service = new Service();
        $service->setChargeable(false);
        $activity->setService($service);
        $this->assertFalse($activity->serializeChargeable());

        // case 5: default
        $activity->setChargeableReference(5);
        $activity->setChargeable(true);
        $this->assertTrue($activity->serializeChargeable());
    }

    function testGetSetRateUnit()
    {
        // get and set RateUnit
        $activity = new Activity();
        $this->assertNull($activity->getRateUnit());
        $activity->setRateUnit('neuer RateUnit');
        $this->assertEquals('neuer RateUnit', $activity->getRateUnit());
    }

    function testGetSetRateUnitType()
    {
        // get and set rate_unit_type
        $activity = new Activity();
        $rate_unit_type = new RateUnitType();
        $this->assertNull($activity->getRateUnitType());
        $activity->setRateUnitType($rate_unit_type);
        $this->assertEquals($rate_unit_type, $activity->getRateUnitType());
    }

    function testGetSetVat()
    {
        // get and set Vat
        $activity = new Activity();
        $this->assertNull($activity->getVat());
        $activity->setVat(0.077);
        $this->assertEquals(0.077, $activity->getVat());
    }
}
