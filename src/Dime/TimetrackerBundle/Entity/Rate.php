<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;

/**
 * Dime\TimetrackerBundle\Entity\Rate
 *
 * @ORM\Table(name="rates")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\RateRepository")
 */
class Rate extends Entity implements DimeEntityInterface
{

    /**
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
     * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", onDelete="SET NULL")
     * @JMS\SerializedName("rateGroup")
     */
    protected $rateGroup;

    /**
     * @var string $rateUnit
     *
     * @ORM\Column(name="rate_unit", type="text", nullable=true)
     * @JMS\SerializedName("rateUnit")
     */
    protected $rateUnit;

    /**
     * @var rateUnitType $rateUnitType
     *
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateUnitType")
     * @JMS\SerializedName("rateUnitType")
     */
    protected $rateUnitType;

    /**
     * @ORM\ManyToOne(targetEntity="Service", inversedBy="rates")
     * @ORM\JoinColumn(name="service_id", referencedColumnName="id")
     * @JMS\SerializedName("service")
     * @JMS\MaxDepth(1)
     **/
    protected $service;

    /**
     * @var Money $rateValue
     *
     * @ORM\Column(name="rate_value", type="money", nullable=true)
     * @JMS\SerializedName("rateValue")
     * @JMS\Type(name="Money")
     */
    protected $rateValue;


    /**
     * Set rateGroup
     *
     * @param string $rateGroup
     *
     * @return Rate
     */
    public function setRateGroup($rateGroup)
    {
        $this->rateGroup = $rateGroup;

        return $this;
    }

    /**
     * Get rateGroup
     *
     * @return string
     */
    public function getRateGroup()
    {
        return $this->rateGroup;
    }

    /**
     * Set rateUnit
     *
     * @param string $rateUnit
     *
     * @return Rate
     */
    public function setRateUnit($rateUnit)
    {
        $this->rateUnit = $rateUnit;

        return $this;
    }

    /**
     * Get rateUnit
     *
     * @return string
     */
    public function getRateUnit()
    {
        return $this->rateUnit;
    }

    /**
     * Set service
     *
     * @param string $service
     *
     * @return Rate
     */
    public function setService($service)
    {
        $this->service = $service;

        return $this;
    }

    /**
     * Get service
     *
     * @return string
     */
    public function getService()
    {
        return $this->service;
    }

    /**
     * Set value
     *
     * @param string $rateValue
     *
     * @return Rate
     */
    public function setRateValue($rateValue)
    {
        $this->rateValue = $rateValue;

        return $this;
    }

    /**
     * Get value
     *
     * @return Money
     */
    public function getRateValue()
    {
        return $this->rateValue;
    }

    /**
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return Rate
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
     * @return Rate
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * @return RateUnitType
     */
    public function getRateUnitType()
    {
        return $this->rateUnitType;
    }

    /**
     * @param RateUnitType $rateUnitType
     *
     * @return $this
     */
    public function setRateUnitType($rateUnitType)
    {
        $this->rateUnitType = $rateUnitType;
        return $this;
    }
}
