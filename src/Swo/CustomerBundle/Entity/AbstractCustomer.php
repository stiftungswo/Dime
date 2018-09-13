<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Swo\CommonsBundle\Entity\AbstractEntity;

/**
 * AbstractCustomer
 * @ORM\MappedSuperclass()
 */
abstract class AbstractCustomer extends AbstractEntity
{
    /**
     * @var \Swo\CustomerBundle\Entity\Address $address
     *
     * @JMS\Groups({"List"})
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Address", cascade={"all"})
     * @ORM\JoinColumn(name="address_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    private $address;

    /**
     * @var \Dime\TimetrackerBundle\Entity\RateGroup $rateGroup
     *
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
     * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     * @JMS\SerializedName("rateGroup")
     */
    private $rateGroup;

    /**
     * Can this customer be used for offers / invoices?
     * @var boolean $systemCustomer
     *
     * @JMS\Groups({"List"})
     * @JMS\SerializedName("systemCustomer")
     * @ORM\Column(name="systemCustomer", type="boolean")
     */
    private $systemCustomer = true;

    /**
     * @var string $comment
     *
     * @ORM\Column(name="comment", type="text", nullable=true)
     */
    private $comment;

    /**
     * @var string $email
     *
     * @JMS\Groups({"List"})
     * @ORM\Column(name="email", type="string", length=60, nullable=true)
     */
    private $email;

    /**
     * Set address
     *
     * @param \Swo\CustomerBundle\Entity\Address $address
     *
     * @return AbstractCustomer
     */
    public function setAddress($address)
    {
        $this->address = $address;

        return $this;
    }

    /**
     * Get address
     *
     * @return \Swo\CustomerBundle\Entity\Address
     */
    public function getAddress()
    {
        return $this->address;
    }

    /**
     * Set rateGroup
     *
     * @param \Dime\TimetrackerBundle\Entity\RateGroup $rateGroup
     *
     * @return AbstractCustomer
     */
    public function setRateGroup($rateGroup)
    {
        $this->rateGroup = $rateGroup;

        return $this;
    }

    /**
     * Get rateGroup
     *
     * @return \Dime\TimetrackerBundle\Entity\RateGroup
     */
    public function getRateGroup()
    {
        return $this->rateGroup;
    }

    /**
     * Set systemCustomer
     *
     * @param boolean $systemCustomer
     *
     * @return AbstractCustomer
     */
    public function setSystemCustomer($systemCustomer)
    {
        $this->systemCustomer = $systemCustomer;

        return $this;
    }

    /**
     * Get systemCustomer
     *
     * @return boolean
     */
    public function getSystemCustomer()
    {
        return $this->systemCustomer;
    }

    /**
     * Set comment
     *
     * @param string $comment
     *
     * @return AbstractCustomer
     */
    public function setComment($comment)
    {
        $this->comment = $comment;

        return $this;
    }

    /**
     * Get comment
     *
     * @return string
     */
    public function getComment()
    {
        return $this->comment;
    }

    /**
     * Set email
     *
     * @param string $email
     *
     * @return AbstractCustomer
     */
    public function setEmail($email)
    {
        $this->email = $email;

        return $this;
    }

    /**
     * Get email
     *
     * @return string
     */
    public function getEmail()
    {
        return $this->email;
    }
}
