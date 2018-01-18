<?php

namespace Dime\OfferBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;
use Money\Money;

class OfferPositionControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/offerpositions')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/offerpositions')->getStatusCode());
    }

    public function testGetOfferAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/offerpositions/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerpositions/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find offer positions');
        $this->assertEquals(20, $data['amount'], 'expected to find amount of "20"');
    }

    public function testPostPutDeleteOfferActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/offerpositions',
		    json_encode(array(
			    'offer' => 1, //default offer
                'service' => 1, //consulting
                'order' => 10,
                'amount' => 33,
                'vat' => 8,
		    	'discountable' => true,
		    ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created  */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerpositions/'.$id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(33, $data['amount'], 'expected to find amount of "33"');

        /* modify  */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/offerpositions/'.$id,
		    json_encode(array(
			    'amount' => 45
		    ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/offerpositions/'.($id+100),
	    json_encode(array(
		        'amount' => 77
		    ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerpositions/'.$id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(45, $data['amount'], 'expected to find amount "45"');

        /* delete service */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/offerpositions/'.$id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerpositions/'.$id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
