<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class PeriodControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/periods')->getStatusCode());
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
            'description'   => 'Period test description',
            'customer'      => 1,
            'user'          => 1,
            'employee'      => 7,
            "start"         => "2017-01-25 00:00:00",
            "end"           => "2017-06-07 00:00:00",
            "pensum"        => 0.8
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

        /*
        // modify period
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/periods/' . $id, json_encode(array(
            'name'          => 'Modified Test',
            'alias'         => 'test2',
            'description'   => 'Period test description update',
            'customer'      => 1,
            'user'          => 1
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/periods/' . ($id+100), json_encode(array(
            'name'          => 'Modified Test',
            'alias'         => 'test',
            'description'   => 'Period test description update',
            'customer'      => 1,
            'user'          => 1
        )));
        $this->assertEquals(404, $response->getStatusCode());

        // check created period
        $response = $this->jsonRequest('GET', $this->api_prefix.'/periods/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals('test2', $data['alias'], 'expected to find alias "test2"');

        // delete period
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/periods/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        // check if period still exists
        $response = $this->jsonRequest('GET', $this->api_prefix.'/periods/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
        */
    }
}
