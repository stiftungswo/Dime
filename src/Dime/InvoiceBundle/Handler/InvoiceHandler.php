<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Handler;

use Carbon\Carbon;
use Dime\InvoiceBundle\Entity\Invoice;
use Dime\InvoiceBundle\Entity\InvoiceDiscount;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Handler\GenericHandler;

class InvoiceHandler extends GenericHandler
{
    public function createFromProject(Project $project)
    {
        //Search for all Invoices associated with $project ordered by start and end date
        //Take the Last one.

        $this->repository->createCurrentQueryBuilder('invoice');
        $this->repository->filter(array('project' => $project));
        $qb = $this->repository->getCurrentQueryBuilder();
        //$qb = $this->om->getRepository('DimeInvoiceBundle:Invoice')->createQueryBuilder('invoice');
        $qb->addOrderBy('invoice.start', 'DESC')
            ->addOrderBy('invoice.end', 'DESC');
        $qb->setMaxResults(1);
        $existinginvoice = $qb->getQuery()->getResult();


        //Get One Timeslice filtered by project ordered by startedAt
        $timerepo = $this->om->getRepository('DimeTimetrackerBundle:Timeslice');
        $timerepo->createCurrentQueryBuilder('timeslice');
        $timerepo->filter(array('project' => $project));
        $timeqb = $timerepo->getCurrentQueryBuilder();
        $timeqb->orderBy('timeslice.startedAt', 'DESC');
        $timeqb->setMaxResults(1);
        $lasttimeslice = $timeqb->getQuery()->getResult();

        //if the enddate on the last invoice is grater or equal the Date on the Timeslice return the last invoice
        if ($existinginvoice instanceof Invoice && $lasttimeslice instanceof Timeslice) {
            if ($existinginvoice->getEnd()->gte($lasttimeslice->getStoppedAt())) {
                return $existinginvoice;
            }
        }


        $offerRepo = $this->om->getRepository('DimeOfferBundle:Offer');

        $offer = $offerRepo->findOneBy(array('project' => $project->getId()));

        $invoice = new Invoice();
        if ($existinginvoice instanceof Invoice) {
            //else continue to create an invoice from endate of last invoice+1day to end.
            $invoice->setStart($existinginvoice->getEnd()->addDay());
        } else {
            //If there is no invoice for this project crate one from start till end.
            $timerepo = $this->om->getRepository('DimeTimetrackerBundle:Timeslice');
            $timerepo->createCurrentQueryBuilder('timeslice');
            $timerepo->filter(array('project' => $project));
            $timeqb = $timerepo->getCurrentQueryBuilder();
            $timeqb->orderBy('timeslice.startedAt', 'ASC');
            $timeqb->setMaxResults(1);
            $firsttimeslice = $timeqb->getQuery()->getResult();
            if (is_array($firsttimeslice) && !empty($firsttimeslice)) {
                $firsttimeslice = $firsttimeslice[0];
            }
            if ($firsttimeslice instanceof Timeslice) {
                $invoice->setStart($firsttimeslice->getStartedAt());
            } else {
                $invoice->setStart(Carbon::yesterday());
            }
        }
        if ($lasttimeslice instanceof Timeslice) {
            $invoice->setEnd($lasttimeslice->getStoppedAt());
        } else {
            $invoice->setEnd(Carbon::now());
        }
        $invoice->setName($project->getName().' Rechnung'); //Datum hier auch verwenden.
        $invoice->setDescription($project->getDescription());
        $invoice->setFixedPrice($project->getFixedPrice());
        foreach ($project->getActivities() as $activity) {
            $item = new InvoiceItem();
            $item->setFromActivity($activity);
            $item->setInvoice($invoice);
            $invoice->addItem($item);
        }
        $invoice->setProject($project);
        if (!null === $offer) {
            $invoice->setOffer($offer);
            $invoice->setStandardDiscounts($offer->getStandardDiscounts());
            foreach ($offer->getOfferDiscounts() as $offerDiscount) {
                $discount = new InvoiceDiscount();
                $discount->setFromOfferDiscount($offerDiscount);
                $invoice->addInvoiceDiscounts($discount);
            }
        }
        if (!is_null($project->getCustomer())) {
            $invoice->setCustomer($project->getCustomer());
        }
        $this->om->persist($invoice);
        $this->om->flush();
        return $invoice;
    }

    public function updateInvoice(Invoice $invoice)
    {
        if ($invoice->getProject()instanceof Project) {
            foreach ($invoice->getProject()->getActivities() as $activity) {
                $hasactvity = false;
                foreach ($invoice->getItems() as $item) {
                    $itemactivity = $item->getActivity();
                    if ($itemactivity instanceof Activity) {
                        if ($itemactivity->getId() === $activity->getId()) {
                            $hasactvity = true;
                            $item->setFromActivity($activity);
                        }
                    }
                }
                if (!$hasactvity) {
                    $item = new InvoiceItem();
                    $item->setFromActivity($activity);
                    $item->setInvoice($invoice);
                    $invoice->addItem($item);
                }
            }
        }
        $this->om->persist($invoice);
        $this->om->flush();
        return $invoice;
    }
}
