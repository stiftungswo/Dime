<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Misd\PhoneNumberBundle\Validator\Constraints\PhoneNumber as AssertPhoneNumber;
use Swo\CommonsBundle\Entity\AbstractEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="phone")
\*/
class Phone extends AbstractEntity
{
    /**
     * @var \Swo\CustomerBundle\Entity\Company $company
     * @ORM\ManyToOne(targetEntity="Swo\CustomerBundle\Entity\Company", cascade={"all"})
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    private $company;

    /**
     * Phone Number
     * @var String $number
     *
     * @AssertPhoneNumber(defaultRegion="CH")
     * @ORM\Column(name="phone_number")
     */
    private $number;

    /**
     * If its mobile or private or work phone
     * @var String
     *
     * @ORM\Column(type="string")
     */
    private $type;

    /**
     * @var bool hydrate results to doctrine objects
     */
    public $hydrateObjects = true;

    public function __toString()
    {
        return strval($this->number);
    }

    /**
     * Set company
     *
     * @param \Swo\CustomerBundle\Entity\Company $company
     *
     * @return Phone
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
     * Set number
     *
     * @param integer $number
     * @return Phone
     */
    public function setNumber($number)
    {
        $this->number = $number;
        return $this;
    }

    /**
     * Get number
     *
     * @return integer
     */
    public function getNumber()
    {
        return $this->number;
    }

    /**
     * Set type
     *
     * @param string $type
     * @return Phone
     */
    public function setType($type)
    {
        $this->type = $type;
        return $this;
    }

    /**
     * Get type
     *
     * @return string
     */
    public function getType()
    {
        return $this->type;
    }
}
