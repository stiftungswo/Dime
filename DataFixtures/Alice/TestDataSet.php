<?php
/**
 * Author: Till Wegmüller
 * Date: 6/1/15
 * Dime
 */


$set = new h4cc\AliceFixturesBundle\Fixtures\FixtureSet(array(
	'locale' => 'de_DE',
	'seed' => 123123123,
	'do_drop' => true,
	'do_persist' => true,
	'order' => 1
));

$set->addFile(__DIR__.'/Users.yaml', 'yaml');
$set->addFile(__DIR__.'/RateGroups.yaml', 'yaml');
$set->addFile(__DIR__.'/Tags.yaml', 'yaml');
$set->addFile(__DIR__.'/Rates.yaml', 'yaml');
$set->addFile(__DIR__.'/Services.yaml', 'yaml');
$set->addFile(__DIR__.'/StandardDiscounts.yaml', 'yaml');
$set->addFile(__DIR__.'/Settings.yaml', 'yaml');
$set->addFile(__DIR__.'/Customers.yaml', 'yaml');
$set->addFile(__DIR__.'/Projects.yaml', 'yaml');
$set->addFile(__DIR__.'/Activities.yaml', 'yaml');
$set->addFile(__DIR__.'/Timeslices.yaml', 'yaml');

return $set;