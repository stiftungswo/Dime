<?php

namespace Dime\OfferBundle\Tests\Entity;

use Dime\OfferBundle\Entity\OfferDiscount;
use Money\Money;
use PHPUnit\Framework\TestCase;

class OfferDiscountTest extends TestCase
{
    public function testGetCalculatedDiscount()
    {
        // should return its own value if not percentage
        $offer_discount = new OfferDiscount();
        $offer_discount->setValue(87263.34);
        $this->assertEquals(
            Money::CHF(87263.34),
            $offer_discount->getCalculatedDiscount(Money::CHF(0))
        );

        // should return percentage value
        $offer_discount->setPercentage(true);
        $offer_discount->setValue(0.12);
        $this->assertEquals(Money::CHF(91.85), $offer_discount->getCalculatedDiscount(Money::CHF(765.44)));
    }
}
