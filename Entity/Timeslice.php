<?php

namespace Dime\TimetrackerBundle\Entity;

use Carbon\Carbon;
use DateTime;
use DeepCopy\DeepCopy;
use DeepCopy\Filter\KeepFilter;
use DeepCopy\Matcher\PropertyMatcher;
use Dime\TimetrackerBundle\Form\Transformer\DurationTransformer;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Model\RateUnitType;
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
 */
class Timeslice extends Entity implements DimeEntityInterface
{
    /**
     * @var Activity $activity
     *
     * @Assert\NotNull()
     * @ORM\ManyToOne(targetEntity="Activity", inversedBy="timeslices", cascade="persist")
     * @ORM\JoinColumn(name="activity_id", referencedColumnName="id", nullable=false, onDelete="CASCADE")
     */
    protected $activity;

    /**
     * @var ArrayCollection $tags
     *
     * @JMS\Type("array")
     * @JMS\SerializedName("tags")
     * @ORM\ManyToMany(targetEntity="Tag", cascade="persist")
     * @ORM\JoinTable(name="timeslice_tags")
     */
    protected $tags;

    /**
     * @var integer $value (in seconds)
     * @JMS\Exclude()
     * @ORM\Column(type="integer", nullable=false)
     */
    protected $value = 0;

    /**
     * @var datetime $startedAt
     *
     * @Assert\DateTime()
     * @JMS\SerializedName("startedAt")
     * @ORM\Column(name="started_at", type="datetime", nullable=true)
     */
    protected $startedAt;

    /**
     * @var datetime $stoppedAt
     *
     * @Assert\DateTime()
     * @JMS\SerializedName("stoppedAt")
     * @ORM\Column(name="stopped_at", type="datetime", nullable=true)
     */
    protected $stoppedAt;


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
     * @param  Activity  $activity
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
     * @param  integer   $value
     *
     * @return Timeslice
     */
    public function setValue($value)
    {
        $this->value = $value;

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
	 */
	public function serializeValue()
    {
        if(is_callable(array($this->activity, 'getRateUnitType'))) {
            if($this->getActivity()->getRateUnitType() === RateUnitType::$NoChange) {
                return $this->getValue();
            }
            $transformer = new DurationTransformer();
            return $transformer->transform($this->getValue());
        } else {
            return $this->getValue();
        }
	}

    public static function getCopyFilters(DeepCopy $deepCopy)
    {
        $deepCopy = parent::getCopyFilters($deepCopy);
        $deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'tags'));
        $deepCopy->addFilter(new KeepFilter(), new PropertyMatcher(self::class, 'activity'));
        return $deepCopy;
    }

    /**
     * Set started_at
     *
     * @param  DateTime  $startedAt
     * @return Timeslice
     */
    public function setStartedAt($startedAt)
    {
        if($startedAt === null) {
            $this->startedAt = null;
            return $this;
        }
        if (!$startedAt instanceof DateTime && !empty($startedAt)) {
            $startedAt = new Carbon($startedAt);
        } elseif (!$startedAt instanceof Carbon && $startedAt instanceof DateTime){
            $startedAt = Carbon::instance($startedAt);
        }
        if($startedAt->hour === 0){
            $startedAt->hour = 8;
        }
        $this->startedAt = $startedAt;
        $this->stoppedAt = null;

        return $this;
    }

    /**
     * Get started_at
     *
     * @return Carbon
     */
    public function getStartedAt()
    {
        if(is_null($this->startedAt)){
            return null;
        }
        return Carbon::instance($this->startedAt);
    }

    /**
     * Set stopped_at
     *
     * @param  DateTime  $stoppedAt
     * @return Timeslice
     */
    public function setStoppedAt($stoppedAt)
    {
        if (!$stoppedAt instanceof DateTime && !empty($stoppedAt)) {
            $stoppedAt = new DateTime($stoppedAt);
        }
        $this->stoppedAt = $stoppedAt;

        return $this;
    }

    /**
     * Get stopped_at
     *
     * @return Carbon
     */
    public function getStoppedAt()
    {
        if(is_null($this->stoppedAt)){
            return null;
        }
        return Carbon::instance($this->stoppedAt);
    }

    /**
     * Add tag
     *
     * @param  Tag      $tag
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
     * Auto generate value if empty
     */
    public function updateValueOnEmpty()
    {
        if (empty($this->value) && !empty($this->startedAt) && !empty($this->stoppedAt)) {
            $this->value = $this->getStartedAt()->diffInSeconds($this->getStoppedAt());
        }
    }

    /**
     * Asume Started Now if Start is empty
     */
    public function updateStartOnEmpty()
    {
        if(empty($this->startedAt)){
            $this->startedAt = Carbon::now();
        }
    }

    /**
     * Try to fill out stoppedAt if Empty
     * There are two Possibilities
     *      * We have value and started (Assume started + value then)
     *      * We have started and non time or no value (Assume started)
     *      * As last Failsafe we assume stopped to be now
     */
    public function updateStopOnEmpty()
    {
        if(empty($this->stoppedAt)){
            if(!empty($this->startedAt) && ($this->activity->getRateUnitType() === RateUnitType::$NoChange || empty($this->value))){
                $this->stoppedAt = $this->getStartedAt();
            } else if(!empty($this->startedAt) && ! empty($this->value)){
                $this->stoppedAt = $this->getStartedAt()->addSeconds($this->getValue());
            }
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
        $this->updateStopOnEmpty();
        $this->updateValueOnEmpty();
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

        if ($this->getStoppedAt() instanceof Carbon) {
            $end = $this->getStoppedAt();
        } else {
            $end = Carbon::now();
        }

        return $this->getStartedAt()->diffInSeconds($end);
    }
}
