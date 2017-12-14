<?php

namespace Dime\InvoiceBundle\Service;

use Dime\InvoiceBundle\Entity\InvoiceDiscount;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\InvoiceBundle\Entity\Invoice;
use Money\Money;

function groupByVAT($items){
    $vatGroups = [];
    foreach($items as $item){
        $vat = $item->getVat();
        if(!array_key_exists($vat, $vatGroups)){
            $vatGroups[$vat] = [];
        }
        $group = $vatGroups[$vat];
        $group[] = $item;
        $vatGroups[$vat] = $group;
    }
    return  $vatGroups;
}

function valueDistribution($groups){
    $sums = [];
    $total = Money::CHF(0);
    foreach($groups as $vat => $items){
        $sum = Money::CHF(0);
        foreach($items as $item){
            $sum = $sum->add($item->getCalculatedTotal());
        }
        $sums[$vat] = $sum;
        $total = $total->add($sum);
    }

    $distributions = [];
    foreach($sums as $vat => $sum){
        $distributions[$vat] = $sum->divide((float)$total->format())->format();
    }
    return $distributions;
}

function applyDiscount($vatGroups, InvoiceDiscount $discount){
    if($discount->getPercentage()){
        return applyDiscountFactor($vatGroups, (float)$discount->getValue(), $discount->getName());
    } else {
        return applyDiscountAmount($vatGroups, Money::CHF($discount->getValue()), $discount->getName());
    }
}

function applyDiscountFactor($vatGroups, $factor, $name){

    $discountedGroups = [];
    foreach($vatGroups as $vat => $group){
        $sum = Money::CHF(0);
        foreach($group as   $item){
            $sum = $sum->add($item->getCalculatedTotal());
        }
        $item = new InvoiceItem();
        $item->setName("%%$name");
        $item->setVat($vat);
        $item->setAmount(1);
        $item->setRateValue($sum->multiply(-1)->multiply($factor));
        $group[] = $item;
        $discountedGroups[$vat] = $group;
    }

    return $discountedGroups;
}

function applyDiscountAmount($vatGroups, Money $amount, $name){
    $distribution = valueDistribution($vatGroups);
    $cuts = $amount->allocate($distribution);

    $discountedGroups = [];
    $i = 0;
    foreach($vatGroups as $vat => $group){
        $item = new InvoiceItem();
        $item->setName("%%$name");
        $item->setVat($vat);
        $item->setAmount(1);
        $item->setRateValue($cuts[$i]->multiply(-1));
        $group[] = $item;
        $discountedGroups[$vat] = $group;
        $i += 1;
    }

    return $discountedGroups;
}

function applyVat($vatGroups){
    $totalItems = [];
    foreach($vatGroups as $vat => $items){
        foreach($items as $item){
            $mult = ((float)$vat) + 1;
            $totalItems[] = $item->getCalculatedTotal()->multiply($mult);
        }
    }
    return $totalItems;
}

function startsWith($haystack, $needle)
{
     $length = strlen($needle);
     return (substr($haystack, 0, $length) === $needle);
}

class InvoiceBreakdown{

    public static function calculate(Invoice $invoice){
        $itemCollection = $invoice->getItems();
        $items = [];
        if($itemCollection != null){
            $items = $itemCollection->toArray();
        }
        $vatGroups = groupByVAT($items);
        $subTotal = $vatGroups;
        foreach($invoice->getInvoiceDiscounts() as $discount){
            $subTotal = applyDiscount($subTotal, $discount);
        }

        $sum = Money::CHF(0);
        $discount = Money::CHF(0);
        $breakdown = [];
        $breakdown['items'] = [];
        $breakdown['discounts'] = [];
        $vat = Money::CHF(0);
        $vatSums = [];
        foreach($vatGroups as $group => $_){
            $vatSums[$group] = Money::CHF(0);
        }

        foreach($subTotal as $group){
            foreach($group as $item){
                if(self::isDiscount($item)){
                    $discount = $discount->add($item->getCalculatedTotal());
                    $breakdown['discounts'][] = $item;
                } else {
                    $sum = $sum->add($item->getCalculatedTotal());
                    $breakdown['items'][] = $item;
                }
                $vatSums[$item->getVat()] = $vatSums[$item->getVat()]->add($item->getCalculatedVAT());
                $vat = $vat->add($item->getCalculatedVAT());
            }
        }
        $breakdown['subtotal'] = $sum->format();
        $breakdown['discount'] = $discount->format();
        $breakdown['vat'] = $vat->format();
        $breakdown['total'] = $sum->add($discount)->add($vat)->format();
        $breakdown['vatSplit'] = [];
        foreach($vatSums as $key => $vatSum){
            $breakdown['vatSplit'][$key] = $vatSum->format();
        }
        return $breakdown;
    }

    /**
     * @param $item
     * @return bool
     */
    public static function isDiscount($item)
    {
        return startswith($item->getName(), "%%");
    }
}