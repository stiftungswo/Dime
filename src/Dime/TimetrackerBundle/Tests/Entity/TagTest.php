<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\Tag;

class TagTest extends KernelTestCase
{

    function testGetSetName()
    {
        // get and set Name
        $tag = new Tag();
        $this->assertNull($tag->getName());
        $tag->setName('some Name');
        $this->assertEquals('some Name', $tag->getName());
    }

    function testToString()
    {
        // should return id
        $tag = new Tag();
        $this->assertEmpty((string)$tag);

        // it should return name
        $tag->setName('some name');
        $this->assertEquals('some name', (string)$tag);
    }

    function testGetSetSystem()
    {
        // get and set System
        $tag = new Tag();
        $this->assertFalse($tag->getSystem());
        $tag->setSystem(true);
        $this->assertTrue($tag->getSystem());
    }
}
