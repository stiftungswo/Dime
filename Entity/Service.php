<?php
namespace Dime\TimetrackerBundle\Entity;

use Dime\TimetrackerBundle\Model\DefaultRateGroup;
use Gedmo\Mapping\Annotation as Gedmo;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as JMS;
use Doctrine\Common\Collections\ArrayCollection;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Knp\JsonSchemaBundle\Annotations as Json;

/**
 * Dime\TimetrackerBundle\Entity\Service
 *
 * @ORM\Table(
 *   name="services",
 *   uniqueConstraints={ @ORM\UniqueConstraint(name="unique_service_alias_user", columns={"alias", "user_id"}) }
 * )
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\ServiceRepository")
 * @Json\Schema("services")
 */
class Service extends Entity implements DimeEntityInterface
{
    /**
     * @var string $name
     *
     * @Assert\NotBlank()
     * @ORM\Column(type="string", nullable=true)
     */
    protected $name;

    /**
     * @var string $alias
     *
     * @Assert\NotBlank()
     * @Gedmo\Slug(fields={"name"})
     * @ORM\Column(type="string", length=30)
     */
    protected $alias;

    /**
     * @var string $description
     *
     * @ORM\Column(type="text", nullable=true)
     */
    protected $description;

    /**
     * JMS\Type("array")
     * @JMS\SerializedName("rates")
     * @ORM\OneToMany(targetEntity="Dime\TimetrackerBundle\Entity\Rate", mappedBy="service")
     **/
     protected $rates;

    /**
     * @var ArrayCollection $tags
     *
     * @JMS\Type("array")
     * @JMS\SerializedName("tags")
     * @ORM\ManyToMany(targetEntity="Tag", cascade="all")
     * @ORM\JoinTable(name="service_tags")
     */
    protected $tags;

	/**
	 * @var boolean $chargeable
	 *
	 * @ORM\Column(type="boolean")
	 */
	protected $chargeable;
	
	/**
	 * @var integer $vat
	 *
	 * @ORM\Column(type="decimal", scale=4, precision=10, nullable=true)
	 */
	protected $vat;
	
	/**
	 * Entity constructor
	 */
	public function __construct()
	{
		$this->tags = new ArrayCollection();
		$this->rates = new ArrayCollection();
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
		if($chargeable !== 'empty')
		{
			$this->chargeable = $chargeable;
		}
		return $this;
	}




    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param  string  $name
     * @return Service
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
     * @param  string  $alias
     * @return Service
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
     * Set description
     *
     * @param  string  $description
     * @return Service
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
	 * Get rate
	 *
	 * @param null $rateGroup
	 *
	 * @return Rate
	 */
    public function getRateByRateGroup($rateGroup = null)
    {
    	if($rateGroup instanceof RateGroup){
		    return $this->getRateByRateGroupId($rateGroup->getId());
    	}
	    elseif (is_numeric($rateGroup)){
		    return $this->getRateByRateGroupId($rateGroup);
	    }
        else {
	        return $this->getRateByRateGroupId(DefaultRateGroup::$ID);
        }
    }

	/**
	 * @param $id
	 *
	 * @return Rate
	 */
    private function getRateByRateGroupId($id)
    {
        $default = null;
        foreach($this->getRates()->toArray() as $rate){
            if($rate->getRateGroup()->getId() == $id)
                return $rate;
            if($rate->getRateGroup()->getId() == DefaultRateGroup::$ID)
                $default = $rate;
        }
        return $default;


    }

    /**
     * get service as string
     *
     * @return string
     */
    public function __toString()
    {
        $service = $this->getName();
        if (empty($service)) {
            $service = $this->getId();
        }

        return $service;
    }

    /**
     * Add tag
     *
     * @param  Tag $tag
     * @return Service
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
     */
    public function removeTag(Tag $tag)
    {
        $this->tags->removeElement($tag);
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
     * @return Service
     */
    public function setTags(ArrayCollection $tags)
    {
        $this->tags = $tags;
        return $this;
    }

    /**
     * Get chargeable
     *
     * @return boolean
     */
    public function getChargeable()
    {
        return $this->chargeable;
    }

    /**
     * Set vat
     *
     * @param string $vat
     *
     * @return Service
     */
    public function setVat($vat)
    {
        $this->vat = $vat;

        return $this;
    }

    /**
     * Get vat
     *
     * @return string
     */
    public function getVat()
    {
        return $this->vat;
    }

    /**
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return Service
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
     * @return Service
     */
    public function setUpdatedAt($updatedAt)
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * Add rate
     *
     * @param \Dime\TimetrackerBundle\Entity\Rate $rate
     *
     * @return Service
     */
    public function addRate(\Dime\TimetrackerBundle\Entity\Rate $rate)
    {
        $this->rates[] = $rate;

        return $this;
    }

    /**
     * Remove rate
     *
     * @param \Dime\TimetrackerBundle\Entity\Rate $rate
     */
    public function removeRate(\Dime\TimetrackerBundle\Entity\Rate $rate)
    {
        $this->rates->removeElement($rate);
    }

    /**
     * Get rates
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getRates()
    {
        return $this->rates;
    }
}
