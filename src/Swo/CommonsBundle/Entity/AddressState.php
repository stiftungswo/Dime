<?php
namespace Swo\CommonsBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
/**
 * @ORM\Entity
 * @ORM\Table(name="address_state")
\*/
Class AddressState
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	protected $id;
	/**
	 * The Cityname
	 * @var String
	 *
	 * @ORM\Column(type="string")
	 */
	protected $name;
	/**
	 * The International Shortcode of the State
	 * @var String
	 *
	 * @ORM\Column(type="string")
	 */
	protected $shortcode;
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
	 * Set name
	 *
	 * @param string $name
	 * @return AddressState
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
	 * Set shortcode
	 *
	 * @param string $shortcode
	 * @return AddressState
	 */
	public function setShortcode($shortcode)
	{
		$this->shortcode = $shortcode;
		return $this;
	}
	/**
	 * Get shortcode
	 *
	 * @return string
	 */
	public function getShortcode()
	{
		return $this->shortcode;
	}
	public function __toString()
	{
		return $this->name;
	}
}