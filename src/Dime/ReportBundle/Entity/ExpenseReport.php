<?php
/**
 * Author: Till Wegmüller
 * Date: 6/24/15
 * Dime
 */

namespace Dime\ReportBundle\Entity;

use Dime\EmployeeBundle\Entity\Employee;
use Dime\InvoiceBundle\Entity\Invoice;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Doctrine\Common\Collections\ArrayCollection;
use JMS\Serializer\Annotation as JMS;

class ExpenseReport extends Report
{
    public function __construct()
    {
        $this->timeslices = new ArrayCollection();
        $this->comments = new ArrayCollection();
    }

    /**
     * @var ArrayCollection
     */
    protected $timeslices;

    /**
     * @var mixed
     */
    protected $employee;

    /**
     * @var ArrayCollection
     */
    protected $comments;

    /**
     * @var Invoice
     */
    protected $invoice;

    /**
     * @return mixed
     */
    public function getEmployee()
    {
        return $this->employee;
    }

    /**
     * @param mixed $employee
     */
    public function setEmployee($employee)
    {
        $this->employee = $employee;
    }

    /**
     * @return mixed
     */
    public function getTimeslices()
    {
        return $this->timeslices;
    }

    /**
     * @param mixed $timeslices
     *
     * @return $this
     */
    public function setTimeslices($timeslices)
    {
        $this->timeslices = $timeslices;
        return $this;
    }

    /**
     * @param Timeslice $timeslice
     *
     * @return $this
     */
    public function addTimeslices(Timeslice $timeslice)
    {
        $this->timeslices->add($timeslice);
        return $this;
    }

    /**
     * @param Timeslice $timeslice
     *
     * @return $this
     */
    public function removeTimeslices(Timeslice $timeslice)
    {
        $this->timeslices->removeElement($timeslice);
        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getComments()
    {
        return $this->comments;
    }

    /**
     * @param ArrayCollection $comments
     *
     * @return ExpenseReport
     */
    public function setComments(ArrayCollection $comments)
    {
        $this->comments = $comments;
        return $this;
    }

    /**
     * @JMS\VirtualProperty()
     * @JMS\SerializedName("totalHours")
     */
    public function getSumHours()
    {
        $total = 0;
        foreach ($this->timeslices as $timeslice) {
            if (!is_null($timeslice->getActivity()) && !is_null($timeslice->getActivity()->getRateUnitType()) && $timeslice->getActivity()->getRateUnitType()->getId() !== RateUnitType::$NoChange) {
                $total += $timeslice->getValue();
            }
        }
        if ($total !== 0) {
            $total = round(($total / 3600), 2).'h';
        }
        return $total;
    }

    public function getGroupedTimeslices()
    {
        $groups = [];

        /** @var Timeslice $timeslice */
        foreach ($this->timeslices as $timeslice) {
            $groups[$timeslice->getStartedAt()->format('d.m.Y')][] = $timeslice;
        }

        return $groups;
    }

    /**
     * @return Invoice
     */
    public function getInvoice()
    {
        return $this->invoice;
    }

    /**
     * @param Invoice $invoice
     *
     * @return ExpenseReport
     */
    public function setInvoice(Invoice $invoice)
    {
        $this->invoice = $invoice;

        return $this;
    }
}
