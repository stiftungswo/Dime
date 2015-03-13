<?php
/**
 * Author: Till Wegmüller
 * Date: 3/12/15
 * Dime
 */

namespace Dime\InvoiceBundle\Extensions;


use Swo\Money\lib\Money\Currency;
use Swo\Money\lib\Money\Money;

class Float2MoneyStringExtension extends \Twig_Extension {

	public function getFilters()
	{
		return array(
			new \Twig_SimpleFilter('float2moneystring', array($this, 'float2moneystringFilter'))
		);
	}

	/**
	 * @param     $number
	 * @param int $returntype
	 *
	 * Returns a String of Money from a float.
	 *
	 * ReturnType defines what should be returned
	 * 0 string of floatval
	 * 1 string of only the full moneypart
	 * 2 string of only the partial part of the float
	 *
	 * @return mixed|string
	 */
	public function float2moneystringFilter($number, $returntype = 0)
	{
		if(! floatval($number)){
			throw new \InvalidArgumentException("\$number must be a float", 500);
		}
		$money = new Money($number, new Currency('CHF'));
		if($returntype == 0){
			return $money->UnitsTostring($money->getAmount());
		} elseif ($returntype == 1){
			return substr_replace($money->getAmount(), '', -2);
		} elseif ($returntype == 2){
			return substr($money->getAmount(), -2);
		} else {
			return '';
		}

	}

	/**
	 * Returns the name of the extension.
	 *
	 * @return string The extension name
	 */
	public function getName()
	{
		return 'float2moneystring_extension';
	}
}