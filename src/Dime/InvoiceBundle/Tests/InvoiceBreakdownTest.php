<?php

namespace Dime\InvoiceBundle\Tests;

use PHPUnit\Framework\TestCase;
use Dime\InvoiceBundle\Entity\InvoiceDiscount;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\InvoiceBundle\Entity\Invoice;
use Money\Money;
use Dime\InvoiceBundle\Service;
use Dime\InvoiceBundle\Service\InvoiceBreakdown;
use Doctrine\Common\Collections\ArrayCollection;

function makeItem($name, $value, $vat)
{
    $item = new InvoiceItem();
    $item->setRateValue(\Money\Money::CHF($value));
    $item->setAmount(1);
    $item->setVat(($vat));
    $item->setName($name);
    return $item;
}

function makeDiscount($name, $value, $percentage = false)
{
    $d = new InvoiceDiscount();
    $d->setName($name);
    $d->setValue($value);
    $d->setPercentage($percentage);
    return $d;
}

class InvoiceBreakdownTest extends TestCase
{
    private $invoice;

    protected function setUp()
    {
        $this->invoice = new Invoice();
        $items = [];
        $items[] = makeItem("Org", "100.00", "0.08");
        $items[] = makeItem("Begleitung", "200.00", "0.08");
        $items[] = makeItem("Gurken", "200.00", "0.025");
        $this->invoice->setItems(new ArrayCollection($items));
    }

    public function testNoDiscounts()
    {
        $discounts = [];
        $this->invoice->setInvoiceDiscounts(new ArrayCollection($discounts));

        $breakdown = InvoiceBreakdown::calculate($this->invoice);
        $this->assertEquals(Money::CHF("529.00"), $breakdown['total']);
    }

    public function testMixedDiscounts()
    {
        $discounts = [];
        //this is dependent on how it is inserted in UI...
        $discounts[] = makeDiscount("Tenbucks", 10.00);
        $discounts[] = makeDiscount("Half", .5, true);
        $this->invoice->setInvoiceDiscounts(new ArrayCollection($discounts));

        $breakdown = InvoiceBreakdown::calculate($this->invoice);
        $this->assertEquals(Money::CHF("259.20"), $breakdown['total']);
    }

    public function testFixedDiscount()
    {
        $discounts = [];
        $discounts[] = makeDiscount("Tenbucks", 10.00);
        $this->invoice->setInvoiceDiscounts(new ArrayCollection($discounts));

        $breakdown = InvoiceBreakdown::calculate($this->invoice);
        $this->assertEquals(Money::CHF("518.40"), $breakdown['total']);
    }

    public function testPercentDiscount()
    {
        $discounts = [];
        $discounts[] = makeDiscount("Half", .5, true);
        $this->invoice->setInvoiceDiscounts(new ArrayCollection($discounts));

        $breakdown = InvoiceBreakdown::calculate($this->invoice);
        $this->assertEquals(Money::CHF("264.50"), $breakdown['total']);
    }
}
