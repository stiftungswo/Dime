<?php

namespace Dime\OfferBundle\Tests\Entity;

use Dime\OfferBundle\Entity\Offer;
use Dime\OfferBundle\Entity\OfferDiscount;
use Dime\OfferBundle\Entity\OfferPosition;
use Money\Money;
use PHPUnit\Framework\TestCase;

class OfferTest extends TestCase
{
    public function testGetSubtotal()
    {
        // should return null if no items are present
        $offer = new Offer();
        $this->assertEquals(Money::CHF(0), $offer->getSubtotal());

        // add two offer positions to also test addition
        $offer_position_1 = new OfferPosition();
        $offer_position_1->setRateValue(Money::CHF(87233));
        $offer_position_1->setAmount(2);
        $offer_position_1->setVat(0.077);
        $offer->addOfferPosition($offer_position_1);
        $this->assertEquals(Money::CHF(187900), $offer_position_1->getTotal());

        $offer_position_2 = new OfferPosition();
        $offer_position_2->setRateValue(Money::CHF(2350));
        $offer_position_2->setAmount(8);
        $offer_position_2->setVat(0.025);
        $offer->addOfferPosition($offer_position_2);
        $this->assertEquals(Money::CHF(19270), $offer_position_2->getTotal());

        $this->assertEquals(Money::CHF(207170), $offer->getSubtotal());
    }

    public function testGetTotalVat()
    {
        // should return null if no items are present
        $offer = new Offer();
        $this->assertEquals(Money::CHF(0), $offer->getSubtotal());

        // add two Offer items to also test addition
        $offer_position_1 = new OfferPosition();
        $offer_position_1->setRateValue(Money::CHF(12477));
        $offer_position_1->setAmount(5);
        $offer_position_1->setVat(0.077);
        $offer->addOfferPosition($offer_position_1);
        $this->assertEquals(Money::CHF(4804), $offer_position_1->getCalculatedVAT());

        $offer_position_2 = new OfferPosition();
        $offer_position_2->setRateValue(Money::CHF(9834));
        $offer_position_2->setAmount(8);
        $offer_position_2->setVat(0.025);
        $offer->addOfferPosition($offer_position_2);
        $this->assertEquals(Money::CHF(1967), $offer_position_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(6771), $offer->getTotalVAT());
    }

    public function testGetTotalWithoutVAT()
    {
        $offer = new Offer();

        // add two offer positions to also test addition
        $offer_position_1 = new OfferPosition();
        $offer_position_1->setRateValue(Money::CHF(34566));
        $offer_position_1->setAmount(7);
        $offer_position_1->setVat(0.077);
        $offer->addOfferPosition($offer_position_1);

        $this->assertEquals(Money::CHF(260595), $offer_position_1->getTotal());
        $this->assertEquals(Money::CHF(18631), $offer_position_1->getCalculatedVAT());

        $offer_position_2 = new OfferPosition();
        $offer_position_2->setRateValue(Money::CHF(7850));
        $offer_position_2->setAmount(4);
        $offer_position_2->setVat(0.025);
        $offer->addOfferPosition($offer_position_2);
        $this->assertEquals(Money::CHF(32185), $offer_position_2->getTotal());
        $this->assertEquals(Money::CHF(785), $offer_position_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(273365), $offer->getTotalWithoutVAT());
    }

    public function testGetTotalDiscounts()
    {
        // should return 0 if no offer discounts are assigned
        $offer = new Offer();
        $this->assertEquals(Money::CHF(0), $offer->getTotalDiscounts());

        // calculate discount
        $offer_discount = new OfferDiscount();
        $offer_discount->setPercentage(true);
        $offer_discount->setValue(0.452);
        $offer->addOfferDiscount($offer_discount);

        $offer_position = new OfferPosition();
        $offer_position->setRateValue(Money::CHF(84566));
        $offer_position->setAmount(7);
        $offer_position->setVat(0.16);
        $offer->addOfferPosition($offer_position);
        $this->assertEquals(Money::CHF(686675), $offer_position->getTotal());

        // now check the total of the discounts
        $this->assertEquals(Money::CHF(310375), $offer->getTotalDiscounts());
    }

    public function testGetTotal()
    {
        $offer = new Offer();

        $offer_position = new OfferPosition();
        $offer_position->setRateValue(Money::CHF(7456));
        $offer_position->setAmount(30);
        $offer_position->setVat(0.077);
        $offer->addOfferPosition($offer_position);
        $this->assertEquals(Money::CHF(240905), $offer_position->getTotal());

        $offer_discount = new OfferDiscount();
        $offer_discount->setPercentage(true);
        $offer_discount->setValue(0.1);
        $offer->addOfferDiscount($offer_discount);

        $this->assertEquals(Money::CHF(216815), $offer->getTotal());
    }

    public function testGetSetFixedPrice()
    {
        // get and set fixed price
        $offer = new Offer();
        $this->assertNull($offer->getFixedPrice());
        $offer->setFixedPrice(Money::CHF(453511));
        $this->assertEquals(Money::CHF(453511), $offer->getFixedPrice());
    }
}
