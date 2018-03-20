<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class PeriodControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/periods')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/periods')->getStatusCode());
    }

    public function testGetPeriodsAction()
    {
        $this->loginAs('admin');
        $response = $this->jsonRequest('GET', $this->api_prefix.'/periods');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find periods');
        $this->assertEquals('2017-01-25 00:00:00', $data[0]['start']);
    }

    public function testGetPeriodAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing period */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/periods/11111')->getStatusCode());

        /* check existing period */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/periods/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find periods');
        $this->assertEquals('2017-01-25 00:00:00', $data['start']);
    }

    public function testPostPutDeletePeriodActions()
    {
        $this->loginAs('admin');
        /* create new period */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/periods', json_encode(array(
            'user'          => 1,
            'employee'      => 7,
            "start"         => "2017-01-25 00:00:00",
            "end"           => "2017-06-07 00:00:00",
            "pensum"        => 0.8,
            "yearlyEmployeeVacationBudget" => 20,
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created period */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/periods/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('2017-01-25 00:00:00', $data['start']);
        $this->assertEquals('0.8', $data['pensum']);
        $this->assertEquals(20, $data['yearlyEmployeeVacationBudget']);


        // modify period
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/periods/' . $id, json_encode(array(
            'user'          => 4,
            'employee'      => 3,
            "start"         => "2017-02-28 00:00:00",
            "end"           => "2017-08-31 00:00:00",
            "pensum"        => 1,
            "lastYearHolidayBalance" => 22
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/periods/' . ($id+100), json_encode(array(
            'user'          => 4,
            'employee'      => 3,
            "start"         => "2017-02-28 00:00:00",
            "end"           => "2017-08-31 00:00:00",
            "pensum"        => 1,
            "lastYearHolidayBalance" => 22
        )));
        $this->assertEquals(404, $response->getStatusCode());

        // check created period
        $response = $this->jsonRequest('GET', $this->api_prefix.'/periods/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('2017-02-28 00:00:00', $data['start']);
        $this->assertEquals(1, $data['pensum']);
        $this->assertEquals(22, $data['lastYearHolidayBalance']);

        // delete period
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/periods/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        // check if period still exists
        $response = $this->jsonRequest('GET', $this->api_prefix.'/periods/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
