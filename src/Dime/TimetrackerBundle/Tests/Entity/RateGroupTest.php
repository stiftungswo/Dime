<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\RateGroup;
use PHPUnit\Framework\TestCase;

class RateGroupTest extends TestCase
{

    function testGetSetDescription()
    {
        // get and set Description
        $rate_group = new RateGroup();
        $this->assertNull($rate_group->getDescription());
        $rate_group->setDescription('neuer Description');
        $this->assertEquals('neuer Description', $rate_group->getDescription());
    }

    function testGetSetName()
    {
        // get and set Name
        $rate_group = new RateGroup();
        $this->assertNull($rate_group->getName());
        $rate_group->setName('neuer Name');
        $this->assertEquals('neuer Name', $rate_group->getName());
    }
    
    function testGetSetCreatedAt()
    {
        // get and set created at
        $rate_group = new RateGroup();
        $dt = new \DateTime();
        $this->assertNull($rate_group->getCreatedAt());
        $rate_group->setCreatedAt($dt);
        $this->assertEquals($dt, $rate_group->getCreatedAt());
    }

    function testGetSetUpdatedAt()
    {
        // get and set created at
        $rate_group = new RateGroup();
        $dt = new \DateTime();
        $this->assertNull($rate_group->getUpdatedAt());
        $rate_group->setUpdatedAt($dt);
        $this->assertEquals($dt, $rate_group->getUpdatedAt());
    }
}
