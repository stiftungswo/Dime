<?php

namespace Swo\CommonsBundle\Tests\Helper;

use Swo\CommonsBundle\Helper\DimeMoneyHelper;
use Money\Money;
use PHPUnit\Framework\TestCase;

class DimeMoneyHelpersTest extends TestCase
{

    public function testRoundTo5()
    {
        // check a few values
        $this->assertEquals(Money::CHF(1230), DimeMoneyHelper::roundTo5(Money::CHF(1230)));
        $this->assertEquals(Money::CHF(1230), DimeMoneyHelper::roundTo5(Money::CHF(1231)));
        $this->assertEquals(Money::CHF(1230), DimeMoneyHelper::roundTo5(Money::CHF(1232)));
        $this->assertEquals(Money::CHF(1235), DimeMoneyHelper::roundTo5(Money::CHF(1233)));
        $this->assertEquals(Money::CHF(1235), DimeMoneyHelper::roundTo5(Money::CHF(1234)));
        $this->assertEquals(Money::CHF(1235), DimeMoneyHelper::roundTo5(Money::CHF(1235)));
        $this->assertEquals(Money::CHF(1235), DimeMoneyHelper::roundTo5(Money::CHF(1236)));
        $this->assertEquals(Money::CHF(1235), DimeMoneyHelper::roundTo5(Money::CHF(1237)));
        $this->assertEquals(Money::CHF(1240), DimeMoneyHelper::roundTo5(Money::CHF(1238)));
        $this->assertEquals(Money::CHF(1240), DimeMoneyHelper::roundTo5(Money::CHF(1239)));
        $this->assertEquals(Money::CHF(1240), DimeMoneyHelper::roundTo5(Money::CHF(1240)));
    }

    public function testFormatWithCurrency()
    {
        $this->assertEquals('1.00 CHF', DimeMoneyHelper::formatWithCurrency(Money::CHF(100)));
        $this->assertEquals('0.50 CHF', DimeMoneyHelper::formatWithCurrency(Money::CHF(50)));
        $this->assertEquals("98765.43 CHF", DimeMoneyHelper::formatWithCurrency(Money::CHF(9876543)));
        $this->assertEquals("9876543.21 CHF", DimeMoneyHelper::formatWithCurrency(Money::CHF(987654321)));
    }

    public function testFormatWithoutCurrency()
    {
        $this->assertEquals('1.00', DimeMoneyHelper::formatWithoutCurrency(Money::CHF(100)));
        $this->assertEquals('0.50', DimeMoneyHelper::formatWithoutCurrency(Money::CHF(50)));
        $this->assertEquals("98765.43", DimeMoneyHelper::formatWithoutCurrency(Money::CHF(9876543)));
        $this->assertEquals("9876543.21", DimeMoneyHelper::formatWithoutCurrency(Money::CHF(987654321)));
    }

    public function testFixedDiscountToMoney()
    {
        $this->assertEquals(Money::CHF(123000), DimeMoneyHelper::fixedDiscountToMoney((float)1230));
        $this->assertEquals(Money::CHF(123010), DimeMoneyHelper::fixedDiscountToMoney((float)1230.1));
        $this->assertEquals(Money::CHF(123011), DimeMoneyHelper::fixedDiscountToMoney((float)1230.11));

        $this->expectException(\UnexpectedValueException::class);
        DimeMoneyHelper::fixedDiscountToMoney((float)1230.111);
    }
}
