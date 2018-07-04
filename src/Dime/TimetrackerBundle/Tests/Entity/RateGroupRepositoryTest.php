<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\RateGroupRepository;

class RateGroupRepositoryTest extends DimeRepositoryTestCase
{

    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:RateGroup';
    protected const QB_ALIAS='r';

    // TESTS
    function testSearch()
    {
        $rand_id = rand(1, 2);
        $rate_group = $this->getRepo()->find($rand_id);

        // find it by name
        // important: the internal query contains like queries, so we can't figure out
        // the exact amount through another query
        // but we know, that it should at least fire as much back as the findBy query
        $rate_groups = $this->getRepo()->findBy(['name' => $rate_group->getName()]);
        $this->assertGreaterThanOrEqual(count($rate_groups), count($this->getRepoWithQB()
            ->search($rate_group->getName())->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(
            RateGroupRepository::class,
            $this->getRepoWithQB()->scopeByDate('date')
        );
    }
}
