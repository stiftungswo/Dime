<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\ActivityReference;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Dime\TimetrackerBundle\Entity\RateGroup
 *
 * @ORM\Table(name="rate_groups")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\RateGroupRepository")
 */
class RateGroup extends Entity implements DimeEntityInterface
{
	
	public static $DEFAULT = 1;
	
	/**
	 * @var string $description
	 *
	 * @ORM\Column(type="text", nullable=true)
	 */
	protected $description;
	
	/**
	 * @var string $description
	 *
	 * @ORM\Column(type="string", length=255, nullable=false)
	 */
	protected $name;
	

    /**
     * Set description
     *
     * @param string $description
     *
     * @return RateGroup
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set name
     *
     * @param string $name
     *
     * @return RateGroup
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
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return RateGroup
     */
    public function setCreatedAt($createdAt)
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    /**
     * Set updatedAt
     *
     * @param \DateTime $updatedAt
     *
     * @return RateGroup
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }
}
