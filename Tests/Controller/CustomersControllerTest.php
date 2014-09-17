<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class CustomersControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->request('GET', $this->api_prefix.'/customers.json', null, array('CONTENT_TYPE'=> 'application/json'))->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->request('GET', $this->api_prefix.'/customers.json', null, array('CONTENT_TYPE'=> 'application/json'))->getStatusCode());
    }

    public function testGetCustomersAction()
    {
        $this->loginAs('admin');
        $response = $this->request('GET', $this->api_prefix.'/customers.json',null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find customers');
        $this->assertEquals('CWE Customer', $data[0]['name'], 'expected to find "Another Customer" first');
    }

    public function testGetCustomerAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->request('GET', $this->api_prefix.'/customers/11111.json', null, array('CONTENT_TYPE'=> 'application/json'))->getStatusCode());

        /* check existing service */
        $response = $this->request('GET', $this->api_prefix.'/customers/1.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find customers');
        $this->assertEquals('CWE Customer', $data['name']);
    }

    public function testPostPutDeleteCustomerActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->request('POST', $this->api_prefix.'/customers.json', '{"name": "Test", "alias": "Test"}', array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/customers/' . $id . '.json',null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name'], 'expected to find "Test"');
        $this->assertEquals('test', $data['alias'], 'expected to find alias "Test"');

        /* modify service */
        $response = $this->request('PUT', $this->api_prefix.'/customers/' . $id . '.json', '{"name": "Modified Test", "alias": "Modified"}', array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->request('PUT', $this->api_prefix.'/customers/' . ($id+1) . '.json', '{"name": "Modified Test", "alias": "Modified"}', array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/customers/' . $id . '.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals('modified', $data['alias'], 'expected to find alias "Modified"');

        /* delete service */
        $response = $this->request('DELETE', $this->api_prefix.'/customers/' . $id . '.json', null, array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(204, $response->getStatusCode());

        /* check if service still exists*/
        $response = $this->request('GET', $this->api_prefix.'/customers/' . $id . '.json', null, array('CONTENT_TYPE'=> 'application/json'));
        $this->assertEquals(404, $response->getStatusCode());
    }
}
