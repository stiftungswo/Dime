<?php
namespace Dime\TimetrackerBundle\Entity;

use Gedmo\Mapping\Annotation as Gedmo;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Dime\TimetrackerBundle\Entity\Customer
 *
 * @UniqueEntity(fields={"alias", "user"})
 * @ORM\Table(
 *   name="customers",
 *   uniqueConstraints={ @ORM\UniqueConstraint(name="unique_customer_alias_user", columns={"alias", "user_id"}) }
 * )
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\CustomerRepository")
 * @Json\Schema("customers")
 */
class Customer extends Entity implements DimeEntityInterface
{
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
     * @var ArrayCollection $tags
     *
     * @JMS\Type("array")
     * @JMS\SerializedName("tags")
     * @ORM\ManyToMany(targetEntity="Tag", cascade="all")
     * @ORM\JoinTable(name="customer_tags")
     */
    protected $tags;

    /**
     * @var String
     *
     * @ORM\Column(type="string", length=60, nullable=true)
     */
    protected $company;

    /**
     * @var String
     *
     * @ORM\Column(type="string", length=60, nullable=true)
     */
    protected $department;

    /**
     * @var String
     *
     * @ORM\Column(type="string", length=60, nullable=true)
     */
    protected $fullname;

    /**
     * @var String
     *
     * @ORM\Column(type="string", length=60, nullable=true)
     */
    protected $salutation;
	
	/**
	 * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
	 * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
	 * @JMS\SerializedName("rateGroup")
	 */
	protected $rateGroup;

	/**
	 * @var boolean $chargeable
	 *
	 * @ORM\Column(type="boolean")
	 */
	protected $chargeable = true;

	/**
	 * @var \Swo\CommonsBundle\Entity\Address $address
	 *
	 * @ORM\ManyToOne(targetEntity="\Swo\CommonsBundle\Entity\Address", cascade={"all"})
	 */
	protected $address;

	/**
	 * @JMS\Type("array")
	 * @JMS\SerializedName("phones")
	 * @ORM\ManyToMany(targetEntity="\Swo\CommonsBundle\Entity\Phone", cascade={"all"}, orphanRemoval=true)
	 * @ORM\JoinTable(name="customer_phones",
	 *      joinColumns={@ORM\JoinColumn(name="customer_id", referencedColumnName="id")},
	 *      inverseJoinColumns={@ORM\JoinColumn(name="phone_id", referencedColumnName="id", unique=true)}
	 * )
	 */
	protected $phones;

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
		if($chargeable !== 'empty')
		{
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
    }

    /**
     * Set name
     *
     * @param  string   $name
     * @return Customer
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
     * @param  string   $alias
     * @return Customer
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
     * get customer as string
     *
     * @return string
     */
    public function __toString()
    {
        $customer = $this->getName();
        if (empty($customer)) {
            $customer = $this->getId();
        }

        return $customer;
    }

    /**
     * Add tag
     *
     * @param  Tag $tag
     * @return Customer
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
     * @return Customer
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
     * @return Customer
     */
    public function setRateGroup($rateGroup)
    {
        $this->rateGroup = $rateGroup;

        return $this;
    }

    /**
     * Get rateGroup
     *
     * @return string
     */
    public function getRateGroup()
    {
        return $this->rateGroup;
    }

    /**
     * Get chargeable
     *
     * @return boolean
     */
    public function getChargeable()
    {
        return $this->chargeable;
    }

    /**
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return Customer
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
     * @return Customer
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

	/**
	 * @return \Swo\CommonsBundle\Entity\Address
	 */
	public function getAddress()
	{
		return $this->address;
	}

	/**
	 * @param \Swo\CommonsBundle\Entity\Address $address
	 *
	 * @return $this
	 */
	public function setAddress($address)
	{
		$this->address = $address;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getPhones()
	{
		return $this->phones;
	}

	/**
	 * @param mixed $phones
	 *
	 * @return $this
	 */
	public function setPhones($phones)
	{
		$this->phones = $phones;
		return $this;
	}

    /**
     * @return String
     */
    public function getCompany()
    {
        return $this->company;
    }

    /**
     * @param String $company
     *
     * @return $this
     */
    public function setCompany($company)
    {
        $this->company = $company;
        return $this;
    }

    /**
     * @return String
     */
    public function getDepartment()
    {
        return $this->department;
    }

    /**
     * @param String $department
     *
     * @return $this
     */
    public function setDepartment($department)
    {
        $this->department = $department;
        return $this;
    }

    /**
     * @return String
     */
    public function getFullname()
    {
        return $this->fullname;
    }

    /**
     * @param String $fullname
     *
     * @return $this
     */
    public function setFullname($fullname)
    {
        $this->fullname = $fullname;
        return $this;
    }

    /**
     * @return String
     */
    public function getSalutation()
    {
        return $this->salutation;
    }

    /**
     * @param String $salutation
     *
     * @return $this
     */
    public function setSalutation($salutation)
    {
        $this->salutation = $salutation;
        return $this;
    }



}
