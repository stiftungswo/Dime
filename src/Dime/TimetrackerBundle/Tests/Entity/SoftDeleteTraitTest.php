<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\SoftDeleteTrait;
use PHPUnit\Framework\TestCase;

class SoftDeleteTraitTest extends TestCase
{

    function testGetSetDeletedAt()
    {
        $mock = $this->getMockBuilder(SoftDeleteTrait::class)->setMethods(null)
            ->getMockForTrait();

        // it should initially be null
        $this->assertNull($mock->getDeletedAt());

        // but we can switch it to a date
        $dt = new \DateTime();
        $mock->setDeletedAt($dt);
        $this->assertEquals($dt, $mock->getDeletedAt());
    }
}
