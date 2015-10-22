<?php

namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Money\Money;

/**
 * Class StandardDiscount
 * @package Dime\TimetrackerBundle\Entity
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\StandardDiscountRepository")
 * @ORM\Table(name="standard_discounts")
 */
class StandardDiscount extends Entity implements DimeEntityInterface
{

    /**
     * @var
     * @ORM\Column(type="string")
     */
    protected $name;

    /**
     * @var
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    protected $value;

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
}
