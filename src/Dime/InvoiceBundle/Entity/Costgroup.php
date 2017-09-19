<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;

use Carbon\Carbon;
use DateTime;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class Invoice
 * @package Dime\InvoiceBundle\Entity
 *
 * @Json\Schema("costgroups")
 * @ORM\Table(name="costgroups")
 * @ORM\Entity(repositoryClass="Dime\InvoiceBundle\Entity\CostgroupRepository")
 */
class Costgroup extends Entity implements DimeEntityInterface
{
	/**
	 * @var string $number
	 *
	 * @ORM\Column(type="integer", nullable=true)
	 */
	protected $number;

	/**
	 * @var string $description
	 *
	 * @ORM\Column(type="string", length=255, nullable=true)
	 */
	protected $description;

	/**
	 * @return integer
	 */
	public function getNumber()
	{
		return $this->number;
	}

	/**
	 * @param integer $number
	 *
	 * @return $this
 	*/
	public function setNumber($number)
	{
		$this->number = $number;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getDescription()
	{
		return $this->description;
	}

	/**
	 * @param string $description
	 *
	 * @return $this
	 */
	public function setDescription($description)
	{
		$this->description = $description;
		return $this;
	}
}
