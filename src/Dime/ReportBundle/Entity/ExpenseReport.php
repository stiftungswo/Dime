<?php
/**
 * Author: Till Wegmüller
 * Date: 6/24/15
 * Dime
 */

namespace Dime\ReportBundle\Entity;


use Dime\EmployeeBundle\Entity\Employee;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Timeslice;
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
	 * @var mixed
	 */
	protected $employee;

	/**
	 * @return mixed
	 */
	public function getEmployee()
	{
		return $this->employee;
	}

	/**
	 * @param mixed $employee
	 */
	public function setEmployee($employee)
	{
		$this->employee = $employee;
	}

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
			if(!is_null($timeslice->getActivity()) && !is_null($timeslice->getActivity()->getRateUnitType()) && $timeslice->getActivity()->getRateUnitType()->getId() !== RateUnitType::$NoChange){
				$total += $timeslice->getValue();
			}
		}
		if($total !== 0){
			$total = round(($total / 3600), 2).'h';
		}
		return $total;
	}
}