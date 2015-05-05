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
	 * @ORM\Column(type="string")
	 * @JMS\SerializedName("rateUnit")
	 */
	protected $rateUnit;

	/**
	 * @ORM\Column(type="decimal", scale=3, precision=10, nullable=true)
	 */
	protected $vat;

	/**
	 * @var string
	 * @ORM\Column(type="string")
	 */
	protected $amount;

	/**
	 * @var Money
	 * @JMS\Type(name="Money")
	 * @ORM\Column(name="total", type="money")
	 */
	protected $total;

	/**
	 * @var Activity
	 * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Activity", )
	 */
	protected $activity;

	/**
	 * @param Activity $activity
	 *
	 * @return $this
	 */
	public function setFromActivity(Activity $activity)
	{
		$this->name         = $activity->getName();
		$this->rateValue    = $activity->getRateValue();
		$this->amount       = $activity->serializeValue();
		$this->rateUnit     = $activity->getRateUnit();
		$this->vat          = $activity->getVat();
		$this->total        = $activity->getCharge();
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
		if($this->rateValue instanceof Money && is_numeric($this->amount) && is_numeric($this->vat))
			return $this->rateValue->multiply($this->amount)->multiply($this->vat);
		else
			return null;
	}

	/**
	 * @return Money
	 */
	public function getTotal()
	{
		return $this->total;
	}

	/**
	 * @param Money $total
	 *
	 * @return $this
	 */
	public function setTotal($total)
	{
		$this->total = $total;
		return $this;
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
	 * @return int
	 */
	public function getRateValue()
	{
		return $this->rateValue;
	}

	/**
	 * @param int $rateValue
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
		return $this->amount;
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
		return $this->vat;
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


} 