<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;

use Carbon\Carbon;
use DateTime;
use Dime\TimetrackerBundle\Entity\Customer;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\StandardDiscount;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;
use Symfony\Component\Validator\Constraints as Assert;

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
     * @JMS\Groups({"List"})
     * @var string
     * @ORM\Column(type="text", nullable=true)
     */
    protected $description;

    /**
     * @var \Dime\TimetrackerBundle\Entity\Project
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Project", inversedBy="invoices")
     * @JMS\MaxDepth(1)
     */
    protected $project;

    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="Dime\InvoiceBundle\Entity\InvoiceItem", mappedBy="invoice", cascade={"all"}, orphanRemoval=true)
     */
    protected $items;

    /**
     * @var ArrayCollection
     * @JMS\SerializedName("invoiceDiscounts")
     * @ORM\OneToMany(targetEntity="InvoiceDiscount", mappedBy="invoice", cascade={"all"})
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
     * @JMS\Groups({"List"})
     * @var DateTime
     * @ORM\Column(name="start", type="date", nullable=true)
     */
    protected $start;

    /**
     * @JMS\Groups({"List"})
     * @var DateTime
     * @ORM\Column(name="end", type="date", nullable=true)
     */
    protected $end;

    /**
     * @var Money
     * @JMS\Exclude()
     * @ORM\Column(name="fixed_price", type="money", nullable=true)
     */
    protected $fixedPrice;

    /**
     * @var Customer
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Customer")
     * @ORM\JoinColumn(name="customer_id", referencedColumnName="id", nullable=true, onDelete="SET NULL"))
     */
    protected $customer;


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
        if ($this->getStandardDiscounts()) {
            foreach ($this->getStandardDiscounts() as $standardDiscount) {
                $totalDiscounts = $totalDiscounts->add($standardDiscount->getCalculatedDiscount($this->getSubtotal()));
            }
        }
        if ($this->getInvoiceDiscounts()) {
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
        if ($this->getSubtotal()) {
            return $this->getSubtotal()->subtract($this->getTotalDiscounts());
        }
        return Money::CHF(0);
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("subtotal")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getSubtotal()
    {
        if ($this->getItems()) {
            $subtotal = Money::CHF(0);
            foreach ($this->getItems() as $item) {
                if (!empty($item->getTotal())) {
                    $subtotal = $subtotal->add($item->getTotal());
                }
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
        if ($this->getItems()) {
            $totalVAT = Money::CHF(0);
            foreach ($this->getItems() as $invoicePosition) {
                if ($invoicePosition->getCalculatedVAT()) {
                    $totalVAT = $totalVAT->add($invoicePosition->getCalculatedVAT());
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
     * @return ArrayCollection|InvoiceDiscount[]
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
     * @return ArrayCollection|StandardDiscount[]
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
        if (is_null($this->start)) {
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
        if (is_null($this->end)) {
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

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("fixedPrice")
     * @return string
     */
    public function serializeFixedPrice()
    {
        if ($this->fixedPrice != null && !$this->fixedPrice->isZero()) {
            return $this->fixedPrice->format();
        } else {
            return null;
        }
    }

    /**
     * @return Customer
     */
    public function getCustomer()
    {
        if ($this->customer) {
            return $this->customer;
        }
        if ($this->getProject()) {
            return $this->getProject()->getCustomer();
        }
        return null;
    }

    /**
     * @param Customer $customer
     *
     * @return $this
     */
    public function setCustomer($customer)
    {
        $this->customer = $customer;
        return $this;
    }
}
