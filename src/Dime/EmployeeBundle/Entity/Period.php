<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;

use Carbon\Carbon;
use Swo\CommonsBundle\Entity\AbstractEntity;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;

/**
 * Class WorkingPeriod
 * @package Dime\EmployeeBundle\Entity
 * @ORM\Table(name="WorkingPeriods")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\PeriodRepository")
 */
class Period extends AbstractEntity implements DimeEntityInterface
{
    /**
     * @var Carbon
     * @ORM\Column(type="date", nullable=true)
     */
    protected $start;

    /**
     * @var Carbon
     * @ORM\Column(type="date", nullable=true)
     */
    protected $end;

    /**
     * @var float
     * @ORM\Column(type="decimal", nullable=true, precision=10, scale=2)
     */
    protected $pensum;

    /**
     * @var Employee
     * @JMS\Exclude()
     * @ORM\ManyToOne(targetEntity="Dime\EmployeeBundle\Entity\Employee", inversedBy="workingPeriods")
     */
    protected $employee;

    /**
     * @var int
     * Holidays (Feiertage, see Holiday Entity) in Seconds that are in this Period
     * @ORM\Column(type="integer", nullable=true)
     */
    protected $holidays;

    /**
     * @var int
     * Holidays in Seconds that are available to the employee
     * (according to his employeeholiday at the time of creation of this period (or edited later))
     * @JMS\SerializedName("yearlyEmployeeVacationBudget")
     * @ORM\Column(name="yearly_employee_vacation_budget", type="integer", nullable=false)
     */
    protected $yearlyEmployeeVacationBudget;

    /**
     * @var float
     * Holidaybalance from last year
     * @JMS\SerializedName("lastYearHolidayBalance")
     * @ORM\Column(name="last_year_holiday_balance", type="string", nullable=true)
     */
    protected $lastYearHolidayBalance;

    /**
     * @var int
     * RealTime in Seconds
     * @ORM\Column(type="integer", nullable=true)
     * @JMS\SerializedName("realTime")
     */
    protected $realTime;

