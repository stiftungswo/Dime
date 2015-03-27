<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;

use Carbon\Carbon;
use DateTime;
use DeepCopy\DeepCopy;
use DeepCopy\Filter\Doctrine\DoctrineCollectionFilter;
use DeepCopy\Filter\KeepFilter;
use DeepCopy\Filter\SetNullFilter;
use DeepCopy\Matcher\PropertyMatcher;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\StandardDiscount;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Swo\CommonsBundle\Filter\NewNameFilter;
use Symfony\Component\Validator\Constraints as Assert;
use Money\Money;

/**
 * Class Invoice
 * @package Dime\InvoiceBundle\Entity
 *
 * @ORM\Table(name="invoices")
 * @ORM\Entity(repositoryClass="Dime\InvoiceBundle\Entity\InvoiceRepository")
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
	 * @ORM\Column(type="text", nullable=true)
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
	 * @JMS\SerializedName("invoiceDiscounts")
	 */
	protected $invoiceDiscounts;

	/**
	 * @var ArrayCollection
	 * @ORM\ManyToMany(targetEntity="Dime\TimetrackerBundle\Entity\StandardDiscount")
	 * @ORM\JoinTable(name="invoice_standard_discounts",
	 *      joinColumns={@ORM\JoinColumn(name="invoice_id", referencedColumnName="id")},
	 *      inverseJoinColumns={@ORM\JoinColumn(name="standard_discount_id", referencedColumnName="id", unique=true)}
	 *      )
	 * @JMS\SerializedName("standardDiscounts")
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

	/**
	 * @var DateTime
	 * @ORM\Column(name="start", type="date")
	 */
	protected $start;

	/**
	 * @var DateTime
	 * @ORM\Column(name="end", type="date")
	 */
	protected $end;

	/**
	 * @var Money
	 * @JMS\SerializedName("fixedPrice")
	 * @JMS\Type(name="Money")
	 * @ORM\Column(name="fixed_price", type="money", nullable=true)
	 */
	protected $fixedPrice;


	public function __construct()
	{
		$this->invoiceDiscounts = new ArrayCollection();
		$this->standardDiscounts = new ArrayCollection();
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
		if($this->getStandardDiscounts()) {
			foreach ($this->getStandardDiscounts() as $standardDiscount) {
				$totalDiscounts = $totalDiscounts->add($standardDiscount->getCalculatedDiscount($this->getSubtotal()));
			}
		}
		if($this->getInvoiceDiscounts()) {
			foreach ($this->getInvoiceDiscounts() as $invoiceDiscount) {
				$totalDiscounts = $totalDiscounts->add($invoiceDiscount->getCalculatedDiscount($this->getSubtotal()));
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
	 * @JMS\VirtualProperty
	 * @JMS\SerializedName("subtotal")
	 * @JMS\Type(name="Money")
	 * @return Money
	 */
	public function getSubtotal()
	{
		if($this->getItems()){
			$subtotal = Money::CHF(0);
			foreach ($this->getItems() as $item) {
				if(!empty($item->getTotal()))
					$subtotal = $subtotal->add($item->getTotal());
			}
			return $subtotal;
		} else {
			return null;
		}
	}

	/**
	 * /**
	 * @JMS\VirtualProperty
	 * @JMS\SerializedName("totalVAT")
	 * @JMS\Type(name="Money")
	 * @return Money
	 */
	public function getTotalVAT()
	{
		if($this->getItems()){
			$totalVAT = Money::CHF(0);
			foreach ($this->getItems() as $invoicePosition) {
				if($invoicePosition->getCalculatedVAT()) {
					$totalVAT = $totalVAT->add($invoicePosition->getCalculatedVAT());
				}
			}
			return $totalVAT;
		} else {
			return null;
		}
	}

	public static function getCopyFilters(DeepCopy $deepCopy)
	{
		$deepCopy = parent::getCopyFilters($deepCopy);
		$deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'project'));
		$deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'offer'));
		$deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'tags'));
		$deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'standardDiscounts'));
		$deepCopy->addFilter(new DoctrineCollectionFilter(), new PropertyMatcher(self::class, 'items'));
		$deepCopy->addFilter(new DoctrineCollectionFilter(), new PropertyMatcher(self::class, 'invoiceDiscounts'));
		$deepCopy->addFilter(new NewNameFilter('Invoice'), new PropertyMatcher(self::class, 'name'));
		$deepCopy->addFilter(new SetNullFilter(), new PropertyMatcher(self::class, 'alias'));
		$deepCopy = InvoiceDiscount::getCopyFilters($deepCopy);
		$deepCopy = InvoiceItem::getCopyFilters($deepCopy);
		return $deepCopy;
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

	/**
	 * @return DateTime
	 */
	public function getStart()
	{
		if(is_null($this->start)){
			return null;
		}
		return Carbon::instance($this->start);
	}

	/**
	 * @param DateTime $start
	 *
	 * @return $this
	 */
	public function setStart($start)
	{
		$this->start = $start;
		return $this;
	}

	/**
	 * @return Carbon
	 */
	public function getEnd()
	{
		if(is_null($this->end)){
			return null;
		}
		return Carbon::instance($this->end);
	}

	/**
	 * @param DateTime $end
	 *
	 * @return $this
	 */
	public function setEnd($end)
	{
		$this->end = $end;
		return $this;
	}

	/**
	 * @return Money
	 */
	public function getFixedPrice()
	{
		return $this->fixedPrice;
	}

	/**
	 * @param Money $fixedPrice
	 *
	 * @return $this
	 */
	public function setFixedPrice($fixedPrice)
	{
		$this->fixedPrice = $fixedPrice;
		return $this;
	}

} 