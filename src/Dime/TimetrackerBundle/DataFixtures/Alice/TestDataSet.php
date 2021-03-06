<?php
/**
 * Author: Till Wegmüller
 * Date: 6/1/15
 * Dime
 */
$alicepath = '/DataFixtures/Alice';

$bundleRoot = realpath(__DIR__ . '/../../../');

$set = new h4cc\AliceFixturesBundle\Fixtures\FixtureSet(array(
    'locale' => 'de_CH',
    'seed' => 123123123,
    'do_drop' => true,
    'do_persist' => true
));

$bundleFixturePath = $bundleRoot . '/TimetrackerBundle' . $alicepath;

// Base Data
$set->addFile($bundleFixturePath . '/Users.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/RateGroups.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/RateUnitTypes.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Tags.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Settings.yaml', 'yaml');

$bundleFixturePath = $bundleRoot . '/EmployeeBundle' . $alicepath;
// EmployeeBundle
$set->addFile($bundleFixturePath . '/Employees.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Periods.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Holidays.yaml', 'yaml');

$bundleFixturePath = $bundleRoot . '/TimetrackerBundle' . $alicepath;
// TimetrackerBundle
$set->addFile($bundleFixturePath . '/Rates.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Services.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Customers.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/ProjectCategories.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Projects.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/ProjectComments.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Activities.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Timeslices.yaml', 'yaml');

$bundleFixturePath = $bundleRoot . '/InvoiceBundle' . $alicepath;
// InvoiceBundle
$set->addFile($bundleFixturePath . '/InvoiceDiscounts.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Invoices.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/InvoiceItems.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Costgroups.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/InvoiceCostgroups.yaml', 'yaml');

$bundleFixturePath = $bundleRoot . '/OfferBundle' . $alicepath;
// OfferBundle
$set->addFile($bundleFixturePath . '/OfferStatusUCs.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/OfferDiscounts.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/Offers.yaml', 'yaml');
$set->addFile($bundleFixturePath . '/OfferPositions.yaml', 'yaml');

return $set;
