<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\Activity;
use Doctrine\Common\Collections\ArrayCollection;
use Carbon\Carbon;
use Dime\EmployeeBundle\Entity\Employee;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Tag;
use PHPUnit\Framework\TestCase;
use Dime\TimetrackerBundle\Entity\Timeslice;

class TimesliceTest extends TestCase
{
    public function testSetStandardUnit()
    {
        // only has a setter
        $timeslice = new Timeslice();
        $timeslice->setStandardUnit('h');
    }

    public function testGetSetActivity()
    {
        // get and set activity
        $timeslice = new Timeslice();
        $activity = new Activity();
        $this->assertNull($timeslice->getActivity());
        $timeslice->setActivity($activity);
        $this->assertEquals($activity, $timeslice->getActivity());
    }

    public function testSetValue()
    {
        // it should return own value
        $timeslice = new Timeslice();
        $timeslice->setValue('2h');
        $this->assertEquals('2h', $timeslice->getValue());

        // it should return value in combination with rate unit type
        $rate_unit_type = new RateUnitType();
        $rate_unit_type->setId('h');
        $activity = new Activity();
        $activity->setRateUnitType($rate_unit_type);
        $timeslice->setActivity($activity);
        $timeslice->setValue('2h');

        $this->assertEquals(7200, $timeslice->getValue());
    }

    public function testSerializeValue()
    {
        // it should return its own value
        $timeslice = new Timeslice();
        $timeslice->setValue(60480);
        $this->assertEquals(60480, $timeslice->serializeValue());

        // it should transform between unit if standardunit is set
        $timeslice->setStandardUnit('t');
        $this->assertEquals('2t', $timeslice->serializeValue());

        // it should transform it
        $timeslice->setValue('2h');
        $rate_unit_type = new RateUnitType();
        $rate_unit_type->setId('h');
        $activity = new Activity();
        $activity->setRateUnitType($rate_unit_type);
        $timeslice->setActivity($activity);
        $timeslice->setStandardUnit(null);
        $this->assertEquals('2h', $timeslice->serializeValue());
    }

    public function testGetSetProject()
    {
        // get and set activity
        $activity = new Activity();
        $project = new Project();
        $timeslice = new Timeslice();
        $this->assertNull($timeslice->getProject());
        $activity->setProject($project);
        $timeslice->setActivity($activity);
        $this->assertEquals($project, $timeslice->getProject());
    }

    public function testGetSetStartedAt()
    {
        // it should be null if argument is null
        $timeslice = new Timeslice();
        $timeslice->setStartedAt(null);
        $this->assertNull($timeslice->getStartedAt());
        $this->assertNull($timeslice->getStartedAtSerialized());

        // it should process string values
        $timeslice->setStartedAt('2018-07-02');
        $carboned_version = new Carbon('2018-07-02 08:00');
        $this->assertEquals($carboned_version, $timeslice->getStartedAt());
        $this->assertEquals($carboned_version->toDateTimeString(), $timeslice->getStartedAtSerialized());

        // it should process datetime values
        $dt = new \DateTime();
        $timeslice->setStartedAt($dt);
        $this->assertEquals(Carbon::instance($dt), $timeslice->getStartedAt());
        $this->assertEquals(
            Carbon::instance($dt)->toDateTimeString(),
            $timeslice->getStartedAtSerialized()
        );
    }

    public function testGetStoppedAt()
    {
        // it should be null if value is null
        $timeslice = new Timeslice();
        $timeslice->setStartedAt(null);
        $this->assertNull($timeslice->getStoppedAt());
        $this->assertNull($timeslice->getStoppedAtSerialized());

        // it should return calculation based on own value
        $timeslice->setValue(36000);
        $timeslice->setStartedAt('2018-07-02');
        $carboned_version = new Carbon('2018-07-02 18:00');

        $this->assertEquals($carboned_version, $timeslice->getStoppedAt());
        $this->assertEquals(
            $carboned_version->toDateTimeString(),
            $timeslice->getStoppedAtSerialized()
        );
    }

    public function testTags()
    {
        // timeslice has by default no tags
        $timeslice = new Timeslice();
        $this->assertEquals(0, count($timeslice->getTags()));

        // but we can add one
        $tag = new Tag();
        $timeslice->addTag($tag);
        $this->assertEquals(1, count($timeslice->getTags()));

        // and remove it
        $timeslice->removeTag($tag);
        $this->assertEquals(0, count($timeslice->getTags()));

        // and it's also possible to pass an Array
        $timeslice->setTags(new ArrayCollection([$tag]));
        $this->assertEquals(1, count($timeslice->getTags()));
    }

    public function testUpdateStartOnEmpty()
    {
        // it should insert a carbon value
        $timeslice = new Timeslice;
        $this->assertNull($timeslice->getStartedAt());

        $timeslice->updateStartOnEmpty();
        $this->assertInstanceOf(Carbon::class, $timeslice->getStartedAt());
    }

    public function testUpdateOnEmpty()
    {
        // it should insert a carbon value
        $timeslice = new Timeslice;
        $this->assertNull($timeslice->getStartedAt());

        $timeslice->updateOnEmpty();
        $this->assertInstanceOf(Carbon::class, $timeslice->getStartedAt());
    }

    public function testGetCurrentDuration()
    {
        // it should return diff to current time
        $timeslice = new Timeslice();
        $timeslice->setStartedAt('2018-07-02');
        $this->assertNotNull($timeslice->getCurrentDuration());

        // it should return its own value
        $timeslice->setValue(8567);
        $this->assertEquals(8567, $timeslice->getCurrentDuration());
    }

    public function testGetSetEmployee()
    {
        // get and set employee
        $timeslice = new Timeslice();
        $employee = new Employee();
        $this->assertNull($timeslice->getEmployee());
        $timeslice->setEmployee($employee);
        $this->assertEquals($employee, $timeslice->getEmployee());
    }
}
