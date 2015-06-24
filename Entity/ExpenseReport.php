<?php
/**
 * Author: Till Wegmüller
 * Date: 6/24/15
 * Dime
 */

namespace Dime\ReportBundle\Entity;


use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Model\RateUnitType;
use Doctrine\Common\Collections\ArrayCollection;
use JMS\Serializer\Annotation as JMS;

class ExpenseReport extends Report {

	public function __construct()
	{
		$this->timeslices = new ArrayCollection();
	}

	/**
	 * @var ArrayCollection
	 */
	protected $timeslices;

	/**
	 * @return mixed
	 */
	public function getTimeslices()
	{
		return $this->timeslices;
	}

	/**
	 * @param mixed $timeslices
	 *
	 * @return $this
	 */
	public function setTimeslices($timeslices)
	{
		$this->timeslices = $timeslices;
		return $this;
	}

	/**
	 * @param Timeslice $timeslice
	 *
	 * @return $this
	 */
	public function addTimeslices(Timeslice $timeslice)
	{
		$this->timeslices->add($timeslice);
		return $this;
	}

	/**
	 * @param Timeslice $timeslice
	 *
	 * @return $this
	 */
	public function removeTimeslices(Timeslice $timeslice)
	{
		$this->timeslices->removeElement($timeslice);
		return $this;
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("totalHours")
	 */
	public function getSumHours()
	{
		$total = 0;
		foreach($this->timeslices as $timeslice){
			if($timeslice->getActivity()->getRateUnitType() !== RateUnitType::$NoChange){
				$total += $timeslice->getValue();
			}
		}
		if($total !== 0){
			$total = ($total / RateUnitType::$HourInSeconds).'h';
		}
		return $total;
	}
}