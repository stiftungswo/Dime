<?php
namespace Dime\OfferBundle\Entity;

use Dime\TimetrackerBundle\Entity\Customer;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\StandardDiscount;
use Dime\TimetrackerBundle\Entity\Tag;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;

/**
 * Dime\OfferBundle\Entity\Offer
 *
 * @ORM\Table(name="offers")
 * @ORM\Entity(repositoryClass="Dime\OfferBundle\Entity\OfferRepository")
 */
class Offer extends Entity implements DimeEntityInterface
{
    
    /**
     * @JMS\SerializedName("offerPositions")
     * @ORM\OneToMany(targetEntity="OfferPosition", mappedBy="offer", cascade={"all"})
     */
    protected $offerPositions;
    
    /**
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $name;
    
    /**
     * @JMS\SerializedName("validTo")
     * @ORM\Column(name="valid_to", type="date", nullable=true)
     */
    protected $validTo;
    
    /**
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Project")
     * @ORM\JoinColumn(name="project_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     * @JMS\MaxDepth(1)
     */
    protected $project;
    
    /**
     * @ORM\ManyToOne(targetEntity="OfferStatusUC")
     * @ORM\JoinColumn(name="status_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $status;
    
    /**
     * @JMS\SerializedName("rateGroup")
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
     * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $rateGroup;
    
    /**
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Customer")
     * @ORM\JoinColumn(name="customer_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $customer;
    
    /**
     * @JMS\SerializedName("accountant")
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\User")
     * @ORM\JoinColumn(name="accountant_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $accountant;
    
    /**
     * @JMS\Groups({"List"})
     * @JMS\SerializedName("shortDescription")
     * @ORM\Column(name="short_description", type="text", nullable=true)
     */
    protected $shortDescription;
    
    /**
     * @ORM\Column(name="description", type="text", nullable=true)
     */
    protected $description;

    /**
     * @JMS\SerializedName("standardDiscounts")
     * @ORM\ManyToMany(targetEntity="Dime\TimetrackerBundle\Entity\StandardDiscount", cascade={"all"})
     * @ORM\JoinTable(name="offer_standard_discounts",
     *      joinColumns={@ORM\JoinColumn(name="offer_id", referencedColumnName="id")},
     *      inverseJoinColumns={@ORM\JoinColumn(name="standard_discount_id", referencedColumnName="id")}
     *      )
     **/
    protected $standardDiscounts;

    /**
     * @JMS\SerializedName("offerDiscounts")
     * @ORM\OneToMany(targetEntity="OfferDiscount", mappedBy="offer", cascade={"all"})
     */
    protected $offerDiscounts;

    /**
     * @var ArrayCollection $tags
     *
     * @JMS\Type("array")
     * @JMS\SerializedName("tags")
     * @ORM\ManyToMany(targetEntity="Dime\TimetrackerBundle\Entity\Tag", cascade="all")
     * @ORM\JoinTable(name="offer_tags")
     */
    protected $tags;

    /**
     * @var Money $fixedPrice
     *
     * @JMS\SerializedName("fixedPrice")
     * @JMS\Type(name="Money")
     * @ORM\Column(name="fixed_price", type="money", nullable=true)
     */
    protected $fixedPrice;

    /**
     * @var \Swo\CommonsBundle\Entity\Address $address
     *
     * @ORM\ManyToOne(targetEntity="\Swo\CommonsBundle\Entity\Address", cascade="all")
     */
    protected $address;

