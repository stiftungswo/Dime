<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Company
 *
 * @ORM\Table(name="company")
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\CompanyRepository")
 */
class Company extends AbstractCustomer
{
    /**
     * @var string $name
     *
     * @JMS\Groups({"List"})
     * @Assert\NotBlank()
     * @ORM\Column(name="name", type="string", length=255)
     */
    private $name;

    /**
     * @Gedmo\Slug(fields={"name"})
     */
    private $alias;

    /**
     * @var string $department
     *
     * @ORM\Column(name="department", type="string", length=60, nullable=true)
     */
    private $department;

    /**
     * Set name
     *
     * @param string $name
     *
     * @return Company
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set department
     *
     * @param string $department
     *
     * @return Company
     */
    public function setDepartment($department)
    {
        $this->department = $department;

        return $this;
    }

    /**
     * Get department
     *
     * @return string
     */
    public function getDepartment()
    {
        return $this->department;
    }
}

