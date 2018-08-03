<?php

namespace Dime\InvoiceBundle\Tests\Entity;

use Dime\InvoiceBundle\Entity\InvoiceDiscount;
use Money\Money;
use PHPUnit\Framework\TestCase;

class InvoiceDiscountTest extends TestCase
{
    public function testGetCalculatedDiscount()
    {
        // should return its own value if not percentage
        $invoice_discount = new InvoiceDiscount();
        $invoice_discount->setValue(57384.44);
        $this->assertEquals(
            Money::CHF(57384.44),
            $invoice_discount->getCalculatedDiscount(Money::CHF(786.55))
        );

        // should return percentage value
        $invoice_discount->setPercentage(true);
        $invoice_discount->setValue(0.69);
        $this->assertEquals(Money::CHF(542.72), $invoice_discount->getCalculatedDiscount(Money::CHF(786.55)));
    }
}
