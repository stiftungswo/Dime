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
	public static $NoChange = '0';
	protected function loadChoiceList()
	{
		return new SimpleChoiceList(array(
			$this::$NoChange => 'Anderes',
			$this::$Hourly => 'Stunden',
			$this::$Minutely => 'Minuten',
			$this::$Dayly => 'Tage'
		));
	}
} 