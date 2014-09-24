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
use Dime\TimetrackerBundle\Entity\ActivityRepository;
use Doctrine\ORM\EntityManager;
use Symfony\Component\DependencyInjection\ContainerAware;

class InvoiceHandler extends ContainerAware
{
	protected $entityManager;

	protected $activityRepo;

	protected $projectRepo;

	protected $customerRepo;

	public function __construct(EntityManager $entityManager)
	{
		$this->entityManager = $entityManager;
		$this->activityRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Activity');
		$this->projectRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Project');
		$this->customerRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Customer');
		$this->serviceRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Service');
		$this->amountRepo = $this->entityManager->getRepository('DimeTimetrackerBundle:Amount');
	}

	public function allByService($id)
	{

	}

	public function allByCustomer($id)
	{

		$invoice = new Invoice();
		$invoice->setCustomer($this->customerRepo->find($id));
		foreach($this->projectRepo->findByCustomer($id) as $project)
		{
			$invoiceproject = new InvoiceProject();
			$invoiceproject->setProject($project);
			foreach($this->activityRepo->findByProject($project->getId()) as $activity)
			{
				$invoiceproject->addItem(new InvoiceItem($activity));
			}
			foreach($this->amountRepo->findByProject($project->getId()) as $amount)
			{
				$invoiceproject->addItem(new InvoiceItem($amount));
			}
			$invoice->addProject($invoiceproject);
		}
		return $invoice;
	}

	public function allByProject($id)
	{

	}

	public function getByActivityOrAmount($id)
	{

	}
} 