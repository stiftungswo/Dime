<?php
/**
 * Author: Till Wegmüller
 * Date: 5/29/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;

use Carbon\Carbon;
use Swo\CommonsBundle\Entity\AbstractEntity;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Swo\CommonsBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;

/**
 * Class Holiday
 * @package Dime\EmployeeBundle\Entity
 * @ORM\Table("holidays")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\HolidayRepository")
 */
class Holiday extends AbstractEntity implements DimeEntityInterface
{

    /**
     * @var Carbon
     * @ORM\Column(type="date", nullable=true)
     */
    protected $date;

    /**
     * @var int
     * Duration in Seconds
     * @JMS\Exclude()
     * @ORM\Column(type="integer", nullable=true)
     */
    protected $duration;

    /**
     * @return Carbon
     */
    public function getDate()
    {
        if (is_null($this->date)) {
            return null;
        }
        return Carbon::instance($this->date);
    }

    /**
     * @param Carbon $date
     *
     * @return $this
     */
    public function setDate($date)
    {
        $this->date = $date;
        return $this;
    }

    /**
     * @return int
     */
    public function getDuration()
    {
        return $this->duration;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("duration")
     */
    public function serializeDuration()
    {
        return RateUnitType::transformBetweenTimeUnits($this->getDuration(), RateUnitType::$Secondly, RateUnitType::$Hourly, true, 1);
    }

    /**
     * @param int $duration
     *
     * @return $this
     */
    public function setDuration($duration)
    {
        $rateunit = new RateUnitType();
        $this->duration = $rateunit->reverseTransform($duration);
        return $this;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("weekday")
     */
    public function getWeekday()
    {
        setlocale(LC_TIME, "de_DE");
        if ($this->date != null) {
            return strftime("%A", $this->date->getTimestamp());
        } else {
            return "";
        }
    }
}
