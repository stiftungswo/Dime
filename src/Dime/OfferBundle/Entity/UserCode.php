<?php
namespace Dime\OfferBundle\Entity;

use Dime\TimetrackerBundle\Entity\Entity;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;

/**
 *
 */
abstract class UserCode extends Entity
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
