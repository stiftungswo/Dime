<?php
/**
 * Author: Till Wegmüller
 * Date: 9/25/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;

use Dime\OfferBundle\Entity\OfferDiscount;
use Swo\CommonsBundle\Entity\AbstractEntity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use Knp\JsonSchemaBundle\Annotations as Json;
use JMS\Serializer\Annotation as JMS;
use Money\Money;

/**
 * Class InvoiceDiscount
 * @package Dime\InvoiceBundle\Entity
 * @ORM\Entity(repositoryClass="Dime\InvoiceBundle\Entity\InvoiceDiscountRepository")
 * @ORM\Table(name="invoiceDiscounts")
 * @Json\Schema("invoiceDiscount")
 */
class InvoiceDiscount extends AbstractEntity implements DimeEntityInterface
{
    /**
     * @JMS\SerializedName("invoice")
     * @ORM\ManyToOne(targetEntity="Invoice", inversedBy="invoiceDiscounts")
     * @ORM\JoinColumn(name="invoice_id", referencedColumnName="id", nullable=true)
     * @JMS\MaxDepth(1)
     */
    protected $invoice;

    /**
     * @var
     * @ORM\Column(type="string")
     */
    protected $name;

    /**
     * @var
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    protected $value = 0;

    /**
     * @var
     * @ORM\Column(type="boolean", nullable=true)
     */
    protected $percentage;

    /**
     * @var
     * @ORM\Column(type="boolean", nullable=true)
     */
    protected $minus;

    /**
     * @param Money $subtotal
     *
     * @return Money
     */
    public function getCalculatedDiscount(Money $subtotal)
    {
        if ($this->percentage) {
            return $subtotal->multiply(floatval($this->value));
        } else {
            return Money::CHF($this->value);
        }
    }

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     *
     * @return $this
     */
    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }


    /**
     * @return mixed
     */
    public function getMinus()
    {
        return $this->minus;
    }

    /**
     * @param mixed $minus
     *
     * @return $this
     */
    public function setMinus($minus)
    {
        $this->minus = $minus;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getPercentage()
    {
        return $this->percentage;
    }

    /**
     * @param mixed $percentage
     *
     * @return $this
     */
    public function setPercentage($percentage)
    {
        $this->percentage = $percentage;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getValue()
    {
        return $this->value;
    }

    /**
     * @param mixed $value
     *
     * @return $this
     */
    public function setValue($value)
    {
        $this->value = $value;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getInvoice()
    {
        return $this->invoice;
    }

    /**
     * @param mixed $invoice
     *
     * @return $this
     */
    public function setInvoice($invoice)
    {
        $this->invoice = $invoice;
        return $this;
    }



    /**
     * @param OfferDiscount $offerDiscount
     *
     * @return $this
     */
    public function setFromOfferDiscount(OfferDiscount $offerDiscount)
    {
        $this->setName($offerDiscount->getName());
        $this->setMinus($offerDiscount->getMinus());
        $this->setPercentage($offerDiscount->getPercentage());
        $this->setValue($offerDiscount->getValue());
        return $this;
    }
}
