<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Dime\TimetrackerBundle\Entity\SettingAssignProject
 *
 * @ORM\Table(name="setting_assign_projects")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\SettingAssignProjectRepository")
 * @Json\Schema("settingassignprojects")
 */
class SettingAssignProject extends Entity implements DimeEntityInterface
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

    /**
     * @var Project $project
     *
     * @JMS\MaxDepth(1)
     * @JMS\Groups({"List"})
     * @ORM\ManyToOne(targetEntity="Project", inversedBy="activities")
     * @ORM\JoinColumn(name="project_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $project;

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

    /**
     * Set project
     *
     * @param  Project $project
     * @return Activity
     */
    public function setProject($project)
    {
        $this->project = $project;
        return $this;
    }

    /**
     * Get project
     *
     * @return Project
     */
    public function getProject()
    {
        return $this->project;
    }
}