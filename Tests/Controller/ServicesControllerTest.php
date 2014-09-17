<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ServicesControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->request('GET', $this->api_prefix.'/services.json')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->request('GET', $this->api_prefix.'/services.json')->getStatusCode());
    }

    public function testGetServiceAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->request('GET', $this->api_prefix.'/services/11111.json', null, array('CONTENT_TYPE'=> 'application/json'))->getStatusCode());

        /* check existing service */
        $response = $this->request('GET', $this->api_prefix.'/services/1.json', null, array('CONTENT_TYPE'=> 'application/json'));

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
        $response = $this->request('POST', $this->api_prefix.'/services.json', '{"name": "Test", "alias": "test", "rate": 555}', array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/services/' . $id . '.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name'], 'expected to find "Test"');
        $this->assertEquals(555, $data['rate'], 'expected to find rate "555"');

        /* modify service */
        $response = $this->request('PUT', $this->api_prefix.'/services/' . $id.'.json', '{"name": "Modified Test", "alias": "test", "rate": 111, "foo": "bar"}', array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->request('PUT', $this->api_prefix.'/services/' . ($id+1).'.json', '{"name": "Modified Test", "alias": "test", "rate": 111, "foo": "bar"}', array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/services/' . $id.'.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals(111, $data['rate'], 'expected to find rate "111"');

        /* delete service */
        $response = $this->request('DELETE', $this->api_prefix.'/services/' . $id.'.json', null, array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->request('GET', $this->api_prefix.'/services/' . $id.'.json', null, array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
