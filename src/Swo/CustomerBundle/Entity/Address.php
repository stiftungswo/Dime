<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;

/**
 * @ORM\Entity
 * @ORM\Table(name="addresses")
 */

class Address extends Entity
{
    /**
     * @var Company|null $company
     * @JMS\Groups({"List"})
     * @JMS\Exclude()
     * @ORM\OneToOne(targetEntity="Swo\CustomerBundle\Entity\Company", mappedBy="address")
     */
    protected $company;

    /**
     * @var ArrayCollection $persons
     * @JMS\Groups({"List"})
     * @JMS\Exclude()
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Person", mappedBy="address")
     */
    protected $persons;

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

    public function __construct()
    {
        $this->persons = new ArrayCollection();
    }

    /**
     * @return Company|null
     */
    public function getCompany()
    {
        return $this->company;
    }

    /**
     * @param Company|null $company
     * @return Address
     */
    public function setCompany($company) : Address
    {
        $this->company = $company;
        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getPersons() : ArrayCollection
    {
        return $this->persons;
    }

    /**
     * @param Person $person
     * @return Address
     */
    public function addPerson(Person $person) : Address
    {
        $this->persons[] = $person;
        return $this;
    }

    /**
     * @param ArrayCollection $persons
     * @return Address
     */
    public function setPersons(ArrayCollection $persons) : Address
    {
        $this->persons = $persons;
        return $this;
    }

    /**
     * @param Person $person
     * @return Address
     */
    public function removePerson(Person $person) : Address
    {
        $this->persons->removeElement($person);
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
}
