<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\UserRepository;

class UserRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeTimetrackerBundle:User';
    protected const QB_ALIAS='u';

    // TESTS
    public function testSearch()
    {
        // this function has no further options, so we just check the type to get coverage
        $this->assertInstanceOf(UserRepository::class, $this->getRepo()->search('text'));
    }

    public function testScopeByDate()
    {
        // this function provides no further functionality, so we just the type
        $this->assertInstanceOf(UserRepository::class, $this->getRepo()->scopeByDate('text'));
    }
    public function testScopeByFullname()
    {
        $rand_id = rand(1, 26);
        $user = $this->getRepo()->find($rand_id);

        // it should return user with first and last name
        // but it is always possible to have a user with the same name
        $expect = $this->getRepo()->findBy(['firstname' => $user->getFirstname(),
            'lastname' => $user->getLastname()]);
        $result = $this->getRepoWithQB()->scopeByFullname($user->getFullname())
            ->getCurrentQueryBuilder()->getQuery()->execute();
        $this->assertEquals(count($expect), count($result));

        // it should return users with the same first name (when we only pass the first name)
        $firstname = $user->getFirstname();
        $result = $this->getRepo()->findBy(['firstname' => $firstname]);
        $this->assertEquals(count($result), count($this->getRepoWithQB()->scopeByFullname($firstname)
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }
    
    public function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly internally
        $user_repository = $this->getMockBuilder(UserRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeByDate', 'scopeByFullname', 'scopeByField', 'search'])->getMock();

        // with date
        $user_repository->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('27.01.2018'));
        $user_repository->filter(['date' => '27.01.2018']);

        // with search
        $user_repository->expects($this->once())->method('search')
            ->with($this->equalTo('jahade'));
        $user_repository->filter(['search' => 'jahade']);

        // with fullname
        $user_repository->expects($this->once())->method('scopeByFullname')
            ->with($this->equalTo('jahade'));
        $user_repository->filter(['fullname' => 'jahade']);

        // default
        $user_repository->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('email'),
                $this->equalTo('some@mail.com')
            );
        $user_repository->filter(['email' => 'some@mail.com']);
    }
}