    public function __construct()
    {
        $this->standardDiscounts = new ArrayCollection();
        $this->tags = new ArrayCollection();
        $this->offerPositions = new ArrayCollection();
        $this->offerDiscounts = new ArrayCollection();
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("subtotal")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getSubtotal()
    {
        if ($this->getOfferPositions()) {
            $subtotal = Money::CHF(0);
            foreach ($this->getOfferPositions() as $offerPosition) {
                if ($offerPosition->getTotal() !== null) {
                    $subtotal = $subtotal->add($offerPosition->getTotal());
                }
            }
            return $subtotal;
        } else {
            return null;
        }
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("totalVAT")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getTotalVAT()
    {
        if ($this->getOfferPositions()) {
            $totalVAT = Money::CHF(0);
            foreach ($this->getOfferPositions() as $offerPosition) {
                if ($offerPosition->getCalculatedVAT()) {
                    $totalVAT = $totalVAT->add($offerPosition->getCalculatedVAT());
                }
            }
            return $totalVAT;
        } else {
            return null;
        }
    }

    /**
     * /**
     * @return Money
     */
    public function getTotalWithoutVAT()
    {
        return $this->getSubtotal()->subtract($this->getTotalVAT());
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("totalDiscounts")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getTotalDiscounts()
    {
        $totalDiscounts = Money::CHF(0);
        if ($this->getStandardDiscounts()) {
            foreach ($this->getStandardDiscounts() as $standardDiscount) {
                $totalDiscounts = $totalDiscounts->add($standardDiscount->getCalculatedDiscount($this->getSubtotal()));
            }
        }
        if ($this->getOfferDiscounts()) {
            foreach ($this->getOfferDiscounts() as $offerDiscount) {
                $totalDiscounts = $totalDiscounts->add($offerDiscount->getCalculatedDiscount($this->getSubtotal()));
            }
        }
        return $totalDiscounts;
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("total")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getTotal()
    {
        return $this->getSubtotal()->subtract($this->getTotalDiscounts());
    }

    /**
     * Set validTo
     *
     * @param \DateTime $validTo
     *
     * @return Offer
     */
    public function setValidTo($validTo)
    {
        $this->validTo = $validTo;

        return $this;
    }

    /**
     * Get validTo
     *
     * @return \DateTime
     */
    public function getValidTo()
    {
        return $this->validTo;
    }

    /**
     * Set project
     *
     * @param string $project
     *
     * @return Offer
     */
    public function setProject($project)
    {
        $this->project = $project;

        return $this;
    }

    /**
     * Get project
     *
     * @return string
     */
    public function getProject()
    {
        return $this->project;
    }

    /**
     * Set status
     *
     * @param string $status
     *
     * @return Offer
     */
    public function setStatus($status)
    {
        $this->status = $status;

        return $this;
    }

    /**
     * Get status
     *
     * @return string
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Set rateGroup
     *
     * @param string $rateGroup
     *
     * @return Offer
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
     * Set customer
     *
     * @param \Dime\TimetrackerBundle\Entity\Customer $customer
     *
     * @return Offer
     */
    public function setCustomer($customer)
    {
        $this->customer = $customer;
        if ($customer->getAddress()) {
            $address = clone $customer->getAddress();
            $this->setAddress($address);
        }
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
     * Set accountant
     *
     * @param string $accountant
     *
     * @return Offer
     */
    public function setAccountant($accountant)
    {
        $this->accountant = $accountant;

        return $this;
    }

    /**
     * Get accountant
     *
     * @return string
     */
    public function getAccountant()
    {
        return $this->accountant;
    }

    /**
     * Set shortDescription
     *
     * @param string $shortDescription
     *
     * @return Offer
     */
    public function setShortDescription($shortDescription)
    {
        $this->shortDescription = $shortDescription;

        return $this;
    }

    /**
     * Get shortDescription
     *
     * @return string
     */
    public function getShortDescription()
    {
        return $this->shortDescription;
    }

    /**
     * Set description
     *
     * @param string $description
     *
     * @return Offer
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
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return Offer
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
     * @return Offer
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * Add discount
     *
     * @param StandardDiscount $standardDiscount
     *
     *
     * @return Offer
     */
    public function addStandardDiscount(StandardDiscount $standardDiscount)
    {
        $this->standardDiscounts[] = $standardDiscount;

        return $this;
    }

    /**
     * Remove discount
     *
     * @param StandardDiscount $standardDiscounts
     *
     */
    public function removeStandardDiscount(StandardDiscount $standardDiscounts)
    {
        $this->standardDiscounts->removeElement($standardDiscounts);
    }

    /**
     * Get discounts
     *
     * @return \Doctrine\Common\Collections\Collection|StandardDiscount[]
     */
    public function getStandardDiscounts()
    {
        return $this->standardDiscounts;
    }

    /**
     * Add discount
     *
     * @param OfferDiscount $offerDiscount
     *
     *
     * @return Offer
     */
    public function addOfferDiscount(OfferDiscount $offerDiscount)
    {
        $this->offerDiscounts[] = $offerDiscount;

        return $this;
    }

    /**
     * Remove discount
     *
     * @param OfferDiscount $offerDiscounts
     *
     */
    public function removeOfferDiscount(OfferDiscount $offerDiscounts)
    {
        $this->offerDiscounts->removeElement($offerDiscounts);
    }

    /**
     * Get discounts
     *
     * @return \Doctrine\Common\Collections\Collection|OfferDiscount[]
     */
    public function getOfferDiscounts()
    {
        return $this->offerDiscounts;
    }

    /**
     * Add tag
     *
     * @param Tag $tag
     *
     * @return Offer
     */
    public function addTag(Tag $tag)
    {
        $this->tags[] = $tag;

        return $this;
    }

    /**
     * Remove tag
     *
     * @param Tag $tag
     */
    public function removeTag(Tag $tag)
    {
        $this->tags->removeElement($tag);
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
     * Set name
     *
     * @param string $name
     *
     * @return Offer
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
     * Add offerPosition
     *
     * @param OfferPosition $offerPosition
     *
     * @return Offer
     */
    public function addOfferPosition(OfferPosition $offerPosition)
    {
        $this->offerPositions[] = $offerPosition;

        return $this;
    }

    /**
     * Remove offerPosition
     *
     * @param OfferPosition $offerPosition
     */
    public function removeOfferPosition(OfferPosition $offerPosition)
    {
        $this->offerPositions->removeElement($offerPosition);
    }

    /**
     * Get offerPositions
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getOfferPositions()
    {
        return $this->offerPositions;
    }

    /**
     * Set fixedPrice
     *
     * @param  Money $fixedPrice
     * @return Offer
     */
    public function setFixedPrice(Money $fixedPrice)
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
}
