<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Symfony\Component\Validator\Context\ExecutionContextInterface;

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
     * related company (number can ony belong to one company, but to many persons)
     *
     * @var Company|null
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", inversedBy="addresses")
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true)
     */
    protected $company;

    /**
     * related person
     * @var Person|null $person
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Person", inversedBy="addresses")
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
