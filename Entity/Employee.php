<?php
namespace Dime\EmployeeBundle\Entity;

use DeepCopy\DeepCopy;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;
use Dime\TimetrackerBundle\Annotation\DiscriminatorEntry;
use Dime\TimetrackerBundle\Entity\User;

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

	public function getSollWorkingDays()
	{
		$workingDays = 0;
		foreach($this->getWorkingPeriods() as $workingPeriod)
		{
			$workingDays += $workingPeriod->getPeriodInWeekDays();
		}
		foreach($this->getFreePeriods() as $freePeriod)
		{
			$workingDays -= $freePeriod->getPeriodInWeekDays();
		}
		return $workingDays;
	}

	public function getSollWorkingHours()
	{
		return $this->getSollWorkingDays() * 8.4;
	}

	public function getIstWorkingHours()
	{

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