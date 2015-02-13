<?php
namespace Dime\TimetrackerBundle\Model;


use DeepCopy\DeepCopy;

interface DimeEntityInterface
{
	static function getCopyFilters(DeepCopy $deepCopy);
}