<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class AmountsControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/amounts')->getStatusCode());
        $this->loginas('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/amounts')->getStatusCode());
    }

    public function testGetAmountsAction()
    {
        $this->loginas('admin');
        $response = $this->jsonRequest('GET', $this->api_prefix.'/amounts');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find amounts');
        $this->assertEquals('cwe: initial requirements meeting with customer', $data[0]['description']);
    }

    public function testGetAmountAction()
    {
        $this->loginas('admin');
        // expect to get 404 on non-existing amount
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/amounts/11111')->getStatusCode());

        // check existing amount
        $response = $this->jsonRequest('GET', $this->api_prefix.'/amounts/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find amounts');
        $this->assertEquals('cwe: initial requirements meeting with customer', $data['description'], 'expected to find "consulting"');
    }

    public function testPostPutDeleteAmountActions()
    {
        $this->loginas('admin');
        // create new amount
        $response = $this->jsonRequest('POST', $this->api_prefix.'/amounts', json_encode(array(
            'description'   => 'Test',
            'rate'          => 65.13,
            'rateReference' => 'customer',
            'service'       => 1,
            'customer'      => 1,
            'project'       => 1,
            'user'          => 1,
	        'value'         => '5',
        )));
        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        // check created amount
        $response = $this->jsonRequest('GET', $this->api_prefix.'/amounts/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['description'], 'expected to find "Test"');
        $this->assertEquals(65.13, $data['rate'], 'expected to find rate "65.13"');

        // modify amount
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/amounts/' . $id, json_encode(array(
            'description'   => 'Modified Test',
            'rate'          => 111,
            'service'       => 1,
            'customer'      => 1,
            'project'       => 1,
            'user'          => 1,
            'value'         => '5',
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/amounts/' . ($id+100), json_encode(array(
            'description'   => 'Modified Test',
            'rate'          => 111,
            'service'       => 1,
            'customer'      => 1,
            'project'       => 1,
            'user'          => 1
        )));
        $this->assertEquals(404, $response->getStatusCode());

        // check created amount
        $response = $this->jsonRequest('GET', $this->api_prefix.'/amounts/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['description'], 'expected to find "Modified Test"');
        $this->assertEquals(111, $data['rate'], 'expected to find rate "111"');

        // delete amount
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/amounts/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        // check if amount still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/amounts/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
