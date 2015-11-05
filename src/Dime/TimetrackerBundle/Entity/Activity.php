<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\ActivityReference;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;


/**
 * Dime\TimetrackerBundle\Entity\Activity
 *
 *
 * @ORM\Table(name="activities")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\ActivityRepository")
 * @ORM\HasLifecycleCallbacks()
 * @Json\Schema("activities")
 */
class Activity extends Entity implements DimeEntityInterface
{
	/**
	 * @var Project $project
	 *
	 * @JMS\MaxDepth(1)
	 * @JMS\Groups({"List"})
	 * @ORM\ManyToOne(targetEntity="Project", inversedBy="activities")
	 * @ORM\JoinColumn(name="project_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
	 */
	protected $project;

	/**
	 * @var Service $service
	 *
	 * @JMS\MaxDepth(1)
	 * @ORM\ManyToOne(targetEntity="Service")
	 * @JMS\Groups({"List"})
	 * @ORM\JoinColumn(name="service_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
	 */
	protected $service;

	/**
	 * @var ArrayCollection $timeslices
	 *
	 * @JMS\Type("array")
	 * @JMS\Exclude()
	 * @JMS\SerializedName("timeslices")
	 * @ORM\OneToMany(targetEntity="Timeslice", mappedBy="activity", cascade="persist")
	 */
	protected $timeslices;

	/**
	 * @var ArrayCollection $tags
	 *
	 * @JMS\Type("array")
	 * @JMS\SerializedName("tags")
	 * @ORM\ManyToMany(targetEntity="Tag", cascade="all")
	 * @ORM\JoinTable(name="activity_tags")
	 */
	protected $tags;

	/**
	 * @var string $description
	 *
	 * @JMS\Groups({"List"})
	 * @ORM\Column(type="text", nullable=true)
	 */
	protected $description;

	/**
	 * @JMS\Groups({"List"})
	 * @ORM\Column(name="rate_value", type="money", nullable=true)
	 * @JMS\SerializedName("rateValue")
	 * @JMS\Type(name="Money")
	 */
	protected $rateValue;

	/**
	 * @var boolean $chargeable
	 *
	 * @ORM\Column(type="boolean", nullable=true)
	 * @JMS\Exclude()
	 */
	protected $chargeable;

	/**
	 * @var integer $chargeableReference (enum see Model\ActivityReference)
	 *
	 * @JMS\SerializedName("chargeableReference")
	 * @ORM\Column(name="cargeable_reference", type="smallint")
	 * @JMS\Exclude()
	 */
	protected $chargeableReference = 1;

	/**
	 * @ORM\Column(type="decimal", scale=3, precision=10, nullable=true)
	 */
	protected $vat;

	/**
	 * @JMS\Groups({"List"})
	 * @ORM\Column(name="rate_unit", type="text", nullable=true)
	 * @JMS\SerializedName("rateUnit")
	 */
	protected $rateUnit;

	/**
	 * @var RateUnitType $rateUnitType
	 *
	 * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateUnitType")
	 * @JMS\SerializedName("rateUnitType")
	 */
	protected $rateUnitType;

	/**
	 * @param bool $pure
	 *
	 * @return float
	 */
	public function getValue($pure = false)
	{
		$value = 0;

		foreach ($this->getTimeslices() as $timeslice) {
			$value += $timeslice->getValue();
		}
		if (!$pure) {
			if ($this->rateUnitType instanceof RateUnitType) {
				return $this->rateUnitType->transform($value);
			}
		}
		return $value;
	}

	/**
	 * Auto generate duration if empty
	 *
	 * @ORM\PrePersist
	 * @ORM\PreUpdate
	 * @return Activity
	 */
	public function updateEmptyRateFromDefault()
	{
		$serviceRate = $this->getServiceRate();
		if (is_null($serviceRate))
			return $this;
		if (is_null($this->rateValue))
			$this->rateValue = $serviceRate->getRateValue();
		if (is_null($this->rateUnit))
			$this->rateUnit = $serviceRate->getRateUnit();
		if (is_null($this->rateUnitType))
			$this->rateUnitType = $serviceRate->getRateUnitType();
		return $this;
	}

	/**
	 * return the Rate from the service according the offers rate group
	 * @JMS\VirtualProperty
	 * @JMS\MaxDepth(1)
	 * @JMS\SerializedName("serviceRate")
	 *
	 * @return Rate
	 */
	public function getServiceRate()
	{
		if (empty($this->service)) {
			return null;
		}
		return $this->service->getRateByRateGroup($this->project->getRateGroup());
	}


	/**
	 * Returns How mch the whole Activity Costs
	 * @return Money
	 * @JMS\VirtualProperty()
	 * @JMS\Type(name="Money")
	 * @JMS\SerializedName("charge")
	 */
	public function getCharge()
	{

		$total = $this->getRateValue();
		if ($total === null)
			return null;
		if ($this->getValue() !== null) {
			$total = $total->multiply($this->getValue());
		}
		$vat = $this->getCalculatedVAT();
		if ($vat instanceof Money) {
			$total = $total->add($vat);
		}
		return $total;
	}

	/**
	 * Returns the Name the Activity has.
	 * @return string
	 * @JMS\VirtualProperty()
	 * @JMS\Groups({"List"})
	 * @JMS\SerializedName("name")
	 */
	public function getName()
	{
		if ($this->getService() && $this->getProject()) {
			return $this->getId() . ' ' . $this->getProject()->getName() . ' - ' . $this->getService()->getName();
		} else {
			return '';
		}
	}

