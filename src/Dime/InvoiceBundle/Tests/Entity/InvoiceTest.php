<?php

namespace Dime\InvoiceBundle\Tests\Entity;

use Dime\InvoiceBundle\Entity\Invoice;
use Dime\InvoiceBundle\Entity\InvoiceDiscount;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Money\Money;
use PHPUnit\Framework\TestCase;

class InvoiceTest extends TestCase
{

    public function testGetTotalDiscounts()
    {
        // should return 0 if no invoicediscounts are assigned
        $invoice = new Invoice();
        $this->assertEquals(Money::CHF(0), $invoice->getTotalDiscounts());

        // calculate discount
        $invoice_discount = new InvoiceDiscount();
        $invoice_discount->setPercentage(true);
        $invoice_discount->setValue(0.1);
        $invoice->addInvoiceDiscount($invoice_discount);

        $invoice_item = new InvoiceItem();
        $invoice_item->setRateValue(Money::CHF(56744));
        $invoice_item->setAmount(3);
        $invoice_item->setVat(0.78);
        $invoice->addItem($invoice_item);

        $this->assertEquals(Money::CHF(303013), $invoice_item->getTotal());

        // now check the total of the discounts
        $this->assertEquals(Money::CHF(30301), $invoice->getTotalDiscounts());
    }

    public function testGetSubtotal()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // add two invoice items to also test addition
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(87233));
        $invoice_item_1->setAmount(2);
        $invoice_item_1->setVat(0.077);
        $invoice->addItem($invoice_item_1);
        $this->assertEquals(Money::CHF(187900), $invoice_item_1->getTotal());

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(2350));
        $invoice_item_2->setAmount(8);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);
        $this->assertEquals(Money::CHF(19270), $invoice_item_2->getTotal());

        $this->assertEquals(Money::CHF(207170), $invoice->getSubtotal());
    }

    public function testGetTotalVat()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // add two invoice items to also test addition
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(12477));
        $invoice_item_1->setAmount(5);
        $invoice_item_1->setVat(0.077);
        $invoice->addItem($invoice_item_1);
        $this->assertEquals(Money::CHF(4804), $invoice_item_1->getCalculatedVAT());

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(9834));
        $invoice_item_2->setAmount(8);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);
        $this->assertEquals(Money::CHF(1967), $invoice_item_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(6771), $invoice->getTotalVAT());
    }

    public function testGetTotalVat8()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // should only calc items with 0.080 VAT
        // so add two items
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(764901));
        $invoice_item_1->setAmount(2);
        $invoice_item_1->setVat(0.080);
        $invoice->addItem($invoice_item_1);
        $this->assertEquals(Money::CHF(122384), $invoice_item_1->getCalculatedVAT());

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(746540));
        $invoice_item_2->setAmount(3);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);

        $this->assertEquals(Money::CHF(122384), $invoice->getTotalVAT8());
    }

    public function testGetTotalVat2()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // should only calc items with 0.080 VAT
        // so add two items
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(986410));
        $invoice_item_1->setAmount(5);
        $invoice_item_1->setVat(0.080);
        $invoice->addItem($invoice_item_1);

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(34449));
        $invoice_item_2->setAmount(15);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);
        $this->assertEquals(Money::CHF(12918), $invoice_item_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(12918), $invoice->getTotalVAT2());
    }

    public function testGetSetFixedPrice()
    {
        // get and set fixed price
        $invoice = new Invoice();
        $this->assertNull($invoice->getFixedPrice());
        $invoice->setFixedPrice(Money::CHF(453511));
        $this->assertEquals(Money::CHF(453511), $invoice->getFixedPrice());
    }
}
