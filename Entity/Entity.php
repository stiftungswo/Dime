<?php
namespace Dime\TimetrackerBundle\Entity;

use DateTime;
use DeepCopy\DeepCopy;
use DeepCopy\Filter\SetNullFilter;
use DeepCopy\Matcher\PropertyMatcher;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;

/**
 * Dime\TimetrackerBundle\Entity\Entity
 *
 * @ORM\HasLifecycleCallbacks()
 */
abstract class Entity
{
    /**
     * @var integer $id
     *
     * @ORM\Id
     * @ORM\Column(name="id", type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @var User $user
     *
     * @Gedmo\Blameable(on="create")
     * @ORM\ManyToOne(targetEntity="Dime\TimetrackerBundle\Entity\User")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id", nullable=true, onDelete="SET NULL")
     */
    protected $user;

    /**
     * @var datetime $createdAt
     *
     * @Gedmo\Timestampable(on="create")
     * @JMS\SerializedName("createdAt")
     * @ORM\Column(name="created_at", type="datetime")
     */
    protected $createdAt;

    /**
     * @var datetime $updatedAt
     *
     * @Gedmo\Timestampable(on="update")
     * @JMS\SerializedName("updatedAt")
     * @ORM\Column(name="updated_at", type="datetime")
     */
    protected $updatedAt;

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
     * Set user
     *
     * @param  User     $user
     * @return Activity
     */
    public function setUser(User $user)
    {
        $this->user = $user;

        return $this;
    }

    /**
     * Get user
     *
     * @return User
     */
    public function getUser()
    {
        return $this->user;
    }

    /**
     * Get created at datetime
     *
     * @return datetime
     */
    public function getCreatedAt()
    {
        return $this->createdAt;
    }

    /**
     * Get updated at datetime
     *
     * @return datetime
     */
    public function getUpdatedAt()
    {
        return $this->updatedAt;
    }

    /**
     * get activity as string
     *
     * @return string
     */
    public function __toString()
    {
        return (string) $this->getId();
    }

    public static function getCopyFilters(DeepCopy $deepCopy)
    {
        $deepCopy->skipUncloneable(true);
        $deepCopy->addFilter(new SetNullFilter(), new PropertyMatcher(static::class, 'id'));
        $deepCopy->addFilter(new SetNullFilter(), new PropertyMatcher(static::class, 'createdAt'));
        $deepCopy->addFilter(new SetNullFilter(), new PropertyMatcher(static::class, 'updatedAt'));
        $deepCopy->addFilter(new SetNullFilter(), new PropertyMatcher(static::class, 'user'));
        return $deepCopy;
    }

    public function sanitize(array $parameters)
    {
        $retval = array();
        $properties = $this->getProperties();
        foreach($parameters as $key => $value)
        {
            if(array_key_exists($key, $properties)){
                $retval[$key] = $value;
            }
        }
        return $retval;
    }

    public function getProperties()
    {
        $retval = array();
        foreach($this as $key => $value)
        {
            $retval[] = $key;
        }
        return $retval;
    }
}