	/**
	 * Returns the Alias the Activity has.
	 * @return string
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("alias")
	 * @JMS\Groups("List")
	 */
	public function getAlias()
	{
		if ($this->getService()) {
			return $this->getService()->getAlias();
		} else {
			return '';
		}
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("value")
	 * @JMS\Groups({"List"})
	 * @return string
	 */
	public function serializeValue()
	{
		if ($this->rateUnitType instanceof RateUnitType) {
			return $this->rateUnitType->serializedOutput($this->getValue());
		}
		return $this->getValue();
	}

	/**
	 * @JMS\VirtualProperty
	 * @JMS\SerializedName("calculatedVAT")
	 * @JMS\Type(name="Money")
	 * @return Money
	 */
	public function getCalculatedVAT()
	{
		if ($this->rateValue instanceof Money && is_numeric($this->getValue()) && is_numeric($this->vat))
			return $this->rateValue->multiply((float)$this->getValue())->multiply((float)$this->vat);
		else
			return null;
	}

	/**
	 * Entity constructor
	 */
	public function __construct()
	{
		$this->timeslices = new ArrayCollection();
		$this->tags = new ArrayCollection();
	}

	/**
	 * Set description
	 *
	 * @param  string $description
	 * @return Activity
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
	 * Set rate
	 *
	 * @param  float $rateValue
	 * @return Activity
	 */
	public function setRateValue($rateValue)
	{
		$this->rateValue = $rateValue;
		return $this;
	}

	/**
	 * Get rate
	 *
	 * @return Money
	 */
	public function getRateValue()
	{
		if (empty($this->rateValue)) {
			if ($this->getService() instanceof Service) {
				$rate = $this->getServiceRate();
				return $rate->getRateValue();
			} else {
				return null;
			}
		} else {
			return $this->rateValue;
		}
	}

	/**
	 * Customer for Simplicity
	 * @JMS\VirtualProperty
	 * @JMS\SerializedName("customer")
	 */
	public function getCustomer()
	{
		return $this->getProject()->getCustomer();
	}

	/**
	 * Set project
	 *
	 * @param  Project $project
	 * @return Activity
	 */
	public function setProject($project)
	{
		$this->project = $project;
		return $this;
	}

	/**
	 * Get project
	 *
	 * @return Project
	 */
	public function getProject()
	{
		return $this->project;
	}

	/**
	 * Set service
	 *
	 * @param  Service $service
	 * @return Activity
	 */
	public function setService($service)
	{
		$this->service = $service;
		$rate = $this->getServiceRate();
		if (!is_null($rate)) {
			$this->setRateUnitType($rate->getRateUnitType());
			$this->setRateUnit($rate->getRateUnit());
			$this->setRateValue($rate->getRateValue());
			$this->setVat($service->getVat());
		}
		return $this;
	}

	/**
	 * Get service
	 *
	 * @return Service
	 */
	public function getService()
	{
		return $this->service;
	}

	/**
	 * Add time slice
	 *
	 * @param  Timeslice $timeslice
	 * @return Activity
	 */
	public function addTimeslice(Timeslice $timeslice)
	{
		$this->timeslices[] = $timeslice;

		return $this;
	}

	/**
	 * Get time slices
	 *
	 * @return \Doctrine\Common\Collections\Collection
	 */
	public function getTimeslices()
	{
		return $this->timeslices;
	}

	/**
	 * Add tag
	 *
	 * @param  Tag $tag
	 * @return Activity
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
	 *
	 * @return Activity
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
	 * @return Activity
	 */
	public function setTags(ArrayCollection $tags)
	{
		$this->tags = $tags;

		return $this;
	}

	/**
	 * @return boolean
	 */
	public function isChargeable()
	{
		return $this->chargeable;
	}

	/**
	 * @return bool
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("chargeable")
	 */
	public function serializeChargeable()
	{
		switch ($this->getChargeableReference()) {
			case ActivityReference::$ACTIVITY:
				return $this->chargeable;
				break;
			case ActivityReference::$PROJECT:
				if ($this->getProject())
					return $this->getProject()->isChargeable();
				else
					return $this->chargeable;
				break;
			case ActivityReference::$CUSTOMER:
				if ($this->getCustomer())
					return $this->getCustomer()->isChargeable();
				else
					return $this->chargeable;
				break;
			case ActivityReference::$SERVICE:
				if ($this->getService())
					return $this->getService()->isChargeable();
				else
					return $this->chargeable;
				break;
			default:
				return $this->chargeable;
				break;
		}
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
	 * @return int
	 */
	public function getChargeableReference()
	{
		return $this->chargeableReference;
	}

	/**
	 * @param int $chargeableReference
	 *
	 * @return $this
	 */
	public function setChargeableReference($chargeableReference)
	{
		$this->chargeableReference = $chargeableReference;
		return $this;
	}

	/**
	 * Set rateUnit
	 *
	 * @param string $rateUnit
	 *
	 * @return Activity
	 */
	public function setRateUnit($rateUnit)
	{
		$this->rateUnit = $rateUnit;

		return $this;
	}

	/**
	 * Get rateUnit
	 *
	 * @return string
	 */
	public function getRateUnit()
	{
		return $this->rateUnit;
	}

	/**
	 * Set rate
	 *
	 * @param RateUnitType $rateUnitType
	 *
	 * @return Activity
	 */
	public function setRateUnitType($rateUnitType)
	{
		$this->rateUnitType = $rateUnitType;

		return $this;
	}

	/**
	 * Get rateUnitType
	 *
	 * @return RateUnitType
	 */
	public function getRateUnitType()
	{
		return $this->rateUnitType;
	}

	/**
	 * @return mixed
	 */
	public function getVat()
	{
		return $this->vat;
	}

	/**
	 * @param mixed $vat
	 *
	 * @return $this
	 */
	public function setVat($vat)
	{
		$this->vat = $vat;
		return $this;
	}


}
