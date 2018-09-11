<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Swo\Commonsbundle\Entity\AbstractEntity;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Dime\TimetrackerBundle\Entity\ProjectCategory
 *
 * @ORM\Table(name="project_categories")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\ProjectCategoryRepository")
 * @Json\Schema("projectcategories")
 */
class ProjectCategory extends AbstractEntity implements DimeEntityInterface
{

    /**
     * @var string $name
     * @ORM\Column(type="string", nullable=false)
     */
    protected $name;

    /**
     * @ORM\Id
     * @var integer $id
     * @ORM\Column(name="id", type="integer", nullable=false)
     * @ORM\GeneratedValue(strategy="IDENTITY")
     *
     */
    protected $id;

    protected $user;

    /**
     * Set $name
     *
     * @param  string $name
     * @return ProjectCategory
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get $name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set $id
     *
     * @param  integer $id
     * @return ProjectCategory
     */
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get $id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }
}
