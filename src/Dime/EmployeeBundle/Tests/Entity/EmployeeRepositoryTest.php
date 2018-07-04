<?php

namespace Dime\EmployeeBundle\Tests\Entity;

use Dime\TimetrackerBundle\Tests\Entity\DimeRepositoryTestCase;
use Dime\EmployeeBundle\Entity\EmployeeRepository;

class EmployeeRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeEmployeeBundle:Employee';
    protected const QB_ALIAS='e';

    // TESTS
    function testScopeByDate()
    {
        // this function does nothing, so we just verify its return value
        $this->assertInstanceOf(
            EmployeeRepository::class,
            $this->getRepoWithQB()->scopeByDate('2055-07-01')
        );
    }

    function testScopeWithTag()
    {
        // this function does nothing, so we just verify its return value
        $this->assertInstanceOf(
            EmployeeRepository::class,
            $this->getRepoWithQB()->scopeWithTag('hashtag')
        );
    }

    function testScopeWithoutTag()
    {
        // this function does nothing, so we just verify its return value
        $this->assertInstanceOf(
            EmployeeRepository::class,
            $this->getRepoWithQB()->scopeWithoutTag('swo')
        );
    }

    function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly
        $employee_repository = $this->getMockBuilder(EmployeeRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeWithTags', 'scopeWithoutTags', 'search',
                'scopeByField', 'scopeByDate'])->getMock();

        // with tags
        $employee_repository->expects($this->once())->method('scopeWithTags')
            ->with($this->equalTo('some values'));
        $employee_repository->filter(['withTags' => 'some values']);

        // without tags
        $employee_repository->expects($this->once())->method('scopeWithoutTags')
            ->with($this->equalTo('some values'));
        $employee_repository->filter(['withoutTags' => 'some values']);

        // with date
        $employee_repository->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('2018-06-23'));
        $employee_repository->filter(['date' => '2018-06-23']);

        // with search
        $employee_repository->expects($this->once())->method('search')
            ->with($this->equalTo('some values'));
        $employee_repository->filter(['search' => 'some values']);

        // default
        $employee_repository->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('name'),
                $this->equalTo('some values')
            );
        $employee_repository->filter(['name' => 'some values']);
    }

    function testSearch()
    {
        // this function does nothing, so we just verify its return value
        $this->assertInstanceOf(
            EmployeeRepository::class,
            $this->getRepoWithQB()->search('employikes')
        );
    }
}
