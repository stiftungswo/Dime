<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;


use Dime\TimetrackerBundle\Entity\Project;

class InvoiceProject {
	protected $project;
	protected $items;

	public function __construct()
	{
		$this->items = array();
	}

	/**
	 * @return \SplObjectStorage
	 */
	public function getItems()
	{
		return $this->items;
	}

	/**
	 * @param InvoiceItem $item
	 *
	 * @return $this
	 */
	public function addItem(InvoiceItem $item)
	{
		$this->items[] = $item;
		return $this;
	}

	/**
	 * @param InvoiceItem $item
	 *
	 * @return $this
	 */
/*	public function removeItem(InvoiceItem $item)
	{
		$this->items->detach($item);
		return $this;
	}*/

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
	public function setProject(Project $project)
	{
		$this->project = $project;
		return $this;
	}
} 