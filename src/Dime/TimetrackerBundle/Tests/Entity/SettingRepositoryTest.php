<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\SettingRepository;

class SettingRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:Setting';
    protected const QB_ALIAS='s';

    // TESTS
    public function testSearch()
    {
        // class does not implement search
        $this->assertInstanceOf(
            SettingRepository::class,
            $this->getRepoWithQB()->search('something')
        );
    }

    public function testScopeByDate()
    {
        // class does not implement scopeByDate
        $this->assertInstanceOf(
            SettingRepository::class,
            $this->getRepoWithQB()->scopeByDate('something')
        );
    }

    public function testScopeByNamespace()
    {
        $rand_id = rand(1, 9);
        $setting = $this->getRepoWithQB()->find($rand_id);
        $this->assertGreaterThanOrEqual(1, count($this->getRepoWithQB()
            ->scopeByNamespace($setting->getNamespace())->getCurrentQueryBuilder()
            ->getQuery()->execute()));
    }
}
