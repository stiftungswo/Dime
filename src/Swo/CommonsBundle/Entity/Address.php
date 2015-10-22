<?php
namespace Swo\CommonsBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
/**
 * @ORM\Entity
 * @ORM\Table(name="address")
\*/
Class Address
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	protected $id;

	/**
	 * The Streetname
	 *
	 * @JMS\Groups({"List"})
	 * @ORM\Column(type="string", nullable=true)
	 */
	protected $street;

	/**
	 * The Streetnumber
	 * @var String
	 *
	 * @JMS\Groups({"List"})
	 * @ORM\Column(type="string", nullable=true)
	 */
	protected $streetnumber;

	/**
	 * The City or Town
	 *
	 * @JMS\Groups({"List"})
	 * @ORM\Column(type="string", nullable=true)
	 */
	protected $city;

	/**
	 * @var String
	 *
	 * @JMS\Groups({"List"})
	 * @ORM\Column(type="integer", nullable=true)
	 */
	protected $plz;

	/**
	 * The State or Kanton or Bundesland...
	 *
	 * @ORM\Column(type="string", nullable=true)
	 */
	protected $state;

	/**
	 * The Country
	 *
	 * @ORM\Column(type="string", nullable=true)
	 */
	protected $country;

	/**
	 * @return mixed
	 */
	public function getStreet()
	{
		return $this->street;
	}

	/**
	 * @param mixed $street
	 *
	 * @return $this
	 */
	public function setStreet($street)
	{
		$this->street = $street;
		return $this;
	}

	/**
	 * @return String
	 */
	public function getStreetnumber()
	{
		return $this->streetnumber;
	}

	/**
	 * @param String $streetnumber
	 *
	 * @return $this
	 */
	public function setStreetnumber($streetnumber)
	{
		$this->streetnumber = $streetnumber;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getCity()
	{
		return $this->city;
	}

	/**
	 * @param mixed $city
	 *
	 * @return $this
	 */
	public function setCity($city)
	{
		$this->city = $city;
		return $this;
	}

	/**
	 * @return String
	 */
	public function getPlz()
	{
		return $this->plz;
	}

	/**
	 * @param String $plz
	 *
	 * @return $this
	 */
	public function setPlz($plz)
	{
		$this->plz = $plz;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getState()
	{
		return $this->state;
	}

	/**
	 * @param mixed $state
	 *
	 * @return $this
	 */
	public function setState($state)
	{
		$this->state = $state;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getCountry()
	{
		return $this->country;
	}

	/**
	 * @param mixed $country
	 *
	 * @return $this
	 */
	public function setCountry($country)
	{
		$this->country = $country;
		return $this;
	}

	public function __toString()
	{
		if(!empty($this->state)) {
			return $this->getStreet() . ' ' . $this->getStreetnumber() . ' - ' . $this->getCity()->getPlz() . ' ' . $this->getCity() . ' - ' . $this->getState() . ' ' . $this->getCountry();
		} else {
			return $this->getStreet() . ' ' . $this->getStreetnumber() . ' - ' . $this->getCity()->getPlz() . ' ' . $this->getCity();
		}
	}

	public function __clone()
	{
		unset($this->id);
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
}