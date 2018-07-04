<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\Rate;
use Dime\TimetrackerBundle\Entity\Service;
use Dime\TimetrackerBundle\Entity\Tag;

class ServiceTest extends KernelTestCase
{

    function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    function testSetGetChargeable()
    {
        // should do nothing if chargeable is empty
        $service = new Service();
        $this->assertTrue($service->getChargeable());
        $service->setChargeable('empty');
        $this->assertTrue($service->getChargeable());

        // should set and return chargeable
        $service->setChargeable(false);
        $this->assertFalse($service->isChargeable());
    }

    function testGetId()
    {
        $service = new Service();
        $this->assertNull($service->getId());
    }

    function testGetSetName()
    {
        // get and set Name
        $service = new Service();
        $this->assertNull($service->getName());
        $service->setName('neuer Name');
        $this->assertEquals('neuer Name', $service->getName());
    }

    function testGetSetAlias()
    {
        // get and set Alias
        $service = new Service();
        $this->assertNull($service->getAlias());
        $service->setAlias('neuer Alias');
        $this->assertEquals('neuer Alias', $service->getAlias());
    }

    function testGetSetDescription()
    {
        // get and set Description
        $service = new Service();
        $this->assertNull($service->getDescription());
        $service->setDescription('neuer Description');
        $this->assertEquals('neuer Description', $service->getDescription());
    }

    function testGetRateByRateGroup()
    {
        // it should return rate group
        $rand_id = rand(1, 2);
        $rate = new Rate();
        $service = new Service();

        $rate_group = $this->em->getRepository('DimeTimetrackerBundle:RateGroup')->find($rand_id);
        $rate->setRateGroup($rate_group);
        $service->addRate($rate);
        $this->assertEquals($rate, $service->getRateByRateGroup($rate_group));

        // it should return rate group based on id
        $this->assertEquals($rate, $service->getRateByRateGroup($rand_id));

        // it should return rate with rate group id 1
        $rate_group = $this->em->getRepository('DimeTimetrackerBundle:RateGroup')->find(1);
        $rate->setRateGroup($rate_group);
        $this->assertEquals($rate, $service->getRateByRateGroup());
    }

    function testToString()
    {
        // should return id
        $service = new Service();
        $this->assertEmpty((string)$service);

        // it should return name
        $service->setName('some name');
        $this->assertEquals('some name', (string)$service);
    }

    function testTags()
    {
        // service has by default no tags
        $service = new Service();
        $this->assertEquals(0, count($service->getTags()));

        // but we can add one
        $tag = new Tag();
        $service->addTag($tag);
        $this->assertEquals(1, count($service->getTags()));

        // and remove it
        $service->removeTag($tag);
        $this->assertEquals(0, count($service->getTags()));

        // and it's also possible to pass an Array
        $service->setTags(new ArrayCollection([$tag]));
        $this->assertEquals(1, count($service->getTags()));
    }

    function testGetSetVat()
    {
        // get and set Vat
        $service = new Service();
        $this->assertNull($service->getVat());
        $service->setVat(1.098);
        $this->assertEquals(1.098, $service->getVat());
    }

    function testSetCreatedAt()
    {
        // get and set created at
        $service = new Service();
        $dt = new \DateTime();
        $this->assertNull($service->getCreatedAt());
        $service->setCreatedAt($dt);
        $this->assertEquals($dt, $service->getCreatedAt());
    }

    function testSetUpdatedAt()
    {
        // get and set updated at
        $service = new Service();
        $dt = new \DateTime();
        $this->assertNull($service->getUpdatedAt());
        $service->setUpdatedAt($dt);
        $this->assertEquals($dt, $service->getUpdatedAt());
    }
    
    function testRates()
    {
        // service has by default no rates
        $service = new Service();
        $this->assertEquals(0, count($service->getRates()));

        // but we can add one
        $rate = new Rate();
        $service->addRate($rate);
        $this->assertEquals(1, count($service->getRates()));

        // and remove it
        $service->removeRate($rate);
        $this->assertEquals(0, count($service->getRates()));
    }
}
