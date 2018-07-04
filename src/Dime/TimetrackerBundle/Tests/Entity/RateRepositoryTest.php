<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\RateRepository;

class RateRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:Rate';
    protected const QB_ALIAS='r';

    // TESTS
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
