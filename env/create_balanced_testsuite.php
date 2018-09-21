<?php
/* you can call this script in the following order
first param needs to be the path your junit measure file from PHPUnit.
You can run it with or without coverage, coverage tends to give more accurate results

Second param has to be how many runners you want to run. Default is pinned to 5.

Rerun this file as soon as you added new tests to the project. New files won't be picked up by PHPUnit because the script hardcodes the path to the tests.
*/

// https://www.phpflow.com/php/how-to-convert-xml-to-associative-array/
$junitFile = file_get_contents($argv[1]);
$obj = simplexml_load_string($junitFile);
$json = json_encode($obj);
$rawData = json_decode($json, true);
$phpunitConfFileLocation = '../app/phpunit.xml.dist';
$phpunitConfXml = simplexml_load_string(file_get_contents($phpunitConfFileLocation));

$nodes = $argv[2] ? (int)$argv[2] : 5;
$testSuites = array();
$executionTimes = array();

for ($i = 1; $i <= $nodes; $i++) {
    $executionTimes[] = (double)0;
    $testSuites[] = array();
}

foreach ($rawData['testsuite']['testsuite'] as $testMeasure) {
    $minValue = min($executionTimes);
    $arrKey = array_search($minValue, $executionTimes);

    // add up execution time in execution time arr and path to test in test suite array
    $executionTimes[$arrKey] = $executionTimes[$arrKey] + (double)$testMeasure['@attributes']['time'];
    $testSuites[$arrKey][] = array(
        'time' => (double)$testMeasure['@attributes']['time'],
        'file' => $testMeasure['@attributes']['file']
    );
}

// check that we have a fair "distribution" of the tests after the initial distribution
$minExecutionTime = min($executionTimes);
$maxExecutionTime = max($executionTimes);
$tries = 1;
do {
    // the half of the difference between both is the ideal thing to balance out
    $differenceToBalance = ($maxExecutionTime - $minExecutionTime)/2;
    // get the execution times from the test suite object
    $arrKeyOfMaxSuite = array_search($maxExecutionTime, $executionTimes);
    $testExecutionTimes = array_column($testSuites[$arrKeyOfMaxSuite], 'time');

    // return the closest item to the difference
    $closest = null;
    foreach ($testExecutionTimes as $item) {
        if ($closest === null || abs($differenceToBalance - $closest) > abs($item - $differenceToBalance)) {
            $closest = $item;
        }
    }

    // find the element corresponding for the closest time
    $closestItem = null;
    foreach ($testSuites[$arrKeyOfMaxSuite] as $testSuite) {
        if ($closest == $testSuite['time']) {
            $closestItem = $testSuite;
            break;
        }
    }

    // remove item from previous holder and subtract its execution time from the execution time array
    $arrKeyWithinArr = array_search($closestItem, $testSuites[$arrKeyOfMaxSuite]);
    unset($testSuites[$arrKeyOfMaxSuite][$arrKeyWithinArr]);
    $executionTimes[$arrKeyOfMaxSuite] = $executionTimes[$arrKeyOfMaxSuite] - $closestItem['time'];

    // add the item to its new holder and add the execution time to the execution time array
    $arrKeyOfMaxSuite = array_search($minExecutionTime, $executionTimes);
    $testSuites[$arrKeyOfMaxSuite][] = $closestItem;
    $executionTimes[$arrKeyOfMaxSuite] = $executionTimes[$arrKeyOfMaxSuite] + $closestItem['time'];

    // redo things for the while calculation
    $minExecutionTime = min($executionTimes);
    $maxExecutionTime = max($executionTimes);
    $tries++;
} while (($maxExecutionTime - $minExecutionTime) > (array_sum($executionTimes) / count($executionTimes) * 0.1) || $tries <= 10);

if ($phpunitConfXml->testsuites) {
    unset($phpunitConfXml->testsuites);
}

$testsuitesXml = $phpunitConfXml->addChild('testsuites');

for ($i = 0; $i <= ($nodes-1); $i++) {
    $testsuiteXml = $testsuitesXml->addChild('testsuite');
    $testsuiteXml->addAttribute('name', 'Suite_P' . $i);

    foreach ($testSuites[$i] as $testFile) {
        $testsuiteXml->addChild('file', str_replace('/var/www/html', '..', $testFile['file']));
    }
}

$phpunitConfXml->asXml($phpunitConfFileLocation);

echo("Finished balancing tests based on your JUnit file. Estimated execution time per node based on the report:\n\n");
for ($i = 0; $i <= ($nodes-1); $i++) {
    echo("Node " . $i . ": " . $executionTimes[$i] . " sec\n");
}
echo("\nPlease manually edit the phpunit.xml.dist, should the distribution be very inaccurate.\n\n");
