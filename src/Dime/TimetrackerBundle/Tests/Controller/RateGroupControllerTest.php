<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class RateGroupControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/rategroups')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/rategroups')->getStatusCode());
    }

    public function testGetServiceAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/rategroups/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rategroups/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find rategroups');
        $this->assertEquals('Default', $data['name'], 'expected to find "Default"');
    }

    public function testPostPutDeleteServiceActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/rategroups',
		    json_encode(array(
			    'name' => 'Test Rate Group',
			    'description' => 'Description of test rate group'
		    ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rategroups/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test Rate Group', $data['name'], 'expected to find "Test Rate Group"');
        $this->assertEquals('Description of test rate group', $data['description'], 'expected to find description "Description of test rate group"');

        /* modify service */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/rategroups/' . $id,
		    json_encode(array(
			    'name' => 'Modified Test',
			    'description' => 'modified'
		    ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/rategroups/' . ($id+100),
	    json_encode(array(
		        'name' => 'Modified Test to be failed',
		        'description' => 'fail'
		    ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rategroups/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals('modified', $data['description'], 'expected to find rate "test"');

        /* delete service */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/rategroups/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rategroups/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
