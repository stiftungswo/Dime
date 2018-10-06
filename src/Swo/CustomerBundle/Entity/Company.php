<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\CompanyRepository")
 * @ORM\Table(name="companies")
 */
class Company extends Customer implements DimeEntityInterface
{
    /**
     * @var ArrayCollection $persons
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Person", mappedBy="company", cascade={"all"}, orphanRemoval=true)
     * @JMS\Groups({"List"})
     * @JMS\Type("array")
     * @JMS\MaxDepth(2)
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

    public function __construct()
    {
        parent::__construct();
        $this->persons = new ArrayCollection();
    }

    /**
     * @return ArrayCollection
     */
    public function getPersons(): ArrayCollection
    {
        return $this->persons;
    }

    /**
     * @param Person $person
     * @return Company
     */
    public function addPerson(Person $person): Company
    {
        $this->persons[] = $person;
        return $this;
    }

    /**
     * @param ArrayCollection $persons
     * @return Company
     */
    public function setPersons(ArrayCollection $persons): Company
    {
        $this->persons = $persons;
        return $this;
    }

    /**
     * @param Person $person
     * @return Company
     */
    public function removePerson(Person $person): Company
    {
        $this->persons->removeElement($person);
        return $this;
    }

    /**
     * @return bool|null
     */
    public function getChargeable()
    {
        return $this->chargeable;
    }

    /**
     * @return bool|null
     */
    public function getHideForBusiness()
    {
        return $this->hideForBusiness;
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
    public function setName(string $name): Company
    {
        $this->name = $name;
        $this->commonName = $name;
        return $this;
    }
}
