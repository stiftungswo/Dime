<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Carbon\Carbon;
use Dime\EmployeeBundle\Entity\Employee;
use Dime\EmployeeBundle\Entity\Period;
use PHPUnit\Framework\TestCase;

class PeriodTest extends TestCase
{
    const SECONDS_IN_HOURS = 60 * 60;
    const HOURS_IN_WORKDAYS = 8.4;
    const SECONDS_IN_WORKDAYS = self::HOURS_IN_WORKDAYS * self::SECONDS_IN_HOURS;

    public function testGetTargetTime()
    {
        $period = new Period();
        $period->setPensum(1.0);
        $period->setStart(Carbon::create(2018, 1, 1, 0)); // monday
        $period->setEnd(Carbon::create(2018, 12, 31, 0)); // monday

        $expected = 261 * self::SECONDS_IN_WORKDAYS;

        $period->setHolidays(0); // todo what is this?
        $this->assertSame($expected, $period->getTargetTime());
        $period->setHolidays(1000); // todo what is this?
        $this->assertSame($expected - 1000, $period->getTargetTime());
    }

    public function testGetTargetTimeEndsOnWeekend()
    {
        $period = new Period();
        $period->setPensum(1.0);
        $period->setStart(Carbon::create(2018, 1, 1, 0)); // monday
        $period->setEnd(Carbon::create(2018, 12, 30, 0)); // sunday
        $expected = 260 * self::SECONDS_IN_WORKDAYS;

        $period->setHolidays(0); // todo what is this?
        $this->assertSame($expected, $period->getTargetTime());
    }

    public function testGetEmployeeholiday()
    {
        $period = new Period();
        $period->setPensum(1.0);
        $period->setStart(Carbon::create(2018, 1, 1, 0));
        $period->setEnd(Carbon::create(2018, 12, 31, 0));

        $employee = new Employee();
        $employee->setEmployeeholiday(200000); // current employee holiday doesnt matter
        $period->setEmployee($employee);

        $period->setYearlyEmployeeVacationBudget(20);

        $expected = 20 * self::SECONDS_IN_WORKDAYS;

        $this->assertSame($expected, $period->getPeriodVacationBudget());

        $period->setYearlyEmployeeVacationBudget(21);

        $expected = 21 * self::SECONDS_IN_WORKDAYS;

        $this->assertSame($expected, $period->getPeriodVacationBudget());

        $period->setPensum(0.3);
        $this->assertSame($expected * 0.3, $period->getPeriodVacationBudget());
        $period->setPensum(1.0);

        $period->setLastYearHolidayBalance('2.0');
        $this->assertSame($expected + (2 * self::SECONDS_IN_HOURS), $period->getPeriodVacationBudget());
    }

    public function testGetEmployeeholidayPartOfYear()
    {
        $period = new Period();
        $period->setPensum(1.0);
        $period->setStart(Carbon::create(2018, 1, 1, 0));
        $period->setEnd(Carbon::create(2018, 3, 31, 0)); // so 90 days

        $period->setYearlyEmployeeVacationBudget(20);

        $expected = (20 / 365 * 90) * self::SECONDS_IN_WORKDAYS;

        $this->assertSame($expected, $period->getPeriodVacationBudget());
    }

    public function testGetEmployeeholidayAcrossYears()
    {
        $period = new Period();
        $period->setPensum(1.0);
        $period->setStart(Carbon::create(2017, 12, 1, 0));
        $period->setEnd(Carbon::create(2018, 1, 31, 0));

        $period->setYearlyEmployeeVacationBudget(20);

        $expected = (20 / 365 * 31) * self::SECONDS_IN_WORKDAYS; // for 2017 (not leap year)
        $expected += (20 / 365 * 31) * self::SECONDS_IN_WORKDAYS; // for 2018 (not leap year)

        $this->assertSame($expected, $period->getPeriodVacationBudget());
    }

    public function testGetEmployeeholidayLeapYear()
    {
        $period = new Period();
        $period->setPensum(1.0);
        $period->setStart(Carbon::create(2016, 1, 1, 0));
        $period->setEnd(Carbon::create(2016, 3, 31, 0)); // so 91 days

        $period->setYearlyEmployeeVacationBudget(20);

        $expected = (20 / 366 * 91) * self::SECONDS_IN_WORKDAYS;

        $this->assertSame($expected, $period->getPeriodVacationBudget());
    }

    public function testGetEmployeeholidayAcrossLeapYears()
    {
        $period = new Period();
        $period->setPensum(1.0);
        $period->setStart(Carbon::create(2015, 12, 1, 0));
        $period->setEnd(Carbon::create(2016, 3, 31, 0));


        $period->setYearlyEmployeeVacationBudget(20);

        $expected = (20 / 365 * 31) * self::SECONDS_IN_WORKDAYS; // for 2015 (not leap year)
        $expected += (20 / 366 * 91) * self::SECONDS_IN_WORKDAYS; // for 2016 (leap year)

        $this->assertSame($expected, $period->getPeriodVacationBudget());
    }

    public function testGetSetHolidayBalance()
    {
        // get and set chargeable
        $period = new Period();
        $this->assertEquals(0.0, $period->getHolidayBalance());
        $period->setHolidayBalance(16.7);
        $this->assertEquals(true, $period->getHolidayBalance());
    }
}
