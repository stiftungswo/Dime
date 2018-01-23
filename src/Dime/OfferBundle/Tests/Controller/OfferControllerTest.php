<?php

namespace Dime\OfferBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class OfferControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/offers')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/offers')->getStatusCode());
    }

    public function testGetOfferAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing offer */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/offers/11111')->getStatusCode());

        /* check existing offer */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find offers');
        $this->assertEquals('Default Offer', $data['name'], 'expected to find "Default Offer"');
    }

    public function testPostPutDeleteOfferActions()
    {
        //Todo Fix Test Disabled for now.
        $this->loginAs('admin');
        /* create new offer */
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix.'/offers',
            json_encode(array(
                'name' => 'Test',
                'description' => 'Long Description',
                'shortDescription' => 'Short Description',
                'project' => 8,
                'rateGroup' => 1,
                'customer' => 2,
                'accountant' => 5,
                'validTo' => '2017-02-21',
                'fixedPrice' => '1337',
                'status' => 1
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created  */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name']);
        $this->assertEquals('Short Description', $data['shortDescription']);
        $this->assertEquals('2017-02-21 00:00:00', $data['validTo']);

        /* modify  */
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/offers/' . $id,
            json_encode(array(
                'name' => 'Modified Test',
                'description' => 'Long Description Modified',
                'shortDescription' => 'Short Description Modified',
                'project' => 7,
                'rateGroup' => 2,
                //'customer' => 3, // setting customer somehow does not work
                'accountant' => 4,
                'validTo' => '2018-02-21',
                'fixedPrice' => '2337',
                'status' => 2
            ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name']);
        $this->assertEquals('Short Description Modified', $data['shortDescription']);
        $this->assertEquals(2337, $data['fixedPrice']);

        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/offers/' . ($id+100),
            json_encode(array(
                'name' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created offer */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');

        /* delete offer */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/offers/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if offer still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }

    public function testCreateProjectFromOffer()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'PATCH',
            $this->api_prefix.'/createprojectfromoffer/1',
            json_encode(array())
        );
    }

    public function testPrintOfferAction()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest('GET', $this->api_prefix.'/offers/1/print');

        // test if pdf seems valid
        $data = $response->getContent();
        $this->assertEquals('%PDF-1.4', substr($data, 0, 8), $data);
        $this->assertContains('This is a default offer', $data);
    }
}
