<?php
namespace Dime\TimetrackerBundle\Entity;

use DateTime;
use Dime\EmployeeBundle\Entity\Employee;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;
use Dime\InvoiceBundle\Entity\Invoice;
use Dime\OfferBundle\Entity\Offer;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Dime\TimetrackerBundle\Entity\Project
 *
 * @ORM\Table(name="projects")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\ProjectRepository")
 * @Json\Schema("projects")
 * @Gedmo\SoftDeleteable(fieldName="deletedAt", timeAware=false)
 */
class Project extends Entity implements DimeEntityInterface
{
    /**
     * Hook SoftDeleteable fields
     */
    use SoftDeleteTrait;

    /**
     * Archivable fields
     */
    use ArchivableTrait;

    /**
     * @var Customer $customer
     *
     * @JMS\MaxDepth(2)
     * @ORM\ManyToOne(targetEntity="Customer")
     * @ORM\JoinColumn(name="customer_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $customer;

    /**
     * @var string $name
     *
     * @JMS\Groups({"List"})
     * @Assert\NotBlank()
     * @ORM\Column(type="string", length=255)
     */
    protected $name;

    /**
     * @var string $alias
     *
     * @JMS\Groups({"List"})
     * @Gedmo\Slug(fields={"name"})
     * @ORM\Column(type="string", length=30)
     */
    protected $alias;

    /**
     * @var DateTime $startedAt
     *
     * @Assert\Date()
     * @JMS\SerializedName("startedAt")
     * @ORM\Column(name="started_at", type="datetime", nullable=true)
     */
    protected $startedAt;

    /**
     * @var DateTime $stoppedAt
     *
     * @Assert\Date()
     * @JMS\SerializedName("stoppedAt")
     * @ORM\Column(name="stopped_at", type="datetime", nullable=true)
     */
    protected $stoppedAt;

    /**
     * @var DateTime $deadline
     *
     * @Assert\Date()
     * @ORM\Column(name="deadline", type="datetime", nullable=true)
     */
    protected $deadline;

    /**
     * @var string $description
     *
     * @JMS\Groups({"List"})
     * @ORM\Column(type="text", nullable=true)
     */
    protected $description;

    /**
     * @var Money $budgetPrice
     *
     * @JMS\Exclude()
     * @ORM\Column(name="budget_price", type="money", nullable=true)
     */
    protected $budgetPrice;

    /**
     * @var Money $fixedPrice
     *
     * @JMS\Exclude
     * @ORM\Column(name="fixed_price", type="money", length=255, nullable=true)
     */
    protected $fixedPrice;

    /**
     * @var integer $budgetTime
     *
     * @JMS\Exclude()
     * @ORM\Column(name="budget_time", type="integer", length=255, nullable=true)
     */
    protected $budgetTime;

    /**
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\RateGroup")
     * @ORM\JoinColumn(name="rate_group_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     * @JMS\MaxDepth(1)
     * @JMS\SerializedName("rateGroup")
     */
    protected $rateGroup;

    /**
     * @var ArrayCollection $tags
     *
     * @JMS\Type("array")
     * @JMS\SerializedName("tags")
     * @ORM\ManyToMany(targetEntity="Tag", cascade="all")
     * @ORM\JoinTable(name="project_tags")
     */
    protected $tags;

    /**
     * @var boolean $chargeable
     *
     *
     * @ORM\Column(type="boolean", nullable=true)
     */
    protected $chargeable;

    /**
     * @var ArrayCollection $activities
     * @JMS\MaxDepth(2)
     * @JMS\Type("array")
     * @ORM\OneToMany(targetEntity="Dime\TimetrackerBundle\Entity\Activity", mappedBy="project", cascade={"all"})
     */
    protected $activities;

    /**
     * @var ProjectCategory $projectCategory
     *
     * @ORM\ManyToOne(targetEntity="ProjectCategory",cascade={"persist"})
     * @ORM\JoinColumn(name="project_category_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     * @JMS\SerializedName("projectCategory")
     */
    protected $projectCategory;

    /**
     * @var ArrayCollection $invoices
     *
     * @ORM\OneToMany(targetEntity="Dime\InvoiceBundle\Entity\Invoice", mappedBy="project")
     * @ORM\JoinColumn(name="id", referencedColumnName="project_id", nullable=true, onDelete="SET NULL")
     * @JMS\SerializedName("invoices")
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     */
    protected $invoices;

    /**
     * @var ArrayCollection $invoices
     *
     * @ORM\OneToMany(targetEntity="Dime\TimetrackerBundle\Entity\ProjectComment", mappedBy="project")
     * @ORM\JoinColumn(name="id", referencedColumnName="project_id", nullable=true, onDelete="SET NULL")
     * @JMS\SerializedName("comments")
     * @JMS\Type("array")
     */
    protected $comments;

