<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\RateRepository;

class RateRepositoryTest extends KernelTestCase
{

    // according to https://symfony.com/doc/current/testing/doctrine.html
    function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    // HELPER FUNCTIONS TO DRY
    protected function getRepo()
    {
        return $this->em->getRepository('DimeTimetrackerBundle:Rate');
    }

    protected function getRepoWithQB()
    {
        return $this->getRepo()->createCurrentQueryBuilder('c');
    }

    function testSearch()
    {
        // not implemented in this class
        $this->assertInstanceOf(RateRepository::class, $this->getRepoWithQB()
            ->search('date'));
    }

    function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(RateRepository::class, $this->getRepoWithQB()
            ->scopeByDate('date'));
    }
}
