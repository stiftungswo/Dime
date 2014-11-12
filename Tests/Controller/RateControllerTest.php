<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Entity\RateGroup;

class RateControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/rates')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/rates')->getStatusCode());
    }

    public function testGetServiceAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/rates/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rates/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find rates');
        $this->assertEquals(120, $data['rateValue'], 'expected to get 120');
    }

    public function testPostPutDeleteServiceActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/rates',
		    json_encode(array(
			    'rateValue' => 100,
		    	'service' => 1,
		   		'rateUnit' => 'h',
			    'rateGroup' => 1
		    ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rates/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(100, $data['rateValue'], 'expected to find value 100');
        $this->assertEquals('h', $data['rateUnit'], 'expected to find rate unit "h"');

        /* modify service */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/rates/' . $id,
		    json_encode(array(
			    'rateValue' => 120,
			    'rateUnit' => 'EUR/h'
		    ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/rates/' . ($id+100),
	    json_encode(array(
			    'rateValue' => 200,
			    'rateUnit' => 'fail'
		    ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rates/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(120, $data['rateValue'], 'expected to find value 120');
        $this->assertEquals('EUR/h', $data['rateUnit'], 'expected to find rate unit "EUR/h"');

        /* delete service */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/rates/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rates/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
