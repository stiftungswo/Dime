<?php
namespace Dime\EmployeeBundle\Entity;

use Dime\TimetrackerBundle\Annotation\DiscriminatorEntry;
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
 * @Json\Schema("employees")
 * @DiscriminatorEntry(value="employee")
 */
class Employee extends User implements DimeEntityInterface
{

	/**
	 * @var boolean
	 * @ORM\Column(name="extend_timetrack", type="boolean", nullable=false)
	 * @JMS\SerializedName("extendTimetrack")
	 */
	protected $extendTimetrack = true;

	/**
	 * @var ArrayCollection
	 * @ORM\OneToMany(targetEntity="Dime\EmployeeBundle\Entity\Period", mappedBy="employee")
	 * @JMS\SerializedName("workingPeriods")
	 */
	protected $workingPeriods;

	/**
	 * @var integer
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("realTime")
	 * @return int
	 */
	public function getRealTime()
	{
		$realTime = 0;
		foreach($this->getWorkingPeriods() as $period){
			$realTime += $period->getRealTime();
		}
		return $realTime;
	}

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
		return $targetTime;
	}

	public function __construct()
	{
		$this->workingPeriods = new ArrayCollection();
		$this->freePeriods = new ArrayCollection();
		parent::__construct();
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
	 * @return boolean
	 */
	public function getExtendTimetrack()
	{
		return $this->extendTimetrack;
	}

	/**
	 * @param boolean $extendTimetrack
	 *
	 * @return $this
	 */
	public function setExtendTimetrack($extendTimetrack)
	{
		$this->extendTimetrack = $extendTimetrack;
		return $this;
	}
}
