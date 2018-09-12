<?php
namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
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
     * The Streetname (with a street number)
     *
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $street;

    /**
     * An address supplement (eg: Postfach 12)
     * @var String
     *
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $supplement;

    /**
     * The City or Town
     *
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $city;

    /**
     * @var String
     *
     * @JMS\Groups({"List"})
     * @ORM\Column(type="integer", nullable=true)
     */
    protected $plz;

    /**
     * The Country
     *
     * @ORM\Column(type="string", nullable=true)
     */
    protected $country;

    /**
     * @return mixed
     */
    public function getStreet()
    {
        return $this->street;
    }

    /**
     * @param mixed $street
     *
     * @return $this
     */
    public function setStreet($street)
    {
        $this->street = $street;
        return $this;
    }

    /**
     * @return String
     */
    public function getSupplement()
    {
        return $this->supplement;
    }

    /**
     * @param String $supplement
     *
     * @return $this
     */
    public function setSupplement($supplement)
    {
        $this->supplement = $supplement;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getCity()
    {
        return $this->city;
    }

    /**
     * @param mixed $city
     *
     * @return $this
     */
    public function setCity($city)
    {
        $this->city = $city;
        return $this;
    }

    /**
     * @return String
     */
    public function getPlz()
    {
        return $this->plz;
    }

    /**
     * @param String $plz
     *
     * @return $this
     */
    public function setPlz($plz)
    {
        $this->plz = $plz;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getCountry()
    {
        return $this->country;
    }

    /**
     * @param mixed $country
     *
     * @return $this
     */
    public function setCountry($country)
    {
        $this->country = $country;
        return $this;
    }

    public function __toString()
    {
        if (!empty($this->supplement)) {
            return $this->getStreet() . ' - ' . $this->getCity()->getPlz() . ' ' . $this->getCity() . ' - ' . $this->getSupplement() . ' ' . $this->getCountry();
        } else {
            return $this->getStreet() . ' - ' . $this->getCity()->getPlz() . ' ' . $this->getCity();
        }
    }

    public function __clone()
    {
        unset($this->id);
    }

    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }
}
