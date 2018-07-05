<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\Tag;
use PHPUnit\Framework\TestCase;

class TagTest extends TestCase
{
    public function testGetSetName()
    {
        // get and set Name
        $tag = new Tag();
        $this->assertNull($tag->getName());
        $tag->setName('some Name');
        $this->assertEquals('some Name', $tag->getName());
    }

    public function testToString()
    {
        // should return id
        $tag = new Tag();
        $this->assertEmpty((string)$tag);

        // it should return name
        $tag->setName('some name');
        $this->assertEquals('some name', (string)$tag);
    }

    public function testGetSetSystem()
    {
        // get and set System
        $tag = new Tag();
        $this->assertFalse($tag->getSystem());
        $tag->setSystem(true);
        $this->assertTrue($tag->getSystem());
    }
}
