<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;

use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;

/**
 * Class InvoiceItem
 * @package Dime\InvoiceBundle\Entity
 * @ORM\Entity(repositoryClass="Dime\InvoiceBundle\Entity\InvoiceItemRepository")
 * @ORM\Table(name="invoice_items")
 * @Json\Schema("invoiceItems")
 */
class InvoiceItem extends Entity implements DimeEntityInterface
{
    /**
     * @var Invoice
     * @ORM\ManyToOne(targetEntity="Dime\InvoiceBundle\Entity\Invoice", inversedBy="items")
     * @JMS\MaxDepth(1)
     */
    protected $invoice;

    /**
     * @var string
     * @ORM\Column(type="string")
     */
    protected $name;

    /**
     * @var int
     * @ORM\Column(name="rate_value", type="money", nullable=true)
     * @JMS\SerializedName("rateValue")
     * @JMS\Type(name="Money")
     */
    protected $rateValue;

    /**
     * @var string
     * @ORM\Column(type="string", nullable=true)
     * @JMS\SerializedName("rateUnit")
     */
    protected $rateUnit;

    /**
     * @ORM\Column(type="decimal", scale=3, precision=10, nullable=true)
     */
    protected $vat;

    /**
     * @var string
     * @ORM\Column(type="string", nullable=true)
     */
    protected $amount;

    /**
     * @var Activity
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Activity", )
     */
    protected $activity;

    /**
     * @JMS\SerializedName("order")
     * @ORM\Column(name="order_no", type="decimal", nullable=true)
     */
    protected $order;

    /**
     * @param Activity $activity
     *
     * @return $this
     */
    public function setFromActivity(Activity $activity)
    {
        $this->name         = $activity->getService()->getName();
        $this->rateValue    = $activity->getRateValue();
        $this->amount = $activity->getValue();
        $this->rateUnit     = $activity->getRateUnit();
        $this->vat          = $activity->getVat();
        $this->activity     = $activity;
        return $this;
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("calculatedVAT")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getCalculatedVAT()
    {
        if ($this->rateValue instanceof Money && is_numeric($this->amount) && is_numeric($this->vat)) {
            return $this->rateValue->multiply((float)$this->amount)->multiply((float)$this->vat);
        } else {
            return Money::CHF(0);
        }
    }

    public function getCalculatedTotal()
    {
        if ($this->rateValue instanceof Money && is_numeric($this->amount)) {
            return $this->rateValue->multiply((float)$this->amount);
        } else {
            return Money::CHF(0);
        }
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("total")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getTotal()
    {
        $total = $this->getRateValue();
        if ($total === null) {
            return null;
        }
        if ($this->getAmount() !== null) {
            $total = $total->multiply($this->getAmount());
        }
        $vat = $this->getCalculatedVAT();
        if ($vat instanceof Money) {
            $total = $total->add($vat);
        }
        return $total;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("totalWithoutVAT")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getTotalWithoutVAT()
    {
        $total = $this->getRateValue();
        if ($total === null) {
            return null;
        }
        if ($this->getAmount() !== null) {
            $total = $total->multiply($this->getAmount());
        }
        return $total;
    }

    /**
     * @return Invoice
     */
    public function getInvoice()
    {
        return $this->invoice;
    }

    /**
     * @param Invoice $invoice
     *
     * @return $this
     */
    public function setInvoice($invoice)
    {
        $this->invoice = $invoice;
        return $this;
    }

    /**
     * @return string
     */
    public function getRateUnit()
    {
        return $this->rateUnit;
    }

    /**
     * @param string $rateUnit
     *
     * @return $this
     */
    public function setRateUnit($rateUnit)
    {
        $this->rateUnit = $rateUnit;
        return $this;
    }

    /**
     * @return Money
     */
    public function getRateValue()
    {
        return $this->rateValue;
    }

    /**
     * @param Money $rateValue
     *
     * @return $this
     */
    public function setRateValue($rateValue)
    {
        $this->rateValue = $rateValue;
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
     * @return float
     */
    public function getAmount()
    {
        return floatval($this->amount);
    }

    /**
     * @param float $amount
     *
     * @return $this
     */
    public function setAmount($amount)
    {
        $this->amount = $amount;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getVat()
    {
        return $this->vat ? $this->vat : 0;
    }

    /**
     * @param mixed $vat
     *
     * @return $this
     */
    public function setVat($vat)
    {
        $this->vat = $vat;
        return $this;
    }

    /**
     * @return Activity
     */
    public function getActivity()
    {
        return $this->activity;
    }

    /**
     * @param Activity $activity
     *
     * @return $this
     */
    public function setActivity($activity)
    {
        $this->activity = $activity;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getOrder()
    {
        return $this->order;
    }

    /**
     * @param mixed $order
     */
    public function setOrder($order)
    {
        $this->order = $order;
    }
}
