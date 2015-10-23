<?php
/**
 * Author: Till Wegmüller
 * Date: 3/23/15
 * Dime
 */

namespace Dime\InvoiceBundle\Service;

use Carbon\Carbon;

class InvoiceDateRangeCalculator
{

    public function getByType($dateRangeType)
    {
        switch ($dateRangeType) {
            case 'ly':
                return $this->getPeriod('Year', true);
            break;
            case 'lm':
                return $this->getPeriod('Month', true);
            break;
            case 'lw':
                return $this->getPeriod('Week', true);
            break;
            case 'ty':
                return $this->getPeriod('Year', false);
            break;
            case 'tm':
                return $this->getPeriod('Month', false);
            break;
            case 'tw':
                return $this->getPeriod('Week', false);
            break;
            default:
                return array();
            break;
        }
    }

    /**
     * Returns Dates from $last $period
     *
     * @param string $period
     *
     * @param bool   $last
     *
     * @return array
     */
    private function getPeriod($period = 'Year', $last = true)
    {
        $startfunction = 'startOf'.$period;
        $endfunction = 'endOf'.$period;
        $subfunction = 'sub'.$period;
        $carb = Carbon::today();
        if ($last) {
            $carb->$subfunction();
        }
        return array(
                'start' => $carb->$startfunction(),
                'end' => $carb->$endfunction(),
            );
    }
}
