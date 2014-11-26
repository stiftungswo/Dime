<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Handler;

use Dime\InvoiceBundle\Entity\Invoice;
use Dime\InvoiceBundle\Entity\InvoiceDiscount;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Handler\GenericHandler;
use Doctrine\Common\Collections\ArrayCollection;

class InvoiceHandler extends GenericHandler
{
	public function createFromProject(Project $project)
	{
		$invoice = $this->repository->findOneBy(array('project' => $project->getId()));
		if($invoice !== null){
			return $invoice;
		}
		$offerRepo = $this->om->getRepository('DimeOfferBundle:Offer');

		$offer = $offerRepo->findOneBy(array('project' => $project->getId()));

		$invoice = new Invoice();
		$invoice->setName($project->getName().' Rechnung');
		$invoice->setDescription($project->getDescription());
		$invoice->setGross($project->getFixedPrice());
		foreach($project->getActivities() as $activity){
			$item = new InvoiceItem();
			$item->setFromActivity($activity);
			$item->setInvoice($invoice);
			$invoice->addItem($item);
		}
		$invoice->setProject($project);
		if(!null === $offer){
			$invoice->setOffer($offer);
			$invoice->setStandardDiscounts($offer->getStandardDiscounts());
			foreach($offer->getOfferDiscounts() as $offerDiscount){
				$discount = new InvoiceDiscount();
				$discount->setFromOfferDiscount($offerDiscount);
				$invoice->addInvoiceDiscounts($discount);
			}
		}
		$this->om->persist($invoice);
		$this->om->flush();
		return $invoice;
	}

	public function updateInvoiceItems(Invoice $invoice)
	{
		foreach($invoice->getItems() as $item)
		{
			$invoice->removeItem($item);
			$this->om->remove($item);
		}
		foreach($invoice->getProject()->getActivities() as $activity){
			$item = new InvoiceItem();
			$item->setFromActivity($activity);
			$item->setInvoice($invoice);
			$invoice->addItem($item);
		}
		$this->om->persist($invoice);
		$this->om->flush();
		return $invoice;
	}
} 