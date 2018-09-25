<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\CompanyRepository")
 * @ORM\Table(name="companies")
 */

class Company extends AbstractCustomer implements DimeEntityInterface
{
    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Phone", mappedBy="company", cascade={"all"}, orphanRemoval=true)
     * @JMS\Groups({"List"})
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\SerializedName("phoneNumbers")
     */
    protected $phoneNumbers;

    /**
     * @var \Dime\TimetrackerBundle\Entity\RateGroup|null $rateGroup
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
     * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     * @JMS\SerializedName("rateGroup")
     */
    protected $rateGroup;

    /**
     * @var Address|null $address
     * @JMS\Groups({"List"})
     * @ORM\OneToOne(targetEntity="Swo\CustomerBundle\Entity\Address", mappedBy="company", cascade={"all"}, orphanRemoval=true)
     */
    protected $address;

    /**
     * @var ArrayCollection $persons
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Person", mappedBy="company", cascade={"all"}, orphanRemoval=true)
     * @JMS\Groups({"List"})
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\SerializedName("persons")
     */
    protected $persons;

    /**
     * @var string|null $name
     * @JMS\Groups({"List"})
     * @Assert\NotBlank()
     * @ORM\Column(name="name", type="string")
     */
    protected $name;

    /**
     * @var string|null $department
     * @ORM\Column(name="department", type="string", nullable=true)
     */
    protected $department;


    public function __construct()
    {
        $this->phoneNumbers = new ArrayCollection();
        $this->persons = new ArrayCollection();
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
     * @return Company
     */
    public function addPhoneNumber(Phone $phone) : Company
    {
        $this->phoneNumbers[] = $phone;
        return $this;
    }

    /**
     * @param ArrayCollection $phoneNumbers
     * @return Company
     */
    public function setPhoneNumbers(ArrayCollection $phoneNumbers) : Company
    {
        $this->phoneNumbers = $phoneNumbers;
        return $this;
    }

    /**
     * @param Phone $phone
     * @return Company
     */
    public function removePhoneNumber(Phone $phone) : Company
    {
        $this->phoneNumbers->removeElement($phone);
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
     * @return Address|null
     */
    public function getAddress()
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
     * @return string|null
     */
    public function getName()
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
     * @return string|null
     */
    public function getDepartment()
    {
        return $this->department;
    }

    /**
     * @param string|null $department
     * @return Company
     */
    public function setDepartment($department) : Company
    {
        $this->department = $department;
        return $this;
    }
}
