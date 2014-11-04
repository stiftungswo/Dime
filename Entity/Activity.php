<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\ActivityReference;
use Dime\TimetrackerBundle\Model\DefaultRateGroup;
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
     * @var Customer $customer
     *
     * @ORM\ManyToOne(targetEntity="Customer")
     * @ORM\JoinColumn(name="customer_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $customer;

    /**
     * @var Project $project
     *
     * @ORM\ManyToOne(targetEntity="Project")
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
     * @var float $rate
     * @JMS\AccessType("public_method")
     * @ORM\Column(type="decimal", scale=2, precision=10, nullable=true)
     */
    private $rate;
     
	/**
	 * @var boolean $chargeable
	 *
	 * @ORM\Column(type="boolean", nullable=true)
	 * @JMS\AccessType("public_method")
	 */
	protected $chargeable;

	/**
	 * @var integer $chargeableReference (enum see Model\ActivityReference)
	 *
	 * @JMS\SerializedName("chargeableReference")
	 * @ORM\Column(name="cargeable_reference", type="smallint")
	 */
	protected $chargeableReference;

	/**
	 * @var integer $value
	 *
	 * @ORM\Column(type="decimal", scale=2, precision=10, nullable=true)
	 * @JMS\AccessType("public_method")
	 */
	protected $value;

	/**
	 * @return float
	 */
	public function getValue()
	{
		$value = 0;

		foreach($this->getTimeslices() as $timeslice)
		{
			$value += $timeslice->getCurrentDuration();
		}

		if (!empty($this->value))
		{
			$value = $this->value;
		}


		$rateUnit = 's';

		if($this->getService() instanceof Service){
			$rateUnit =  $this->getService()->getRateByRateGroup($this->getProject()->getRateGroup())->getRateUnit();
		}


		switch($rateUnit)
		{
		case 'm':
			return ($value / 60);
			break;
		case 'h':
			return ($value / 60 / 60);
			break;
		case 'd':
			return ($value / 60 / 60 / 24);
			break;
		default:
			return $value;
		}
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
     * Entity constructor
     */
    public function __construct()
    {
        $this->timeslices = new ArrayCollection();
        $this->tags = new ArrayCollection();
	    $this->chargeableReference = ActivityReference::$SERVICE;
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
			    return $rate->getValue();
		    } else {
			    return 0;
		    }
	    }
	    else {
		    return $this->rate;
	    }
    }

    /**
     * Set customer
     *
     * @param  Customer $customer
     * @return Activity
     */
    public function setCustomer($customer)
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
		switch($this->getChargeableReference())
		{
		case ActivityReference::$ACTIVITY:
			return $this->chargeable;
			break;
		case ActivityReference::$PROJECT:
			return $this->getProject()->isChargeable();
			break;
		case ActivityReference::$CUSTOMER:
			return $this->getCustomer()->isChargeable();
			break;
		case ActivityReference::$SERVICE:
			return $this->getService()->isChargeable();
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
		$this->chargeable = $chargeable;
		$this->chargeableReference = ActivityReference::$ACTIVITY;
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


}
