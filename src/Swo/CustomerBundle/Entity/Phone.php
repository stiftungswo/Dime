<?php

namespace Swo\CustomerBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Component\Validator\Context\ExecutionContextInterface;

/**
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\PhoneRepository")
 * @ORM\Table(name="phones")
 */

class Phone extends Entity implements DimeEntityInterface
{
    /**
     * phone number
     *
     * @var string|null $number
     * @ORM\Column(type="string", nullable=false)
     * @JMS\Groups({"List"})
     */
    protected $number;

    /**
     * category of the phone number (type is a reserved word in the dime frontend)
     *
     * @var int|null $category
     * @ORM\Column(type="integer", nullable=false)
     * @JMS\Groups({"List"})
     */
    protected $category;

    /**
     * related company
     *
     * @var Company|null
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", inversedBy="phoneNumbers")
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true)
     */
    protected $company;

    /**
     * related person
     * @var Person|null $person
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Person", inversedBy="phoneNumbers")
     * @ORM\JoinColumn(name="person_id", referencedColumnName="id", nullable=true)
     */
    protected $person;

    /**
     * @return string|null
     */
    public function getNumber()
    {
        return $this->number;
    }

    /**
     * @param string|null $number
     * @return Phone
     */
    public function setNumber(string $number) : Phone
    {
        $this->number = $number;
        return $this;
    }

    /**
     * @return integer|null
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * @param integer|null $category
     * @return Phone
     */
    public function setCategory($category) : Phone
    {
        $this->category = $category;
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
     * @return Person|null
     */
    public function getPerson()
    {
        return $this->person;
    }

    /**
     * @param Person|null $person
     * @return Phone
     */
    public function setPerson($person) : Phone
    {
        $this->person = $person;
        return $this;
    }

    /**
     * @param ExecutionContextInterface $context
     * @Assert\Callback
     */
    public function hasCompanyOrPerson(ExecutionContextInterface $context)
    {
        if (is_null($this->getPerson()) && is_null($this->getCompany())) {
            $context->buildViolation('Phone has to have either an associated company or phone.')
                ->atPath('company')
                ->addViolation();
        }

        if (!is_null($this->getPerson()) && !is_null($this->getCompany())) {
            $context->buildViolation('Phone has to have either an associated company or phone, but not both.')
                ->atPath('company')
                ->addViolation();
        }
    }
}
