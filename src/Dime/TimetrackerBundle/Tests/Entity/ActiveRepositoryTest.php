<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\ActivityRepository;
use Doctrine\ORM\QueryBuilder;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class ActiveRepositoryTest extends KernelTestCase
{

    // according to https://symfony.com/doc/current/testing/doctrine.html
    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    // HELPER FUNCTIONS TO DRY

    public function getRepo()
    {
        return $this->em->getRepository('DimeTimetrackerBundle:Activity');
    }

    public function getRepoWithQB()
    {
        return $this->getRepo()->createCurrentQueryBuilder('a');
    }

    public function getQBFromRepo()
    {
        return $this->getRepoWithQB()->getCurrentQueryBuilder();
    }

    // TESTS

    public function testAllowedFields()
    {
        $allowed_fields_results = $this->getRepo()->allowedFields();
        $allowed_fields_should = array('customer', 'project', 'service', 'user');

        // check that array contains fields it should contain
        $this->assertTrue((boolean)count(array_intersect(
            $allowed_fields_should,
            $allowed_fields_results
        )) == count($allowed_fields_should));
    }

    public function testSearch()
    {
        // we give it an exact description, it should only find one record (based on the fixtures)
        $this->assertEquals(1, count($this->getRepoWithQB()->search('DimERP Programmieren')->
            getCurrentQueryBuilder()->getQuery()->execute()));
    }

    public function testName()
    {
        // this method is a bit more complicated to test, as the executed query is a "LIKE" query
        // in the fixtures, it can generate a lot of services with the same name
        // so, to test this, with a random id like in the other examples, we only can rebuild the query
        // which does not really proof that method works, because the test executes
        // the same code as the tested method
        // so, we just call the method to have it covered if something breaks because of e.g. updates

        $this->getRepoWithQB()->name('*et')->getCurrentQueryBuilder()->getQuery()->execute();
    }

    public function testScopeByCustomer()
    {
        // method is not finished yet, so we ignore that one
    }

    public function testScopeByProject()
    {
        $rand_id = rand(1, 23);

        // fetch the data first through sql
        $qb = $this->getQBFromRepo();
        $expect = count($qb->where($qb->expr()->eq('a.project', $rand_id))->getQuery()->execute());

        $this->assertEquals($expect, count($this->getRepoWithQB()->scopeByProject($rand_id)
            ->getCurrentQueryBuilder()->getQuery()->execute()));

        // do also test findByProject() because it's the same logic
        $this->assertEquals($expect, count($this->getRepoWithQB()->findByProject($rand_id)));
    }

    public function testScopeByService()
    {
        $rand_id = rand(1, 80);

        // now fetch the expectations of amount of records in the activities table
        $qb = $this->getQBFromRepo();
        $expect = count($qb->where($qb->expr()->eq('a.service', $rand_id))->getQuery()->execute());

        $this->assertEquals($expect, count($this->getRepoWithQB()
            ->scopeByService($rand_id)->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    public function testTagScopes()
    {
        $rand_id = rand(1, 20);
        $tag = $this->em->getRepository('DimeTimetrackerBundle:Tag')->find($rand_id);

        // now fetch the expectations of amount of records in the activities table
        $qb = $this->em->getConnection()->createQueryBuilder('a');
        $qb = $qb->select('activity_id')->from('activity_tags')
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

        // if we want all activities without the tag,
        // it should equal the amount of activities minus the upper result
        $all_activities = count($this->getRepoWithQB()->findAll());
        $without_tag = $all_activities - $expect;
        $this->assertEquals($without_tag, count($this->getRepoWithQB()->scopeWithoutTag($rand_id)
            ->getCurrentQueryBuilder()->getQuery()->execute()));

        // same thing if we use the name instead of the id
        $without_tag_name = $all_activities - $tags_with_name;
        $this->assertEquals($without_tag_name, count($this->getRepoWithQB()->scopeWithoutTag($tag->getName())
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    public function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly
        $activity_repository = $this->getMockBuilder(ActivityRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeWithTags', 'scopeWithoutTags', 'search',
                'name', 'scopeByField', 'scopeByDate'])->getMock();

        // with tags
        $activity_repository->expects($this->once())->method('scopeWithTags')
            ->with($this->equalTo('dadum'));
        $activity_repository->filter(['withTags' => 'dadum']);

        // without tags
        $activity_repository->expects($this->once())->method('scopeWithoutTags')
            ->with($this->equalTo('dadum'));
        $activity_repository->filter(['withoutTags' => 'dadum']);

        // with date
        $activity_repository->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('dadum'));
        $activity_repository->filter(['date' => 'dadum']);

        // with search
        $activity_repository->expects($this->once())->method('search')
            ->with($this->equalTo('dadum'));
        $activity_repository->filter(['search' => 'dadum']);

        // with name
        $activity_repository->expects($this->once())->method('name')
            ->with($this->equalTo('dadum'));
        $activity_repository->filter(['name' => 'dadum']);

        // default
        $activity_repository->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('rate_value'),
                $this->equalTo('dadum')
            );
        $activity_repository->filter(['rate_value' => 'dadum']);
    }
}
