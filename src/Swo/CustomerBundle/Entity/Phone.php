<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;

/**
 * @ORM\Entity
 * @ORM\Table(name="phones")
 */

class Phone extends Entity
{
    /**
     * phone number
     *
     * @var string
     * @ORM\Column(type="string", nullable=false)
     * @JMS\Groups({"List"})
     */
    protected $number;

    /**
     * type of the phone number
     *
     * @var string
     * @ORM\Column(type="string", nullable=false)
     * @JMS\Groups({"List"})
     */
    protected $type;

    /**
     * related company (number can ony belong to one company, but to many persons)
     *
     * @var Company|null
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", inversedBy="phoneNumbers")
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true)
     * @JMS\Exclude()
     */
    protected $company;

    /**
     * related persons
     * @var ArrayCollection $persons
     * @ORM\ManyToMany(targetEntity="Swo\CustomerBundle\Entity\Person", inversedBy="phoneNumbers")
     * @ORM\JoinTable(name="phones_persons")
     * @JMS\Exclude()
     */
    protected $persons;

    /**
     * Phone constructor.
     */
    public function __construct()
    {
        $this->persons = new ArrayCollection();
    }

    /**
     * @return int
     */
    public function getNumber() : string
    {
        return $this->number;
    }

    /**
     * @param int $number
     * @return Phone
     */
    public function setNumber(string $number) : Phone
    {
        $this->number = $number;
        return $this;
    }

    /**
     * @return string
     */
    public function getType() : string
    {
        return $this->type;
    }

    /**
     * @param string $type
     * @return Phone
     */
    public function setType(string $type) : Phone
    {
        $this->type = $type;
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
     * @return Phone
     */
    public function setCompany($company) : Phone
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
     * @return Phone
     */
    public function addPerson(Person $person) : Phone
    {
        $this->persons[] = $person;
        return $this;
    }

    /**
     * @param ArrayCollection $persons
     * @return Phone
     */
    public function setPersons(ArrayCollection $persons) : Phone
    {
        $this->persons = $persons;
        return $this;
    }

    /**
     * @param Person $person
     * @return Phone
     */
    public function removePerson(Person $person) : Phone
    {
        $this->persons->removeElement($person);
        return $this;
    }
}
