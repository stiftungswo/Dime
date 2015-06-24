<?php
/**
 * Author: Till Wegmüller
 * Date: 6/24/15
 * Dime
 */

namespace Dime\ReportBundle\Entity;

use JMS\Serializer\Annotation as JMS;

class Report {
	protected $name;

	protected $title;

	protected $user;

	protected $project;

	/**
	 * @JMS\VirtualProperty()
	 * @JMS\SerializedName("id")
	 */
	public function getId()
	{
		return 1;
	}

	/**
	 * @return mixed
	 */
	public function getName()
	{
		return $this->name;
	}

	/**
	 * @param mixed $name
	 *
	 * @return $this
	 */
	public function setName($name)
	{
		$this->name = $name;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getTitle()
	{
		return $this->title;
	}

	/**
	 * @param mixed $title
	 *
	 * @return $this
	 */
	public function setTitle($title)
	{
		$this->title = $title;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getUser()
	{
		return $this->user;
	}

	/**
	 * @param mixed $user
	 *
	 * @return $this
	 */
	public function setUser($user)
	{
		$this->user = $user;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getProject()
	{
		return $this->project;
	}

	/**
	 * @param mixed $project
	 *
	 * @return $this
	 */
	public function setProject($project)
	{
		$this->project = $project;
		return $this;
	}


}