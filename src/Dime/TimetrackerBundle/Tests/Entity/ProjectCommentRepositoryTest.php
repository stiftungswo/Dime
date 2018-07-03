<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class ProjectCommentRepositoryTest extends KernelTestCase
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
        return $this->em->getRepository('DimeTimetrackerBundle:ProjectComment');
    }

    protected function getRepoWithQB()
    {
        return $this->getRepo()->createCurrentQueryBuilder('c');
    }

    function testSearch()
    {
        // not implemented in this class
        $this->assertNull($this->getRepoWithQB()->search('date'));
    }
}
