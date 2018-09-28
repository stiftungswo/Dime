<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Symfony\Component\Validator\Context\ExecutionContextInterface;

/**
 * @ORM\Entity
 * @ORM\Table(name="addresses")
 */

class Address extends Entity
{
    /**
     * name of the street including street number
     *
     * @var string
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $street;

    /**
     * An address supplement (eg: Postfach 12)
     *
     * @var string
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $supplement;

    /**
     * the city or town
     *
     * @var string
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string")
     */
    protected $city;

    /**
     * postcode of the city
     *
     * @var int
     * @JMS\Groups({"List"})
     * @ORM\Column(type="integer")
     */
    protected $postcode;

    /**
     * country of the address
     *
     * @var string
     * @JMS\Groups({"List"})
     * @ORM\Column(type="string", nullable=true)
     */
    protected $country;

    /**
     * related company (number can ony belong to one company, but to many persons)
     *
     * @var Company|null
     * @ORM\OneToOne(targetEntity="Swo\CustomerBundle\Entity\Company", inversedBy="address")
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true)
     */
    protected $company;

    /**
     * related person
     * @var Person|null $person
     * @ORM\OneToOne(targetEntity="Swo\CustomerBundle\Entity\Person", inversedBy="address")
     * @ORM\JoinColumn(name="person_id", referencedColumnName="id", nullable=true)
     */
    protected $person;

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
     * @return Person|null
     */
    public function getPerson()
    {
        return $this->person;
    }

    /**
     * @param Person|null $person
     * @return Address
     */
    public function setPerson($person) : Address
    {
        $this->person = $person;
        return $this;
    }

    /**
     * @return string
     */
    public function getStreet(): string
    {
        return $this->street;
    }

    /**
     * @param string $street
     * @return Address
     */
    public function setStreet(string $street): Address
    {
        $this->street = $street;
        return $this;
    }

    /**
     * @return string
     */
    public function getSupplement(): string
    {
        return $this->supplement;
    }

    /**
     * @param string $supplement
     * @return Address
     */
    public function setSupplement(string $supplement): Address
    {
        $this->supplement = $supplement;
        return $this;
    }

    /**
     * @return string
     */
    public function getCity(): string
    {
        return $this->city;
    }

    /**
     * @param string $city
     * @return Address
     */
    public function setCity(string $city): Address
    {
        $this->city = $city;
        return $this;
    }

    /**
     * @return int
     */
    public function getPostcode(): int
    {
        return $this->postcode;
    }

    /**
     * @param int $postcode
     * @return Address
     */
    public function setPostcode(int $postcode) : Address
    {
        $this->postcode = $postcode;
        return $this;
    }

    /**
     * @return string
     */
    public function getCountry() : string
    {
        return $this->country;
    }

    public function setCountry(string $country) : Address
    {
        $this->country = $country;
        return $this;
    }

    /**
     * @param ExecutionContextInterface $context
     * @Assert\Callback
     */
    public function hasCompanyOrPerson(ExecutionContextInterface $context)
    {
        if (is_null($this->getPerson()) && is_null($this->getCompany())) {
            $context->buildViolation('Address has to have either an associated company or phone.')
                ->atPath('company')
                ->addViolation();
        }

        if (!is_null($this->getPerson()) && !is_null($this->getCompany())) {
            $context->buildViolation('Address has to have either an associated company or phone, but not both.')
                ->atPath('company')
                ->addViolation();
        }
    }
}
