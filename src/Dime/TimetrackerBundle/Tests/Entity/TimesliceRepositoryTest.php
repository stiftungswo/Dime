<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\TimesliceRepository;
use Doctrine\ORM\QueryBuilder;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Carbon\Carbon;

class TimesliceRepositoryTest extends KernelTestCase
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
        return $this->em->getRepository('DimeTimetrackerBundle:Timeslice');
    }

    public function getRepoWithQB()
    {
        return $this->getRepo()->createCurrentQueryBuilder('t');
    }

    public function testSearch()
    {
        // you can't search in this class, so we just call the method for the coverage
        $this->getRepoWithQB()->search('some_text');
    }

    public function testScopeByLatest()
    {
        // it should only the latest object
        $qb = $this->getRepoWithQB()->getCurrentQueryBuilder();
        $qb = $qb->orderBy('t.startedAt', 'DESC')->setMaxResults(1);
        $expect = $qb->getQuery()->execute();

        $test = $this->getRepoWithQB()
            ->scopeByLatest()->getCurrentQueryBuilder()->getQuery()->execute();

        $this->assertEquals(1, count($test));

        $this->assertEquals($expect, $test);
    }

    public function testScopeByDate()
    {
        $rand_id = rand(1, 300);
        // get a timeslice to get its creation date
        $timeslice = $this->getRepoWithQB()->find($rand_id);
        $dt = Carbon::instance($timeslice->getStartedAt());

        $this->assertNotEquals(0, count($this->getRepoWithQB()
            ->scopeByDate([$dt->toDateString()])
            ->getCurrentQueryBuilder()->getQuery()->execute()));

        $this->assertNotEquals(0, count($this->getRepoWithQB()
            ->scopeByDate([$dt->toDateString(), (clone $dt)->addWeeks(4)->toDateString()])
            ->getCurrentQueryBuilder()->getQuery()->execute()));

        $this->assertNotEquals(0, count($this->getRepoWithQB()
            ->scopeByDate($dt->toDateString(). ',' . (clone $dt)->addDays(3)->toDateString())
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    public function testScopeByEmployee()
    {
        // currently not tested, see comment at method itself
    }

    public function testScopeByActivityData()
    {
        $rand_id = rand(1, 54);
        $activity = $this->em->getRepository('DimeTimetrackerBundle:Activity')->find($rand_id);

        // now fetch the expectations of amount of records in the timeslices table
        $qb = $this->em->getConnection()->createQueryBuilder('a');
        $qb = $qb->select('activity_id')->from('timeslices')
            ->where($qb->expr()->eq('activity_id', $rand_id));
        $expect = $qb->execute()->fetchAll();

        // lets compare the results
        $this->assertEquals(count($expect), count($this->getRepoWithQB()
            ->scopeByActivityData(['project' => $activity->getProject()->getId(),
                'service' => $activity->getService()->getId(),
                'user' => $activity->getUser()->getId()])
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    public function testTagScopes()
    {
        $rand_id = rand(1, 20);
        $tag = $this->em->getRepository('DimeTimetrackerBundle:Tag')->find($rand_id);

        // now fetch the expectations of amount of records in the timeslices table
        $qb = $this->em->getConnection()->createQueryBuilder('a');
        $qb = $qb->select('timeslice_id')->from('timeslice_tags')
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
        // it should equal the amount of timeslices minus the upper result
        $all_timeslices = count($this->getRepoWithQB()->findAll());
        $without_tag = $all_timeslices - $expect;
        $this->assertEquals($without_tag, count($this->getRepoWithQB()->scopeWithoutTag($rand_id)
            ->getCurrentQueryBuilder()->getQuery()->execute()));

        // same thing if we use the name instead of the id
        $without_tag_name = $all_timeslices - $tags_with_name;
        $this->assertEquals($without_tag_name, count($this->getRepoWithQB()->scopeWithoutTag($tag->getName())
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    public function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly internally
        $timeslice_repository = $this->getMockBuilder(TimesliceRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeByDate', 'scopeWithTags', 'scopeWithoutTags',
                'scopeByLatest', 'scopeByField', 'scopeByActivityData'])->getMock();

        // with date
        $timeslice_repository->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('dadum'));
        $timeslice_repository->filter(['date' => 'dadum']);

        // with customer / project / service
        $value_map = [
            ['customer' => 'dadum'], ['project' => 'dadum'], ['service' => 'dadum'] ];
        $timeslice_repository->expects($this->exactly(3))->method('scopeByActivityData')
            ->will($this->returnValueMap($value_map));
        $timeslice_repository->filter(['customer' => 'dadum']);
        $timeslice_repository->filter(['project' => 'dadum']);
        $timeslice_repository->filter(['service' => 'dadum']);

        // with tags
        $timeslice_repository->expects($this->once())->method('scopeWithTags')
            ->with($this->equalTo('dadum'));
        $timeslice_repository->filter(['withTags' => 'dadum']);

        // without tags
        $timeslice_repository->expects($this->once())->method('scopeWithoutTags')
            ->with($this->equalTo('dadum'));
        $timeslice_repository->filter(['withoutTags' => 'dadum']);

        // with latest
        $timeslice_repository->expects($this->once())->method('scopeByLatest');
        $timeslice_repository->filter(['latest' => null]);

        // default
        $timeslice_repository->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('value'),
                $this->equalTo(7200)
            );
        $timeslice_repository->filter(['value' => 7200]);
    }

    public function testFetchActivityIdsByDates()
    {
        $rand_id = rand(1, 461);

        $timeslice = $this->getRepoWithQB()->find($rand_id);
        $dt_from = Carbon::instance($timeslice->getStartedAt());
        $dt_to = (clone $dt_from)->addDays(8);

        // check fetchActivityIdsByDate first
        $this->assertNotEquals(0, count($this->getRepoWithQB()
            ->fetchActivityIdsByDate($dt_from->toDateString())));

        // check also that it is possible to return 0
        $dt = Carbon::create(1832, 4, 23, 15, 13, 43, 'America/Toronto');
        $this->assertEquals(0, count($this->getRepoWithQB()
            ->fetchActivityIdsByDate($dt->toDateString())));

        // check fetchActivityIdsByDateRange now
        $this->assertNotEquals(0, count($this->getRepoWithQB()
            ->fetchActivityIdsByDateRange($dt_from->toDateString(), $dt_to->toDateString())));

        // check also that it is possible to return 0
        $dt = Carbon::create(1832, 4, 23, 15, 13, 43, 'America/Toronto');
        $this->assertEquals(0, count($this->getRepoWithQB()
            ->fetchActivityIdsByDateRange($dt->toDateString(), $dt->addDays(3)->toDateString())));
    }
}
