<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\RateUnitType;

class RateUnitTypeTest extends KernelTestCase
{

    /**
     * @var \Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * {@inheritDoc}
     */
    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()
            ->get('doctrine')
            ->getManager()
        ;
    }

    public function testReverseTransform()
    {
        // no changes, just parse to float
        $entity = $this->em
            ->getRepository('DimeTimetrackerBundle:RateUnitType')
            ->findOneBy(array('id' => 'a'));

        $this->assertEquals('a', $entity->getId());
        $this->assertEquals(false, $entity->isDoTransform());
        $this->assertEquals(6, $entity->reverseTransform("6.0"));
        $this->assertEquals(1.5, $entity->reverseTransform(1.5));
        $this->assertEquals(1.5, $entity->reverseTransform("1.5"));
        $this->assertEquals(-3.5, $entity->reverseTransform(-3.5));
        $this->assertEquals(-3.5, $entity->reverseTransform("-3.5"));
        $this->assertEquals(3.5, $entity->reverseTransform("3,5"));
        $this->assertEquals(3.123456789, $entity->reverseTransform(3.123456789));

        // transform hours into seconds
        $entity = $this->em
            ->getRepository('DimeTimetrackerBundle:RateUnitType')
            ->findOneBy(array('id' => 'h'));

        $this->assertEquals(3600, $entity->getFactor());
        $this->assertEquals(1*60*60, $entity->reverseTransform("1h"));
        $this->assertEquals((1*60*60)*1.4, $entity->reverseTransform("1.4h"));
        $this->assertEquals(60, $entity->reverseTransform(60));
        // some edge cases
        $this->assertEquals(1*60*60, $entity->reverseTransform("1h "));
        $this->assertEquals(1*60*60, $entity->reverseTransform(" 1h"));
        $this->assertEquals(1*60*60, $entity->reverseTransform("1H"));
        $this->assertEquals(4044, $entity->reverseTransform("1.12345h"));
        $this->assertEquals(-(1*60*60)*1.4, $entity->reverseTransform("-1.4h"));
        $this->assertEquals(-(1*60*60)*1.4, $entity->reverseTransform("-1,4h"));
        $this->assertEquals(60, $entity->reverseTransform("60"));
        $this->assertEquals(0, $entity->reverseTransform(null));
        $this->assertEquals(0, $entity->reverseTransform('somesthing else'));

        // transform minutes into seconds
        $entity = $this->em
            ->getRepository('DimeTimetrackerBundle:RateUnitType')
            ->findOneBy(array('id' => 'm'));

        $this->assertEquals(1*60, $entity->reverseTransform("1m"));
        $this->assertEquals(1*60+24, $entity->reverseTransform("1.4m"));
        $this->assertEquals(60, $entity->reverseTransform(60));

        // transform days into seconds
        $entity = $this->em
            ->getRepository('DimeTimetrackerBundle:RateUnitType')
            ->findOneBy(array('id' => 't'));

        $this->assertEquals(60*60*8.4, $entity->reverseTransform("1d"));
        $this->assertEquals((60*60*8.4)*1.4, $entity->reverseTransform("1.4d"));
        $this->assertEquals(60, $entity->reverseTransform(60));

/*
        TODO: Zivitage:
        0.1zt => 0.5d

        8.4h = 1zt
        5h = 1zt
        4.5h = 0.5zt

        10h = 1.5zt
*/
    }

    /**
     * {@inheritDoc}
     */
    protected function tearDown()
    {
        parent::tearDown();
        $this->em->close();
    }
}
