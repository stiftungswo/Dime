<?php
/**
 * Author: Till Wegmüller
 * Date: 1/14/15
 * Dime
 */

namespace Dime\TimetrackerBundle;


final class TimetrackEvents {
	/**
	 * The setting.resolve Event is thrown everytime Settings
	 * are loaded and could need some Aditional Code Execution
	 *
	 * The event listener receives an
	 * Dime\TimetrackerBundle\Event\ResolveSettingEvent instance.
	 *
	 * @var string
	 */
	const SETTING_RESOLVE = 'setting.resolve';
}