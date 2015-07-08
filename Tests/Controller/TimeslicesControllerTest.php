<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class TimeslicesControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/timeslices')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/timeslices')->getStatusCode());
    }

    public function testGetActivitiesTimeSlicesAction()
    {
        $this->loginAs('admin');
        $response = $this->jsonRequest('GET', $this->api_prefix.'/timeslices');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find timeslices got '.$response->getContent());
        $this->assertEquals($data[0]['value'], '2h', 'expected to find value "2h"');
    }

    public function testGetTimesliceAction()
    {
        $this->loginAs('admin');
        // expect to get 404 on non-existing activity
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/timeslices/11111')->getStatusCode());

        // check existing activity timeslice
        $response = $this->jsonRequest('GET', $this->api_prefix.'/timeslices/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find activities');
        $this->assertEquals($data['value'], '2h', 'expected to find value "2h"');
    }

    public function testPostPutDeleteTimeslicesActions()
    {
        $this->loginAs('admin');
        // create new activity
        $response = $this->jsonRequest('POST', $this->api_prefix.'/timeslices', json_encode(array(
            'activity'    => '1',
            'startedAt'   => '2012-02-10 19:00:00',
            'stoppedAt'   => '2012-02-10 19:30:00',
            'value'    => '',
            'user'        => '1'
        )));
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        // check created activity
        $response = $this->jsonRequest('GET', $this->api_prefix.'/timeslices/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals($data['startedAt'], '2012-02-10 19:00:00', 'expected to find "2012-02-10 19:00:00"');
        $this->assertEquals($data['stoppedAt'], '2012-02-10 19:30:00', 'expected to find rate "2012-02-10 19:30:00"');

        // modify activity
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/timeslices/' . $id, json_encode(array(
            'activity'    => '1',
            'startedAt'   => '2012-02-10 19:00:00',
            'stoppedAt'   => '2012-02-10 19:30:00',
            'value'    => '2h',
            'user'        => '1'
        )));
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/timeslices/' .($id+100), json_encode(array(
            'activity'    => '1',
            'startedAt'   => '2012-02-10 19:00:00',
            'stoppedAt'   => '2012-02-10 19:30:00',
            'value'    => '',
            'user'        => '1'
        )));
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());

        // check created activity
        $response = $this->jsonRequest('GET', $this->api_prefix.'/timeslices/' . $id);

        // convert json to arraymysql
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals($data['value'], '2h', 'expected to find "2h"');

        // delete activity
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/timeslices/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check if activity still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/timeslices/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
