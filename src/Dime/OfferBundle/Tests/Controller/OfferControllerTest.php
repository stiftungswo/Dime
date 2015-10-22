<?php

namespace Dime\OfferBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class OfferControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/offers')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/offers')->getStatusCode());
    }

    public function testGetOfferAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/offers/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find offers');
        $this->assertEquals('Default Offer', $data['name'], 'expected to find "Default Offer"');
    }

//    public function testPostPutDeleteOfferActions()
//    {
//	    //Todo Fix Test Disabled for now.
//        $this->loginAs('admin');
//        /* create new service */
//        $response = $this->jsonRequest('POST', $this->api_prefix.'/offers',
//		    json_encode(array(
//			    'name' => 'Test',
//		    	'status' => 1
//		    ))
//        );
//        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());
//
//        // convert json to array
//        $data = json_decode($response->getContent(), true);
//
//        $id = $data['id'];
//
//        /* check created  */
//        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/' . $id);
//
//        // convert json to array
//        $data = json_decode($response->getContent(), true);
//
//        // assert that data has content
//        $this->assertEquals('Test', $data['name'], 'expected to find "Test"');
//
//        /* modify  */
//        $response = $this->jsonRequest('PUT', $this->api_prefix.'/offers/' . $id,
//		    json_encode(array(
//			    'name' => 'Modified Test'
//		    ))
//        );
//        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());
//
//        $response = $this->jsonRequest('PUT', $this->api_prefix.'/offers/' . ($id+100),
//	    json_encode(array(
//		        'name' => 'Modified Test (to be failed)'
//		    ))
//        );
//        $this->assertEquals(404, $response->getStatusCode());
//
//        /* check created service */
//        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/' . $id);
//
//        // convert json to array
//        $data = json_decode($response->getContent(), true);
//
//        // assert that data has content
//        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
//
//        /* delete service */
//        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/offers/' . $id);
//        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());
//
//        /* check if service still exists*/
//        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/' . $id);
//        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
//    }

    public function testCreateProjectFromOffer(){
        $this->loginAs('admin');

        $response = $this->jsonRequest('PATCH', $this->api_prefix.'/createprojectfromoffer/1',
            json_encode(array())
        );
    }

}
