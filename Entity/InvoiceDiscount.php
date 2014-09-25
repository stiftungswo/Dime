<?php
/**
 * Author: Till Wegmüller
 * Date: 9/25/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;


class InvoiceDiscount
{
	protected $name;
	protected $value;
	protected $percentage;
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