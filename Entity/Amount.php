<?php
/**
 * Created by PhpStorm.
 * User: toast
 * Date: 9/19/14
 * Time: 11:00 AM
 */

namespace Dime\TimetrackerBundle\Entity;


use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;

/**
 * Dime\TimetrackerBundle\Entity\Amount
 *
 * @ORM\Table(name="amounts")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\AmountRepository")
 */
class Amount extends Entity implements DimeEntityInterface {
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
	* @var ArrayCollection $tags
	*
	* @JMS\Type("array")
	* @JMS\SerializedName("tags")
	* @ORM\ManyToMany(targetEntity="Tag", cascade="all")
	* @ORM\JoinTable(name="amounts_tags")
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
	 *
	 * @ORM\Column(type="decimal", scale=2, precision=10, nullable=true)
	 */
	protected $rate;

	/**
	 * @var string $rateReference (considered as enum: customer|project|service)
	 *
	 * @JMS\SerializedName("rateReference")
	 * @ORM\Column(name="rate_reference", type="string", length=255, nullable=true)
	 */
	protected $rateReference;

	/**
	 * @var boolean $chargeable
	 *
	 * @ORM\Column(type="boolean")
	 */
	protected $chargeable;

	/**
	 * @var integer $value
	 *
	 * @ORM\Column(type="decimal", scale=2, precision=10)
	 */
	protected $value;

	/**
	 * Entity constructor
	 */
	public function __construct()
	{
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
	 * @return float
	 */
	public function getRate()
	{
		return $this->rate;
	}

	/**
	 * Set rateReference
	 *
	 * @param  string   $rateReference
	 * @return Activity
	 */
	public function setRateReference($rateReference)
	{
		$this->rateReference = $rateReference;

		return $this;
	}

	/**
	 * Get rateReference
	 *
	 * @return string
	 */
	public function getRateReference()
	{
		return $this->rateReference;
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
	 * @internal param Tag $tags
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
	 *
	 * @return Activity
	 */
	public function setTags(ArrayCollection $tags)
	{
		$this->tags = $tags;

		return $this;
	}

	/**
	 * @param $chargeable
	 *
	 * @return $this
	 */
	public function setChargeable($chargeable)
	{
		$this->chargeable = $chargeable;
		return $this;
	}

	/**
	 * @return bool
	 */
	public function getChargeable()
	{
		return $this->chargeable;
	}

	/**
	 * @param $value
	 *
	 * @return $this
	 */
	public function setValue($value)
	{
		$this->value = $value;
		return $this;
	}

	/**
	 * @return int
	 */
	public function getValue()
	{
		return $this->value;
	}
} 