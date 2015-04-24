<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;


use DeepCopy\DeepCopy;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Carbon\Carbon;
use Dime\TimetrackerBundle\Model\RateUnitType;

abstract class Period extends Entity implements DimeEntityInterface
{
	protected $start;
	protected $end;
	protected $pensum;
	protected $employee;

	public function getPeriodInWeekDays()
	{
		return $this->getStart()->diffInWeekdays($this->getEnd()) * $this->getPensum();
	}

	static function getCopyFilters(DeepCopy $deepCopy)
	{
		// TODO: Implement getCopyFilters() method.
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
		if($this->start instanceof Carbon) {
			return $this->start;
		} else {
			return Carbon::instance($this->start);
		}
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
		if($this->end instanceof Carbon) {
			return $this->end;
		} else {
			return Carbon::instance($this->end);
		}
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


}