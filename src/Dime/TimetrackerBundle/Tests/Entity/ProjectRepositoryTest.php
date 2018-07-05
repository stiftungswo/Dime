<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\ProjectRepository;

class ProjectRepositoryTest extends DimeRepositoryTestCase
{

    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:Project';
    protected const QB_ALIAS='p';

    // TESTS
    public function testSearch()
    {
        $rand_id = rand(1, 23);
        $project = $this->getRepo()->find($rand_id);

        // find it by name
        // important: the internal query contains like queries, so we can't figure out
        // the exact amount through another query
        // but we know, that it should at least fire as much back as the findBy query
        $projects = $this->getRepo()->findBy(['name' => $project->getName()]);
        $this->assertGreaterThanOrEqual(count($projects), count($this->getRepoWithQB()
            ->search($project->getName())->getCurrentQueryBuilder()->getQuery()->execute()));

        // let's do the same for the alias
        $projects = $this->getRepo()->findBy(['alias' => $project->getAlias()]);
        $this->assertGreaterThanOrEqual(count($projects), count($this->getRepoWithQB()
            ->search($project->getAlias())->getCurrentQueryBuilder()->getQuery()->execute()));

        // and another time for the description
        $projects = $this->getRepo()->findBy(['description' => $project->getDescription()]);
        $this->assertGreaterThanOrEqual(count($projects), count($this->getRepoWithQB()
            ->search($project->getName())->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    public function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(
            ProjectRepository::class,
            $this->getRepoWithQB()->scopeByDate('date')
        );
    }

    public function testFindByCustomer()
    {
        // should at least fire back one result because all projects in the fixtures have a customer
        $rand_id = rand(1, 23);
        $project = $this->getRepo()->find($rand_id);

        $this->assertGreaterThanOrEqual(1, count($this->getRepoWithQB()->findByCustomer(
            $project->getCustomer()->getId()
        )));
    }

    public function testTagScopes()
    {
        $rand_id = rand(1, 20);
        $tag = $this->getRepo('DimeTimetrackerBundle:Tag')->find($rand_id);

        // now fetch the expectations of amount of records in the customers table
        $qb = $this->em->getConnection()->createQueryBuilder('a');
        $qb = $qb->select('project_id')->from('project_tags')
            ->where($qb->expr()->eq('tag_id', $rand_id));
        $expect = count($qb->execute()->fetchAll());

        // check it first with the ID
        $this->assertEquals($expect, count($this->getRepoWithQB()
            ->scopeWithTag($rand_id)->getCurrentQueryBuilder()->getQuery()->execute()));

        // the result could differ with the name, as the fixtures could include doubles
        // but it should at least be as much as the previous result
        $tags_with_name = count($this->getRepoWithQB()
            ->scopeWithTag($tag->getName())->getCurrentQueryBuilder()->getQuery()->execute());
        $this->assertGreaterThanOrEqual($expect, $tags_with_name);

        // if we want all projects without the tag,
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

    public function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly internally
        $project_repository = $this->getMockBuilder(ProjectRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeByDate', 'scopeWithTags', 'scopeWithoutTags',
                'scopeByField', 'search'])->getMock();

        // with tags
        $project_repository->expects($this->once())->method('scopeWithTags')
            ->with($this->equalTo('badabing'));
        $project_repository->filter(['withTags' => 'badabing']);

        // without tags
        $project_repository->expects($this->once())->method('scopeWithoutTags')
            ->with($this->equalTo('badabeng'));
        $project_repository->filter(['withoutTags' => 'badabeng']);

        // with date
        $project_repository->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('27.01.2018'));
        $project_repository->filter(['date' => '27.01.2018']);

        // with search
        $project_repository->expects($this->once())->method('search')
            ->with($this->equalTo('jahade'));
        $project_repository->filter(['search' => 'jahade']);

        // default
        $project_repository->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('budget_price'),
                $this->equalTo('65000')
            );
        $project_repository->filter(['budget_price' => '65000']);
    }
}
