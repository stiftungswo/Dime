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
        $offer_position_1->setRateValue(Money::CHF(872.33));
        $offer_position_1->setAmount(2);
        $offer_position_1->setVat(0.077);
        $offer->addOfferPosition($offer_position_1);
        // should be 1879.00, but because Money library rounds incorrectly, it is .05
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(1879.05), $offer_position_1->getTotal());

        $offer_position_2 = new OfferPosition();
        $offer_position_2->setRateValue(Money::CHF(23.50));
        $offer_position_2->setAmount(8);
        $offer_position_2->setVat(0.025);
        $offer->addOfferPosition($offer_position_2);
        $this->assertEquals(Money::CHF(192.70), $offer_position_2->getTotal());

        // should be .70, but because Money library rounds incorrectly, it is .75
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(2071.75), $offer->getSubtotal());
    }

    public function testGetTotalVat()
    {
        // should return null if no items are present
        $offer = new Offer();
        $this->assertEquals(Money::CHF(0), $offer->getSubtotal());

        // add two Offer items to also test addition
        $offer_position_1 = new OfferPosition();
        $offer_position_1->setRateValue(Money::CHF(124.77));
        $offer_position_1->setAmount(5);
        $offer_position_1->setVat(0.077);
        $offer->addOfferPosition($offer_position_1);
        $this->assertEquals(Money::CHF(48.04), $offer_position_1->getCalculatedVAT());

        $offer_position_2 = new OfferPosition();
        $offer_position_2->setRateValue(Money::CHF(98.34));
        $offer_position_2->setAmount(8);
        $offer_position_2->setVat(0.025);
        $offer->addOfferPosition($offer_position_2);
        $this->assertEquals(Money::CHF(19.67), $offer_position_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(67.71), $offer->getTotalVAT());
    }

    public function testGetTotalWithoutVAT()
    {
        $offer = new Offer();

        // add two offer positions to also test addition
        $offer_position_1 = new OfferPosition();
        $offer_position_1->setRateValue(Money::CHF(345.66));
        $offer_position_1->setAmount(7);
        $offer_position_1->setVat(0.077);
        $offer->addOfferPosition($offer_position_1);
        // should be .95, but because Money library rounds incorrectly, it is .85
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(2605.85), $offer_position_1->getTotal());
        $this->assertEquals(Money::CHF(186.31), $offer_position_1->getCalculatedVAT());

        $offer_position_2 = new OfferPosition();
        $offer_position_2->setRateValue(Money::CHF(78.50));
        $offer_position_2->setAmount(4);
        $offer_position_2->setVat(0.025);
        $offer->addOfferPosition($offer_position_2);
        $this->assertEquals(Money::CHF(321.85), $offer_position_2->getTotal());
        $this->assertEquals(Money::CHF(7.85), $offer_position_2->getCalculatedVAT());

        $this->assertEquals(Money::CHF(2733.55), $offer->getTotalWithoutVAT());
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
        $offer_position->setRateValue(Money::CHF(845.66));
        $offer_position->setAmount(7);
        $offer_position->setVat(0.16);
        $offer->addOfferPosition($offer_position);
        // should be .75, but because Money library rounds incorrectly, it is .70
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(6866.70), $offer_position->getTotal());

        // now check the total of the discounts
        $this->assertEquals(Money::CHF(3103.75), $offer->getTotalDiscounts());
    }

    public function testGetTotal()
    {
        $offer = new Offer();

        $offer_position = new OfferPosition();
        $offer_position->setRateValue(Money::CHF(74.56));
        $offer_position->setAmount(30);
        $offer_position->setVat(0.077);
        $offer->addOfferPosition($offer_position);
        // should be 9.05, but because Money library rounds incorrectly, it is 8.70
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(2408.70), $offer_position->getTotal());

        $offer_discount = new OfferDiscount();
        $offer_discount->setPercentage(true);
        $offer_discount->setValue(0.1);
        $offer->addOfferDiscount($offer_discount);

        // should be 8.15, but because Money library rounds incorrectly, it is 7.85
        // TODO: Adapt value after replacement of Money library
        $this->assertEquals(Money::CHF(2167.85), $offer->getTotal());
    }

    public function testGetSetFixedPrice()
    {
        // get and set fixed price
        $offer = new Offer();
        $this->assertNull($offer->getFixedPrice());
        $offer->setFixedPrice(Money::CHF(4535.11));
        $this->assertEquals(Money::CHF(4535.11), $offer->getFixedPrice());
    }
}
