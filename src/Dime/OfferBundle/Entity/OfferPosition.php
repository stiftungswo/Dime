<?php
namespace Dime\OfferBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\Service;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;

/**
 * @ORM\Table(name="offer_positions")
 * @ORM\Entity(repositoryClass="Dime\OfferBundle\Entity\OfferPositionRepository")
 * @ORM\HasLifecycleCallbacks()
 */
class OfferPosition extends Entity implements DimeEntityInterface
{
    /**
     * @JMS\SerializedName("offer")
     * @ORM\ManyToOne(targetEntity="Offer", inversedBy="offerPositions")
     * @ORM\JoinColumn(name="offer_id", referencedColumnName="id", nullable=false)
     * @JMS\MaxDepth(1)
     */
    protected $offer;
    
    /**
     *
     * @JMS\SerializedName("service")
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\Service")
     * @ORM\JoinColumn(name="service_id", referencedColumnName="id")
     * @JMS\MaxDepth(2)
     *
     * @var Service
     */
    protected $service;
    
    /**
     * @JMS\SerializedName("order")
     * @ORM\Column(name="order_no", type="integer", nullable=true)
     */
    protected $order;
    
    /**
     * Amount of the position is multiplicated with the rate to determine total cost e.g. amount of 7 hours.
     *
     * @ORM\Column(type="decimal", scale=2, precision=10, nullable=true)
     */
    protected $amount;
    
    /**
     * @ORM\Column(name="rate_value", type="money", nullable=true)
     * @JMS\SerializedName("rateValue")
     * @JMS\Type(name="Money")
     */
    protected $rateValue;

    /**
     * @ORM\Column(name="rate_unit", type="text", nullable=true)
     * @JMS\SerializedName("rateUnit")
     */
    protected $rateUnit;

    /**
     * @var RateUnitType $rateUnitType
     *
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateUnitType")
     * @JMS\SerializedName("rateUnitType")
     */
    protected $rateUnitType;

    /**
     * @ORM\Column(type="decimal", scale=3, precision=10, nullable=true)
     */
    protected $vat;
    
    /**
     * @ORM\Column(type="boolean")
     */
    protected $discountable;

    /**
     * @var boolean $chargeable
     *
     * @ORM\Column(type="boolean", nullable=true)
     * @JMS\Exclude()
     */
    protected $chargeable;

    /**
     * Auto generate duration if empty
     *
     * @ORM\PrePersist
     * @ORM\PreUpdate
     * @return OfferPosition
     */
    public function updateEmptyRateFromDefault()
    {
        $serviceRate = $this->getServiceRate();
        if ($serviceRate === null) {
            return $this;
        }
        if ($this->rateValue == null) {
            $this->rateValue = $serviceRate->getRateValue();
        }
        if ($this->rateUnit == null) {
            $this->rateUnit = $serviceRate->getRateUnit();
        }
        if ($this->rateUnitType == null) {
            $this->rateUnitType = $serviceRate->getRateUnitType();
        }
        return $this;
    }

