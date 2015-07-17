<?php
/**
 * Author: Till Wegmüller
 * Date: 6/29/15
 * Dime
 */

namespace Dime\TimetrackerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;

/**
 * Class RateUnitType
 * @package Dime\TimetrackerBundle\Entity
 *
 * @ORM\Table(name="rateunittypes")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\RateUnitTypeRepository")
 */
class RateUnitType extends Entity implements DimeEntityInterface
{

	/**
	 * @var string
	 * @JMS\Exclude()
	 */
	public static $Hourly = 'h';

	/**
	 * @var string
	 * @JMS\Exclude()
	 */
	public static $Minutely = 'm';

	/**
	 * @var string
	 * @JMS\Exclude()
	 */
	public static $Dayly = 't';

	/**
	 * @var string
	 * @JMS\Exclude()
	 */
	public static $NoChange = 'a';

	/**
	 * @var int
	 * @JMS\Exclude()
	 */
	private static $DayInSeconds = 30240;

	/**
	 * @var int
	 * @JMS\Exclude()
	 */
	private static $HourInSeconds = 3600;

	/**
	 * @var int
	 * @JMS\Exclude()
	 */
	private static $MinuteInSeconds = 60;

	/**
	 * @var string $id
	 *
	 * @ORM\Id
	 * @ORM\Column(name="id", type="string")
	 */
	protected $id;

	/**
	 * @var string
	 *
	 * @ORM\Column(type="string", nullable=true)
	 */
	protected $name;

	/**
	 * @var boolean
	 *
	 * @ORM\Column(type="boolean")
	 * @JMS\SerializedName("doTransform")
	 */
	protected $doTransform;

	/**
	 * @var double
	 *
	 * @ORM\Column(type="decimal", scale=3, precision=10, nullable=true)
	 */
	protected $factor;

	/**
	 * @var integer
	 * Scale of Decimals to round to.
	 *
	 * @ORM\Column(type="integer")
	 */
	protected $scale;

	/**
	 * @var integer
	 * PHP_ROUNDING_MODE
	 *
	 * @ORM\Column(type="integer")
	 * @JMS\SerializedName("roundMode")
	 */
	protected $roundMode;

	/**
	 * @var string
	 *
	 * @ORM\Column(type="string", nullable=true)
	 */
	protected $symbol;

	/**
	 * @param $value
	 *
	 * Returns a Human Readable Value based on factor, scale and Rounding Mode.
	 *
	 * @return float
	 */
	public function transform($value)
	{
		if($this->doTransform){
			switch($this->roundMode){
			case 1:
			case 2:
			case 3:
			case 4:
				return round(($value / $this->factor), $this->scale, $this->roundMode);
				break;
			case 5:
				//Math trick for Precision independant Flooring
				$pow = pow(10, $this->scale);
				return floor(($value / $this->factor) * $pow) / $pow;
				break;
			case 6:
				//Math trick for Precision indepandant Ceiling
				$pow = pow ( 10, $this->scale );
				$value = ($value / $this->factor);
				return ( ceil ( $pow * $value ) + ceil ( $pow * $value - ceil ( $pow * $value ) ) ) / $pow;
				break;
			case 7:
				//Math trick to round numbers to 5 or 0
				$pow   = pow(10, $this->scale);
				$value = ($value / $this->factor);
				$value = $value * $pow;
				$value = (int)round($value / 5) * 5;
				return $value / $pow;
				break;
			case 8:
				//Math trick to floor numbers to 5 or 0
				$pow   = pow(10, $this->scale);
				$value = ($value / $this->factor);
				$value = $value * $pow;
				$value = (int)floor($value / 5) * 5;
				return $value / $pow;
				break;
			default:
				return $value;
				break;
			}
		}
		return $value;
	}

	public static function transformToStandardUnit($value, $unit, $includeUnit = true, $scale = 3, $roundMode = PHP_ROUND_HALF_UP)
	{
		switch($unit) {
		case RateUnitType::$Hourly :
			$factor = RateUnitType::$HourInSeconds;
			break;
		case RateUnitType::$Minutely :
			$factor = RateUnitType::$MinuteInSeconds;
			break;
		case RateUnitType::$Dayly :
			$factor = RateUnitType::$DayInSeconds;
			break;
		default:
			$factor = 1;
			break;
		}
		$value = round(($value / $factor), $scale, $roundMode);
		if($includeUnit === true){
			$value .= $unit;
		}
		return $value;
	}

	/**
	 * @param $value
	 *
	 * Returns the non Human readable value of $value
	 *
	 * @return int
	 */
	public function reverseTransform($value)
	{
		if(is_string($value)){
			$format = substr($value, -1);
			$time = substr($value, 0, -1);
			$time = floatval(str_replace(',', '.', $time));
			switch($format){
			case 'h':
				$time = $time * RateUnitType::$HourInSeconds;
				break;
			case 'm':
				$time = $time * RateUnitType::$MinuteInSeconds;
				break;
			case 'd':
				$time = $time * RateUnitType::$DayInSeconds;
				break;
			case $this->getSymbol():
				$time = $time * $this->factor;
				break;
			default:
				$time = $value;
				break;
			}
			return intval($time);
		}
		return $value;
	}

	public function serializedOutput($value)
	{
		if($this->getSymbol() === 'a') {
			return $value;
		} else {
			return $value . $this->getSymbol();
		}
	}

	/**
	 * @return string
	 */
	public function getId()
	{
		return $this->id;
	}

	/**
	 * @param string $id
	 *
	 * @return $this
	 */
	public function setId($id)
	{
		$this->id = $id;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getName()
	{
		return $this->name;
	}

	/**
	 * @param string $name
	 *
	 * @return $this
	 */
	public function setName($name)
	{
		$this->name = $name;
		return $this;
	}

	/**
	 * @return boolean
	 */
	public function isDoTransform()
	{
		return $this->doTransform;
	}

	/**
	 * @param boolean $doTransform
	 *
	 * @return $this
	 */
	public function setDoTransform($doTransform)
	{
		$this->doTransform = $doTransform;
		return $this;
	}

	/**
	 * @return float
	 */
	public function getFactor()
	{
		return $this->factor;
	}

	/**
	 * @param float $factor
	 *
	 * @return $this
	 */
	public function setFactor($factor)
	{
		$this->factor = $factor;
		return $this;
	}

	/**
	 * @return int
	 */
	public function getScale()
	{
		return $this->scale;
	}

	/**
	 * @param int $scale
	 *
	 * @return $this
	 */
	public function setScale($scale)
	{
		$this->scale = $scale;
		return $this;
	}

	/**
	 * @return int
	 */
	public function getRoundMode()
	{
		return $this->roundMode;
	}

	/**
	 * @param int $roundMode
	 *
	 * @return $this
	 */
	public function setRoundMode($roundMode)
	{
		$this->roundMode = $roundMode;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getSymbol()
	{
		if(is_null($this->symbol)) {
			return $this->id;
		}
		return $this->symbol;
	}

	/**
	 * @param string $symbol
	 *
	 * @return $this
	 */
	public function setSymbol($symbol)
	{
		$this->symbol = $symbol;
		return $this;
	}


}