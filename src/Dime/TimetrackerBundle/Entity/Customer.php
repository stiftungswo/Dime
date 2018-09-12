<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Swo\Commonsbundle\Entity\AbstractEntity;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Validator\Constraints as Assert;

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
class Customer extends AbstractEntity implements DimeEntityInterface
{
    /**
     * @var string $name
     *
     * @JMS\Groups({"List"})
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
     * @JMS\Groups({"List"})
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
     * @var String
     *
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", length=60, nullable=true)
     */
    protected $email;

    /**
     * @var String
     *
     * @ORM\Column(type="string", length=60, nullable=true)
     */
    protected $phone;

    /**
     * @var String
     *
     * @ORM\Column(type="string", length=60, nullable=true)
     */
    protected $mobilephone;

    /**
     * @var String
     *
     * @ORM\Column(type="text", nullable=true)
     */
    protected $comment;

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
     * Can this customer be used for offers / invoices?
     * @var boolean $systemCustomer
     *
     * @JMS\Groups({"List"})
     * @JMS\SerializedName("systemCustomer")
     * @ORM\Column(type="boolean", name="system_customer")
     */
    protected $systemCustomer = true;

    /**
     * @var \Swo\CustomerBundle\Entity\Address $address
     *
     * @JMS\Groups({"List"})
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Address", cascade={"all"})
     */
    protected $address;

    /**
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\SerializedName("phones")
     * @ORM\ManyToMany(targetEntity="Swo\CustomerBundle\Entity\Phone", cascade={"all"}, orphanRemoval=true)
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
    }

    /**
     * Set name
     *
     * @param  string $name
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
     * @param  string $alias
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
            $customer = $this->getId() ? (string)$this->getId() : '';
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
     * @return Customer
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
     * @return bool
     */
    public function isSystemCustomer()
    {
        return $this->systemCustomer;
    }

    /**
     * @param bool $systemCustomer
     */
    public function setSystemCustomer($systemCustomer)
    {
        $this->systemCustomer = $systemCustomer;
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
     * @return \Swo\CustomerBundle\Entity\Address
     */
    public function getAddress()
    {
        return $this->address;
    }

    /**
     * @param \Swo\CustomerBundle\Entity\Address $address
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

    /**
     * @return String
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * @param String $email
     *
     * @return $this
     */
    public function setEmail($email)
    {
        $this->email = $email;
        return $this;
    }

    /**
     * @return String
     */
    public function getPhone()
    {
        return $this->phone;
    }

    /**
     * @param String $phone
     *
     * @return $this
     */
    public function setPhone($phone)
    {
        $this->phone = $phone;
        return $this;
    }

    /**
     * @return String
     */
    public function getMobilephone()
    {
        return $this->mobilephone;
    }

    /**
     * @param String $mobilephone
     *
     * @return $this
     */
    public function setMobilephone($mobilephone)
    {
        $this->mobilephone = $mobilephone;
        return $this;
    }

    /**
     * @return String
     */
    public function getComment()
    {
        return $this->comment;
    }

    /**
     * @param String $comment
     *
     * @return $this
     */
    public function setComment($comment)
    {
        $this->comment = $comment;
        return $this;
    }
}
