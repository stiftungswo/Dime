<?php
/**
 * Author: Till Wegmüller
 * Date: 2/13/15
 * Dime
 */

namespace Swo\CommonsBundle\Filter;


use DeepCopy\Filter\Filter;
use ReflectionProperty;

class NewNameFilter implements Filter
{
	private $baseName;

	public function __construct($baseName)
	{
		$this->baseName = $baseName;
	}

	/**
	 * Apply the filter to the object.
	 *
	 * @param object   $object
	 * @param string   $property
	 * @param callable $objectCopier
	 */
	public function apply($object, $property, $objectCopier)
	{
		$reflectionProperty = new ReflectionProperty($object, $property);
		$reflectionProperty->setAccessible(true);
		$reflectionProperty->setValue($object, $this->baseName.$this->randomString());
	}

	private function randomString() {
		$length = 6;
		$chars = "0123456789abcdefghijklmnopqrstuvwxyz";
		$str = "";

		for ($i = 0; $i < $length; $i++) {
			$str .= $chars[mt_rand(0, strlen($chars) - 1)];
		}

		return $str;
	}
}