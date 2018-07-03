<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\SoftDeleteTrait;

class SoftDeleteTraitTest extends KernelTestCase
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
