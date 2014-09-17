<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class TimeslicesControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->request('GET', $this->api_prefix.'/timeslices.json', null, array(), array(), array())->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->request('GET', $this->api_prefix.'/timeslices.json')->getStatusCode());
    }

    public function testGetActivitiesTimeSlicesAction()
    {
        $this->loginAs('admin');
        $response = $this->request('GET', $this->api_prefix.'/timeslices.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find timeslices got '.$response->getContent());
        $this->assertEquals($data[0]['duration'], '7200', 'expected to find duration "7200"');
    }

    public function testGetTimesliceAction()
    {
        $this->loginAs('admin');
        // expect to get 404 on non-existing activity
        $this->assertEquals(404, $this->request('GET', $this->api_prefix.'/timeslices/11111.json', null, array('CONTENT_TYPE'=> 'application/json'))->getStatusCode());

        // check existing activity timeslice
        $response = $this->request('GET', $this->api_prefix.'/timeslices/1.json',null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find activities');
        $this->assertEquals($data['duration'], '7200', 'expected to find duration "7200"');
    }

    public function testPostPutDeleteTimeslicesActions()
    {
        $this->loginAs('admin');
        // create new activity
        $response = $this->request('POST', $this->api_prefix.'/timeslices.json', json_encode(array(
            'activity'    => '1',
            'startedAt'   => '2012-02-10 19:00:00',
            'stoppedAt'   => '2012-02-10 19:30:00',
            'duration'    => '',
            'user'        => '1'
        )), array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        // check created activity
        $response = $this->request('GET', $this->api_prefix.'/timeslices/' . $id.'.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals($data['startedAt'], '2012-02-10 19:00:00', 'expected to find "2012-02-10 19:00:00"');
        $this->assertEquals($data['stoppedAt'], '2012-02-10 19:30:00', 'expected to find rate "2012-02-10 19:30:00"');

        // modify activity
        $response = $this->request('PUT', $this->api_prefix.'/timeslices/' . $id.'.json', json_encode(array(
            'activity'    => '1',
            'startedAt'   => '2012-02-10 19:00:00',
            'stoppedAt'   => '2012-02-10 19:30:00',
            'duration'    => '7200',
            'user'        => '1'
        )), array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->request('PUT', $this->api_prefix.'/timeslices/' .($id+200).'.json', json_encode(array(
            'activity'    => '1',
            'startedAt'   => '2012-02-10 19:00:00',
            'stoppedAt'   => '2012-02-10 19:30:00',
            'duration'    => '',
            'user'        => '1'
        )), array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());

        // check created activity
        $response = $this->request('GET', $this->api_prefix.'/timeslices/' . $id.'.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals($data['duration'], '7200', 'expected to find "7200"');

        // delete activity
        $response = $this->request('DELETE', $this->api_prefix.'/timeslices/' . $id.'.json', null , array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check if activity still exists*/
        $response = $this->request('GET', $this->api_prefix.'/timeslices/' . $id.'.json', null, array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
