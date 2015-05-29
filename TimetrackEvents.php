<?php
/**
 * Author: Till Wegmüller
 * Date: 1/14/15
 * Dime
 */

namespace Dime\TimetrackerBundle;


final class TimetrackEvents {
	/**
	 * @var string
	 */
	const ENTITY_PRE_FORM_SET_DATA = 'dime.entity.pre_form_set_data';

	/**
	 * @var string
	 */
	const ENTITY_PRE_PERSIST = 'dime.entity.pre_persist';

	/**
	 * @var string
	 */
	const ENTITY_POST_PERSIST = 'dime.entity.post_persist';
}