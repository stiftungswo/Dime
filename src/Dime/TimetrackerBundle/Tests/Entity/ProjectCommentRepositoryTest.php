<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

class ProjectCommentRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:ProjectComment';
    protected const QB_ALIAS='p';

    // TESTS
    function testSearch()
    {
        // not implemented in this class
        $this->assertNull($this->getRepoWithQB()->search('date'));
    }
}
