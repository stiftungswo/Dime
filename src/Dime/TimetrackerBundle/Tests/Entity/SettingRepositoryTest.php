<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\SettingRepository;

class SettingRepositoryTest extends KernelTestCase
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
        return $this->em->getRepository('DimeTimetrackerBundle:Setting');
    }

    protected function getRepoWithQB()
    {
        return $this->getRepo()->createCurrentQueryBuilder('t');
    }
    
    function testSearch()
    {
        // class does not implement search
        $this->assertInstanceOf(
            SettingRepository::class,
            $this->getRepoWithQB()->search('something')
        );
    }

    function testScopeByDate()
    {
        // class does not implement scopeByDate
        $this->assertInstanceOf(
            SettingRepository::class,
            $this->getRepoWithQB()->scopeByDate('something')
        );
    }

    function testScopeByNamespace()
    {
        $rand_id = rand(1, 9);
        $setting = $this->getRepoWithQB()->find($rand_id);
        $this->assertGreaterThanOrEqual(1, count($this->getRepoWithQB()
            ->scopeByNamespace($setting->getNamespace())->getCurrentQueryBuilder()
            ->getQuery()->execute()));
    }
}
