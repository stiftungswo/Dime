<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Swo\CommonsBundle\Model\DimeEntityInterface;
use Symfony\Component\Validator\Constraints as Assert;
use Gedmo\Mapping\Annotation as Gedmo;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Company
 *
 * @ORM\Table(name="companies")
 * @ORM\Entity(repositoryClass="Swo\CustomerBundle\Entity\CompanyRepository")
 * @Json\Schema("companies")
 */
class Company extends AbstractCustomer implements DimeEntityInterface
{
    /**
     * @var string $alias
     *
     * @Gedmo\Slug(fields={"name"})
     * @ORM\Column(type="string", length=30)
     */
    private $alias;

    /**
     * @var string $name
     *
     * @JMS\Groups({"List"})
     * @Assert\NotBlank()
     * @ORM\Column(name="name", type="string", length=255)
     */
    private $name;

    /**
     * @var string $department
     *
     * @ORM\Column(name="department", type="string", length=60, nullable=true)
     */
    private $department;

    /**
     * Set alias
     *
     * @param  string $alias
     * @return Company
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
