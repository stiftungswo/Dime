<?php
namespace Dime\TimetrackerBundle\Entity;

use DateTime;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Dime\TimetrackerBundle\Entity\Project
 *
 * @ORM\Table(name="projects")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\ProjectRepository")
 * @Json\Schema("projects")
 */
class Project extends Entity implements DimeEntityInterface
{
	/**
	 * @var Customer $customer
	 *
	 * @ORM\ManyToOne(targetEntity="Customer")
	 * @ORM\JoinColumn(name="customer_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
	 */
	protected $customer;

	/**
	 * @var string $name
	 *
	 * @Assert\NotBlank()
	 * @ORM\Column(type="string", length=255)
	 */
	protected $name;

	/**
	 * @var string $alias
	 *
	 * @Gedmo\Slug(fields={"name"})
	 * @ORM\Column(type="string", length=30)
	 */
	protected $alias;

	/**
	 * @var DateTime $startedAt
	 *
	 * @Assert\Date()
	 * @JMS\SerializedName("startedAt")
	 * @ORM\Column(name="started_at", type="datetime", nullable=true)
	 */
	protected $startedAt;

	/**
	 * @var DateTime $stoppedAt
	 *
	 * @Assert\Date()
	 * @JMS\SerializedName("stoppedAt")
	 * @ORM\Column(name="stopped_at", type="datetime", nullable=true)
	 */
	protected $stoppedAt;

	/**
	 * @var DateTime $deadline
	 *
	 * @Assert\Date()
	 * @ORM\Column(name="deadline", type="datetime", nullable=true)
	 */
	protected $deadline;

	/**
	 * @var string $description
	 *
	 * @ORM\Column(type="text", nullable=true)
	 */
	protected $description;

	/**
	 * @var Money $budgetPrice
	 *
	 * @JMS\Exclude()
	 * @ORM\Column(name="budget_price", type="money", nullable=true)
	 */
	protected $budgetPrice;

	/**
	 * @var Money $fixedPrice
	 *
	 * @JMS\SerializedName("fixedPrice")
	 * @JMS\Type(name="Money")
	 * @ORM\Column(name="fixed_price", type="money", length=255, nullable=true)
	 */
	protected $fixedPrice;

	/**
	 * @var integer $budgetTime
	 *
	 * @JMS\Exclude()
	 * @ORM\Column(name="budget_time", type="integer", length=255, nullable=true)
	 */
	protected $budgetTime;

	/**
	 * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
	 * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
	 * @JMS\SerializedName("rateGroup")
	 */
	protected $rateGroup;

	/**
	 * @var ArrayCollection $tags
	 *
	 * @JMS\Type("array")
	 * @JMS\SerializedName("tags")
	 * @ORM\ManyToMany(targetEntity="Tag", cascade="all")
	 * @ORM\JoinTable(name="project_tags")
	 */
	protected $tags;

	/**
	 * @var boolean $chargeable
	 *
	 *
	 * @ORM\Column(type="boolean", nullable=true)
	 */
	protected $chargeable;

	/**
	 * @var ArrayCollection $activities
	 * @JMS\MaxDepth(2)
	 * @JMS\Type("array")
	 * @JMS\SerializedName("activities")
	 * @ORM\OneToMany(targetEntity="Dime\TimetrackerBundle\Entity\Activity", mappedBy="project", cascade={"all"})
	 */
	protected $activities;

