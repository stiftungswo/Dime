<?php
namespace Dime\TimetrackerBundle\Entity;

use DeepCopy\DeepCopy;
use DeepCopy\Filter\Doctrine\DoctrineCollectionFilter;
use DeepCopy\Filter\KeepFilter;
use DeepCopy\Matcher\PropertyMatcher;
use Dime\TimetrackerBundle\Model\ActivityReference;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Model\RateUnitType;
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
     * @ORM\ManyToOne(targetEntity="Project", inversedBy="activities")
     * @ORM\JoinColumn(name="project_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $project;

    /**
     * @var Service $service
     *
     * @ORM\ManyToOne(targetEntity="Service")
     * @ORM\JoinColumn(name="service_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $service;

    /**
     * @var ArrayCollection $timeslicesø
     *
     * @JMS\Type("array")
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
     * @ORM\Column(type="text", nullable=true)
     */
    protected $description;

    /**
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
	 * @ORM\Column(type="decimal", scale=2, precision=10, nullable=true)
	 */
	protected $vat;

	/**
     * @ORM\Column(name="rate_unit", type="text", nullable=true)
     * @JMS\SerializedName("rateUnit")
     */
    protected $rateUnit;

    /**
     * @var string $rateUnitType
     *
     * @ORM\Column(name="rate_unit_type", type="text", nullable=true)
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

		foreach($this->getTimeslices() as $timeslice)
		{
			$value += $timeslice->getValue();
		}
		if(!$pure) {
			switch($this->getRateUnitType()) {
			case RateUnitType::$Hourly:
				return round(($value / RateUnitType::$HourInSeconds), 2);
				break;
			case RateUnitType::$Minutely:
				return round(($value / RateUnitType::$MinuteInSeconds), 2);
				break;
			case RateUnitType::$Dayly:
				return round(($value / RateUnitType::$DayInSeconds), 2);
				break;
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
        if($serviceRate === null)
            return $this;
        if($this->rateValue == null)
            $this->rateValue = $serviceRate->getRateValue();
        if($this->rateUnit == null)
            $this->rateUnit = $serviceRate->getRateUnit();
        if($this->rateUnitType == null)
            $this->rateUnitType = $serviceRate->getRateUnitType();
        return $this;
    }

    /**
     * return the Rate from the service according the offers rate group
     * @JMS\VirtualProperty
     * @JMS\SerializedName("serviceRate")
     *
     * @return Rate
     */
    public function getServiceRate()
    {
        if(empty($this->service))
            return null;
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
		if($this->getRateValue() instanceof Money) {
			return $this->getRateValue()->multiply($this->getValue());
		}
		return Money::CHF(0.00);
	}

	/**
	 * Returns the Name the Activty has.
	 * @return string
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("name")
	 */
	public function getName()
	{
        if($this->getService()) {
            return $this->getService()->getName();
        } else {
            return '';
        }
	}

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("value")
	 * @return string
	 */
	public function serializeValue()
	{
		$value = $this->getValue();
		switch ($this->getRateUnitType()){
		case RateUnitType::$Hourly:
			return $value.'h';
			break;
		case RateUnitType::$Minutely:
			return $value.'m';
			break;
		case RateUnitType::$Dayly:
			return $value.'d';
			break;
		}
		return $value;
	}

	/**
	 * @JMS\VirtualProperty
	 * @JMS\SerializedName("calculatedVAT")
	 * @JMS\Type(name="Money")
	 * @return Money
	 */
	public function getCalculatedVAT()
	{
		if($this->rateValue instanceof Money && is_numeric($this->getValue()) && is_numeric($this->vat))
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

    public static function getCopyFilters(DeepCopy $deepCopy, $keepProject = true)
    {
	    $deepCopy = parent::getCopyFilters($deepCopy);
	    $deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'tags'));
	    if($keepProject) {
		    $deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'project'));
        }
        $deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'service'));
        $deepCopy->addFilter(new DoctrineCollectionFilter(), new PropertyMatcher(self::class, 'timeslices'));
        $deepCopy = Timeslice::getCopyFilters($deepCopy, false);
        return $deepCopy;
    }

    /**
     * Set description
     *
     * @param  string   $description
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
     * @param  float    $rateValue
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
	    if( empty($this->rateValue) ){
		    if($this->getService() instanceof Service){
			    $rate =  $this->getService()->getRateByRateGroup($this->getProject()->getRateGroup());
			    return $rate->getRateValue();
		    } else {
			    return null;
		    }
	    }
	    else {
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
     * @param  Project  $project
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
     * @param  Service  $service
     * @return Activity
     */
    public function setService($service)
    {
        $this->service = $service;
	    $rate = $this->getServiceRate();
	    $this->setRateUnitType($rate->getRateUnitType());
	    $this->setRateUnit($rate->getRateUnit());
	    $this->setRateValue($rate->getRateValue());

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
     * @param  Tag      $tag
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
		switch($this->getChargeableReference())
		{
		case ActivityReference::$ACTIVITY:
			return $this->chargeable;
			break;
		case ActivityReference::$PROJECT:
			if($this->getProject())
				return $this->getProject()->isChargeable();
			else
				return $this->chargeable;
			break;
		case ActivityReference::$CUSTOMER:
			if($this->getCustomer())
				return $this->getCustomer()->isChargeable();
			else
				return $this->chargeable;
			break;
		case ActivityReference::$SERVICE:
			if($this->getService())
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
        if($chargeable !== 'empty')
        {
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
     * @param string $rateUnitType
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
     * @return string
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
