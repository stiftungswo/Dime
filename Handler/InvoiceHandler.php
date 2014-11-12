<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Handler;


use Dime\InvoiceBundle\Entity\Invoice;
use Dime\InvoiceBundle\Entity\Discount;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\InvoiceBundle\Entity\InvoiceProject;
use Doctrine\ORM\EntityManager;
use Symfony\Component\DependencyInjection\ContainerAware;

class InvoiceHandler extends ContainerAware
{
	protected $entityManager;

	protected $activityRepo;

	protected $projectRepo;

	protected $customerRepo;

	protected $discountRepo;

	protected $discounts;

	protected $nonChargeable;

	protected $fixed;

	protected $details;

	public function __construct(EntityManager $entityManager)
	{
		$this->entityManager = $entityManager;
		$this->activityRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Activity');
		$this->projectRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Project');
		$this->customerRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Customer');
		$this->serviceRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Service');
		$this->discountRepo = $this->entityManager->getRepository('DimeInvoiceBundle:Discount');
	}

	public function allByService($id, $nonChargeable = false, $fixed = false, $details = true, $discounts = array())
	{
		$this->nonChargeable = $nonChargeable;
		$this->fixed = $fixed;
		$this->details = $details;
		$this->discounts = $discounts;
		$invoices = array();
		foreach($this->customerRepo->findByService($id) as $customer)
		{
			$invoices[] = $this->fillInvoice($this->customerRepo->find($customer), $this->projectRepo->findByCustomer($customer->getId()));
		}
		return $invoices;
	}

	public function allByCustomer($id, $nonChargeable = false, $fixed = false, $details = true, $discounts = array())
	{
		$this->nonChargeable = $nonChargeable;
		$this->fixed = $fixed;
		$this->details = $details;
		$this->discounts = $discounts;
		return $this->fillInvoice($this->customerRepo->find($id), $this->projectRepo->findByCustomer($id));
	}

	public function allByProject($id, $nonChargeable = false, $fixed = false, $details = true, $discounts = array())
	{
		$this->nonChargeable = boolval($nonChargeable);
		$this->fixed = boolval($fixed);
		$this->details = boolval($details);
		$this->discounts = $discounts;
		return $this->fillInvoice($this->customerRepo->findByProject($id), array($this->projectRepo->find($id)));
	}

	private function fillInvoice($customer, $projects)
	{
		$invoice = new Invoice();
		$invoice->setCustomer($customer);
		$invoice->setProjects($this->fillProjects($projects));

		$invoice = $this->ApplyDiscounts($invoice);

		if($this->details === false)
		{
			foreach($invoice->getProjects() as $project)
			{
				$project->setItems(array());
			}
		}
		$invoice->setGross($this->fixed);
		$invoice->setNet();
		return $invoice;
	}

	private function ApplyDiscounts($invoice)
	{
		foreach($this->discounts as $discoutid)
		{
			$discount = $this->discountRepo->find($discoutid);
			$invoice->addDiscount($discount);
		}
		return $invoice;
	}

	/**
	 * @param $projects
	 *
	 * @return InvoiceProject
	 */
	private function fillProjects($projects)
	{
		$invoiceprojects = array();
		foreach($projects as $project)
		{
			if ($project->isChargeable() and $this->nonChargeable)
			{
				$invoiceproject = new InvoiceProject();
				$invoiceproject->setProject($project);
				$invoiceproject->setItems($this->fillItems($this->activityRepo->findByProject($project->getId())));
				$invoiceprojects[] = $invoiceproject;
			}
		}
		return $invoiceprojects;
	}

	private function fillItems($entities)
	{
		$items = array();
		foreach($entities as $entity)
		{
			if ($entity->isChargeable() and $this->nonChargeable)
			{
				$items[] = new InvoiceItem($entity);
			}
		}
		return $items;
	}
} 