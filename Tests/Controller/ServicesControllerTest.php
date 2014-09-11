<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ServicesControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(500, $this->request('GET', $this->api_prefix.'/services')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->request('GET', $this->api_prefix.'/services')->getStatusCode());
    }

    public function testGetServiceAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->request('GET', $this->api_prefix.'/services/11111')->getStatusCode());

        /* check existing service */
        $response = $this->request('GET', $this->api_prefix.'/services/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find services');
        $this->assertEquals('Consulting', $data['name'], 'expected to find "consulting"');
    }

    public function testPostPutDeleteServiceActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->request('POST', $this->api_prefix.'/services', '{"name": "Test", "alias": "test", "rate": 555}');
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/services/' . $id . '');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name'], 'expected to find "Test"');
        $this->assertEquals(555, $data['rate'], 'expected to find rate "555"');

        /* modify service */
        $response = $this->request('PUT', $this->api_prefix.'/services/' . $id, '{"name": "Modified Test", "alias": "test", "rate": 111, "foo": "bar"}');
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->request('PUT', $this->api_prefix.'/services/' . ($id+1), '{"name": "Modified Test", "alias": "test", "rate": 111, "foo": "bar"}');
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/services/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals(111, $data['rate'], 'expected to find rate "111"');

        /* delete service */
        $response = $this->request('DELETE', $this->api_prefix.'/services/' . $id);
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->request('GET', $this->api_prefix.'/services/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
