<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity
 * @ORM\Table(name="companies")
 */

class Company extends AbstractCustomer
{
    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Phone", mappedBy="company", cascade={"all"}, orphanRemoval=true)
     */
    protected $phone_numbers;

    /**
     * @var \Dime\TimetrackerBundle\Entity\RateGroup|null $rateGroup
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
     * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $rateGroup;

    /**
     * @var Address $address
     * @JMS\Groups({"List"})
     * @ORM\OneToOne(targetEntity="Swo\CustomerBundle\Entity\Address", inversedBy="customer", cascade={"all"}, orphanRemoval=true)
     * @ORM\JoinColumn(name="address_id", referencedColumnName="id", nullable=false)
     */
    protected $address;

    /**
     * @var ArrayCollection $persons
     * @JMS\Groups({"List"})
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Person", mappedBy="company", cascade={"all"}, orphanRemoval=true)
     */
    protected $persons;

    /**
     * @var string $name
     * @JMS\Groups({"List"})
     * @Assert\NotBlank()
     * @ORM\Column(name="name", type="string")
     */
    protected $name;

    /**
     * @var string $department
     * @ORM\Column(name="department", type="string", nullable=true)
     */
    protected $department;


    public function __construct()
    {
        $this->phone_numbers = new ArrayCollection();
        $this->persons = new ArrayCollection();
    }

    /**
     * @return ArrayCollection
     */
    public function getPhoneNumbers() : ArrayCollection
    {
        return $this->phone_numbers;
    }

    /**
     * @param Phone $phone
     * @return Company
     */
    public function addPhoneNumber(Phone $phone) : Company
    {
        $this->phone_numbers[] = $phone;
        return $this;
    }

    /**
     * @param ArrayCollection $phone_numbers
     * @return Company
     */
    public function setPhoneNumbers(ArrayCollection $phone_numbers) : Company
    {
        $this->phone_numbers = $phone_numbers;
        return $this;
    }

    /**
     * @param Phone $phone
     * @return Company
     */
    public function removePhoneNumber(Phone $phone) : Company
    {
        $this->phone_numbers->removeElement($phone);
        return $this;
    }

    /**
     * @return \Dime\TimetrackerBundle\Entity\RateGroup|null
     */
    public function getRateGroup()
    {
        return $this->rateGroup;
    }

    /**
     * @param \Dime\TimetrackerBundle\Entity\RateGroup|null $rateGroup
     * @return Company
     */
    public function setRateGroup($rateGroup) : Company
    {
        $this->rateGroup = $rateGroup;
        return $this;
    }

    /**
     * @return Address
     */
    public function getAddress() : Address
    {
        return $this->address;
    }
    
    public function setAddress(Address $address) : Company
    {
        $this->address = $address;
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
     * @return Company
     */
    public function addPerson(Person $person) : Company
    {
        $this->persons[] = $person;
        return $this;
    }

    /**
     * @param ArrayCollection $person_numbers
     * @return Company
     */
    public function setPersons(ArrayCollection $persons) : Company
    {
        $this->persons = $persons;
        return $this;
    }

    /**
     * @param Person $person
     * @return Company
     */
    public function removePerson(Person $person) : Company
    {
        $this->persons->removeElement($person);
        return $this;
    }

    /**
     * @return string
     */
    public function getName() : string
    {
        return $this->name;
    }

    /**
     * @param string $name
     * @return Company
     */
    public function setName(string $name) : Company
    {
        $this->name = $name;
        return $this;
    }

    /**
     * @return string
     */
    public function getDepartment() : string
    {
        return $this->department;
    }

    /**
     * @param string $department
     * @return Company
     */
    public function setDepartment(string $department) : Company
    {
        $this->department = $department;
        return $this;
    }
}
