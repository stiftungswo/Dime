<?php
namespace Dime\EmployeeBundle\Entity;

use DateTime;
use Dime\TimetrackerBundle\Model\RateUnitType;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use Sluggable\Fixture\Handler\User;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Dime\EmployeeBundle\Entity\Employee
 *
 * @ORM\Table(name="Employees")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\EmployeeRepository")
 * @Json\Schema("Employees")
 */
class Employee extends User implements DimeEntityInterface
{

    /**
     * @var datetime $workingHours
     * Calculatable
     */
    protected $workingHours;

    /**
     * @return DateTime
     */
    public function getWorkingHours()
    {
        return $this->workingHours;
    }

    /**
     * @return DateTime
     */
    public function getEndDate()
    {
        return $this->endDate;
    }

    /**
     * @param DateTime $endDate
     */
    public function setEndDate($endDate)
    {
        $this->endDate = $endDate;
    }

    /**
     * @return DateTime
     */
    public function getStartDate()
    {
        return $this->startDate;
    }

    /**
     * @param DateTime $startDate
     */
    public function setStartDate($startDate)
    {
        $this->startDate = $startDate;
    }

    /**
     * @return DateTime
     */
    public function getHolidays()
    {
        return $this->holidays;
    }

    /**
     * @param DateTime $holidays
     */
    public function setHolidays($holidays)
    {
        $this->holidays = $holidays;
    }

    /**
     * @var datetime $workingDays
     * Calculatable
     */
    protected $workingDays;

    /**
     * DateTime <> Timestap see
     * http://php.net/manual/de/function.time.php
     * and
     * http://php.net/manual/de/datetime.gettimestamp.php
     * @var datetime $time_stamp
     * Calculatable
     */
    protected $time_stamp;

    /**
     * @var datetime $holiday
     * I Suggest a separate Entity, with Holiday dates and a oneToMany Relation
     */
    protected $holiday;

    /**
     * @var datetime $no_remaining_days
     * Calculatable
     */
    protected $no_remaining_days;

    /**
     * @var datetime $last_day_of_week
     * Calculatable
     */
    protected $last_day_of_week;

    /**
     * @var datetime $last_day_of_week
     * Duplcate
     */
    //protected $last_day_of_week;

    /**
     * @var datetime $first_day_of_week
     * Calculatable
     */
    protected $first_day_of_week;

    /**
     * @var datetime $start
     */
    protected $start;

    /**
     * @var datetime $end
     */
    protected $end;

    /**
     * @var datetime $holidays
     * Duplcate
     */
    protected $holidays;

    /**
     * @var datetime $endDate
     * Duplicate
     */
    protected $endDate;

    /**
     * @var datetime $startDate
     * Duplicate
     */
    protected $startDate;

    /**
     * @var datetime $no_full_weeks
     * Calculatable
     */
    protected $no_full_weeks;

    /**
     * @var string $name
     *
     * @Assert\NotBlank()
     * @ORM\Column(type="string", length=255)
     */
    protected $name;

    /**
     * @var string $alias
     *
     * @Gedmo\Slug(fields={"name"})
     * @ORM\Column(type="string", length=30)
     */
    protected $alias;


    /**
     * Entity constructor
     */
    public function __construct()
    {
        $this->tags = new ArrayCollection();
        $this->activities = new ArrayCollection();
    }


    /**
     * Set name
     *
     * @param  string $name
     * @return Employee
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
     * Set alias
     *
     * @param  string $alias
     * @return Employee
     */
    public function setAlias($alias)
    {
        $this->alias = $alias;

        return $this;
    }

    /**
     * Get alias
     *
     * @return string
     */
    public function getAlias()
    {
        return $this->alias;
    }

    /**
     * get Employee as string
     *
     * @return string
     */
    public function __toString()
    {
        return (empty($this->name)) ? $this->getId() : $this->getName();
    }

    /**
     * @return ArrayCollection
     * Im Unsure if Employees should be linked to Activities
     * If So then It would only be unidirectinal and inside Activities
     * Maybe have a look at Entity Manager aware Entities and Lifecycle Events, to save the Hours worked as number in this eintity
     */
    public function getActivities()
    {
        return $this->activities;
    }


    public function ShowWorkingDays()
    {
        $start = "2015-01-31";
        $end = "2015-01-01";
        //Use $this-> to access functions inside class
        //use of uninitialized Variables.
        $this->getAllWorkingDays($start,$end,$holidays);
    }

    /**
     * Todo Document Algorythm Here as Plaintext.
     *
     * @param $startDate
     * @param $endDate
     * @param $holidays
     *
     * @return float|int
     */
	function getAllWorkingDays($startDate,$endDate,$holidays)
    {
        //Beware It is bestpractice to work with Types Objects in Symfony

        //Beware, that Workingdays have 8.4h and not 24h.

        //Also Have a look at https://github.com/briannesbitt/Carbon
        // It has many differnce getting and Calculation functions.
        $endDate = strtotime($endDate);
        $startDate = strtotime($startDate);

        //Totale anzahl an Tage zwischen zwei Daten. In Tage umgerechnet (/60*60*24)
        // +1 für beide Intervalle
        $days = ($endDate - $startDate) / 86400 + 1;

        //abrunden
        $no_full_weeks = floor($days / 7);

        //Fliesskommadivision
        $no_remaining_days = fmod($days, 7);

        //Rückgabe für den Tag. Montag = 1... Sonntag = 7
        $first_day_of_week = date("N", $startDate);
        $last_day_of_week = date("N", $endDate);

        //Be careful not to reinvant the wheel to much Date Claculation Brekas people.
        //Februar wechssel Jahr
        if ($first_day_of_week <= $last_day_of_week)
        {
            if ($first_day_of_week <= 6 && 6 <= $last_day_of_week) $no_remaining_days--;
            if ($first_day_of_week <= 7 && 7 <= $last_day_of_week) $no_remaining_days--;
        }
        else
        {
            // Starttag der Woche ist später als Endtag
            if ($first_day_of_week == 7)
            {
                // Wenn Starttag Sonnta, dann -1
                $no_remaining_days--;
                if ($last_day_of_week == 6)
                {
                    // wenn Endtag dann nochmals -1
                    $no_remaining_days--;
                }
            }
            else
            {
                // Starttag war Sonntag oder noch früher und Endtag war zwischen Montag-Freitag
                // Wochenende überspringen und -2 Tage
                $no_remaining_days -= 2;
            }
        }

        //Arbeitstage = (Anzahl Wochen zwischen 2 Daten) * (5 Arbeitstage) + Reminder
        $workingDays = $no_full_weeks * 5;
        if ($no_remaining_days > 0 )
        {
            $workingDays += $no_remaining_days;
        }

        //Ferien abziehen
        foreach($holidays as $holiday)
        {
            $time_stamp=strtotime($holiday);

            //Wenn Ferien nicht auf Wochenendtag fällt
            if ($startDate <= $time_stamp && $time_stamp <= $endDate && date("N",$time_stamp) != 6 && date("N",$time_stamp) != 7)
                $workingDays--;
        }
        $workingHours = $workingDays*8.4;

        return $workingHours;
    }

}