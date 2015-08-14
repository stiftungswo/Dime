<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;


use Carbon\Carbon;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class WorkingPeriod
 * @package Dime\EmployeeBundle\Entity
 * @ORM\Table(name="WorkingPeriods")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\PeriodRepository")
 */
class Period extends Entity implements DimeEntityInterface
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
	 * Holidays in Seconds that are in this Period
	 * @ORM\Column(type="integer", nullable=true)
	 */
	protected $holidays;

	/**
	 * @var int
	 * RealTime in Seconds
	 * @ORM\Column(type="integer", nullable=true)
	 * @JMS\SerializedName("realTime")
	 */
	protected $realTime;

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("targetTime")
	 */
	public function getTargetTime()
	{
		if($this->pensum && $this->getStart() instanceof Carbon && $this->getEnd() instanceof Carbon) {
			$weekdays = $this->getStart()->diffInWeekdays($this->getEnd()->addDay());
			$seconds = $weekdays * 60 * 60 * 8.4;
			$seconds -= $this->holidays;
			return $seconds * $this->getPensum();
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
		foreach($holidays as $holiday){
			if($holiday instanceof Holiday){
				if($holiday->getDate()->between($this->getStart(), $this->getEnd())) {
					if($method == 'DELETE'){
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
		foreach($timeslices as $slice){
			if($slice instanceof Timeslice) {
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
		if(is_null($this->start)){
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
		if(is_null($this->end)){
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


}