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
    function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()
            ->get('doctrine')
            ->getManager()
        ;
    }

    protected function getEntity($id)
    {
        return $this->em
            ->getRepository('DimeTimetrackerBundle:RateUnitType')
            ->findOneBy(array('id' => $id));
    }

    function testTransform()
    {
        // test it with anderes
        $entity = $this->getEntity('a');
        $entity->setDoTransform(true);

        // round mode is 1
        $entity->setRoundMode(1);
        $this->assertEquals(743.921, $entity->transform(743.921347981234));

        // round mode is 2
        $entity->setRoundMode(2);
        $this->assertEquals(345.678, $entity->transform(345.67812));

        // round mode is 3
        $entity->setRoundMode(3);
        $this->assertEquals(3456.789, $entity->transform(3456.78901));

        // round mode is 4
        $entity->setRoundMode(4);
        $this->assertEquals(2345.679, $entity->transform(2345.678901));
        $this->assertEquals(2345.678, $entity->transform(2345.678101));

        // round mode is 5
        $entity->setRoundMode(5);
        $this->assertEquals(2345.678, $entity->transform(2345.678901));

        // round mode is 6
        $entity->setRoundMode(6);
        $this->assertEquals(234.568, $entity->transform(234.56789));

        // round mode is 7
        $entity->setRoundMode(7);
        $this->assertEquals(234.570, $entity->transform(234.56789));
        $this->assertEquals(234.565, $entity->transform(234.566));
        $this->assertEquals(234.560, $entity->transform(234.562));

        // round mode is 8
        $entity->setRoundMode(8);
        $this->assertEquals(234.570, $entity->transform(234.570));
        $this->assertEquals(234.565, $entity->transform(234.566));
        $this->assertEquals(234.560, $entity->transform(234.562));

        // round mode is 9
        $entity->setRoundMode(9);
        $this->assertEquals(234.570, $entity->transform(234.56789));
        $this->assertEquals(234.565, $entity->transform(234.565));
        $this->assertEquals(234.560, $entity->transform(234.559));

        // round mode is something
        $entity->setRoundMode(17);
        $this->assertEquals(234.56789, $entity->transform(234.56789));

        // we deliver the whole thing a string
        $entity->setDoTransform(false);
        $this->assertEquals(234, $entity->transform('234'));

        // one day you could expand the test with tests for any RateType
        // but all of them are anyways using roundMode 1, so we verify that
        $entity = $this->getEntity('h');
        $this->assertEquals(3600 / 3600, $entity->transform(3600));
        $this->assertEquals(1.00, $entity->transform(3601));
        $this->assertEquals(0.99, $entity->transform(3559));

        $entity = $this->getEntity('m');
        $this->assertEquals(60 / 60, $entity->transform(60));
        $this->assertEquals(1.02, $entity->transform(61));
        $this->assertEquals(0.98, $entity->transform(59));

        $entity = $this->getEntity('t');
        $this->assertEquals(30240 / 30240, $entity->transform(30240));
        $this->assertEquals(1.03, $entity->transform(31000));
        $this->assertEquals(0.99, $entity->transform(30000));

        $entity = $this->getEntity('zt');
        $this->assertEquals(30240 / 30240, $entity->transform(30240));
        $this->assertEquals(1.03, $entity->transform(31000));
        $this->assertEquals(0.99, $entity->transform(30000));
    }

    function testTransformBetweenTimeUnits()
    {
        $entity = $this->getEntity('a');

        // hours to hours
        $this->assertEquals('1h', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Hourly, RateUnitType::$Hourly));

        // hours to minutes
        $this->assertEquals(1*60 . 'm', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Hourly, RateUnitType::$Minutely));

        // hours to days
        $this->assertEquals(round(1*(3600/30240), 3) . 't', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Hourly, RateUnitType::$Dayly));

        // hours to zivi days
        $this->assertEquals(round(1*(3600/30240), 3) . 'zt', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Hourly, RateUnitType::$ZiviDayly));

        // hours to seconds
        $this->assertEquals(3600, $entity->transformBetweenTimeUnits(
            1,
            RateUnitType::$Hourly,
            null
        ));

        // minutes to hours
        $this->assertEquals(round(1/60, 3) . 'h', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Minutely, RateUnitType::$Hourly));

        // minutes to minutes
        $this->assertEquals('1m', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Minutely, RateUnitType::$Minutely));

        // minutes to days
        $this->assertEquals(round(1*(60/30240), 3) . 't', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Minutely, RateUnitType::$Dayly));

        // minutes to zivi days
        $this->assertEquals(round(1*(60/30240), 3) . 'zt', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Minutely, RateUnitType::$ZiviDayly));

        // minutes to seconds
        $this->assertEquals(60, $entity->transformBetweenTimeUnits(
            1,
            RateUnitType::$Minutely,
            null
        ));

        // (zivi)days to hours
        $this->assertEquals('8.4h', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Dayly, RateUnitType::$Hourly));

        // (zivi)days to minutes
        $this->assertEquals(8.4*60 . 'm', $entity
            ->transformBetweenTimeUnits(1, RateUnitType::$Dayly, RateUnitType::$Minutely));

        // (zivi)days to days
        $this->assertEquals('1t', $entity->transformBetweenTimeUnits(
            1,
            RateUnitType::$Dayly,
            RateUnitType::$Dayly
        ));

        // (zivi)days to zivi days
        $this->assertEquals('1zt', $entity->transformBetweenTimeUnits(
            1,
            RateUnitType::$Dayly,
            RateUnitType::$ZiviDayly
        ));

        // (zivi)days to seconds
        $this->assertEquals(8.4*60*60, $entity->transformBetweenTimeUnits(
            1,
            RateUnitType::$Dayly,
            null
        ));

        // seconds to hours
        $this->assertEquals(round(1/60/60, 3) . 'h', $entity
            ->transformBetweenTimeUnits(1, null, RateUnitType::$Hourly));

        // seconds to minutes
        $this->assertEquals(round(1/60, 3) . 'm', $entity
            ->transformBetweenTimeUnits(1, null, RateUnitType::$Minutely));

        // seconds to days
        $this->assertEquals(round(1/60/60/8.4, 3) . 't', $entity
            ->transformBetweenTimeUnits(1, null, RateUnitType::$Dayly));

        // seconds to zividays
        $this->assertEquals(round(1/60/60/8.4, 3) . 'zt', $entity
            ->transformBetweenTimeUnits(1, null, RateUnitType::$ZiviDayly));

        // seconds to seconds
        $this->assertEquals(1, $entity->transformBetweenTimeUnits(
            1,
            null,
            null
        ));
    }

    function testReverseTransform()
    {
        // no changes, just parse to float
        $entity = $this->getEntity('a');
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
        $entity = $this->getEntity('h');
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
        $entity = $this->getEntity('m');
        $this->assertEquals(1*60, $entity->reverseTransform("1m"));
        $this->assertEquals(1*60+24, $entity->reverseTransform("1.4m"));
        $this->assertEquals(60, $entity->reverseTransform(60));

        // transform days into seconds
        $entity = $this->getEntity('t');
        $this->assertEquals(60*60*8.4, $entity->reverseTransform("1d"));
        $this->assertEquals((60*60*8.4)*1.4, $entity->reverseTransform("1.4d"));
        $this->assertEquals(60, $entity->reverseTransform(60));

        // cover Zivi day, even the implementation is not final yet
        $entity = $this->getEntity('zt');
        $this->assertEquals(60*60*8.4, $entity->reverseTransform("1zt"));
        $this->assertEquals((60*60*8.4)*1.4, $entity->reverseTransform("1.4zt"));

/*
        TODO: Zivitage:
        0.1zt => 0.5d

        8.4h = 1zt
        5h = 1zt
        4.5h = 0.5zt

        10h = 1.5zt
*/
    }

    function testSerializedOutput()
    {
        // return just the value if type is 'a'
        $entity = $this->getEntity('a');
        $this->assertEquals(16, $entity->serializedOutput(16));
        $this->assertEquals('16', $entity->serializedOutput('16'));

        // return the value plus a symbol
        $entity = $this->getEntity('h');
        $this->assertEquals('16h', $entity->serializedOutput(16));
        $this->assertEquals('16h', $entity->serializedOutput('16'));
    }

    function testGetSetId()
    {
        // get and set a new id
        $entity = $this->getEntity('a');
        $entity->setId('pog');
        $this->assertEquals('pog', $entity->getId());
        $entity->setId('a');
    }

    function testGetSetName()
    {
        // get and set a new name
        $entity = $this->getEntity('a');
        $entity->setName('pog');
        $this->assertEquals('pog', $entity->getName());
        $entity->setName('Anderes');
    }

    function testGetSetDoTransform()
    {
        // get and set doTransform
        $entity = $this->getEntity('a');
        $entity->setDoTransform(true);
        $this->assertEquals(true, $entity->isDoTransform());
        $entity->setDoTransform(false);
    }

    function testGetSetFactor()
    {
        // get and set Factory
        $entity = $this->getEntity('a');
        $entity->setFactor(70);
        $this->assertEquals(70, $entity->getFactor());
        $entity->setFactor(1);
    }

    function testGetSetScale()
    {
        // get and set Scale
        $entity = $this->getEntity('a');
        $entity->setScale(56);
        $this->assertEquals(56, $entity->getScale());
        $entity->setScale(1);
    }

    function testGetSetRoundMode()
    {
        // get and set RoundMode
        $entity = $this->getEntity('a');
        $entity->setRoundMode(9);
        $this->assertEquals(9, $entity->getRoundMode());
        $entity->setRoundMode(1);
    }

    function testGetSetSymbol()
    {
        // get and set Symbol
        $entity = $this->getEntity('a');
        $entity->setSymbol('qwertz');
        $this->assertEquals('qwertz', $entity->getSymbol());

        // return id if symbol is empty
        $entity->setSymbol(null);
        $this->assertEquals('a', $entity->getSymbol());
        $entity->setSymbol('a');
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
