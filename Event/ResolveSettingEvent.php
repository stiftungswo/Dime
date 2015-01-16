<?php
/**
 * Author: Till Wegmüller
 * Date: 1/14/15
 * Dime
 */

namespace Dime\TimetrackerBundle\Event;

use Dime\TimetrackerBundle\Entity\Setting;
use Symfony\Component\EventDispatcher\Event;

class ResolveSettingEvent extends Event
{
	protected $setting;

	protected $parameters;

	public function __construct(Setting $setting, array $parameters)
	{
		$this->setting = $setting;
		$this->parameters = $parameters;
	}

	public function getSetting()
	{
		return $this->setting;
	}

	public function getParameters()
	{
		return $this->parameters;
	}
}