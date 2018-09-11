<?php
namespace Dime\OfferBundle\Entity;

use Swo\CommonsBundle\Entity\AbstractEntity;
use Doctrine\ORM\Mapping as ORM;

/**
 *
 */
abstract class UserCode extends AbstractEntity
{
    /**
     * @ORM\Column(name="text", type="string", length=255)
     */
    protected $text;

    /**
     * @ORM\Column(name="active", type="boolean")
     */
    protected $active;
}
