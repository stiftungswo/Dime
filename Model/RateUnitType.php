<?php
/**
 * Author: Till Wegmüller
 * Date: 11/12/14
 * Dime
 */

namespace Dime\TimetrackerBundle\Model;


use Symfony\Component\Form\Extension\Core\ChoiceList\LazyChoiceList;
use Symfony\Component\Form\Extension\Core\ChoiceList\SimpleChoiceList;

class RateUnitType extends LazyChoiceList {
	public static $Hourly = 'h';
	public static $Minutely = 'm';
	public static $Dayly = 't';
	public static $NoChange = 'a';
	public static $DayInSeconds = 30240;
	public static $HourInSeconds = 3600;
	public static $MinuteInSeconds = 60;
	public static function ChoiceList()
	{
		return array(
			RateUnitType::$NoChange => 'Anderes',
			RateUnitType::$Hourly => 'Stunden',
			RateUnitType::$Minutely => 'Minuten',
			RateUnitType::$Dayly => 'Tage'
		);
	}
	protected function loadChoiceList()
	{
		return new SimpleChoiceList($this::ChoiceList());
	}
} 