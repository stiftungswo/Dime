<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Swo\CommonsBundle\Entity\AbstractEntity;
use PHPUnit\Framework\TestCase;
use Dime\TimetrackerBundle\Entity\User;

class EntityTest extends TestCase
{
    protected function getEntityMock()
    {
        return $this->getMockBuilder(AbstractEntity::class)->setMethods(null)
            ->getMockForAbstractClass();
    }

    public function testGetId()
    {
        // returns null because we have no persistent object
        $this->assertNull($this->getEntityMock()->getId);
    }

    public function testGetSetUser()
    {
        $mock = $this->getEntityMock();
        $user = new User();
        $this->assertNull($mock->getUser());
        $mock->setUser($user);
        $this->assertEquals($user, $mock->getUser());
    }

    public function testGetProperties()
    {
        $result = $this->getEntityMock()->getProperties();
        $this->assertContains('id', $result);
        $this->assertContains('user', $result);
        $this->assertContains('createdAt', $result);
        $this->assertContains('updatedAt', $result);
    }
}
