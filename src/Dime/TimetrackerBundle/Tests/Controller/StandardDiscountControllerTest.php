<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class StandardDiscountControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/projects')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/projects')->getStatusCode());
    }

    public function testGetStandardDiscountsAction()
    {
        $this->loginAs('admin');
        $response = $this->jsonRequest('GET', $this->api_prefix.'/standarddiscounts');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find projects');
        $this->assertEquals('Skonto 2%', $data[0]['name'], 'expected to find other value first');
    }

    public function testGetProjectAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing project */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/projects/11111')->getStatusCode());

        /* check existing project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/standarddiscounts/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find projects');
        $this->assertEquals('Skonto 2%', $data['name'], 'expected to find other value');
    }

    public function testPostPutDeleteProjectActions()
    {
        $this->loginAs('admin');
        /* create new project */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/standarddiscounts', json_encode(array(
            'name'          => 'Test',
            'percentage'         => false,
            'minus' => true,
            'value'      => 19.90,
            'user'          => 1
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/standarddiscounts/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name'], 'expected to find other value');
        $this->assertEquals(19.90, $data['value'], 'expected to find other value');

        /* modify project */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/standarddiscounts/' . $id, json_encode(array(
            'name'          => 'Modified Test',
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/standarddiscounts/' . ($id+100), json_encode(array(
            'name'          => 'Modified Test',
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/standarddiscounts/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find other value');

        /* delete project */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/standarddiscounts/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if project still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/standarddiscounts/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