	/**
	 * @return Money current Price
	 */
	public function calculateCurrentPrice()
	{
		$price = Money::CHF(0);
		foreach ($this->activities as $activity) {
			$price = $price->add($activity->getCharge());
		}
		return $price;
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("currentPrice")
	 */
	public function getCurrentPrice()
	{
		return $this->calculateCurrentPrice()->format(true);
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("remainingBudgetPrice")
	 *
	 */
	public function getRemainingBudgetPrice()
	{
		if($this->budgetPrice != null) {
			return $this->budgetPrice->subtract($this->calculateCurrentPrice())->format(true);
		} else {
			return null;
		}
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("currentTime")
	 */
	public function getCurrentTime()
	{
		$duration = 0;
		foreach ($this->activities as $activity) {
			if ($activity->getRateUnitType() != null && $activity->getRateUnitType()->getSymbol() !== RateUnitType::$NoChange) {
				$duration += RateUnitType::transformBetweenTimeUnits($activity->getValue(true), RateUnitType::$Secondly, RateUnitType::$Hourly, false);
			}
		}
		return number_format($duration, 2). ' ' . RateUnitType::$Hourly;
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("remainingBudgetTime")
	 *
	 */
	public function getRemainingBudgetTime()
	{
		if($this->budgetTime != null) {
			$currentBudget = $this->budgetTime - $this->getCurrentTime();
			return number_format($currentBudget, 2) . ' ' . RateUnitType::$Hourly;
		} else {
			return null;
		}
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("budgetTime")
	 */
	public function serializeBudgetTime()
	{
		if($this->budgetTime != null) {
			return number_format($this->budgetTime, 2) . ' ' . RateUnitType::$Hourly;
		} else {
			return null;
		}
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("budgetPrice")
	 */
	public function serializeBudgetPrice()
	{
		if($this->budgetPrice != null) {
			return $this->budgetPrice->format(true);
		} else {
			return null;
		}
	}

	/**
	 * @return boolean
	 */
	public function isChargeable()
	{
		return $this->chargeable;
	}

	/**
	 * @param boolean $chargeable
	 *
	 * @return $this
	 */
	public function setChargeable($chargeable)
	{
		if ($chargeable !== 'empty') {
			$this->chargeable = $chargeable;
		}
		return $this;
	}

	/**
	 * Entity constructor
	 */
	public function __construct()
	{
		$this->tags = new ArrayCollection();
		$this->activities = new ArrayCollection();
	}

	/**
	 * Set customer
	 *
	 * @param  Customer $customer
	 * @return Project
	 */
	public function setCustomer(Customer $customer)
	{
		$this->customer = $customer;

		return $this;
	}

	/**
	 * Get customer
	 *
	 * @return Customer
	 */
	public function getCustomer()
	{
		return $this->customer;
	}

	/**
	 * Set name
	 *
	 * @param  string $name
	 * @return Project
	 */
	public function setName($name)
	{
		$this->name = $name;

		return $this;
	}

	/**
	 * Get name
	 *
	 * @return string
	 */
	public function getName()
	{
		return $this->name;
	}

	/**
	 * Set alias
	 *
	 * @param  string $alias
	 * @return Project
	 */
	public function setAlias($alias)
	{
		$this->alias = $alias;

		return $this;
	}

	/**
	 * Get alias
	 *
	 * @return string
	 */
	public function getAlias()
	{
		return $this->alias;
	}

	/**
	 * Set startedAt
	 *
	 * @param  DateTime $startedAt
	 * @return Project
	 */
	public function setStartedAt($startedAt)
	{
		$this->startedAt = $startedAt;

		return $this;
	}

	/**
	 * Get startedAt
	 *
	 * @return datetime
	 */
	public function getStartedAt()
	{
		return $this->startedAt;
	}

	/**
	 * Set stoppedAt
	 *
	 * @param  datetime $stoppedAt
	 * @return Project
	 */
	public function setStoppedAt($stoppedAt)
	{
		$this->stoppedAt = $stoppedAt;

		return $this;
	}

	/**
	 * Get stoppedAt
	 *
	 * @return datetime
	 */
	public function getStoppedAt()
	{
		return $this->stoppedAt;
	}

	/**
	 * Set deadline
	 *
	 * @param  datetime $deadline
	 * @return Project
	 */
	public function setDeadline($deadline)
	{
		$this->deadline = $deadline;

		return $this;
	}

	/**
	 * Get deadline
	 *
	 * @return datetime
	 */
	public function getDeadline()
	{
		return $this->deadline;
	}

	/**
	 * Set description
	 *
	 * @param  string $description
	 * @return Project
	 */
	public function setDescription($description)
	{
		$this->description = $description;

		return $this;
	}

	/**
	 * Get description
	 *
	 * @return string
	 */
	public function getDescription()
	{
		return $this->description;
	}

	/**
	 * Set budgetPrice
	 *
	 * @param Money $budgetPrice
	 * @return Project
	 */
	public function setBudgetPrice($budgetPrice)
	{
		$this->budgetPrice = $budgetPrice;
		return $this;
	}

	/**
	 * Get budgetPrice
	 *
	 * @return Money
	 */
	public function getBudgetPrice()
	{
		return $this->budgetPrice;
	}

	/**
	 * Set fixedPrice
	 *
	 * @param  Money $fixedPrice
	 * @return Project
	 */
	public function setFixedPrice($fixedPrice)
	{
		$this->fixedPrice = $fixedPrice;
		return $this;
	}

	/**
	 * Get fixedPrice
	 *
	 * @return Money
	 */
	public function getFixedPrice()
	{
		return $this->fixedPrice;
	}

	/**
	 * Set budgetTime
	 *
	 * @param  integer $budgetTime
	 * @return Project
	 */
	public function setBudgetTime($budgetTime)
	{
		$rateunit = new RateUnitType();
		$this->budgetTime = $rateunit->reverseTransform($budgetTime);

		return $this;
	}

	/**
	 * Get budgetTime
	 *
	 * @return int
	 */
	public function getBudgetTime()
	{
		return $this->budgetTime;
	}

	/**
	 * get project as string
	 *
	 * @return string
	 */
	public function __toString()
	{
		return (empty($this->name)) ? $this->getId() : $this->getName();
	}

	/**
	 * Add tag
	 *
	 * @param  Tag $tag
	 * @return Project
	 */
	public function addTag(Tag $tag)
	{
		$this->tags[] = $tag;

		return $this;
	}

	/**
	 * Remove tags
	 *
	 * @param Tag $tag
	 * @return Project
	 */
	public function removeTag(Tag $tag)
	{
		$this->tags->removeElement($tag);

		return $this;
	}

	/**
	 * Get tags
	 *
	 * @return \Doctrine\Common\Collections\Collection
	 */
	public function getTags()
	{
		return $this->tags;
	}

	/**
	 * Set tags
	 *
	 * @param \Doctrine\Common\Collections\ArrayCollection $tags
	 * @return Project
	 */
	public function setTags(ArrayCollection $tags)
	{
		$this->tags = $tags;

		return $this;
	}

	/**
	 * Set rateGroup
	 *
	 * @param string $rateGroup
	 *
	 * @return Project
	 */
	public function setRateGroup($rateGroup)
	{
		$this->rateGroup = $rateGroup;

		// TODO: update rate value on activities

		return $this;
	}

	/**
	 * Get rateGroup
	 *
	 * @return string
	 */
	public function getRateGroup()
	{
		$rateGroup = $this->rateGroup;
		if ($rateGroup === null) {
			if ($this->getCustomer() == null) {
				return null;
			}
			return $this->getCustomer()->getRateGroup();
		}
		return $rateGroup;
	}

	/**
	 * Set createdAt
	 *
	 * @param \DateTime $createdAt
	 *
	 * @return Project
	 */
	public function setCreatedAt($createdAt)
	{
		$this->createdAt = $createdAt;

		return $this;
	}

	/**
	 * Set updatedAt
	 *
	 * @param \DateTime $updatedAt
	 *
	 * @return Project
	 */
	public function setUpdatedAt($updatedAt)
	{
		$this->updatedAt = $updatedAt;

		return $this;
	}

	/**
	 * @return ArrayCollection
	 */
	public function getActivities()
	{
		return $this->activities;
	}

	/**
	 * @param ArrayCollection $activities
	 *
	 * @return $this
	 */
	public function setActivities($activities)
	{
		$this->activities = $activities;
		return $this;
	}

	/**
	 * @param Activity $activity
	 *
	 * @return $this
	 */
	public function addActivity(Activity $activity)
	{
		$this->activities[] = $activity;
		return $this;
	}

	public function removeActivity(Activity $activity)
	{
		$this->activities->removeElement($activity);
		return $this;
	}
}
