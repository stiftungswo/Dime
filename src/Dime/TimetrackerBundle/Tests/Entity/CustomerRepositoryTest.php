<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\CustomerRepository;

class CustomerRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:Customer';
    protected const QB_ALIAS='c';

    // TESTS
    function testSearch()
    {
        $rand_id = rand(1, 25);
        // search searches in the name and the alias
        // let's verify the name first
        $customer = $this->getRepo()->find($rand_id);

        // check for any duplicates
        $customers = $this->getRepo()->findBy(['name' => $customer->getName()]);
        $this->assertGreaterThanOrEqual(count($customers), count($this->getRepoWithQB()
            ->search($customer->getName())->getCurrentQueryBuilder()->getQuery()->execute()));

        // let's do the same for the alias
        $customers = $this->getRepo()->findBy(['alias' => $customer->getAlias()]);
        $this->assertGreaterThanOrEqual(count($customers), count($this->getRepoWithQB()
            ->search($customer->getAlias())->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(CustomerRepository::class, $this->getRepo()->scopeByDate(null));
    }

    function testFindByProject()
    {
        // get a project which has a customer assigned
        $qb = $this->getQBFromRepo('p', 'DimeTimetrackerBundle:Project');
        $qb->where($qb->expr()->isNotNull('p.customer'))->setMaxResults(1);
        $project = $qb->getQuery()->execute()[0];

        // now it should find the same customer
        $this->assertEquals($project->getCustomer(), $this->getRepoWithQB()
            ->findByProject($project->getId()));
    }

    function testTagScopes()
    {
        $rand_id = rand(1, 20);
        $tag = $this->getRepo('DimeTimetrackerBundle:Tag')->find($rand_id);

        // now fetch the expectations of amount of records in the customers table
        $qb = $this->em->getConnection()->createQueryBuilder('a');
        $qb = $qb->select('customer_id')->from('customer_tags')
            ->where($qb->expr()->eq('tag_id', $rand_id));
        $expect = count($qb->execute()->fetchAll());

        // check it first with the ID
        $this->assertEquals($expect, count($this->getRepoWithQB()->scopeWithTag($rand_id)
            ->getQuery()->execute()));

        // the result could differ with the name, as the fixtures could include doubles
        // but it should at least be as much as the previous result
        $tags_with_name = count($this->getRepoWithQB()
            ->scopeWithTag($tag->getName())->getQuery()->execute());
        $this->assertGreaterThanOrEqual($expect, $tags_with_name);

        // if we want all activities without the tag,
        // it should equal the amount of customers minus the upper result
        $all_customers = count($this->getRepoWithQB()->findAll());
        $without_tag = $all_customers - $expect;
        $this->assertEquals($without_tag, count($this->getRepoWithQB()->scopeWithoutTag($rand_id)
            ->getCurrentQueryBuilder()->getQuery()->execute()));

        // same thing if we use the name instead of the id
        $without_tag_name = $all_customers - $tags_with_name;
        $this->assertEquals($without_tag_name, count($this->getRepoWithQB()
            ->scopeWithoutTag($tag->getName())
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly internally
        $customer_repository = $this->getMockBuilder(CustomerRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeByDate', 'scopeWithTags', 'scopeWithoutTags',
                'scopeByField', 'search'])->getMock();

        // with tags
        $customer_repository->expects($this->once())->method('scopeWithTags')
            ->with($this->equalTo('badabing'));
        $customer_repository->filter(['withTags' => 'badabing']);

        // without tags
        $customer_repository->expects($this->once())->method('scopeWithoutTags')
            ->with($this->equalTo('badabeng'));
        $customer_repository->filter(['withoutTags' => 'badabeng']);

        // with date
        $customer_repository->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('27.01.2018'));
        $customer_repository->filter(['date' => '27.01.2018']);

        // with search
        $customer_repository->expects($this->once())->method('search')
            ->with($this->equalTo('jahade'));
        $customer_repository->filter(['search' => 'jahade']);

        // default
        $customer_repository->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('department'),
                $this->equalTo('labore')
            );
        $customer_repository->filter(['department' => 'labore']);
    }
}
