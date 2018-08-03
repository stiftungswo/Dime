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
        $invoice_item->setRateValue(Money::CHF(567.44));
        $invoice_item->setAmount(3);
        $invoice_item->setVat(0.78);
        $invoice->addItem($invoice_item);

        // check total of item first
        // should be 3030.13, but because Money library rounds incorrectly, it is .20
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(3030.20), $invoice_item->getTotal());

        // now check the total of the discounts
        $this->assertEquals(Money::CHF(303.01), $invoice->getTotalDiscounts());
    }

    public function testGetSubtotal()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // add two invoice items to also test addition
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(872.33));
        $invoice_item_1->setAmount(2);
        $invoice_item_1->setVat(0.077);
        $invoice->addItem($invoice_item_1);
        // should be 1879.00, but because Money library rounds incorrectly, it is .05
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(1879.05), $invoice_item_1->getTotal());

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(23.50));
        $invoice_item_2->setAmount(8);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);
        $this->assertEquals(Money::CHF(192.70), $invoice_item_2->getTotal());

        // should be .70, but because Money library rounds incorrectly, it is .75
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(2071.75), $invoice->getSubtotal());
    }

    public function testGetTotalVat()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // add two invoice items to also test addition
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(124.77));
        $invoice_item_1->setAmount(5);
        $invoice_item_1->setVat(0.077);
        $invoice->addItem($invoice_item_1);
        $this->assertEquals(Money::CHF(48.04), $invoice_item_1->getCalculatedVAT());

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(98.34));
        $invoice_item_2->setAmount(8);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);
        $this->assertEquals(Money::CHF(19.67), $invoice_item_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(67.71), $invoice->getTotalVAT());
    }

    public function testGetTotalVat8()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // should only calc items with 0.080 VAT
        // so add two items
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(7649.01));
        $invoice_item_1->setAmount(2);
        $invoice_item_1->setVat(0.080);
        $invoice->addItem($invoice_item_1);
        $this->assertEquals(Money::CHF(1223.84), $invoice_item_1->getCalculatedVAT());

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(7465.4));
        $invoice_item_2->setAmount(3);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);

        $this->assertEquals(Money::CHF(1223.84), $invoice->getTotalVAT8());
    }

    public function testGetTotalVat2()
    {
        // should return null if no items are present
        $invoice = new Invoice();
        $this->assertNull($invoice->getSubtotal());

        // should only calc items with 0.080 VAT
        // so add two items
        $invoice_item_1 = new InvoiceItem();
        $invoice_item_1->setRateValue(Money::CHF(9864.1));
        $invoice_item_1->setAmount(5);
        $invoice_item_1->setVat(0.080);
        $invoice->addItem($invoice_item_1);

        $invoice_item_2 = new InvoiceItem();
        $invoice_item_2->setRateValue(Money::CHF(344.49));
        $invoice_item_2->setAmount(15);
        $invoice_item_2->setVat(0.025);
        $invoice->addItem($invoice_item_2);
        $this->assertEquals(Money::CHF(129.18), $invoice_item_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(129.18), $invoice->getTotalVAT2());
    }

    public function testGetSetFixedPrice()
    {
        // get and set fixed price
        $invoice = new Invoice();
        $this->assertNull($invoice->getFixedPrice());
        $invoice->setFixedPrice(Money::CHF(4535.11));
        $this->assertEquals(Money::CHF(4535.11), $invoice->getFixedPrice());
    }
}