    /**
     * Indicates if rateValue is manually set or derived from service
     * JMS\VirtualProperty
     * JMS\SerializedName("isManualRateValueSet")
     */
    public function isManualRateValueSet()
    {
        if ($this->getServiceRate() === null) {
            return false;
        }
        if ($this->rateValue == $this->getServiceRate()->getRateValue()) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * Indicates if rateUnit is manually set or derived from service
     * JMS\VirtualProperty
     * JMS\SerializedName("isManualRateUnitSet")
     */
    public function isManualRateUnitSet()
    {
        if ($this->getServiceRate() === null) {
            return false;
        }
        if ($this->rateUnit == $this->getServiceRate()->getRateUnit()) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * Indicates if rateUnitType is manually set or derived from service
     * JMS\VirtualProperty
     * JMS\SerializedName("isManualRateUnitTypeSet")
     */
    public function isManualRateUnitTypeSet()
    {
        if ($this->getServiceRate() === null) {
            return false;
        }
        if ($this->rateUnitType === $this->getServiceRate()->getRateUnitType()) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * Indicates if VAT is manually set or derived from service
     * JMS\VirtualProperty
     * JMS\SerializedName("isManualVATSet")
     */
    public function isManualVATSet()
    {
        if ($this->getServiceRate() === null) {
            return false;
        }
        if ($this->vat == $this->getService()->getVat()) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * return the Rate from the service according the offers rate group
     * @JMS\VirtualProperty
     * @JMS\SerializedName("serviceRate")
     *
     * @return \Dime\TimetrackerBundle\Entity\Rate
     */
    public function getServiceRate()
    {
        if (empty($this->service)) {
            return null;
        }
        return $this->getService()->getRateByRateGroup($this->getOffer()->getRateGroup());
    }

    /**
     * return the calculated rate value i.e. the manually set rate value of this offer position. if not set the rate_value of the services rate
     * @JMS\VirtualProperty
     * @JMS\SerializedName("calculatedRateValue")
     * @JMS\Type(name="Money")
     * @return Money
     */
    public function getCalculatedRateValue()
    {
        if ($this->isManualRateValueSet()) {
            return $this->rateValue;
        } else {
            $serviceRate = $this->getServiceRate();
            return isset($serviceRate) ? $serviceRate->getRateValue() : null;
        }
    }

    /**
     * @JMS\VirtualProperty
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
            return null;
        }
    }

    /**
     * Calculates the amount of hours for this OfferPosition if the RateUnitType is a time
     *
     * @return int amount in hours if RateUnitType is a time
     */
    public function getAmountInHours()
    {
        if ($this->rateUnitType->getSymbol() !== RateUnitType::$NoChange) {
            return RateUnitType::transformBetweenTimeUnits($this->amount, $this->rateUnitType, RateUnitType::$Hourly, false);
        } else {
            return 0;
        }
    }

    /**
     * Set service
     *
     * @param Service $service
     *
     * @return OfferPosition
     */
    public function setService(Service $service)
    {
        $this->service = $service;
        $rate = $this->getServiceRate();
        $this->setRateValue($rate->getRateValue());
        $this->setRateUnit($rate->getRateUnit());
        $this->setRateUnitType($rate->getRateUnitType());
        $this->setVat($service->getVat());
        return $this;
    }

    /**
     * Get service
     *
     * @return \Dime\TimetrackerBundle\Entity\Service
     */
    public function getService()
    {
        return $this->service;
    }

    /**
     * Set order
     *
     * @param integer $order
     *
     * @return OfferPosition
     */
    public function setOrder($order)
    {
        $this->order = $order;

        return $this;
    }

    /**
     * Get order
     *
     * @return integer
     */
    public function getOrder()
    {
        return $this->order;
    }

    /**
     * Set amount
     *
     * @param string $amount
     *
     * @return OfferPosition
     */
    public function setAmount($amount)
    {
        $this->amount = $amount;

        return $this;
    }

    /**
     * Get amount
     *
     * @return float
     */
    public function getAmount()
    {
        return (float)$this->amount;
    }

    /**
     * Set rate
     *
     * @param string $rateValue
     *
     * @return OfferPosition
     */
    public function setRateValue($rateValue)
    {
        $this->rateValue = $rateValue;

        return $this;
    }

    /**
     * Get rate
     *
     * @return Money
     */
    public function getRateValue()
    {
        return $this->rateValue;
    }

    /**
     * Set rate
     *
     * @param string $rateUnit
     *
     * @return OfferPosition
     */
    public function setRateUnit($rateUnit)
    {
        $this->rateUnit = $rateUnit;

        return $this;
    }

    /**
     * Get rate
     *
     * @return double
     */
    public function getRateUnit()
    {
        return $this->rateUnit;
    }

    /**
     * Set rate
     *
     * @param RateUnitType $rateUnitType
     *
     * @return OfferPosition
     */
    public function setRateUnitType($rateUnitType)
    {
        $this->rateUnitType = $rateUnitType;

        return $this;
    }

    /**
     * Get rate
     *
     * @return RateUnitType
     */
    public function getRateUnitType()
    {
        return $this->rateUnitType;
    }

    /**
     * Set vat
     *
     * @param string $vat
     *
     * @return OfferPosition
     */
    public function setVat($vat)
    {
        $this->vat = $vat;

        return $this;
    }

    /**
     * Get vat
     *
     * @return string
     */
    public function getVat()
    {
        return $this->vat;
    }

    /**
     * Set discountable
     *
     * @param boolean $discountable
     *
     * @return OfferPosition
     */
    public function setDiscountable($discountable)
    {
        $this->discountable = $discountable;

        return $this;
    }

    /**
     * Get discountable
     *
     * @return boolean
     */
    public function getDiscountable()
    {
        return $this->discountable;
    }

    /**
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return OfferPosition
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
     * @return OfferPosition
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * Set offer
     *
     * @param Offer $offer
     *
     * @return OfferPosition
     */
    public function setOffer(Offer $offer = null)
    {
        $this->offer = $offer;

        return $this;
    }

    /**
     * Get offer
     *
     * @return Offer
     */
    public function getOffer()
    {
        return $this->offer;
    }

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
        $this->chargeable = $chargeable;
    }
}
