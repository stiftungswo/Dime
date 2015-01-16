<?php

namespace Dime\TimetrackerBundle\Entity;

use DateTime;
use Dime\TimetrackerBundle\Form\Transformer\DurationTransformer;
use Dime\TimetrackerBundle\Model\RateUnitType;
use Gedmo\Mapping\Annotation as Gedmo;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Swo\CommonsBundle\Form\Transformer\JsDateTransformer;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;

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
     * @JMS\Exclude()
     * @ORM\Column(name="started_at", type="datetime", nullable=true)
     */
    protected $startedAt;

    /**
     * @var datetime $stoppedAt
     *
     * @Assert\DateTime()
     * @JMS\Exclude()
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

    /**
     * Set started_at
     *
     * @param  DateTime  $startedAt
     * @return Timeslice
     */
    public function setStartedAt($startedAt)
    {
        if (!$startedAt instanceof DateTime && !empty($startedAt)) {
            $startedAt = new DateTime($startedAt);
        }
        $this->startedAt = $startedAt;

        return $this;
    }

    /**
     * Get started_at
     *
     * @return DateTime
     */
    public function getStartedAt()
    {
        return $this->startedAt;
    }

	/**
	 * @JMS\VirtualProperty
	 * @JMS\SerializedName("startedAt")
	 */
	public function serializeStartedAt()
	{
		$transfomer = new JsDateTransformer();
		return $transfomer->transform($this->getStartedAt());
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
     * @return DateTime
     */
    public function getStoppedAt()
    {
        return $this->stoppedAt;
    }

	/**
	 * @JMS\VirtualProperty
	 * @JMS\SerializedName("stoppedAt")
	 */
	public function serializeStoppedAt()
	{
		$transfomer = new JsDateTransformer();
		return $transfomer->transform($this->getStoppedAt());
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
            $this->value = abs($this->stoppedAt->getTimestamp() - $this->startedAt->getTimestamp());
        }
    }

    /**
     * Asume Started Today if Start is empty
     */
    public function updateStartOnEmpty()
    {
        if(empty($this->startedAt)){
            $this->startedAt = new DateTime('now');
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

        if ($this->getStartedAt() instanceof DateTime) {
            if ($this->getStoppedAt() instanceof DateTime) {
                $end = $this->getStoppedAt();
            } else {
                $end = new DateTime('now');
            }

            $duration = $this->getStartedAt()->diff($end);

            return $duration->format('%a') * 24 * 60 * 60
                + $duration->format('%h') * 60 * 60
                + $duration->format('%i') * 60;
        }
    }
}
