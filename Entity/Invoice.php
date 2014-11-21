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
	protected $invoiceDiscounts;
	protected $net;

	public function setNet()
	{
		$net = $this->gross;
		if(!empty($this->invoiceDiscounts))
		{
			foreach($this->invoiceDiscounts as $discount)
			{
				if($discount instanceof InvoiceDiscount)
				{
					$net = $net + $discount->getModifier($this->gross);
				}
			}
		}
		$this->net = $net;
		return $this;
	}

	/**
	 * @param $fixed
	 *
	 * @return $this
	 * ToDO: Fix.
	 */
	public function setGross($fixed)
	{
		$gross = 0;
		foreach($this->projects as $project)
		{
			if (false == $fixed)
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
	public function getInvoiceDiscounts()
	{
		return $this->invoiceDiscounts;
	}

	public function addInvoiceDiscount(InvoiceDiscount $discount)
	{
		$this->invoiceDiscounts[] = $discount;
		return $this;
	}

	/**
	 * @param mixed $discounts
	 *
	 * @return $this
	 */
	public function setInvoiceDiscounts($discounts)
	{
		$this->invoiceDiscounts = $discounts;
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
} 