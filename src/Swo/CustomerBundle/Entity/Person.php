<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Doctrine\ORM\Mapping\InheritanceType;
use Doctrine\ORM\Mapping\DiscriminatorColumn;
use Doctrine\ORM\Mapping\DiscriminatorMap;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity
 * @ORM\Table(name="persons")
 * @Json\Schema("persons")
 */

class Person extends AbstractCustomer
{
    /**
     * @var string|null $salutation
     * @ORM\Column(name="salutation", type="string", nullable=true, length=60)
     */
    protected $salutation;

    /**
     * @var string $firstName
     * @ORM\Column(name="first_name", type="string", length=60)
     */
    protected $firstName;

    /**
     * @var string $lastName
     * @ORM\Column(name="last_name", type="string", length=60)
     */
    protected $lastName;

    /**
     * @var ArrayCollection $phoneNumbers;
     * @ORM\OneToMany(targetEntity="Phone", mappedBy="person", cascade="all")
     */
    protected $phoneNumbers;

    /**
     * @var \Swo\CustomerBundle\Entity\Company $company
     * @JMS\Groups({"List"})
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", inversedBy="persons", cascade={"all"})
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true)
     */
    protected $company;

    /**
     * @var Address $address
     * @JMS\Groups({"List"})
     * @ORM\OneToOne(targetEntity="Swo\CustomerBundle\Entity\Address", mappedBy="person", cascade={"all"}, orphanRemoval=true)
     */
    protected $address;

    /**
     * Person constructor.
     */
    public function __construct()
    {
        $this->phoneNumbers = new ArrayCollection();
    }

    /**
     * @return string|null
     */
    public function getSalutation()
    {
        return $this->salutation;
    }

    /**
     * @param string|null $salutation
     * @return Person
     */
    public function setSalutation($salutation) : Person
    {
        $this->salutation = $salutation;
        return $this;
    }

    /**
     * @return string
     */
    public function getFirstName() : string
    {
        return $this->firstName;
    }

    /**
     * @param string $firstName
     * @return Person
     */
    public function setFirstName(string $firstName) : Person
    {
        $this->firstName = $firstName;
        return $this;
    }

    /**
     * @return string
     */
    public function getLastName() : string
    {
        return $this->lastName;
    }

    /**
     * @param string $lastName
     * @return Person
     */
    public function setLastName(string $lastName) : Person
    {
        $this->lastName = $lastName;
        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getPhoneNumbers() : ArrayCollection
    {
        return $this->phoneNumbers;
    }

    /**
     * @param Phone $phone
     * @return Person
     */
    public function addPhoneNumber(Phone $phone) : Person
    {
        $this->phoneNumbers[] = $phone;
        return $this;
    }

    /**
     * @param ArrayCollection $phones
     * @return Person
     */
    public function setPhoneNumbers(ArrayCollection $phones) : Person
    {
        $this->phoneNumbers = $phones;
        return $this;
    }

    public function removePhoneNumber(Phone $phone) : Person
    {
        $this->phoneNumbers->removeElement($phone);
        return $this;
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
     * @return Person
     */
    public function setCompany($company) : Person
    {
        $this->company = $company;
        return $this;
    }
}
