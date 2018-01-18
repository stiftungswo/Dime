<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ActivitiesControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/activities')->getStatusCode());
        $this->loginas('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/activities')->getStatusCode());
    }

    public function testGetActivitiesAction()
    {
        $this->loginas('admin');
        $response = $this->jsonRequest('GET', $this->api_prefix.'/activities');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find activities');

        $this->assertEquals('DimERP Programmieren', $data[0]['description']);
    }

    public function testGetActivityAction()
    {
        $this->loginas('admin');
        // expect to get 404 on non-existing activity
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/activities/11111')->getStatusCode());

        // check existing activity
        $response = $this->jsonRequest('GET', $this->api_prefix.'/activities/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find activities');
        $this->assertEquals('DimERP Programmieren', $data['description'], 'expected to find "consulting"');
    }

    public function testPostPutDeleteActivityActions()
    {
        $this->loginas('admin');
        // create new activity
        $response = $this->jsonRequest('POST', $this->api_prefix.'/activities', json_encode(array(
            'description'   => 'Test',
            'service'       => 1,
            'project'       => 1,
            'user'          => 1,
            'chargeableReference' => 'customer'
        )));
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        // check created activity
        $response = $this->jsonRequest('GET', $this->api_prefix.'/activities/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['description'], 'expected to find "Test"');

        // modify activity
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/activities/' . $id, json_encode(array(
            'description'   => 'Modified Test',
            'rateValue'          => 111,
            'service'       => 1,
            'project'       => 1,
            'user'          => 1
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/activities/' . ($id+100), json_encode(array(
            'description'   => 'Modified Test',
            'rateValue'          => 111,
            'service'       => 1,
            'project'       => 1,
            'user'          => 1
        )));
        $this->assertEquals(404, $response->getStatusCode());

        // check created activity
        $response = $this->jsonRequest('GET', $this->api_prefix.'/activities/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['description'], 'expected to find "Modified Test"');
        $this->assertEquals(111, $data['rateValue'], 'expected to find rateValue "111"');

        // delete activity
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/activities/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        // check if activity still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/activities/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
