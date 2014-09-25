<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;


use Dime\TimetrackerBundle\Entity\Activity;

class InvoiceItem {
	public $rate;
	public $amount;
	public $rateUnit;
	public $charge;

	public function __construct(Activity $activity)
	{
		$this->rate     = $activity->getRate();
		$this->amount   = $activity->getDuration();
		$this->rateUnit = $activity->getService()->getRateUnit();
		$this->charge   = ($activity->getRate() * $activity->getDuration());
	}
} 