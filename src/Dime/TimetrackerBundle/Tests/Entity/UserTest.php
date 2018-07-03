<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\User;

class UserTest extends KernelTestCase
{

    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }
    
    public function testGetSetNames()
    {
        // Get and Set Name of user
        $user = new User();
        $this->assertEquals(null, $user->getFirstname());
        $this->assertEquals(null, $user->getLastname());
        
        $user->setFirstname('neuer Firstname');
        $user->setLastname('neuer Lastname');

        $this->assertEquals('neuer Firstname', $user->getFirstname());
        $this->assertEquals('neuer Lastname', $user->getLastname());
        $this->assertEquals('neuer Firstname neuer Lastname', $user->getFullname());
    }

    public function testGetId()
    {
        // has only a getter method
        $user = new User();
        $this->assertEquals(null, $user->getId());
    }

    public function testGetCreatedAt()
    {
        // has only a getter method
        $user = new User();
        $this->assertEquals(null, $user->getCreatedAt());
    }

    public function testGetUpdatedAt()
    {
        // has only a getter method
        $user = new User();
        $this->assertEquals(null, $user->getUpdatedAt());
    }

    public function testGetSetEmployeeholiday()
    {
        // get and set Employeeholiday
        $user = new User();
        $this->assertEquals(null, $user->getEmployeeholiday());
        $user->setEmployeeholiday(20);
        $this->assertEquals(20, $user->getEmployeeholiday());
    }

    public function testRoles()
    {
        // user has by default a standard role
        $user = new User();
        $this->assertEquals(1, count($user->getRoles()));

        // but we can add one
        $role = 'hello';
        $user->addRole($role);
        $this->assertEquals(2, count($user->getRoles()));

        // and remove it
        $user->removeRole($role);
        $this->assertEquals(1, count($user->getRoles()));

        // and it's also possible to pass an Array
        $user->setRoles(([$role]));
        $this->assertEquals(2, count($user->getRoles()));
    }

    public function testToString()
    {
        // should return strval if id and names are missing
        $user = new User();
        $this->assertEquals(strval($user), (string)$user);

        // should return name
        $user->setFirstname(' Heini');
        $user->setLastname('Bäcker ');
        $this->assertEquals('Heini Bäcker', (string)$user);

        // should return id if no name is set
        $rand_id = rand(1, 20);
        $user = $this->em->getRepository('DimeTimetrackerBundle:User')->find($rand_id);
        $user->setFirstname(null);
        $user->setLastname(null);
        $this->assertEquals((string)$rand_id, (string)$user);
    }
}
