<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Component\Validator\Context\ExecutionContextInterface;

/**
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\PersonRepository")
 * @ORM\Table(name="persons")
 * @Json\Schema("persons")
 */

class Person extends Customer implements DimeEntityInterface
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
     * @var string|null $department
     * @ORM\Column(name="department", type="string", nullable=true)
     */
    protected $department;

    /**
     * @var Company|null $company
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", inversedBy="persons", cascade={"detach"})
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true)
     * @JMS\Groups({"List"})
     * @JMS\MaxDepth(1)
     */
    protected $company;

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
        $this->commonName = $firstName . ' ' . $this->getLastName();
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
        $this->commonName = $this->getFirstName() . ' ' . $lastName;
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
     * @return bool|null
     */
    public function getChargeable()
    {
        if (is_null($this->getCompany())) {
            return $this->chargeable;
        } else {
            return $this->getCompany()->getChargeable();
        }
    }

    /**
     * @return bool|null
     */
    public function getHideForBusiness()
    {
        if (is_null($this->getCompany())) {
            return $this->hideForBusiness;
        } else {
            return $this->getCompany()->getHideForBusiness();
        }
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
     * @return Person
     */
    public function setDepartment($department): Person
    {
        $this->department = $department;
        return $this;
    }

    /**
     * @param ExecutionContextInterface $context
     * @Assert\Callback
     */
    public function checkFieldsIfNoCompany(ExecutionContextInterface $context)
    {
        if (is_null($this->getCompany())) {
            if (is_null($this->getRateGroup())) {
                $context->buildViolation('Person needs a Rate Group if no company is assigned.')
                    ->atPath('rateGroup')
                    ->addViolation();
            }

            if (is_null($this->getChargeable())) {
                $context->buildViolation('Person needs a chargeable attribute if no company is assigned.')
                    ->atPath('chargeable')
                    ->addViolation();
            }

            if (is_null($this->getChargeable())) {
                $context->buildViolation('Person needs a hideForBusiness attribute if no company is assigned.')
                    ->atPath('hideForBusiness')
                    ->addViolation();
            }
        }
    }
}
