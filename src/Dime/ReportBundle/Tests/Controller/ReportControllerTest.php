<?php

namespace Dime\OfferBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class ReportControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/reports')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/reports')->getStatusCode());
    }

    public function testGetReportsExpenseAction()
    {
        $this->loginAs('admin');

        // load report
        $response = $this->jsonRequest('GET', $this->api_prefix.'/reports/expense?employee=15&project=1');
        $data = json_decode($response->getContent(), true);

        // validate content
        $this->assertNotEmpty($data['timeslices']);
        $this->assertEquals(1, $data['project']['id']);
        $this->assertEquals(15, $data['employee']['id']);

        // load report
        $response = $this->jsonRequest('GET', $this->api_prefix.'/reports/expense?employee=10');
        $data = json_decode($response->getContent(), true);

        // validate content
        $this->assertTrue(count($data['timeslices']) > 0, 'expected some timeslices');
        $this->assertTrue(strlen($data['totalHours']) >= 2, 'expected totalHours to be in format "8h"');
        $this->assertEquals(10, $data['employee']['id']);
    }

    public function testGetReportsZiviweeklyAction()
    {
        $this->loginAs('admin');

        // load report
        $response = $this->jsonRequest('GET', $this->api_prefix.'/reports/ziviweekly?date=2016-03-20,2018-03-27');
        $data = json_decode($response->getContent(), true);

        // validate content
        $this->assertTrue(count($data['timeslices']) > 0);
        $this->assertTrue(strlen($data['totalHours']) >= 2, 'expected totalHours to be in format "8h"');
    }

    public function testGetReportsServicehoursAction()
    {
        $this->loginAs('admin');

        // load report
        $response = $this->jsonRequest('GET', $this->api_prefix.'/reports/servicehours?date=2017-01-01,2017-12-31');
        $data = json_decode($response->getContent(), true);

        // validate content
        $this->assertTrue(count($data['total']['activitylist']) > 0, 'expected activitylist');
        $this->assertTrue(count($data['total']['activities']) > 0, 'expected activities');
        $this->assertTrue(count($data['projects']) > 0, 'expected projects');
        $this->assertGreaterThan(0, $data['projects'][0]['total'], 'expected total not to be 0');
    }

    public function testGetReportsServicehoursCsvAction()
    {
        $this->loginAs('admin');

        // load report
        $response = $this->jsonRequest('GET', $this->api_prefix.'/reports/servicehours/csv?date=2017-01-01,2017-12-31');

        $data = $response->getContent();

        // validate content
        $this->assertContains('Servicestunden Rapport 01.01.2017 - 31.12.2017', $data);
        $this->assertContains('Test Project 10', $data);
        $csv = str_getcsv($data, ';');
        $this->assertGreaterThan(4, count($csv), 'expected more than 4 rows in CSV file');
    }

    public function testGetRevenueReportAsCSVAction()
    {
        $this->loginAs('admin');

        // load report
        $response = $this->jsonRequest('GET', $this->api_prefix . '/reports/revenue/csv?date=2017-08-01,2020-08-31');

        $data = $response->getContent();

        // validate content
        $this->assertContains('Name', $data);
        $csvrows = explode("\n", $data);
        $csv = str_getcsv($csvrows[1], ',');
        $this->assertEquals('sep=,', $csvrows[0], 'expect first row to be excel marker');
        $this->assertGreaterThan(4, count($csvrows), 'expected more than 4 rows in CSV file');
        $this->assertGreaterThan(9, count($csv), 'expected more than 9 columns in CSV file (costgroups)');
    }
}
