<?php
/**
 * Author: Till Wegmüller
 * Date: 9/25/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Class Discount
 * @package Dime\InvoiceBundle\Entity
 * @ORM\Entity()
 * @ORM\Table(name="discounts")
 */
class Discount
{
	/**
	 * @var
	 * @ORM\Id()
	 * @ORM\Column(type="integer", name="id")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	protected $id;
	/**
	 * @var
	 * @ORM\Column(type="string")
	 */
	protected $name;

	/**
	 * @var
	 * @ORM\Column(type="decimal", precision=10, scale=2)
	 */
	protected $value;

	/**
	 * @var
	 * @ORM\Column(type="boolean", nullable=true)
	 */
	protected $percentage;

	/**
	 * @var
	 * @ORM\Column(type="boolean", nullable=true)
	 */
	protected $minus;

	/**
	 * @return mixed
	 */
	public function getName()
	{
		return $this->name;
	}

	/**
	 * @param mixed $name
	 *
	 * @return $this
	 */
	public function setName($name)
	{
		$this->name = $name;
		return $this;
	}


	/**
	 * @return mixed
	 */
	public function getMinus()
	{
		return $this->minus;
	}

	/**
	 * @param mixed $minus
	 *
	 * @return $this
	 */
	public function setMinus($minus)
	{
		$this->minus = $minus;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getPercentage()
	{
		return $this->percentage;
	}

	/**
	 * @param mixed $percentage
	 *
	 * @return $this
	 */
	public function setPercentage($percentage)
	{
		$this->percentage = $percentage;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getValue()
	{
		return $this->value;
	}

	/**
	 * @param mixed $value
	 *
	 * @return $this
	 */
	public function setValue($value)
	{
		$this->value = $value;
		return $this;
	}

	/**
	 * Returns the Positive or negative integer Value of which shall be subtracted of gross.
	 *
	 * @param $gross
	 *
	 * @return float|int $amount
	 */
	public function getModifier($gross)
	{
		$amount = $this->value;
		if ($this->percentage)
		{
			$amount = $this->percentofgross($gross, $this->value, 10);
		}
		if($this->minus)
		{
			$amount = floatval('-'.$amount);
		}
		return $amount;
	}

	private function percentofgross($gross, $percent, $precision)
	{
		$res = round( ($percent/100) * $gross, $precision );

		return $res;
	}
} 