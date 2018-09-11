<?php

namespace Swo\CommonsBundle\Helper;

/* 20180904 APF we used to have a fork of the Money library to add a few swiss specific functionalities to it
but the fork got never updated, and generally having a fork in our context makes things a lot more complex
as a new Zivi always has to remember to sometimes fetch the newest changes from the upstream. Those could conflict
with our changes, and so we're going to have more issues.

Because the money class is final and we don't want a fork, we add a little helper class here with a few static methods. */

use Money\Money;
use UnexpectedValueException;

class DimeMoneyHelper
{
    /**
     * Function to round the given money to the next 5 or 0 and return a money as well
     *
     * @param Money $money
     * @return Money
     */
    public static function roundTo5(Money $money)
    {
        return Money::CHF((int)round($money->getAmount() / 5) * 5);
    }

    /**
     * Format a money value to a string object with its saved currency
     *
     * @param Money $money
     * @return string
     */
    public static function formatWithCurrency(Money $money) : string
    {
        return self::formatWithoutCurrency($money) . ' ' . $money->getCurrency()->getName();
    }

    /**
     * Format a money value to a string object
     *
     * @param Money $money
     * @return string
     */
    public static function formatWithoutCurrency(Money $money) : string
    {
        return number_format($money->getAmount()/100, 2, '.', "");
    }

    /**
     * converts a value from a fixed discount item into a valid money object
     *
     * @param $value
     * @return Money
     * @throws UnexpectedValueException
     */
    public static function fixedDiscountToMoney($value) : Money
    {
        if (strpos($value, '.') !== false) {
            $splittedValue = explode('.', $value, 2);

            switch (strlen($splittedValue[1])) {
                case 1:
                    return Money::CHF(intval(str_replace('.', '', $value)) * 10);
                    break;
                case 2:
                    return Money::CHF(intval(str_replace('.', '', $value)));
                    break;
                default:
                    throw new UnexpectedValueException('Invalid value for fixed discount!');
            }
        } else {
            return Money::CHF(intval($value) * 100);
        }
    }
}