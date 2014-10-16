<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ServicesControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/services')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/services')->getStatusCode());
    }

    public function testGetServiceAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/services/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/services/1');

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
        $response = $this->jsonRequest('POST', $this->api_prefix.'/services',
		    json_encode(array(
			    'name' => 'consulting',
			    'alias' => 'cons'
		    ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/services/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('consulting', $data['name'], 'expected to find "consulting"');
        $this->assertEquals('cons', $data['alias'], 'expected to find alias "cons"');

        /* modify service */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/services/' . $id,
		    json_encode(array(
			    'name' => 'Modified Test',
			    'alias' => 'test',
			    'foo' => 'bar',
		    ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/services/' . ($id+100),
	    json_encode(array(
		        'name' => 'Modified Test',
		        'alias' => 'test',
		        'foo' => 'bar',
		    ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/services/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals('test', $data['alias'], 'expected to find rate "test"');

        /* delete service */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/services/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/services/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
