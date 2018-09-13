<?php

namespace Dime\OfferBundle\Entity;

use Swo\CommonsBundle\Entity\AbstractEntity;
use Swo\CommonsBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Money\Money;

/**
 * @package Dime\OfferBundle\Entity
 * @ORM\Entity(repositoryClass="Dime\OfferBundle\Entity\OfferDiscountRepository")
 * @ORM\Table(name="offer_discounts")
 */
class OfferDiscount extends AbstractEntity implements DimeEntityInterface
{
    /**
     * @JMS\SerializedName("offer")
     * @ORM\ManyToOne(targetEntity="Offer", inversedBy="offerDiscounts")
     * @ORM\JoinColumn(name="offer_id", referencedColumnName="id", nullable=true)
     * @JMS\MaxDepth(1)
     */
    protected $offer;

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
     *
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
     * Set offer
     *
     * @param \Dime\OfferBundle\Entity\Offer $offer
     *
     * @return OfferDiscount
     */
    public function setOffer(Offer $offer = null)
    {
        $this->offer = $offer;

        return $this;
    }

    /**
     * Get offer
     *
     * @return \Dime\OfferBundle\Entity\Offer
     */
    public function getOffer()
    {
        return $this->offer;
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
        if ($minus!=='EMPTY') {
            $this->minus = $minus;
        }
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
        if ($percentage!=='EMPTY') {
            $this->percentage = $percentage;

            if ($percentage==true) {
                $this->value = $this->value*=0.01;
            } else {
                $this->value = $this->value*=100;
            }
        }
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
     * Returns the Positive or negative integer Value of which shall be subtracted of subtotal.
     *
     * @param $gross
     *
     * @return float|int $amount
     */
    public function getModifier($gross)
    {
        $amount = $this->value;
        if ($this->percentage) {
            $amount = $this->percentofgross($gross, $this->value, 10);
        }
        if ($this->minus) {
            $amount = floatval('-'.$amount);
        }
        return $amount;
    }

    private function percentofgross($gross, $percent, $precision)
    {
        $res = round($percent * $gross, $precision);

        return $res;
    }
}
