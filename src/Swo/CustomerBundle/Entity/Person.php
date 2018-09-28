<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\ORM\PersistentCollection;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Doctrine\ORM\Mapping\InheritanceType;
use Doctrine\ORM\Mapping\DiscriminatorColumn;
use Doctrine\ORM\Mapping\DiscriminatorMap;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\PersonRepository")
 * @ORM\Table(name="persons")
 * @Json\Schema("persons")
 */

class Person extends AbstractCustomer implements DimeEntityInterface
{
    /**
     * @var string|null $salutation
     * @ORM\Column(name="salutation", type="string", nullable=true, length=60)
     * @JMS\Groups({"List"})
     * @JMS\SerializedName("salutation")
     */
    protected $salutation;

    /**
     * @var string|null $firstName
     * @ORM\Column(name="first_name", type="string", length=60)
     * @JMS\Groups({"List"})
     * @JMS\SerializedName("firstName")
     */
    protected $firstName;

    /**
     * @var string|null $lastName
     * @ORM\Column(name="last_name", type="string", length=60)
     * @JMS\Groups({"List"})
     * @JMS\SerializedName("lastName")
     */
    protected $lastName;

    /**
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\Groups({"List"})
     * @ORM\OneToMany(targetEntity="Phone", mappedBy="person", cascade="all")
     */
    protected $phoneNumbers;

    /**
     * @var Company|null $company
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", inversedBy="persons", cascade={"detach"})
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true)
     * @JMS\Groups({"List"})
     * @JMS\MaxDepth(1)
     */
    protected $company;

    /**
     * @var Address|null $address
     * @ORM\OneToMany(targetEntity="Swo\CustomerBundle\Entity\Address", mappedBy="person", cascade={"all"}, orphanRemoval=true)
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\Groups({"List"})
     */
    protected $addresses;

    /**
     * Person constructor.
     */
    public function __construct()
    {
        $this->addresses = new ArrayCollection();
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
     * @return string|null
     */
    public function getFirstName()
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
     * @return string|null
     */
    public function getLastName()
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
     * @return ArrayCollection|PersistentCollection
     */
    public function getPhoneNumbers()
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

    /**
     * @return ArrayCollection
     */
    public function getAddresses() : ArrayCollection
    {
        return $this->addresses;
    }

    /**
     * @param Address $address
     * @return Person
     */
    public function addAddress(Address $address) : Person
    {
        $this->addresses[] = $address;
        return $this;
    }

    /**
     * @param ArrayCollection $addresses
     * @return Person
     */
    public function setAddresses(ArrayCollection $addresses) : Person
    {
        $this->addresses = $addresses;
        return $this;
    }

    /**
     * @param Address $address
     * @return Person
     */
    public function removeAddress(Address $address) : Person
    {
        $this->addresses->removeElement($address);
        return $this;
    }
}
