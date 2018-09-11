<?php

namespace Dime\InvoiceBundle\Entity;

use Swo\CommonsBundle\Entity\AbstractEntity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @package Dime\InvoiceBundle\Entity
 *
 * @ORM\Table(name="invoice_costgroups")
 * @ORM\Entity(repositoryClass="Dime\InvoiceBundle\Entity\InvoiceCostgroupRepository")
 * @Json\Schema("invoice_costgroups")
 */
class InvoiceCostgroup extends AbstractEntity implements DimeEntityInterface
{
    /**
     * @var Invoice
     *
     * @Assert\NotBlank()
     * @ORM\ManyToOne(targetEntity="Invoice", inversedBy="costgroups")
     * @ORM\JoinColumn(name="invoice_id", referencedColumnName="id")
     * @JMS\Exclude()
     */
    protected $invoice;

    /**
     * @var Costgroup
     *
     * @ORM\ManyToOne(targetEntity="Costgroup")
     * @ORM\JoinColumn(name="costgroup_id", referencedColumnName="id")
     */
    protected $costgroup;

    /**
     * @var float
     *
     * @ORM\Column(type="float", nullable=false)
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
    public function getWeight()
    {
        return $this->weight;
    }

    /**
     * @param float $weight
     */
    public function setWeight($weight)
    {
        $this->weight = $weight;
    }
}
