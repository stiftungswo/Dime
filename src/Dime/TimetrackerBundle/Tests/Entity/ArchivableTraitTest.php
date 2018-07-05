<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\ArchivableTrait;
use PHPUnit\Framework\TestCase;

class ArchivableTraitTest extends TestCase
{

    function testGetSetArchived()
    {
        $mock = $this->getMockBuilder(ArchivableTrait::class)->setMethods(null)
            ->getMockForTrait();

        // it should initially be false (because null)
        $this->assertFalse($mock->isArchived());

        // but we can switch it to true
        $mock->setArchived(true);
        $this->assertTrue($mock->getArchived());
    }
}
