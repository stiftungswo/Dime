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
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return Employee
     */
    public function setCreatedAt($createdAt)
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    /**
     * Set updatedAt
     *
     * @param \DateTime $updatedAt
     *
     * @return Employee
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getActivities()
    {
        return $this->activities;
    }


    public function ShowWorkingDays()
    {
        $start = "2015-01-31";
        $end = "2015-01-01";
        $Marray="2015-01-01,2015-01-02";
        $holidays = explode(",",['Marray']);
        getAllWorkingDays($start,$end,$holidays);
    }

	function getAllWorkingDays($startDate,$endDate,$holidays)
    {
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