    /**
     * @var int
     * @JMS\SerializedName("timeTillToday")
     */
    protected $timeTillToday = 0;

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("targetTime")
     */
    public function getTargetTime()
    {
        if ($this->pensum && $this->getStart() instanceof Carbon && $this->getEnd() instanceof Carbon) {
            $weekdays = $this->getStart()->diffInWeekdays($this->getEnd()->addDay());
            $seconds = $weekdays * RateUnitType::$DayInSeconds;
            $seconds -= $this->holidays;
            return $seconds * $this->getPensum();
        }
        return null;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("periodVacationBudget")
     */
    public function getPeriodVacationBudget()
    {
        if ($this->pensum && $this->getStart() instanceof Carbon && $this->yearlyEmployeeVacationBudget != null) {
            $pensum = ($this->getPensum());
            $holidayEntitlement = $this->yearlyEmployeeVacationBudget;


            $startYear = $this->getStart()->year;
            $endYear = $this->getEnd()->year;

            $holidayDays = 0;

            for ($i = $startYear; $i <= $endYear; $i++) {
                $start = Carbon::create($i)->startOfYear();
                $end = Carbon::create($i)->endOfYear()->startOfDay();
                $daysOfYear = $start->diffInDays($end) + 1; // diff excludes day of second param

                if ($this->getStart() > $start) {
                    $start = $this->getStart();
                }

                if ($this->getEnd() < $end) {
                    $end = $this->getEnd();
                }

                $daysInYearPeriod = $start->diffInDays($end) + 1; // diff excludes day of second param

                $holidayDays += ($holidayEntitlement / $daysOfYear) * $daysInYearPeriod;
            }
            $holidaySeconds = $holidayDays * $pensum * RateUnitType::$DayInSeconds;

            //add holiday balance from last year
            $holidaySeconds += floatval($this->getLastYearHolidayBalance()) * RateUnitType::$HourInSeconds;

            return $holidaySeconds;
        }

        return null;
    }

    public function insertHolidays(array $holidays)
    {
        return $this->handleHolidaysChange($holidays, 'ADD');
    }

    public function removeHolidays(array $holidays)
    {
        return $this->handleHolidaysChange($holidays, 'DELETE');
    }

    private function handleHolidaysChange(array $holidays, $method)
    {
        foreach ($holidays as $holiday) {
            if ($holiday instanceof Holiday && $holiday->getDate() != null) {
                if ($holiday->getDate()->between($this->getStart(), $this->getEnd())) {
                    if ($method == 'DELETE') {
                        $this->holidays -= $holiday->getDuration();
                    } else {
                        $this->holidays += $holiday->getDuration();
                    }
                }
            }
        }
        return $this;
    }

    public function insertRealTime(array $timeslices)
    {
        foreach ($timeslices as $slice) {
            if ($slice instanceof Timeslice) {
                $this->realTime += $slice->getValue();
            }
        }
        return $this;
    }

    /**
     * @return float
     */
    public function getPensum()
    {
        return $this->pensum;
    }

    /**
     * @param float $pensum
     *
     * @return $this
     */
    public function setPensum($pensum)
    {
        $this->pensum = $pensum;
        return $this;
    }

    /**
     * @return Carbon
     */
    public function getStart()
    {
        if (is_null($this->start)) {
            return null;
        }
        return Carbon::instance($this->start);
    }

    /**
     * @param Carbon $start
     *
     * @return $this
     */
    public function setStart($start)
    {
        $this->start = $start;
        return $this;
    }

    /**
     * @return Carbon
     */
    public function getEnd()
    {
        if (is_null($this->end)) {
            return null;
        }
        return Carbon::instance($this->end);
    }

    /**
     * @param Carbon $end
     *
     * @return $this
     */
    public function setEnd($end)
    {
        $this->end = $end;
        return $this;
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("employee")
     *
     * @return array
     */
    public function getEmployeeId()
    {
        return array('id' => $this->getEmployee()->getId());
    }

    /**
     * @return Employee
     */
    public function getEmployee()
    {
        return $this->employee;
    }

    /**
     * @param Employee $employee
     *
     * @return $this
     */
    public function setEmployee($employee)
    {
        $this->employee = $employee;
        return $this;
    }

    /**
     * @return int
     */
    public function getHolidays()
    {
        return $this->holidays;
    }

    /**
     * @param int $holidays
     *
     * @return $this
     */
    public function setHolidays($holidays)
    {
        $this->holidays = $holidays;
        return $this;
    }

    /**
     * @return int
     */
    public function getYearlyEmployeeVacationBudget()
    {
        return $this->yearlyEmployeeVacationBudget;
    }

    /**
     * @param int $yearlyEmployeeVacationBudget
     *
     * @return Period
     */
    public function setYearlyEmployeeVacationBudget($yearlyEmployeeVacationBudget)
    {
        $this->yearlyEmployeeVacationBudget = $yearlyEmployeeVacationBudget;

        return $this;
    }

    /**
     * @return string
     */
    public function getLastYearHolidayBalance()
    {
        return $this->lastYearHolidayBalance;
    }

    /**
     * @param string $lastYearHolidayBalance
     *
     * @return $this
     */
    public function setLastYearHolidayBalance($lastYearHolidayBalance)
    {
        $this->lastYearHolidayBalance = $lastYearHolidayBalance;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getRealTime()
    {
        return $this->realTime;
    }

    /**
     * @param mixed $realTime
     *
     * @return $this
     */
    public function setRealTime($realTime)
    {
        $this->realTime = $realTime;
        return $this;
    }

    /**
     * @return int
     */
    public function getTimeTillToday()
    {
        return $this->timeTillToday;
    }

    /**
     * @param int $timeTillToday
     *
     * @return $this
     */
    public function setTimeTillToday($timeTillToday)
    {
        $this->timeTillToday = $timeTillToday;
        return $this;
    }
}