    /**
     * @var ArrayCollection $offers
     *
     * @ORM\OneToMany(targetEntity="Dime\OfferBundle\Entity\Offer", mappedBy="project")
     * @ORM\JoinColumn(name="id", referencedColumnName="project_id", nullable=true, onDelete="SET NULL")
     * @JMS\SerializedName("offers")
     * @JMS\Type("array")
     * @JMS\MaxDepth(1)
     */
    protected $offers;

    /**
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\User")
     * @ORM\JoinColumn(name="accountant_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     * @JMS\MaxDepth(1)
     */
    protected $accountant;

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("currentPrice")
     * @return string
     */
    public function getCurrentPrice()
    {
        return $this->calculateCurrentPrice()->format(true);
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("remainingBudgetPrice")
     * @return string
     */
    public function getRemainingBudgetPrice()
    {
        if ($this->budgetPrice != null) {
            return $this->budgetPrice->subtract($this->calculateCurrentPrice())->format(true);
        } else {
            return null;
        }
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("currentTime")
     * @return string
     */
    public function getCurrentTime()
    {
        $duration = 0;
        foreach ($this->activities as $activity) {
            if ($activity->getRateUnitType() != null && $activity->getRateUnitType()->getSymbol() !== RateUnitType::$NoChange) {
                $duration += (float) RateUnitType::transformBetweenTimeUnits($activity->getValue(true), RateUnitType::$Secondly, RateUnitType::$Hourly, false);
            }
        }
        return number_format($duration, 2). ' ' . RateUnitType::$Hourly;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("remainingBudgetTime")
     * @return string
     */
    public function getRemainingBudgetTime()
    {
        if ($this->budgetTime != null) {
            $currentBudget = $this->budgetTime - (int) $this->getCurrentTime();
            return number_format($currentBudget, 2) . ' ' . RateUnitType::$Hourly;
        } else {
            return null;
        }
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("budgetTime")
     * @return string
     */
    public function serializeBudgetTime()
    {
        if ($this->budgetTime != null) {
            return number_format($this->budgetTime, 2) . ' ' . RateUnitType::$Hourly;
        } else {
            return null;
        }
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("budgetPrice")
     * @return string
     */
    public function serializeBudgetPrice()
    {
        if ($this->budgetPrice != null && !$this->budgetPrice->isZero()) {
            return $this->budgetPrice->format(true);
        } else {
            return null;
        }
    }

    /**
     * @return boolean
     */
    public function isChargeable()
    {
        return $this->chargeable;
    }

    /**
     * @param boolean $chargeable
     *
     * @return $this
     */
    public function setChargeable($chargeable)
    {
        if ($chargeable !== 'empty') {
            $this->chargeable = $chargeable;
        }
        return $this;
    }

    /**
     * Entity constructor
     */
    public function __construct()
    {
        $this->tags = new ArrayCollection();
        $this->activities = new ArrayCollection();
    }

    /**
     * Set customer
     *
     * @param  Customer $customer
     * @return Project
     */
    public function setCustomer(Customer $customer)
    {
        $this->customer = $customer;

        return $this;
    }

    /**
     * Get customer
     *
     * @return Customer
     */
    public function getCustomer()
    {
        return $this->customer;
    }

    /**
     * Set name
     *
     * @param  string $name
     * @return Project
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
     * @return Project
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
     * Set startedAt
     *
     * @param  DateTime $startedAt
     * @return Project
     */
    public function setStartedAt($startedAt)
    {
        $this->startedAt = $startedAt;

        return $this;
    }

    /**
     * Get startedAt
     *
     * @return datetime
     */
    public function getStartedAt()
    {
        return $this->startedAt;
    }

    /**
     * Set stoppedAt
     *
     * @param  datetime $stoppedAt
     * @return Project
     */
    public function setStoppedAt($stoppedAt)
    {
        $this->stoppedAt = $stoppedAt;

        return $this;
    }

    /**
     * Get stoppedAt
     *
     * @return datetime
     */
    public function getStoppedAt()
    {
        return $this->stoppedAt;
    }

    /**
     * Set deadline
     *
     * @param  datetime $deadline
     * @return Project
     */
    public function setDeadline($deadline)
    {
        $this->deadline = $deadline;

        return $this;
    }

    /**
     * Get deadline
     *
     * @return datetime
     */
    public function getDeadline()
    {
        return $this->deadline;
    }

    /**
     * Set description
     *
     * @param  string $description
     * @return Project
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set budgetPrice
     *
     * @param Money $budgetPrice
     * @return Project
     */
    public function setBudgetPrice($budgetPrice)
    {
        $this->budgetPrice = $budgetPrice;
        return $this;
    }

    /**
     * Get budgetPrice
     *
     * @return Money
     */
    public function getBudgetPrice()
    {
        return $this->budgetPrice;
    }

    /**
     * @return Money current Price
     */
    public function calculateCurrentPrice()
    {
        $price = Money::CHF(0);
        foreach ($this->activities as $activity) {
            $price = $price->add($activity->getCharge());
        }
        return $price;
    }

    /**
     * Set fixedPrice
     *
     * @param  Money $fixedPrice
     * @return Project
     */
    public function setFixedPrice($fixedPrice)
    {
        $this->fixedPrice = $fixedPrice;
        $this->budgetPrice = $fixedPrice;
        return $this;
    }

    /**
     * Get fixedPrice
     *
     * @return Money
     */
    public function getFixedPrice()
    {
        return $this->fixedPrice;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("fixedPrice")
     * @return string
     */
    public function serializeFixedPrice()
    {
        if ($this->fixedPrice != null && !$this->fixedPrice->isZero()) {
            return $this->fixedPrice->format();
        } else {
            return null;
        }
    }

    /**
     * Set budgetTime
     *
     * @param  integer $budgetTime
     * @return Project
     */
    public function setBudgetTime($budgetTime)
    {
        $rateunit = new RateUnitType();
        $this->budgetTime = $rateunit->reverseTransform($budgetTime);

        return $this;
    }

    /**
     * Get budgetTime
     *
     * @return int
     */
    public function getBudgetTime()
    {
        return $this->budgetTime;
    }

    /**
     * get project as string
     *
     * @return string
     */
    public function __toString()
    {
        return (empty($this->name)) ? strval($this->getId()) : $this->getName();
    }

    /**
     * Add tag
     *
     * @param  Tag $tag
     * @return Project
     */
    public function addTag(Tag $tag)
    {
        $this->tags[] = $tag;

        return $this;
    }

    /**
     * Remove tags
     *
     * @param Tag $tag
     * @return Project
     */
    public function removeTag(Tag $tag)
    {
        $this->tags->removeElement($tag);

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
     * @return Project
     */
    public function setTags(ArrayCollection $tags)
    {
        $this->tags = $tags;

        return $this;
    }

    /**
     * Set rateGroup
     *
     * @param string $rateGroup
     *
     * @return Project
     */
    public function setRateGroup($rateGroup)
    {
        $this->rateGroup = $rateGroup;

        // TODO: update rate value on activities

        return $this;
    }

    /**
     * Get rateGroup
     *
     * @return string
     */
    public function getRateGroup()
    {
        return $this->rateGroup;
    }

    /**
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return Project
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
     * @return Project
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

    /**
     * @param ArrayCollection $activities
     *
     * @return $this
     */
    public function setActivities($activities)
    {
        $this->activities = $activities;
        return $this;
    }

    /**
     * @param Activity $activity
     *
     * @return Project
     */
    public function addActivity(Activity $activity)
    {
        $this->activities[] = $activity;
        return $this;
    }

    public function removeActivity(Activity $activity)
    {
        $this->activities->removeElement($activity);
        return $this;
    }

    /**
     * Set $projectCategory
     *
     * @param  ProjectCategory $projectCategory
     * @return ProjectCategory
     */
    public function setProjectCategory(ProjectCategory $projectCategory)
    {
        $this->projectCategory = $projectCategory;

        return $this;
    }

    /**
     * Get $projectCategory
     *
     * @return ProjectCategory
     */
    public function getProjectCategory()
    {
        return $this->projectCategory;
    }

    /**
     * @return ArrayCollection
     */
    public function getInvoices()
    {
        return $this->invoices;
    }

    /**
     * @param string $invoices
     *
     * @return Project
     */
    public function setInvoices($invoices)
    {
        $this->invoices = $invoices;

        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getComments()
    {
        return $this->comments;
    }

    /**
     * @param ArrayCollection $comments
     *
     * @return Project
     */
    public function setComments($comments)
    {
        $this->comments = $comments;

        return $this;
    }

    /**
     * @param Invoice $invoice
     *
     * @return Project
     */
    public function addInvoice(Invoice $invoice)
    {
        $this->invoices[] = $invoice;
        return $this;
    }

    public function removeInvoice(Invoice $invoice)
    {
        $this->invoices->removeElement($invoice);
        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getOffers()
    {
        return $this->offers;
    }

    /**
     * @param ArrayCollection $offers
     *
     * @return Project
     */
    public function setOffers($offers)
    {
        $this->offers = $offers;

        return $this;
    }

    /**
     * @param Offer $offer
     *
     * @return Project
     */
    public function addOffer(Offer $offer)
    {
        $this->offers[] = $offer;
        return $this;
    }

    /**
     * @param Offer $offer
     * @return Project
     */
    public function removeOffer(Offer $offer)
    {
        $this->offers->removeElement($offer);
        return $this;
    }

    /**
     * @return Employee
     */
    public function getAccountant()
    {
        return $this->accountant;
    }

    /**
     * @param Employee $accountant
     *
     * @return Project
     */
    public function setAccountant($accountant)
    {
        $this->accountant = $accountant;

        return $this;
    }
}
