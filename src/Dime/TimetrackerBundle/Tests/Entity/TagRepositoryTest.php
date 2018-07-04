<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Faker;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\TagRepository;

class TagRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:Tag';
    protected const QB_ALIAS='t';

    // TESTS
    function testSearch()
    {
        $rand_id = rand(1, 20);
        $tag = $this->getRepo()->find($rand_id);

        // find it by name
        // important: the internal query contains like queries, so we can't figure out
        // the exact amount through another query
        // but we know, that it should at least fire as much back as the findBy query
        $tags = $this->getRepo()->findBy(['name' => $tag->getName()]);
        $this->assertGreaterThanOrEqual(count($tags), count($this->getRepoWithQB()
            ->search($tag->getName())->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(
            TagRepository::class,
            $this->getRepoWithQB()->scopeByDate('date')
        );
    }

    function testGetIdsForTags()
    {
        $faker = Faker\Factory::create();
        $tag_rand_id = rand(1, 20);
        $tag = $this->getRepo()->find($tag_rand_id);
        $user_id = $tag->getUser();
        // check for duplicates
        $expect = count($this->getRepo()->findBy(['name' => $tag->getName(),
            'user' => $tag->getUser()]));

        // this thing does multiple things:
        // 1. it searches for all tags
        // 2. because we deliver an unknown tag, it should create a new one
        $result = $this->getRepoWithQB()->getIdsForTags(
            [$tag->getName(), $faker->word],
            $user_id
        );
        $this->assertEquals($expect + 1, count($result));
        $this->assertContains($tag->getId(), $result);

        // it should return empty array if tags are empty
        $this->assertEmpty($this->getRepoWithQB()->getIdsForTags([], $user_id));
    }
}
