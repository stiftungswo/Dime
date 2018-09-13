<?php
namespace Dime\OfferBundle\Entity;

use Swo\CommonsBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Dime\OfferBundle\Entity\OfferStatusUC
 *
 * @ORM\Table(name="offer_status_uc")
 * @ORM\Entity(repositoryClass="Dime\OfferBundle\Entity\OfferStatusUCRepository")
 */
class OfferStatusUC extends UserCode implements DimeEntityInterface
{



    /**
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return OfferStatusUC
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
     * @return OfferStatusUC
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * Set text
     *
     * @param string $text
     *
     * @return OfferStatusUC
     */
    public function setText($text)
    {
        $this->text = $text;

        return $this;
    }

    /**
     * Get text
     *
     * @return string
     */
    public function getText()
    {
        return $this->text;
    }

    /**
     * Set active
     *
     * @param boolean $active
     *
     * @return OfferStatusUC
     */
    public function setActive($active)
    {
        $this->active = $active;

        return $this;
    }

    /**
     * Get active
     *
     * @return boolean
     */
    public function getActive()
    {
        return $this->active;
    }
}
