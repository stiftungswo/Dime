<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;

/**
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\AddressRepository")
 * @ORM\Table(name="addresses")
 */

class Address extends Entity implements DimeEntityInterface
{
    /**
     * name of the street including street number
     *
     * @var string|null
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $street;

    /**
     * An address supplement (eg: Postfach 12)
     *
     * @var string|null
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $supplement;

    /**
     * the city or town
     *
     * @var string|null
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string")
     */
    protected $city;

    /**
     * postcode of the city
     *
     * @var int|null
     * @JMS\Groups({"List"})
     * @ORM\Column(type="integer")
     */
    protected $postcode;

    /**
     * country of the address
     *
     * @var string|null
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $country;

    /**
     * @var string|null $description
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $description;

    /**
     * related customer
     *
     * @var Customer|null
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Customer", inversedBy="addresses")
     * @ORM\JoinColumn(name="customer_id", referencedColumnName="id", nullable=true)
     * @JMS\MaxDepth(1)
     */
    protected $customer;

    /**
     * @return Customer|null
     */
    public function getCustomer()
    {
        return $this->customer;
    }

    /**
     * @param Customer|null $customer
     * @return Address
     */
    public function setCustomer($customer) : Address
    {
        $this->customer = $customer;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getStreet()
    {
        return $this->street;
    }

    /**
     * @param string|null $street
     * @return Address
     */
    public function setStreet($street): Address
    {
        $this->street = $street;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getSupplement()
    {
        return $this->supplement;
    }

    /**
     * @param string|null $supplement
     * @return Address
     */
    public function setSupplement($supplement): Address
    {
        $this->supplement = $supplement;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getCity()
    {
        return $this->city;
    }

    /**
     * @param string|null $city
     * @return Address
     */
    public function setCity($city): Address
    {
        $this->city = $city;
        return $this;
    }

    /**
     * @return int|null
     */
    public function getPostcode()
    {
        return $this->postcode;
    }

    /**
     * @param int|null $postcode
     * @return Address
     */
    public function setPostcode($postcode) : Address
    {
        $this->postcode = $postcode;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getCountry()
    {
        return $this->country;
    }

    /**
     * @param string|null $country
     * @return Address
     */
    public function setCountry($country) : Address
    {
        $this->country = $country;
        return $this;
    }

    /**
     * @return null|string
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @param string|null $description
     * @return Address
     */
    public function setDescription($description) : Address
    {
        $this->description = $description;
        return $this;
    }
}
