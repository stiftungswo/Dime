<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\RateUnitTypeRepository;

class RateUnitTypeRepositoryTest extends KernelTestCase
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
        return $this->em->getRepository('DimeTimetrackerBundle:RateUnitType');
    }

    protected function getRepoWithQB()
    {
        return $this->getRepo()->createCurrentQueryBuilder('c');
    }

    function testSearch()
    {
        $rate_unit = $this->getRepo()->find('h');

        // find it by name
        // important: the internal query contains like queries, so we can't figure out
        // the exact amount through another query
        // but we know, that it should at least fire as much back as the findBy query
        $rate_units = $this->getRepo()->findBy(['name' => $rate_unit->getName()]);
        $this->assertGreaterThanOrEqual(count($rate_units), count($this->getRepoWithQB()
            ->search($rate_unit->getName())->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(
            RateUnitTypeRepository::class,
            $this->getRepoWithQB()->scopeByDate('date')
        );
    }
}
