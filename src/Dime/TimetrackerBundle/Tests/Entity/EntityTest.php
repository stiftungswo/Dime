<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\User;

class EntityTest extends KernelTestCase
{

    protected function getEntityMock()
    {
        return $this->getMockBuilder(Entity::class)->setMethods(null)
            ->getMockForAbstractClass();
    }

    function testGetId()
    {
        // returns null because we have no persistent object
        $this->assertNull($this->getEntityMock()->getId);
    }

    function testGetSetUser()
    {
        $mock = $this->getEntityMock();
        $user = new User();
        $this->assertNull($mock->getUser());
        $mock->setUser($user);
        $this->assertEquals($user, $mock->getUser());
    }

    function testGetProperties()
    {
        $result = $this->getEntityMock()->getProperties();
        $this->assertContains('id', $result);
        $this->assertContains('user', $result);
        $this->assertContains('createdAt', $result);
        $this->assertContains('updatedAt', $result);
    }
}
