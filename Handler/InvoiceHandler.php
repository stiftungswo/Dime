<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Handler;


use Dime\InvoiceBundle\Entity\Invoice;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\InvoiceBundle\Entity\InvoiceProject;
use Dime\TimetrackerBundle\Entity\Project;
use Doctrine\ORM\EntityManager;
use Symfony\Component\DependencyInjection\ContainerAware;

class InvoiceHandler extends ContainerAware
{
	protected $entityManager;

	protected $activityRepo;

	protected $projectRepo;

	protected $customerRepo;

	protected $nonChargeable;

	public function __construct(EntityManager $entityManager)
	{
		$this->entityManager = $entityManager;
		$this->activityRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Activity');
		$this->projectRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Project');
		$this->customerRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Customer');
		$this->serviceRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Service');
	}

	public function allByService($id, $nonChargeable = false)
	{
		$this->nonChargeable = $nonChargeable;
		$invoices = array();
		foreach($this->customerRepo->findByService($id) as $customer)
		{
			$invoices[] = $this->fillInvoice($this->customerRepo->find($customer), $this->projectRepo->findByCustomer($customer->getId()));
		}
		return $invoices;
	}

	public function allByCustomer($id, $nonChargeable = false)
	{
		$this->nonChargeable = $nonChargeable;
		return $this->fillInvoice($this->customerRepo->find($id), $this->projectRepo->findByCustomer($id));
	}

	public function allByProject($id, $nonChargeable = false)
	{
		$this->nonChargeable = $nonChargeable;
		return $this->fillInvoice($this->customerRepo->findByProject($id), array($this->projectRepo->find($id)));
	}

	private function fillInvoice($customer, $projects)
	{
		$invoice = new Invoice();
		$invoice->setCustomer($customer);
		$invoice->setProjects($this->fillProjects($projects));
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
			if (! $project instanceof Project)
			{
				throw new \InvalidArgumentException();
			}
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