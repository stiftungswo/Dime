<?php

namespace Dime\TimetrackerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;

trait ArchivableTrait
{

    /**
     * @var boolean $archived
     * @JMS\Groups({"List"})
     * @ORM\Column(type="boolean")
     */
    protected $archived = false;

    /**
     * @return boolean
     */
    public function isArchived()
    {
        return $this->archived;
    }

    /**
     * @param boolean $archived
     *
     * @return $this
     */
    public function setArchived($archived)
    {
        if ($archived !== 'empty') {
            $this->archived = $archived;
        }

        return $this;
    }

    /**
     * Get archived
     *
     * @return boolean
     */
    public function getArchived()
    {
        return $this->archived;
    }
}
