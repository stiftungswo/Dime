<?php
namespace Swo\CommonsBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;

/**
 * @ORM\Entity
 * @ORM\Table(name="address")
\*/
class Address
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;
    /**
     * The Streetname
     * @var \Swo\CommonsBundle\Entity\AddressStreet
     *
     * @ORM\ManyToOne(targetEntity="AddressStreet", cascade={"persist"})
     * @JMS\Exclude
     */
    protected $street;
    /**
     * The City or Town
     * @var \Swo\CommonsBundle\Entity\AddressCity
     *
     * @ORM\ManyToOne(targetEntity="AddressCity", cascade={"persist"})
     * @JMS\Exclude
     */
    protected $city;
    /**
     * The State or Kanton or Bundesland...
     * @var \Swo\CommonsBundle\Entity\AddressState
     *
     * @ORM\ManyToOne(targetEntity="AddressState", cascade={"persist"})
     * @JMS\Exclude
     */
    protected $state;
    /**
     * The Country
     * @var \Swo\CommonsBundle\Entity\AddressCountry
     *
     * @ORM\ManyToOne(targetEntity="AddressCountry", cascade={"persist"})
     * @JMS\Exclude
     */
    protected $country;
    /**
     * The Streetnumber
     * @var String
     *
     * @ORM\Column(type="string", nullable=true)
     */
    protected $streetnumber;
    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }
    /**
     * Set streetnumber
     *
     * @param integer $streetnumber
     * @return Address
     */
    public function setStreetnumber($streetnumber)
    {
        $this->streetnumber = $streetnumber;
        return $this;
    }
    /**
     * Get streetnumber
     *
     * @return integer
     */
    public function getStreetnumber()
    {
        return $this->streetnumber;
    }
    /**
     * Set street
     *
     * @param \Swo\CommonsBundle\Entity\AddressStreet $street
     * @return Address
     */
    public function setStreet(\Swo\CommonsBundle\Entity\AddressStreet $street = null)
    {
        $this->street = $street;
        return $this;
    }
    /**
     * Get street
     *
     * @return \Swo\CommonsBundle\Entity\AddressStreet
     */
    public function getStreet()
    {
        return $this->street;
    }

    /**
     * @JMS\VirtualProperty
     * @JMS\SerializedName("street")
     */
    public function serializeStreet()
    {
        if ($this->getStreet()) {
            return $this->getStreet()->getName();
        }
        return '';
    }
    /**
     * Set city
     *
     * @param \Swo\CommonsBundle\Entity\AddressCity $city
     * @return Address
     */
    public function setCity(\Swo\CommonsBundle\Entity\AddressCity $city = null)
    {
        $this->city = $city;
        return $this;
    }
    /**
     * Get city
     *
     * @return \Swo\CommonsBundle\Entity\AddressCity
     */
    public function getCity()
    {
        return $this->city;
    }

    /**
     * Helper Function to Properly Serialize the City Entry
     * @JMS\VirtualProperty
     * @JMS\SerializedName("city")
     */
    public function serializeCity()
    {
        if ($this->getCity()) {
            return $this->getCity()->getName();
        }
        return '';
    }

    /**
     * Helper Function to Properly SHow the PLZ
     * @JMS\VirtualProperty
     * @JMS\SerializedName("plz")
     */
    public function serializePlz()
    {
        if ($this->getCity()) {
            return $this->getCity()->getPlz();
        }
        return '';
    }
    /**
     * Set state
     *
     * @param \Swo\CommonsBundle\Entity\AddressState $state
     * @return Address
     */
    public function setState(\Swo\CommonsBundle\Entity\AddressState $state = null)
    {
        $this->state = $state;
        return $this;
    }
    /**
     * Get state
     *
     * @return \Swo\CommonsBundle\Entity\AddressState
     */
    public function getState()
    {
        return $this->state;
    }

    /**
     * Helper Function to Properly Show the State
     * @JMS\VirtualProperty
     * @JMS\SerializedName("state")
     */
    public function serializeState()
    {
        if ($this->getState()) {
            return $this->getState()->getName();
        }
        return '';
    }

    /**
     * Helper Function to Properly Show the Shortcode
     * @JMS\VirtualProperty
     * @JMS\SerializedName("state_shortcode")
     */
    public function serializeStateShortcode()
    {
        if ($this->getState()) {
            return $this->getState()->getShortcode();
        }
        return '';
    }

    /**
     * Set country
     *
     * @param \Swo\CommonsBundle\Entity\AddressCountry $country
     * @return Address
     */
    public function setCountry(\Swo\CommonsBundle\Entity\AddressCountry $country = null)
    {
        $this->country = $country;
        return $this;
    }
    /**
     * Get country
     *
     * @return \Swo\CommonsBundle\Entity\AddressCountry
     */
    public function getCountry()
    {
        return $this->country;
    }

    /**
     * Helper Function to Properly Serialize the Country Entry
     * @JMS\VirtualProperty
     * @JMS\SerializedName("country")
     */
    public function serializeCountry()
    {
        if ($this->getCountry()) {
            return $this->getCountry()->getName();
        }
        return '';
    }

    public function __toString()
    {
        return $this->getStreet().' '.$this->getStreetnumber().' - '.$this->getCity()->getPlz().' '.$this->getCity().' - '.$this->getState().' '.$this->getCountry();
    }

    public function __clone()
    {
        unset($this->id);
    }
}
