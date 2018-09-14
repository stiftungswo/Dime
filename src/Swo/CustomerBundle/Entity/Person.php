<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Swo\CommonsBundle\Model\DimeEntityInterface;
use Symfony\Component\Validator\Constraints as Assert;
use Gedmo\Mapping\Annotation as Gedmo;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Person
 *
 * @ORM\Table(name="persons")
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\PersonRepository")
 * @Json\Schema("persons")
 */
class Person extends AbstractCustomer implements DimeEntityInterface
{
    /**
     * @var string $alias
     *
     * @Gedmo\Slug(fields={"fullName"})
     * @ORM\Column(type="string", length=30)
     */
    private $alias;

    /**
     * @var \Swo\CustomerBundle\Entity\Company $company
     * @JMS\Groups({"List"})
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", cascade={"all"})
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    private $company;

    /**
     * @var string $salutation
     *
     * @ORM\Column(name="salutation", type="string", length=60, nullable=true)
     */
    private $salutation;

    /**
     * @var string $firstName
     *
     * @ORM\Column(name="first_name", type="string", length=60)
     */
    private $firstName;

    /**
     * @var string $lastName
     *
     * @ORM\Column(name="last_name", type="string", length=60)
     */
    private $lastName;

    /**
     * @var string $fullName
     * @Assert\NotBlank()
     * @JMS\Groups({"List"})
     * @ORM\Column(name="full_name", type="string", length=60)
     */
    private $fullName;

    /**
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @ORM\ManyToMany(targetEntity="Swo\CustomerBundle\Entity\Phone", cascade={"all"})
     * @ORM\JoinTable(name="persons_phones",
     *      joinColumns={@ORM\JoinColumn(name="person_id", referencedColumnName="id")},
     *      inverseJoinColumns={@ORM\JoinColumn(name="phone_id", referencedColumnName="id", unique=true)}
     * )
     */
    private $phones;

    /**
     * Set alias
     *
     * @param  string $alias
     * @return Person
     */
    public function setAlias($alias)
    {
        $this->alias = $alias;

        return $this;
    }

    /**
     * Get alias
     *
     * @return string
     */
    public function getAlias()
    {
        return $this->alias;
    }

    /**
     * Set company
     *
     * @param \Swo\CustomerBundle\Entity\Company $company
     *
     * @return Person
     */
    public function setCompany($company)
    {
        $this->company = $company;

        return $this;
    }

    /**
     * Get company
     *
     * @return \Swo\CustomerBundle\Entity\Company
     */
    public function getCompany()
    {
        return $this->company;
    }

    /**
     * Set salutation
     *
     * @param string $salutation
     *
     * @return Person
     */
    public function setSalutation($salutation)
    {
        $this->salutation = $salutation;

        return $this;
    }

    /**
     * Get salutation
     *
     * @return string
     */
    public function getSalutation()
    {
        return $this->salutation;
    }

    /**
     * Set firstName
     *
     * @param string $firstName
     *
     * @return Person
     */
    public function setFirstName($firstName)
    {
        $this->firstName = $firstName;

        return $this;
    }

    /**
     * Get firstName
     *
     * @return string
     */
    public function getFirstName()
    {
        return $this->firstName;
    }

    /**
     * Set lastName
     *
     * @param string $lastName
     *
     * @return Person
     */
    public function setLastName($lastName)
    {
        $this->lastName = $lastName;

        return $this;
    }

    /**
     * Get lastName
     *
     * @return string
     */
    public function getLastName()
    {
        return $this->lastName;
    }

    /**
     * Set fullName
     *
     * @param string $fullName
     *
     * @return Person
     */
    public function setFullName($fullName)
    {
        $this->fullName = $fullName;

        return $this;
    }

    /**
     * Get fullName
     *
     * @return string
     */
    public function getFullName()
    {
        return $this->fullName;
    }

    /**
     * @return mixed
     */
    public function getPhones()
    {
        return $this->phones;
    }

    /**
     * @param mixed $phones
     *
     * @return $this
     */
    public function setPhones($phones)
    {
        $this->phones = $phones;
        return $this;
    }
}
