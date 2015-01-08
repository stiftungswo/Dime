<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\ActivityReference;
use Dime\TimetrackerBundle\Model\RateUnitType;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;


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
     * TODO refactoring rename to rateValue to be coherent with offerposition
     * @var float $rate
     * @JMS\AccessType("public_method")
     * @ORM\Column(type="decimal", scale=2, precision=10, nullable=true)
     */
    private $rate;
     
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
	 * @var integer $value
	 *
	 * @ORM\Column(type="decimal", scale=2, precision=10, nullable=true)
	 * @JMS\Exclude()
	 */
	protected $value;

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
	 * @return float
	 */
	public function getValue()
	{
		$value = 0;

		foreach($this->getTimeslices() as $timeslice)
		{
			$value += $timeslice->getValue();
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
        if($this->rate == null)
            $this->rate = $serviceRate->getRateValue();
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
	 * @return float
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("charge")
	 */
	public function getCharge()
	{
		$value = $this->getValue();
		switch ($this->getRateUnitType()) {
		case RateUnitType::$Hourly:
			$value = ($value / 3600);
			break;
		case RateUnitType::$Minutely:
			$value = ($value / 60);
			break;
		case RateUnitType::$Dayly:
			$value = ($value / 86400);
			break;
		}
		return ($this->getRate() * $value);
	}

	/**
	 * Returns the Name the Activty has.
	 * @return string
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("name")
	 */
	public function getName()
	{
		return $this->getService()->getName();
	}

	/**
	 * @param int $value
	 *
	 * @return $this
	 */
	public function setValue($value)
	{
		$this->value = $value;
		return $this;
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
			return ($value / 3600).'h';
			break;
		case RateUnitType::$Minutely:
			return ($value / 60).'m';
			break;
		case RateUnitType::$Dayly:
			return ($value / 86400).'d';
			break;
		}
		return $value;
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
     * @param  float    $rate
     * @return Activity
     */
    public function setRate($rate)
    {
        $this->rate = $rate;
        return $this;
    }

    /**
     * Get rate
     *
     *
     *
     * @return float
     */
    public function getRate()
    {
	    if( empty($this->rate) ){
		    if($this->getService() instanceof Service){
			    $rate =  $this->getService()->getRateByRateGroup($this->getProject()->getRateGroup());
			    return $rate->getRateValue();
		    } else {
			    return 0;
		    }
	    }
	    else {
		    return $this->rate;
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
	    $this->setRate($rate->getRateValue());

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

}
