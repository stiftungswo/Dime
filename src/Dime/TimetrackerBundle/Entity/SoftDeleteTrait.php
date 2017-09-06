<?php

namespace Dime\TimetrackerBundle\Entity;

trait SoftDeleteTrait {

  /**
	* @var DateTime $deletedAt
  * @JMS\SerializedName("deletedAt")
	* @Assert\Date()
	* @ORM\Column(name="deleted_at", type="datetime", nullable=true)
	*/
	protected $deletedAt;

  /**
	* Get deletedAt
	* @return datetime
	*/
	public function getDeletedAt()
	{
			return $this->deletedAt;
	}

	/**
	 * Set deletedAt
	 * @param \DateTime $deletedAt
	 * @return Project
	 */
	public function setDeletedAt($deletedAt)
	{
			$this->deletedAt = $deletedAt;
	}
}

?>
