<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\ServiceRepository;

class ServiceRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:Service';
    protected const QB_ALIAS='s';

    // TESTS
    function testSearch()
    {
        $rand_id = rand(1, 80);
        $service = $this->getRepo()->find($rand_id);

        // find it by name
        // important: the internal query contains like queries, so we can't figure out
        // the exact amount through another query
        // but we know, that it should at least fire as much back as the findBy query
        $services = $this->getRepo()->findBy(['name' => $service->getName()]);
        $this->assertGreaterThanOrEqual(count($services), count($this->getRepoWithQB()
            ->search($service->getName())->getCurrentQueryBuilder()->getQuery()->execute()));

        // let's do the same for the alias
        $services = $this->getRepo()->findBy(['alias' => $service->getAlias()]);
        $this->assertGreaterThanOrEqual(count($services), count($this->getRepoWithQB()
            ->search($service->getAlias())->getCurrentQueryBuilder()->getQuery()->execute()));

        // and another time for the description
        $services = $this->getRepo()->findBy(['description' => $service->getDescription()]);
        $this->assertGreaterThanOrEqual(count($services), count($this->getRepoWithQB()
            ->search($service->getName())->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(
            ServiceRepository::class,
            $this->getRepoWithQB()->scopeByDate('date')
        );
    }

    function testScopeByRateGroup()
    {
        $rand_id = rand(1, 2);
        $rate_group = $this->getRepo('DimeTimetrackerBundle:RateGroup')->find($rand_id);
        $rates = $this->getRepo('DimeTimetrackerBundle:Rate')
            ->findBy(['rateGroup' => $rate_group]);

        $val = [];
        foreach ($rates as $rate) {
            array_push($val, $rate->getService());
        }

        $expect = count(array_unique($val));
        $this->assertEquals($expect, count($this->getRepo()->scopeByRateGroup(
            $rate_group->getId(),
            $this->getQBFromRepo()
        )
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly internally
        $project_repository = $this->getMockBuilder(ServiceRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeByRateGroup'])->getMock();

        // with rate group
        $project_repository->expects($this->once())->method('scopeByRateGroup')
            ->with($this->equalTo('badabing'));
        $project_repository->filter(['rateGroup' => 'badabing']);

        // default
        $this->expectException(\Exception::class);
        $project_repository->filter(['anything' => 'anything']);
    }
}
