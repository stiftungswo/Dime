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
	protected $gross;
	protected $discounts;
	protected $net;

	public function setNet()
	{
		$net = $this->gross;
		if(!empty($this->discounts))
		{
			foreach($this->discounts as $discount)
			{
				if($discount instanceof Discount)
				{
					$net = $net + $discount->getModifier($this->gross);
				}
			}
		}
		$this->net = $net;
		return $this;
	}

	/**

	 * @return $this
	 */
	public function setGross($fixed)
	{
		$gross = 0;
		foreach($this->projects as $project)
		{
			if (!$fixed)
			{
				foreach($project->getItems() as $item)
				{
					$gross += $item->charge;
				}
			}
			else
			{
				$gross += $project->getProject()->getFixedPrice();
			}
		}
		$this->gross = $gross;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getNet()
	{
		return $this->net;
	}

	/**
	 * @return mixed
	 */
	public function getDiscounts()
	{
		return $this->discounts;
	}

	public function addDiscount(Discount $discount)
	{
		$this->discounts[] = $discount;
		return $this;
	}

	/**
	 * @param mixed $discounts
	 *
	 * @return $this
	 */
	public function setDiscounts($discounts)
	{
		$this->discounts = $discounts;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getGross()
	{
		return $this->gross;
	}

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
	 * @param array $projects
	 *
	 * @return $this
	 */
	public function setProjects($projects)
	{
		$this->projects = $projects;
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