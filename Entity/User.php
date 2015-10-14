<?php
namespace Dime\TimetrackerBundle\Entity;

use DateTime;
use Dime\TimetrackerBundle\Annotation\DiscriminatorEntry;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use FOS\UserBundle\Model\User as BaseUser;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Dime\TimetrackerBundle\Entity\Project
 *
 * @UniqueEntity(fields={"email"})
 * @ORM\Table(name="users")
 * @ORM\Entity(repositoryClass="Dime\TimetrackerBundle\Entity\UserRepository")
 * @Json\Schema("users")
 * @ORM\InheritanceType("SINGLE_TABLE")
 * @ORM\DiscriminatorColumn(name="discr",type="string")
 * @DiscriminatorEntry(value="person")
 */
class User extends BaseUser implements DimeEntityInterface
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
	 * @var string $firstname
	 *
	 * @ORM\Column(type="string", length=255, nullable=true)
	 */
	protected $firstname;

	/**
	 * @var string $lastname
	 *
	 * @ORM\Column(type="string", length=255, nullable=true)
	 */
	protected $lastname;

	/**
	 * @var DateTime $createdAt
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
	 * @var integer $employeeholiday
	 *
	 * @ORM\Column(type="integer", nullable=true)
	 */
	protected $employeeholiday;
	
	/**
	 * @return string
	 */
	public function getFullname()
	{
		return $this->firstname . ' ' . $this->lastname;
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
	 * Set firstname
	 *
	 * @param  string $firstname
	 * @return User
	 */
	public function setFirstname($firstname)
	{
		$this->firstname = $firstname;

		return $this;
	}

	/**
	 * Get firstname
	 *
	 * @return string
	 */
	public function getFirstname()
	{
		return $this->firstname;
	}

	/**
	 * Set lastname
	 *
	 * @param  string $lastname
	 * @return User
	 */
	public function setLastname($lastname)
	{
		$this->lastname = $lastname;

		return $this;
	}

	/**
	 * Get lastname
	 *
	 * @return string
	 */
	public function getLastname()
	{
		return $this->lastname;
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
	* Get $employeeholiday
	*
	* @return integer
	*/
	public function getEmployeeholiday()
	{
		return $this->employeeholiday;
	}

	/**
	 * Set $employeeholiday
	 *
	 * @param  integer $employeeholiday
	 * @return User
	 */
	public function setEmployeeholiday($employeeholiday)
	{
		$this->employeeholiday = $employeeholiday;

		return $this;
	}

	/**
	 * get user as string
	 *
	 * @return string
	 */
	public function __toString()
	{
		$user = trim($this->getFirstname() . ' ' . $this->getLastname());

		if (empty($user)) {
			$user = $this->getId();
		}
		if (!is_string($user)) {
			$user = strval($user);
		}
		return $user;
	}
}
