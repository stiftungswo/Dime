<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;

/**
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\PhoneRepository")
 * @ORM\Table(name="phones")
 */

class Phone extends Entity implements DimeEntityInterface
{
    /**
     * phone number
     *
     * @var string|null $number
     * @ORM\Column(type="string", nullable=false)
     * @JMS\Groups({"List"})
     */
    protected $number;

    /**
     * category of the phone number (type is a reserved word in the dime frontend)
     *
     * @var int|null $category
     * @ORM\Column(type="integer", nullable=false)
     * @JMS\Groups({"List"})
     */
    protected $category;

    /**
     * related customer
     *
     * @var Customer|null
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Customer", inversedBy="phoneNumbers")
     * @ORM\JoinColumn(name="customer_id", referencedColumnName="id", nullable=true)
     */
    protected $customer;

    /**
     * @return string|null
     */
    public function getNumber()
    {
        return $this->number;
    }

    /**
     * @param string|null $number
     * @return Phone
     */
    public function setNumber(string $number) : Phone
    {
        $this->number = $number;
        return $this;
    }

    /**
     * @return integer|null
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * @param integer|null $category
     * @return Phone
     */
    public function setCategory($category) : Phone
    {
        $this->category = $category;
        return $this;
    }

    /**
     * @return Customer|null
     */
    public function getCustomer()
    {
        return $this->customer;
    }

    /**
     * @param Customer|null $customer
     * @return Phone
     */
    public function setCustomer($customer) : Phone
    {
        $this->customer = $customer;
        return $this;
    }
}
