<?php

namespace Dime\OfferBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class OfferStatusUCControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/offerstatusucs')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/offerstatusucs')->getStatusCode());
    }

    public function testGetOfferAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/offerstatusucs/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerstatusucs/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find offerstatusucs');
        $this->assertEquals('Offeriert', $data['text'], 'expected to find "Offeriert"');
    }

    public function testPostPutDeleteOfferActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix.'/offerstatusucs',
            json_encode(array(
                'text' => 'Test',
                'active' => true
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created  */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerstatusucs/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['text'], 'expected to find "Test"');

        /* modify  */
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/offerstatusucs/' . $id,
            json_encode(array(
                'text' => 'Modified Test'
            ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/offerstatusucs/' . ($id+100),
            json_encode(array(
                'text' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerstatusucs/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['text'], 'expected to find "Modified Test"');

        /* delete service */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/offerstatusucs/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerstatusucs/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
