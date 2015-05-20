<?php
namespace Dime\EmployeeBundle\Entity;

use Dime\TimetrackerBundle\Annotation\DiscriminatorEntry;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Entity\User;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Dime\EmployeeBundle\Entity\Employee
 *
 * @ORM\Table(name="Employees")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\EmployeeRepository")
 * @Json\Schema("Employees")
 * @DiscriminatorEntry(value="employee")
 */
class Employee extends User implements DimeEntityInterface
{

	/**
	 * @var ArrayCollection
	 * @ORM\OneToMany(targetEntity="Dime\EmployeeBundle\Entity\WorkingPeriod", mappedBy="employee")
	 * @JMS\SerializedName("workingPeriods")
	 */
	protected $workingPeriods;

	/**
	 * @var ArrayCollection
	 * @ORM\OneToMany(targetEntity="Dime\EmployeeBundle\Entity\FreePeriod", mappedBy="employee")
	 * @JMS\SerializedName("freePeriods")
	 */
	protected $freePeriods;

	/**
	 * @var integer
	 * @ORM\Column(type="integer")
	 * @JMS\SerializedName("realTime")
	 */
	protected $realTime;

	/**
	 * Returns targetTime in Seconds
	 * @return integer
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("targetTime")
	 */
	public function getTargetTime()
	{
		$targetTime = 0;
		foreach($this->getWorkingPeriods() as $period){
			$targetTime += $period->getTargetTime();
		}
		foreach($this->getFreePeriods() as $period){
			$targetTime -= $period->getTargetTime();
		}
		return $targetTime;
	}

	/**
	 * @param Timeslice $slice
	 *
	 * @return $this
	 */
	public function addRealTime(Timeslice $slice)
	{
		$this->setRealTime($this->getRealTime() + $slice->getValue());
		return $this;
	}

	/**
	 * @return integer
	 */
	public function getRealTime()
	{
		return $this->realTime;
	}

	/**
	 * @param integer $realTime
	 *
	 * @return $this
	 */
	public function setRealTime($realTime)
	{
		$this->realTime = $realTime;
		return $this;
	}

	public function __construct()
	{
		$this->workingPeriods = new ArrayCollection();
		$this->freePeriods = new ArrayCollection();
	}

	/**
	 * @return ArrayCollection
	 */
	public function getWorkingPeriods()
	{
		return $this->workingPeriods;
	}

	/**
	 * @param ArrayCollection $workingPeriods
	 *
	 * @return $this
	 */
	public function setWorkingPeriods($workingPeriods)
	{
		$this->workingPeriods = $workingPeriods;
		return $this;
	}

	/**
	 * @param Period $workingPeriod
	 *
	 * @return $this
	 */
	public function addWorkingPeriod(Period $workingPeriod)
	{
		$this->workingPeriods->add($workingPeriod);
		return $this;
	}

	/**
	 * @param Period $workingPeriod
	 *
	 * @return $this
	 */
	public function removeWorkingPeriod(Period $workingPeriod)
	{
		$this->workingPeriods->removeElement($workingPeriod);
		return $this;
	}

	/**
	 * @return ArrayCollection
	 */
	public function getFreePeriods()
	{
		return $this->freePeriods;
	}

	/**
	 * @param ArrayCollection $freePeriods
	 *
	 * @return $this
	 */
	public function setFreePeriods($freePeriods)
	{
		$this->freePeriods = $freePeriods;
		return $this;
	}


	/**
	 * @param Period $freePeriod
	 *
	 * @return $this
	 */
	public function addFreePeriod(Period $freePeriod)
	{
		$this->freePeriods->add($freePeriod);
		return $this;
	}

	/**
	 * @param Period $freePeriod
	 *
	 * @return $this
	 */
	public function removeFreePeriod(Period $freePeriod)
	{
		$this->freePeriods->removeElement($freePeriod);
		return $this;
	}

}