<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;


use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Model\RateUnitType;

class InvoiceItem {
	public $type;
	public $rate;
	public $value;
	public $rateUnit;
	public $charge;

	public function __construct(Activity $activity)
	{
		$this->type     = $activity->getName();
		$this->rate     = $activity->getRate();
		$this->value   = $activity->getValue();
		$this->rateUnit = $activity->getRateUnit();
		$this->rateUnitType = $activity->getRateUnitType();
		$this->charge = ceil($activity->getCharge());
	}
} 