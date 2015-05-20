<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;


use Carbon\Carbon;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use JMS\Serializer\Annotation as JMS;

abstract class Period extends Entity implements DimeEntityInterface
{
	protected $start;
	protected $end;
	protected $pensum;
	protected $employee;

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("targetTime")
	 */
	public function getTargetTime()
	{
		if($this->pensum && $this->getStart() instanceof Carbon && $this->getEnd() instanceof Carbon) {
			return $this->getStart()->diffInSeconds($this->getEnd()) * $this->getPensum();
		}
		return null;
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