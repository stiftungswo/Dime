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
use Dime\OfferBundle\Entity\Offer;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Swo\CommonsBundle\Handler\GenericHandler;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\TimetrackEvents;
use Swo\CommonsBundle\Model\DimeEntityInterface as DEInterface;

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
        // 20180628 https://stackoverflow.com/questions/10482085/how-to-fetch-class-instead-of-array-in-doctrine-2
        $existinginvoice = $qb->getQuery()->getOneOrNullResult();

        //Get One Timeslice filtered by project ordered by startedAt
        $timerepo = $this->om->getRepository('DimeTimetrackerBundle:Timeslice');
        $timerepo->createCurrentQueryBuilder('timeslice');
        $timerepo->filter(array('project' => $project));
        $timeqb = $timerepo->getCurrentQueryBuilder();
        $timeqb->orderBy('timeslice.startedAt', 'DESC');
        $timeqb->setMaxResults(1);
        $lasttimeslice = $timeqb->getQuery()->getOneOrNullResult();

        $offerRepo = $this->om->getRepository('DimeOfferBundle:Offer');
        $offer = $offerRepo->findOneBy(array('project' => $project->getId()));

        $invoice = new Invoice();
        if ($existinginvoice instanceof Invoice && $existinginvoice->getEnd()) {
            //else continue to create an invoice from endate of last invoice+1day to end.
            $invoice->setStart($existinginvoice->getEnd()->addDay());
        } else {
            // if there is no invoice, or an end date missing on the existing invoice,
            // create an invoice from the first to the last timeslice
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
        $invoice->setName($project->getName()); //Datum hier auch verwenden.
        $invoice->setDescription($project->getDescription());
        $invoice->setFixedPrice($project->getFixedPrice());
        foreach ($project->getActivities() as $activity) {
            if ($activity->getService()!=null) {
                $item = new InvoiceItem();
                $item->setFromActivity($activity);
                $item->setInvoice($invoice);
                $invoice->addItem($item);
            }
        }
        $invoice->setProject($project);
        if (isset($offer) && $offer instanceof Offer) {
            foreach ($offer->getOfferDiscounts() as $offerDiscount) {
                $discount = new InvoiceDiscount();
                $discount->setFromOfferDiscount($offerDiscount);
                $invoice->addInvoiceDiscount($discount);
            }
        }
        if (!is_null($project->getCustomer())) {
            $invoice->setCustomer($project->getCustomer());
        }
        if (!is_null($project->getAccountant())) {
            $invoice->setAccountant($project->getAccountant());
        }
        $invoice->setUser($this->getCurrentUser());
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
                if (!$hasactvity && $activity->getService()!=null) {
                    $item = new InvoiceItem();
                    $item->setFromActivity($activity);
                    $item->setInvoice($invoice);
                    $invoice->addItem($item);
                }
            }
            $invoice->setFixedPrice($invoice->getProject()->getFixedPrice());
        }
        $invoice->setUser($this->getCurrentUser());
        $this->om->persist($invoice);
        $this->om->flush();
        return $invoice;
    }
}
