<?php
/**
 * Author: Till Wegmüller
 * Date: 1/14/15
 * Dime
 */

namespace Dime\TimetrackerBundle\Event;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Symfony\Component\EventDispatcher\Event;

class DimeEntityPersistEvent extends Event
{
	protected $entity;

	public function __construct(DimeEntityInterface $entity)
	{
		$this->entity = $entity;
	}

	public function getEntity()
	{
		return $this->entity;
	}
}