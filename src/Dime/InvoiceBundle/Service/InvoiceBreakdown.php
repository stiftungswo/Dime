<?php

namespace Dime\InvoiceBundle\Service;

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

function applyDiscountFactor($vatGroups, $factor){

    $discountedGroups = [];
    foreach($vatGroups as $vat => $group){
        $sum = Money::CHF(0);
        foreach($group as   $item){
            $sum = $sum->add($item->getCalculatedTotal());
        }
        $item = new InvoiceItem();
        $item->setName("%%Discount " . $vat);
        $item->setVat($vat);
        $item->setAmount(1);
        $item->setRateValue($sum->multiply(-1)->multiply($factor));
        $group[] = $item;
        $discountedGroups[$vat] = $group;
    }

    return $discountedGroups;
}

function applyDiscount($vatGroups, Money $amount){
    $distribution = valueDistribution($vatGroups);
    $cuts = $amount->allocate($distribution);

    $discountedGroups = [];
    $i = 0;
    foreach($vatGroups as $vat => $group){
        $item = new InvoiceItem();
        $item->setName("%%Discount " . $vat);
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
        $items = $invoice->getItems()->toArray();
        $vatGroups = groupByVAT($items);
        $subTotal = $vatGroups;
        foreach($invoice->getInvoiceDiscounts() as $discount){
            if($discount->getPercentage()){
                $subTotal = applyDiscountFactor($subTotal, $discount->getValue()/100);
            } else {
                $subTotal = applyDiscount($subTotal, Money::CHF($discount->getValue()));
            }
        }
        //$total = applyVat($subTotal);
        //print_r($total);

        $sum = Money::CHF(0);
        $discount = Money::CHF(0);
        $breakdown = [];
        $breakdown['items'] = [];
        $breakdown['discounts'] = [];

        foreach($subTotal as $group){
            foreach($group as $item){
                if(startswith($item->getName(), "%%")){
                    $discount = $discount->add($item->getTotal());
                    $breakdown['discounts'][] = $item;
                } else {
                    $sum = $sum->add($item->getTotal());
                    $breakdown['items'][] = $item;
                }
            }
        }
        $breakdown['subtotal'] = $sum;
        $breakdown['discount'] = $discount;
        $breakdown['total'] = $sum->add($discount);
        return $breakdown;
    }
}