<?php

namespace Dime\TimetrackerBundle\Entity;

use Carbon\Carbon;
use DateTime;
use Dime\EmployeeBundle\Entity\Employee;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Dime\TimetrackerBundle\Entity\Timeslice
 *
 * @ORM\Table(name="timeslices")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\TimesliceRepository")
 * @ORM\HasLifecycleCallbacks()
 * @Json\Schema("timeslices")
 * @Gedmo\SoftDeleteable(fieldName="deletedAt", timeAware=false)
 */
class Timeslice extends Entity implements DimeEntityInterface
{
    /**
     * Hook SoftDeleteable fields
     */
    use SoftDeleteTrait;

    /**
     * @var Activity $activity
     *
     * @Assert\NotNull()
     * @JMS\MaxDepth(2)
     * @JMS\Groups({"List"})
     * @ORM\ManyToOne(targetEntity="Activity", inversedBy="timeslices", cascade="persist")
     * @ORM\JoinColumn(name="activity_id", referencedColumnName="id", nullable=false, onDelete="CASCADE")
     */
    protected $activity;

    /**
     * @var ArrayCollection $tags
     *
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     * @JMS\SerializedName("tags")
     * @ORM\ManyToMany(targetEntity="Tag", cascade="persist")
     * @ORM\JoinTable(name="timeslice_tags")
     */
    protected $tags;

    /**
     * @var integer $value (in seconds)
     * @JMS\Exclude()
     * @ORM\Column(type="decimal", scale=4, precision=10, nullable=false)
     */
    protected $value = 0;

    /**
     * @var datetime $startedAt
     * @JMS\Exclude()
     * @Assert\DateTime()
     * @ORM\Column(name="started_at", type="datetime", nullable=true)
     */
    protected $startedAt;

    /**
     * Set this Property to overwrite the Unit Convrsion.
     * @var string
     * @JMS\Exclude()
     */
    protected $standardUnit;

    /**
     * @var Employee $employee
     *
     * @JMS\Groups({"List"})
     * @JMS\MaxDepth(1)
     * @JMS\Groups({"List"})
     * @ORM\ManyToOne(targetEntity="Dime\EmployeeBundle\Entity\Employee")
     * @ORM\JoinColumn(name="employee_id", referencedColumnName="id", onDelete="SET NULL")
     */
    protected $employee;

    /**
     * @param string $standardUnit
     *
     * @return $this
     */
    public function setStandardUnit($standardUnit)
    {
        $this->standardUnit = $standardUnit;
        return $this;
    }


    /**
     * Entity constructor
     */
    public function __construct()
    {
        $this->tags = new ArrayCollection();
    }

    /**
     * Set activity
     *
     * @param  Activity $activity
     * @return Timeslice
     */
    public function setActivity(Activity $activity)
    {
        $this->activity = $activity;

        return $this;
    }

    /**
     * Get activity
     *
     * @return Activity
     */
    public function getActivity()
    {
        return $this->activity;
    }

    /**
     * Set value
     *
     * @param  integer $value
     *
     * @return Timeslice
     */
    public function setValue($value)
    {
        if (is_callable(array($this->activity, 'getRateUnitType'))) {
            $this->value = $this->getActivity()->getRateUnitType()->reverseTransform($value);
        } else {
            $this->value = $value;
        }

        return $this;
    }

