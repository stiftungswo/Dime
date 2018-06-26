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
    public static $ZiviDayly = 'zt';

    /**
     * @var string
     * @JMS\Exclude()
     */
    public static $Secondly = 's';


    /**
     * @var string
     * @JMS\Exclude()
     */
    public static $NoChange = 'a';

    /**
     * @var int
     * @JMS\Exclude()
     */
    public static $DayInSeconds = 30240;

    /**
     * @var int
     * @JMS\Exclude()
     */
    public static $HourInSeconds = 3600;

    /**
     * @var int
     * @JMS\Exclude()
     */
    public static $MinuteInSeconds = 60;

    /**
     * @var string $id
     *
     * @ORM\Id
     * @ORM\Column(name="id", type="string")
     * @JMS\Groups({"List"})
     */
    protected $id;

    /**
     * @var string
     *
     * @ORM\Column(type="string", nullable=true)
     * @JMS\Groups({"List"})
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
        if ($this->doTransform) {
            switch ($this->roundMode) {
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
                    $pow = pow(10, $this->scale);
                    $value = ($value / $this->factor);
                    return (ceil($pow * $value) + ceil($pow * $value - ceil($pow * $value))) / $pow;
                    break;
                case 7:
                    //Math trick to round numbers to 5 or 0
                    $pow = pow(10, $this->scale);
                    $value = ($value / $this->factor);
                    $value = $value * $pow;
                    $value = (int)round($value / 5) * 5;
                    return $value / $pow;
                    break;
                case 8:
                    //Math trick to floor numbers to 5 or 0
                    $pow = pow(10, $this->scale);
                    $value = ($value / $this->factor);
                    $value = $value * $pow;
                    $value = (int)floor($value / 5) * 5;
                    return $value / $pow;
                    break;
                case 9:
                    //Math trick to ceil numbers to 5 or 0
                    $pow = pow(10, $this->scale);
                    $value = ($value / $this->factor);
                    $value = $value * $pow;
                    $value = (int)ceil($value / 5) * 5;
                    return $value / $pow;
                    break;
                default:
                    return $value;
            }
        }

        // convert to float because MySQL's DECIMAL is read as string
        return floatval($value);
    }

    public static function transformBetweenTimeUnits($value, $old_unit, $new_unit, $includeUnit = true, $scale = 3, $roundMode = PHP_ROUND_HALF_UP)
    {
        switch ($old_unit) {
            case RateUnitType::$Hourly:
                $factor = RateUnitType::$HourInSeconds;
                break;
            case RateUnitType::$Minutely:
                $factor = RateUnitType::$MinuteInSeconds;
                break;
            case RateUnitType::$Dayly:
            case RateUnitType::$ZiviDayly:
                $factor = RateUnitType::$DayInSeconds;
                break;
            default:
                $factor = 1;
                break;
        }
        switch ($new_unit) {
            case RateUnitType::$Hourly:
                $factor /= RateUnitType::$HourInSeconds;
                break;
            case RateUnitType::$Minutely:
                $factor /= RateUnitType::$MinuteInSeconds;
                break;
            case RateUnitType::$Dayly:
            case RateUnitType::$ZiviDayly:
                $factor /= RateUnitType::$DayInSeconds;
                break;
            default:
                break;
        }
        $value = round(((float) $value * $factor), $scale, $roundMode);
        if ($includeUnit === true) {
            $value .= $new_unit;
        }
        return $value;
    }

    /**
     * @param $value
     *
     * Returns the non Human readable value of $value
     * If there is any suffix (e.g d, h, m, zt, etc.) the value is transformed to seconds,
     * otherwise it is returned as a float
     *
     * @return int
     */
    public function reverseTransform($value)
    {
        if (!is_numeric($value)) {
            $value = trim($value);

            // get suffix
            preg_match('/([a-zA-Z]*)$/', $value, $format);
            $format = strtolower(reset($format));

            // get time without suffix
            if (strlen($format) > 0) {
                $time = substr($value, 0, -strlen($format));
            } else {
                $time = $value;
            }
            $time = str_replace(',', '.', $time);
            $time = floatval($time);

            // transform to seconds
            switch ($format) {
                case RateUnitType::$Hourly:
                    $time = $time * RateUnitType::$HourInSeconds;
                    break;
                case RateUnitType::$Minutely:
                    $time = $time * RateUnitType::$MinuteInSeconds;
                    break;
                case RateUnitType::$Dayly:
                case RateUnitType::$ZiviDayly:
                    $time = $time * RateUnitType::$DayInSeconds;
                    break;
                case strtolower($this->getSymbol()):
                    $time = $time * $this->factor;
                    break;
                default:
                    // do not transform
                    return $time;
                    break;
            }
            return intval($time);
        }
        return floatval($value);
    }

    public function serializedOutput($value)
    {
        if ($this->getSymbol() === 'a') {
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
        if (is_null($this->symbol)) {
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
