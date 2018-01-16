<?php

namespace Dime\TimetrackerBundle\Entity;

use DateTime;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class ProjectComment
 * @package Dime\TimetrackerBundle\Entity
 *
 * @ORM\Table(name="project_comments")
 * @ORM\Entity
 * @Json\Schema("project_comments")
 */
class ProjectComment extends Entity implements DimeEntityInterface
{

    use SoftDeleteTrait;

    /**
     * @var Project
     * @ORM\ManyToOne(targetEntity="Project", inversedBy="comments")
     * @ORM\JoinColumn(name="project_id", referencedColumnName="id", nullable=false)
     */
    protected $project;

    /**
     * @var string
     * @ORM\Column(type="text", nullable=false)
     */
    protected $comment;

    /**
     * @var DateTime
     * @Assert\DateTime()
     * @ORM\Column(name="date", type="datetime", nullable=false)
     */
    protected $date;

    /**
     * @return string
     */
    public function getComment()
    {
        return $this->comment;
    }

    /**
     * @param string $comment
     *
     * @return ProjectComment
     */
    public function setComment($comment)
    {
        $this->comment = $comment;

        return $this;
    }

    /**
     * @return DateTime
     */
    public function getDate()
    {
        return $this->date;
    }

    /**
     * @param DateTime $date
     *
     * @return ProjectComment
     */
    public function setDate($date)
    {
        $this->date = $date;

        return $this;
    }
}
