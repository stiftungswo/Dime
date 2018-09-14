<?php

namespace Swo\CommonsBundle\Tests\Entity;

use Doctrine\ORM\QueryBuilder;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Swo\CommonsBundle\Entity\AbstractEntityRepository;

class EntityRepositoryTest extends KernelTestCase
{

    /**
     * @var \Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * {@inheritDoc}
     */

    // according to https://symfony.com/doc/current/testing/doctrine.html
    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    // HELPER FUNCTIONS TO DRY
    protected function getRepoMock()
    {
        $mock = $this->getMockBuilder(AbstractEntityRepository::class)
            ->setConstructorArgs([$this->em, $this->em->getMetadataFactory()
                ->getMetadataFor('DimeTimetrackerBundle:Customer')])
            ->getMockForAbstractClass();

        return $mock;
    }

    protected function getImaginaryRepoMock()
    {
        return $this->getMockBuilder(ImaginaryRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeWithTag', 'scopeWithoutTag'])
            ->getMock();
    }

    protected function paramValuesToArray($parameters)
    {
        $values = [];
        foreach ($parameters as $parameter) {
            array_push($values, $parameter->getValue());
        }

        return $values;
    }

    /* TESTS

    generally: because AbstractEntityRepository is an abstract class, it is not really possible
    to verify its answers through another SQL query like tests in other repositories.

    So most of them here validate the prepared SQL query or the resulting parameters.
    You can argue, that this "unit test" somewhat cares about the internal logic of the methods,
    which it shouldn't, if you follow the concept of testing very strictly.

    You could also take any child class to do this (like in the last tests for the Tag scopes),
    but then you add additional code which basically does nothing but providing you
    an interface to somehow get access to the abstract methods. Real classes like
    "ActivityRepository" overwrite some logic from the EntityRepository, and this also
    could damage the test.

    I guess, it is the best scenario to gain coverage and some kind of control over the code
    in this class, even it isn't very clean code overall */

    public function testScopeByDate()
    {
        // it should work with an array, who has a single date in it
        $query = $this->getRepoMock()->createCurrentQueryBuilder('x')
            ->scopeByDate(['2018-01-01'])->getCurrentQueryBuilder()->getQuery();
        $this->assertEquals(1, count($query->getParameters()));
        $this->assertContains('.created_at LIKE ?', $query->getSQL());
        $this->assertContains('.updated_at LIKE ?', $query->getSQL());
        $this->assertEquals(['2018-01-01%'], $this->paramValuesToArray($query->getParameters()));

        // it should work with two dates who are comma separated
        $query = $this->getRepoMock()->createCurrentQueryBuilder('x')
            ->scopeByDate('2018-01-01,2018-12-31')->getCurrentQueryBuilder()->getQuery();
        $this->assertEquals(2, count($query->getParameters()));
        $this->assertContains('.created_at BETWEEN ? AND ?', $query->getSQL());
        $this->assertContains('.created_at BETWEEN ? AND ?', $query->getSQL());
        $this->assertEquals(
            ['2018-01-01 00:00:00', '2018-12-31 23:59:59'],
            $this->paramValuesToArray($query->getParameters())
        );

        // it should work two dates in an array
        // it should work with two dates who are comma separated
        $parameters = $this->getRepoMock()->createCurrentQueryBuilder('x')
            ->scopeByDate(['2018-01-01', '2018-12-25'])->getCurrentQueryBuilder()->getQuery()
            ->getParameters();
        $this->assertEquals(2, count($parameters));
        $this->assertEquals(
            ['2018-01-01 00:00:00', '2018-12-25 23:59:59'],
            $this->paramValuesToArray($parameters)
        );
    }

    public function testGetCreateSetCurrentQueryBuilder()
    {
        $mock = $this->getRepoMock();
        $this->assertNull($mock->getCurrentQueryBuilder());

        $this->assertInstanceOf(QueryBuilder::class, $mock->createCurrentQueryBuilder('v')
            ->getCurrentQueryBuilder());

        $qb = new QueryBuilder($this->em);
        $mock->setCurrentQueryBuilder($qb);
        $this->assertEquals($qb, $mock->getCurrentQueryBuilder());
    }

    public function testScopeByField()
    {
        // it should make an equal query if argument contains no wildcard
        $query = $this->getRepoMock()->createCurrentQueryBuilder('x')
            ->scopeByField('alias', 'some value')->getCurrentQueryBuilder()->getQuery();
        $this->assertContains('.alias = ?', $query->getSQL());
        $this->assertEquals(1, count($query->getParameters()));
        $this->assertEquals(['some value'], $this->paramValuesToArray($query->getParameters()));

        // it should make a like query if argument contains wildcard
        $query = $this->getRepoMock()->createCurrentQueryBuilder('x')
            ->scopeByField('alias', '*some value*')->getCurrentQueryBuilder()->getQuery();
        $this->assertContains('.alias LIKE ?', $query->getSQL());
        $this->assertEquals(1, count($query->getParameters()));
        $this->assertEquals(['%some value%'], $this->paramValuesToArray($query->getParameters()));
    }

    public function testInterpretMatchQuery()
    {
        // it should return value with wildcards
        $this->assertEquals("*something*", $query = $this->getRepoMock()
            ->createCurrentQueryBuilder('x')->interpretMatchQuery('%', '=something'));
    }

    public function testInterpretComplexQuery()
    {
        // it should return the initial value if it isn't a string
        $this->assertEquals(2500, $query = $this->getRepoMock()
            ->createCurrentQueryBuilder('x')->interpretComplexQuery('%', 2500));

        // it should also not touch the value if it contains no "match" keyword
        $this->assertEquals('some_value', $this->getRepoMock()
            ->createCurrentQueryBuilder('x')->interpretComplexQuery('%', 'some_value'));

        // it should pass the value to the interpreter method if it contains keyword
        $this->assertEquals('*some_value*', $this->getRepoMock()
            ->createCurrentQueryBuilder('x')->interpretComplexQuery('%', 'match=some_value'));
    }
    
    public function testFilter()
    {
        // set up a new mock for this one
        $mock = $this->getMockBuilder(AbstractEntityRepository::class)
            ->disableOriginalConstructor()
            ->setMethods(['scopeByDate', 'search', 'scopeByField'])
            ->getMockForAbstractClass();

        // with date
        $mock->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('dadum'));
        $mock->filter(['date' => 'dadum']);

        // with search
        $mock->expects($this->once())->method('search')
            ->with($this->equalTo('dart-lang.pub'));
        $mock->filter(['search' => 'dart-lang.pub']);

        // default
        $mock->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('value'),
                $this->equalTo(7200)
            );
        $mock->filter(['value' => 7200]);
    }

    public function testExistsJoinAlias()
    {
        // it should return false if there is no join on the DQL part
        $qb = new QueryBuilder($this->em);
        $this->assertFalse($this->getRepoMock()->createCurrentQueryBuilder('x')
            ->existsJoinAlias($qb, 'a'));

        // it should return false if the join does not contain provided alias
        $qb = $this->getRepoMock()->createCurrentQueryBuilder('x')->getCurrentQueryBuilder();
        $qb->leftJoin('x.tags', 't');
        $this->assertFalse($this->getRepoMock()->createCurrentQueryBuilder('x')
            ->existsJoinAlias($qb, 'a'));

        // it should return true if a join in qb with the provided alias exists
        $this->assertTrue($this->getRepoMock()->createCurrentQueryBuilder('x')
            ->existsJoinAlias($qb, 't'));
    }

    // scopeWithTags resp. scopeWithoutTags are complicated to access
    // they are implemented as protected function and call functions in their children
    // so what we need is a API to somehow get to the methods
    // this is implemented in the ImaginaryRepository below

    public function testWithTagsWithoutTagsScope()
    {
        // it should pack the values into an array
        // we don't see anything of that, but we should receive the same values at the
        // scopeWithTag method
        $mock = $this->getImaginaryRepoMock();
        $mock->expects($this->once())->method('scopeWithTag')
            ->with($this->equalTo(25678));
        $mock->scopeWithTags(25678, new QueryBuilder($this->em));

        // it should call tag as many times as it contains elements in the array
        $mock = $this->getImaginaryRepoMock();
        $mock->expects($this->exactly(5))->method('scopeWithTag');
        $mock->scopeWithTags(range(1, 5));
        
        // it should return a repository
        $mock = $this->getImaginaryRepoMock();
        $this->assertInstanceOf(
            ImaginaryRepository::class,
            $mock->scopeWithTags(range(1, 2))
        );
        
        // now the same things for withoutTags
        // it should pack the values into an array
        // we don't see anything of that, but we should receive the same values at the
        // scopeWithoutTag method
        $mock = $this->getImaginaryRepoMock();
        $mock->expects($this->once())->method('scopeWithoutTag')
            ->with($this->equalTo(25678));
        $mock->scopeWithoutTags(25678, new QueryBuilder($this->em));
        
        // it should call tag as many times as it contains elements in the array
        $mock = $this->getImaginaryRepoMock();
        $mock->expects($this->exactly(5))->method('scopeWithoutTag');
        $mock->scopeWithoutTags(range(1, 5));

        // it should return a repository
        $mock = $this->getImaginaryRepoMock();
        $this->assertInstanceOf(
            ImaginaryRepository::class,
            $mock->scopeWithoutTags(range(1, 2))
        );
    }

    protected function tearDown()
    {
        parent::tearDown();

        $this->em->close();
        $this->em = null; // avoid memory leaks
    }
}

class ImaginaryRepository extends AbstractEntityRepository
{
    public function search($text, QueryBuilder $qb = null)
    {
        return $this;
    }

    public function scopeWithTags($tags, QueryBuilder $qb = null)
    {
        return parent::scopeWithTags($tags, $qb);
    }

    public function scopeWithTag($tagIdOrName, QueryBuilder $qb = null)
    {
        return $this;
    }

    public function scopeWithoutTags($tags, QueryBuilder $qb = null)
    {
        return parent::scopeWithoutTags($tags, $qb);
    }

    public function scopeWithoutTag($tagIdOrName, QueryBuilder $qb = null)
    {
        return $this;
    }
}
