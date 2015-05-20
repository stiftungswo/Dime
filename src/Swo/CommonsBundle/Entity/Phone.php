<?php

namespace Swo\CommonsBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Misd\PhoneNumberBundle\Validator\Constraints\PhoneNumber as AssertPhoneNumber;
use Symfony\Component\Validator\Constraints as Assert;


/**
 * @ORM\Entity
 * @ORM\Table(name="phone")
\*/
class Phone
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	\*/
	protected $id;

	/**
	 * Phone Number
	 * @var Integer
	 *
	 * @AssertPhoneNumber(defaultRegion="CH")
	 * @ORM\Column(type="phone_number")
	 * @JMS\SerializedName("Number")
	 */
	protected $number;

	/**
	 * If its mobile or private or work phone
	 * @var String
	 *
	 * @ORM\Column(type="string")
	 * @JMS\SerializedName("Type")
	 */
	protected $type;

	/**
	 * @var bool hydrate results to doctrine objects
	 */
	public $hydrateObjects = true;

	public function __toString()
	{
		return strval($this->number);
	}

	/**
	 * Get id
	 *
	 * @return integer
	 */
	public function getId()
	{
		return $this->id;
	}

	/**
	 * Set number
	 *
	 * @param integer $number
	 * @return Phone
	 */
	public function setNumber($number)
	{
		$this->number = $number;
		return $this;
	}

	/**
	 * Get number
	 *
	 * @return integer
	 */
	public function getNumber()
	{
		return $this->number;
	}

	/**
	 * Set type
	 *
	 * @param string $type
	 * @return Phone
	 */
	public function setType($type)
	{
		$this->type = $type;
		return $this;
	}

	/**
	 * Get type
	 *
	 * @return string
	 */
	public function getType()
	{
		return $this->type;
	}
}