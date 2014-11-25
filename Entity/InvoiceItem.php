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
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Class InvoiceItem
 * @package Dime\InvoiceBundle\Entity
 * @ORM\Entity()
 * @ORM\Table(name="invoice_items")
 * @Json\Schema("invoiceItems")
 */
class InvoiceItem extends Entity implements DimeEntityInterface
{
	/**
	 * @var Invoice
	 * @ORM\ManyToOne(targetEntity="Dime\InvoiceBundle\Entity\Invoice", inversedBy="items")
	 */
	protected $invoice;

	/**
	 * @var string
	 * @ORM\Column(type="string")
	 */
	protected $type;

	/**
	 * @var int
	 * @ORM\Column(type="integer")
	 */
	protected $rate;

	/**
	 * @var string
	 * @ORM\Column(type="string")
	 */
	protected $rateUnit;

	/**
	 * @var float
	 * @ORM\Column(type="string")
	 */
	protected $value;

	/**
	 * @var float
	 * @ORM\Column(type="decimal", scale=2, precision=10)
	 */
	protected $charge;

	/**
	 * @param Activity $activity
	 *
	 * @return $this
	 */
	public function setFromActivity(Activity $activity)
	{
		$this->type         = $activity->getName();
		$this->rate         = $activity->getRate();
		$this->value        = $activity->serializeValue();
		$this->rateUnit     = $activity->getRateUnit();
		$this->charge       = ceil($activity->getCharge());
		return $this;
	}

	/**
	 * @return float
	 */
	public function getCharge()
	{
		return $this->charge;
	}

	/**
	 * @param float $charge
	 *
	 * @return $this
	 */
	public function setCharge($charge)
	{
		$this->charge = $charge;
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
	public function getRate()
	{
		return $this->rate;
	}

	/**
	 * @param int $rate
	 *
	 * @return $this
	 */
	public function setRate($rate)
	{
		$this->rate = $rate;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getType()
	{
		return $this->type;
	}

	/**
	 * @param string $type
	 *
	 * @return $this
	 */
	public function setType($type)
	{
		$this->type = $type;
		return $this;
	}

	/**
	 * @return float
	 */
	public function getValue()
	{
		return $this->value;
	}

	/**
	 * @param float $value
	 *
	 * @return $this
	 */
	public function setValue($value)
	{
		$this->value = $value;
		return $this;
	}
} 