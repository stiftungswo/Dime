<?php

namespace Dime\OfferBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class OfferDiscountControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/projects')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/projects')->getStatusCode());
    }

    public function testGetProjectAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing project */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/offerdiscounts/11111')->getStatusCode());

        /* check existing project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerdiscounts/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find projects');
        $this->assertEquals('10% Off', $data['name'], 'expected to find other value');
    }

    public function testPostPutDeleteProjectActions()
    {
        $this->loginAs('admin');
        /* create new project */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/offerdiscounts', json_encode(array(
            'name' => 'Test',
            'percentage'  => '0',
            'minus' => true,
            'value' => 49.90,
            'user'  => 1,
            'offer' => 1
        )));

        $this->assertEquals(201, $response->getStatusCode(), $response);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerdiscounts/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name'], 'expected to find other value');
        $this->assertEquals(49.90, $data['value'], 'expected to find other value');

        /* modify project */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/offerdiscounts/' . $id, json_encode(array(
            'name'          => 'Modified Test',
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/offerdiscounts/' . ($id+100), json_encode(array(
            'name'          => 'Modified Test',
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerdiscounts/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find other value');

        /* delete project */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/offerdiscounts/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if project still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/offerdiscounts/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
