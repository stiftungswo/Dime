<?php

namespace Dime\InvoiceBundle\Entity;

use Carbon\Carbon;
use DateTime;
use Dime\EmployeeBundle\Entity\Employee;
use Dime\TimetrackerBundle\Entity\Customer;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Entity\StandardDiscount;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Money\Money;
use Symfony\Component\Validator\Constraints as Assert;
use Dime\InvoiceBundle\Service\InvoiceBreakdown;

/**
 * @package Dime\InvoiceBundle\Entity
 *
 * @ORM\Table(name="invoice_costgroups")
 * @ORM\Entity
 * @Json\Schema("invoice_costgroups")
 */
class InvoiceCostgroup extends Entity implements DimeEntityInterface
{
    /**
     * @var Invoice
     *
     * @Assert\NotBlank()
     * @ORM\ManyToOne(targetEntity="Invoice", inversedBy="costgroups")
     * @ORM\JoinColumn(name="invoice_id", referencedColumnName="id")
     */
    protected $invoice;

    /**
     * @var Costgroup
     *
     * @Assert\NotBlank()
     * @ORM\ManyToOne(targetEntity="Costgroup")
     * @ORM\JoinColumn(name="costgroup_id", referencedColumnName="id")
     */
    protected $costgroup;

	/**
	 * @var float
	 *
	 * @Assert\NotBlank()
	 * @ORM\Column(type="float")
	 */
	protected $weight;

    /**
     * @return Invoice
     */
    public function getInvoice()
    {
        return $this->invoice;
    }

    /**
     * @param Invoice $invoice
     */
    public function setInvoice($invoice)
    {
        $this->invoice = $invoice;
    }

    /**
     * @return Costgroup
     */
    public function getCostgroup()
    {
        return $this->costgroup;
    }

    /**
     * @param Costgroup $costgroup
     */
    public function setCostgroup($costgroup)
    {
        $this->costgroup = $costgroup;
    }

    /**
     * @return float
     */
    public function getRatio()
    {
        return $this->ratio;
    }

    /**
     * @param float $ratio
     */
    public function setRatio($ratio)
    {
        $this->ratio = $ratio;
    }

}
