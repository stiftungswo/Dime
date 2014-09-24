<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;


class Invoice {
	protected $customer;
	protected $projects;

	public function __construct()
	{
		$this->projects =array();
	}

	/**
	 * @return mixed
	 */
	public function getCustomer()
	{
		return $this->customer;
	}

	/**
	 * @param mixed $customer
	 *
	 * @return $this
	 */
	public function setCustomer($customer)
	{
		$this->customer = $customer;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getProjects()
	{
		return $this->projects;
	}

	/**
	 * @param InvoiceProject $project
	 *
	 * @return $this
	 */
	public function addProject(InvoiceProject $project)
	{
		$this->projects[] = $project;
		return $this;
	}

	/**
	 * @param InvoiceProject $project
	 *
	 * @return $this
	 */
/*	public function removeProject(InvoiceProject $project)
	{
		$this->projects->detach($project);
		return $this;
	}*/
} 