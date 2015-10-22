<?php
/**
 * Author: Till Wegmüller
 * Date: 3/12/15
 * Dime
 */

namespace Dime\PrintingBundle\Extensions;


class CharBoxExtension extends \Twig_Extension
{
	public function getFilters()
	{
		return array(
			new \Twig_SimpleFilter('charbox', array($this, 'charboxFilter'), array('is_safe' => array('html')))
		);
	}

	public function charboxFilter($string, $maxchars = 10)
	{
		if(strlen($string) > $maxchars){
			throw new \InvalidArgumentException("Too many Character, not enough space to print", 500);
		}
		$arr = str_split($string);
		$output = '';
		foreach($arr as $char)
		{
			$output = '<div height="5mm" width="4mm" margin-right="1mm" float="right" >'.$char.'</div>'.$output;
		}
		return $output;
	}

	/**
	 * Returns the name of the extension.
	 *
	 * @return string The extension name
	 */
	public function getName()
	{
		return 'charbox_extension';
	}
}