    /**
     * Get value in seconds
     *
     * @return int
     */
    public function getValue()
    {
        return $this->value;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("value")
     * @JMS\Groups({"List"})
     * @param bool $withUnits
     *
     * @return float|int|string
     */
    public function serializeValue($withUnits = true)
    {
        if (!is_null($this->standardUnit)) {
            return RateUnitType::transformBetweenTimeUnits($this->getValue(), RateUnitType::$Secondly, $this->standardUnit);
        }
        if (is_callable(array($this->activity, 'getRateUnitType')) && $this->getActivity()->getRateUnitType() instanceof RateUnitType) {
            $value = $this->getActivity()->getRateUnitType()->transform($this->getValue());
            if ($withUnits) {
                $value = $this->getActivity()->getRateUnitType()->serializedOutput($value);
            }
            return $value;
        } else {
            return $this->getValue();
        }
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("project")
     * @JMS\MaxDepth(1)
     */
    public function getProject()
    {
        if (is_callable(array($this->activity, 'getProject'))) {
            return $this->getActivity()->getProject();
        }
        return null;
    }

    /**
     * Set started_at
     *
     * @param  null|string|\DateTime|Carbon $startedAt
     * @return Timeslice
     */
    public function setStartedAt($startedAt)
    {
        if ($startedAt === null) {
            $this->startedAt = null;
            return $this;
        }
        if (!$startedAt instanceof DateTime && !empty($startedAt)) {
            $startedAt = new Carbon($startedAt);
        } elseif (!$startedAt instanceof Carbon && $startedAt instanceof DateTime) {
            $startedAt = Carbon::instance($startedAt);
        }
        if ($startedAt->hour === 0) {
            $startedAt->hour = 8;
        }
        $this->startedAt = $startedAt;

        return $this;
    }

    /**
     * Get started_at
     *
     * @return Carbon
     */
    public function getStartedAt()
    {
        if (is_null($this->startedAt)) {
            return null;
        }
        return Carbon::instance($this->startedAt);
    }

    /**
     *
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("startedAt")
     * @JMS\Groups({"List"})
     *
     * @return null|string
     */
    public function getStartedAtSerialized()
    {
        if (is_null($this->startedAt)) {
            return null;
        }
        return Carbon::instance($this->startedAt)->toDateTimeString();
    }

    /**
     * Get stopped_at
     *
     * @return Carbon
     */
    public function getStoppedAt()
    {
        if (is_null($this->getStartedAt())) {
            return null;
        }
        return $this->getStartedAt()->addSeconds($this->value);
    }

    /**
     *
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("stoppedAt")
     * @JMS\Groups({"List"})
     *
     * @return null|string
     */
    public function getStoppedAtSerialized()
    {
        if (is_null($this->getStoppedAt())) {
            return null;
        }
        return $this->getStoppedAt()->toDateTimeString();
    }

    /**
     * Add tag
     *
     * @param  Tag $tag
     * @return Timeslice
     */
    public function addTag(Tag $tag)
    {
        $this->tags[] = $tag;

        return $this;
    }

    /**
     * Remove tags
     *
     * @param Tag $tags
     * @return Timeslice
     */
    public function removeTag(Tag $tags)
    {
        $this->tags->removeElement($tags);

        return $this;
    }

    /**
     * Get tags
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getTags()
    {
        return $this->tags;
    }

    /**
     * Set tags
     *
     * @param \Doctrine\Common\Collections\ArrayCollection $tags
     * @return Timeslice
     */
    public function setTags(ArrayCollection $tags)
    {
        $this->tags = $tags;

        return $this;
    }

    /**
     * Asume Started Now if Start is empty
     */
    public function updateStartOnEmpty()
    {
        if (empty($this->startedAt)) {
            $this->startedAt = Carbon::now();
        }
    }

    /**
     * Unified Call for Pre Persist/Update
     *
     * @ORM\PrePersist
     * @ORM\PreUpdate
     * @return Timeslice
     */
    public function updateOnEmpty()
    {
        $this->updateStartOnEmpty();
        return $this;
    }

    /**
     * Get value in seconds from start to now
     *
     * @return int
     */
    public function getCurrentDuration()
    {
        if ($this->getValue()) {
            return $this->getValue();
        }

        return $this->getStartedAt()->diffInSeconds();
    }

    /**
     * @return Employee
     */
    public function getEmployee()
    {
        return $this->employee;
    }

    /**
     * @param Employee $employee
     * @return Timeslice $this
     */
    public function setEmployee($employee)
    {
        $this->employee = $employee;

        return $this;
    }
}
