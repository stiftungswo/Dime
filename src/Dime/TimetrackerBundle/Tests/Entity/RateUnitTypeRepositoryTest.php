<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\RateUnitTypeRepository;

class RateUnitTypeRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:RateUnitType';
    protected const QB_ALIAS='r';

    // TESTS
    public function testSearch()
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

    public function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(
            RateUnitTypeRepository::class,
            $this->getRepoWithQB()->scopeByDate('date')
        );
    }
}
