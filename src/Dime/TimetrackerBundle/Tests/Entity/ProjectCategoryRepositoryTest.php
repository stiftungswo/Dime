<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\ProjectCategoryRepository;

class ProjectCategoryRepositoryTest extends DimeRepositoryTestCase
{

    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:ProjectCategory';
    protected const QB_ALIAS='p';

    // TESTS
    function testSearch()
    {
        // not implemented in this class
        $this->assertInstanceOf(ProjectCategoryRepository::class, $this->getRepoWithQB()
            ->search('date'));
    }

    function testScopeByDate()
    {
        // not implemented in this class
        $this->assertInstanceOf(ProjectCategoryRepository::class, $this->getRepoWithQB()
            ->scopeByDate('date'));
    }
}
