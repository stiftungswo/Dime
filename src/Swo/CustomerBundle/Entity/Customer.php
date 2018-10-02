<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\Tag;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;

/**
 * Class Customer
 * @package Swo\CustomerBundle\Entity
 * @ORM\Entity
 * @ORM\InheritanceType("SINGLE_TABLE")
 * @ORM\DiscriminatorColumn(name="discr", type="string")
 * @ORM\DiscriminatorMap({"person" = "Person", "company" = "Company"})
 */
abstract class Customer extends Entity
{
    /**
     * @var string|null $comment
     * @ORM\Column(name="comment", type="text", nullable=true)
     */
    protected $comment;

    /**
     * @var string|null $email
     * @ORM\Column(name="email", type="text", nullable=true)
     * @JMS\Groups({"List"})
     */
    protected $email;

    /**
     * @var boolean|null $chargeable
     * @ORM\Column(name="chargeable", type="boolean", nullable=true)
     */
    protected $chargeable = true;

    /**
     * Don't show this customer in menus for address selection for offers, invoices and projects
     * @var bool|null $hideForBusiness
     * @ORM\Column(name="hide_for_business", type="boolean", nullable=true)
     * @JMS\SerializedName("hideForBusiness")
     * @JMS\Groups({"List"})
     */
    protected $hideForBusiness = false;

    /**
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\Groups({"List"})
     * @ORM\OneToMany(targetEntity="Phone", mappedBy="customer", cascade="all")
     */
    protected $phoneNumbers;

    /**
     * @var ArrayCollection $addresses
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Address", mappedBy="customer", cascade={"all"}, orphanRemoval=true)
     * @JMS\Groups({"List"})
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\SerializedName("addresses")
     */
    protected $addresses;

    /**
     * @var ArrayCollection $tags
     *
     * @JMS\Type("array")
     * @JMS\SerializedName("tags")
     * @ORM\ManyToMany(targetEntity="Dime\TimetrackerBundle\Entity\Tag", cascade="all")
     * @ORM\JoinTable(name="new_customer_tags")
     * @JMS\Groups({"List"})
     */
    protected $tags;

    /**
     * @var \Dime\TimetrackerBundle\Entity\RateGroup|null $rateGroup
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
     * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     * @JMS\SerializedName("rateGroup")
     */
    protected $rateGroup;

    public function __construct()
    {
        $this->addresses = new ArrayCollection();
        $this->phoneNumbers = new ArrayCollection();
    }

    /**
     * @return string|null
     */
    public function getComment()
    {
        return $this->comment;
    }

    /**
     * @param string $comment
     * @return Customer
     */
    public function setComment(string $comment): Customer
    {
        $this->comment = $comment;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * @param string $email
     * @return Customer
     */
    public function setEmail(string $email): Customer
    {
        $this->email = $email;
        return $this;
    }

    /**
     * @param $chargeable
     * @return Customer
     */
    public function setChargeable($chargeable): Customer
    {
        $this->chargeable = $chargeable;
        return $this;
    }

    public function setHideForBusiness($hideForBusiness): Customer
    {
        $this->hideForBusiness = $hideForBusiness;
        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getPhoneNumbers(): ArrayCollection
    {
        return $this->phoneNumbers;
    }

    /**
     * @param Phone $phone
     * @return Customer
     */
    public function addPhoneNumber(Phone $phone): Customer
    {
        $this->phoneNumbers[] = $phone;
        return $this;
    }

    /**
     * @param ArrayCollection $phoneNumbers
     * @return Customer
     */
    public function setPhoneNumbers(ArrayCollection $phoneNumbers): Customer
    {
        $this->phoneNumbers = $phoneNumbers;
        return $this;
    }

    /**
     * @param Phone $phone
     * @return Customer
     */
    public function removePhoneNumber(Phone $phone): Customer
    {
        $this->phoneNumbers->removeElement($phone);
        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getAddresses(): ArrayCollection
    {
        return $this->addresses;
    }

    /**
     * @param Address $address
     * @return Customer
     */
    public function addAddress(Address $address): Customer
    {
        $this->addresses[] = $address;
        return $this;
    }

    /**
     * @param ArrayCollection $addresses
     * @return Customer
     */
    public function setAddresses(ArrayCollection $addresses): Customer
    {
        $this->addresses = $addresses;
        return $this;
    }

    /**
     * @param Address $address
     * @return Customer
     */
    public function removeAddress(Address $address): Customer
    {
        $this->addresses->removeElement($address);
        return $this;
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
     * @return \Dime\TimetrackerBundle\Entity\RateGroup|null
     */
    public function getRateGroup()
    {
        return $this->rateGroup;
    }

    /**
     * @param \Dime\TimetrackerBundle\Entity\RateGroup|null $rateGroup
     * @return Customer
     */
    public function setRateGroup($rateGroup): Customer
    {
        $this->rateGroup = $rateGroup;
        return $this;
    }
}
