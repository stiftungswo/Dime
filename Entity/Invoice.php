<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\StandardDiscount;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Class Invoice
 * @package Dime\InvoiceBundle\Entity
 *
 * @ORM\Table(name="invoices")
 * @ORM\Entity(repositoryClass="Dime\InvoiceBundle\Entity\InvoiceRepository")
 * @ORM\HasLifecycleCallbacks()
 * @Json\Schema("invoices")
 */
class Invoice extends Entity implements DimeEntityInterface
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
	 * @Assert\NotBlank()
	 * @Gedmo\Slug(fields={"name"})
	 * @ORM\Column(type="string", length=30)
	 */
	protected $alias;

	/**
	 * @var string
	 * @ORM\Column(type="text")
	 */
	protected $description;

	/**
	 * @var \Dime\TimetrackerBundle\Entity\Project
	 * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Project")
	 */
	protected $project;

	/**
	 * @var \Dime\OfferBundle\Entity\Offer
	 * @ORM\ManyToOne(targetEntity="Dime\OfferBundle\Entity\Offer")
	 */
	protected $offer;

	/**
	 * @var float
	 * @ORM\Column(type="decimal", scale=2, precision=4, nullable=true)
	 */
	protected $gross;

	/**
	 * @var ArrayCollection
	 * @ORM\OneToMany(targetEntity="Dime\InvoiceBundle\Entity\InvoiceItem", mappedBy="invoice", cascade={"all"})
	 */
	protected $items;

	/**
	 * @var ArrayCollection
	 * @ORM\ManyToMany(targetEntity="Dime\InvoiceBundle\Entity\InvoiceDiscount", cascade={"all"})
	 * @ORM\JoinTable(name="invoice_invoicediscounts",
	 *      joinColumns={@ORM\JoinColumn(name="invoice_id", referencedColumnName="id")},
	 *      inverseJoinColumns={@ORM\JoinColumn(name="invoicediscount_id", referencedColumnName="id", unique=true)}
	 *      )
	 */
	protected $invoiceDiscounts;

	/**
	 * @var ArrayCollection
	 * @ORM\ManyToMany(targetEntity="Dime\TimetrackerBundle\Entity\StandardDiscount")
	 * @ORM\JoinTable(name="invoice_standard_discounts",
	 *      joinColumns={@ORM\JoinColumn(name="invoice_id", referencedColumnName="id")},
	 *      inverseJoinColumns={@ORM\JoinColumn(name="standard_discount_id", referencedColumnName="id", unique=true)}
	 *      )
	 */
	protected $standardDiscounts;

	/**
	 * @var ArrayCollection $tags
	 *
	 * @JMS\Type("array")
	 * @JMS\SerializedName("tags")
	 * @ORM\ManyToMany(targetEntity="Dime\TimetrackerBundle\Entity\Tag", cascade="all")
	 * @ORM\JoinTable(name="invoice_tags")
	 */
	protected $tags;


	public function __construct()
	{
		$this->invoiceDiscounts = new ArrayCollection();
		$this->standardDiscounts = new ArrayCollection();
	}

	/**
	 * @return float $net
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("net")
	 */
	public function getNet()
	{
		$gross = $this->getGross();
		$net = $gross;
		foreach($this->getInvoiceDiscounts() as $discount)
		{
			if($discount instanceof InvoiceDiscount)
			{
				$net = $net + $discount->getModifier($gross);
			}
		}
		foreach($this->getStandardDiscounts() as $discount)
		{
			if($discount instanceof StandardDiscount)
			{
				$net = $net + $discount->getModifier($gross);
			}
		}
		return $net;
	}

	/**
	 * @ORM\PrePersist
	 * @ORM\PreUpdate
	 */
	public function updateGross()
	{
		$fixed = $this->getProject()->getFixedPrice();
		if($fixed > 0){
			$this->gross = $fixed;
			return $this;
		}
		foreach($this->getItems() as $item) {
			if($item instanceof InvoiceItem){
				$this->gross += $item->getCharge();
			}
		}
		return $this;
	}

	/**
	 * @return float
	 */
	public function getGross()
	{
		return $this->gross;
	}

	/**
	 * @param float $gross
	 *
	 * @return $this
	 */
	public function setGross($gross)
	{
		$this->gross = $gross;
		return $this;
	}

	/**
	 * @return ArrayCollection
	 */
	public function getItems()
	{
		return $this->items;
	}

	/**
	 * @param InvoiceItem $item
	 *
	 * @return $this
	 */
	public function addItem(InvoiceItem $item)
	{
		$this->items[] = $item;
		return $this;
	}

	/**
	 * @param ArrayCollection $items
	 *
	 * @return $this
	 */
	public function setItems($items)
	{
		$this->items = $items;
		return $this;
	}

	/**
	 * @param InvoiceItem $item
	 *
	 * @return $this
	 */
	public function removeItem(InvoiceItem $item)
	{
		$this->items->removeElement($item);
		return $this;
	}


	/**
	 * @return mixed
	 */
	public function getInvoiceDiscounts()
	{
		return $this->invoiceDiscounts;
	}

	/**
	 * @param mixed $invoiceDiscounts
	 *
	 * @return $this
	 */
	public function setInvoiceDiscounts($invoiceDiscounts)
	{
		$this->invoiceDiscounts = $invoiceDiscounts;
		return $this;
	}

	/**
	 * @param InvoiceDiscount $invoiceDiscount
	 *
	 * @return $this
	 */
	public function addInvoiceDiscounts(InvoiceDiscount $invoiceDiscount)
	{
		$this->invoiceDiscounts[] = $invoiceDiscount;
		return $this;
	}

	/**
	 * @return \Dime\OfferBundle\Entity\Offer
	 */
	public function getOffer()
	{
		return $this->offer;
	}

	/**
	 * @param \Dime\OfferBundle\Entity\Offer $offer
	 *
	 * @return $this
	 */
	public function setOffer($offer)
	{
		$this->offer = $offer;
		return $this;
	}

	/**
	 * @return \Dime\TimetrackerBundle\Entity\Project
	 */
	public function getProject()
	{
		return $this->project;
	}

	/**
	 * @param \Dime\TimetrackerBundle\Entity\Project $project
	 *
	 * @return $this
	 */
	public function setProject($project)
	{
		$this->project = $project;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getStandardDiscounts()
	{
		return $this->standardDiscounts;
	}

	/**
	 * @param mixed $standardDiscounts
	 *
	 * @return $this
	 */
	public function setStandardDiscounts($standardDiscounts)
	{
		$this->standardDiscounts = $standardDiscounts;
		return $this;
	}

	/**
	 * @return ArrayCollection
	 */
	public function getTags()
	{
		return $this->tags;
	}

	/**
	 * @param ArrayCollection $tags
	 *
	 * @return $this
	 */
	public function setTags($tags)
	{
		$this->tags = $tags;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getAlias()
	{
		return $this->alias;
	}

	/**
	 * @param mixed $alias
	 *
	 * @return $this
	 */
	public function setAlias($alias)
	{
		$this->alias = $alias;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getDescription()
	{
		return $this->description;
	}

	/**
	 * @param string $description
	 *
	 * @return $this
	 */
	public function setDescription($description)
	{
		$this->description = $description;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getName()
	{
		return $this->name;
	}

	/**
	 * @param string $name
	 *
	 * @return $this
	 */
	public function setName($name)
	{
		$this->name = $name;
		return $this;
	}


} 