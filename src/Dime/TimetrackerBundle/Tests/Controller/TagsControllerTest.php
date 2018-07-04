<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class TagsControllerTest extends DimeTestCase
{
    function testAuthentication()
    {
        $this->assertEquals(401, $this
            ->jsonRequest('GET', $this->api_prefix.'/tags')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/tags')->getStatusCode());
    }

    function testTagsAction()
    {
        // should return tags
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/tags')
            ->getStatusCode());
    }

    function testGetTagAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing tag */
        $this->assertEquals(404, $this
            ->jsonRequest('GET', $this->api_prefix.'/tags/111111')
            ->getStatusCode());

        /* check existing tag */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/tags/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find tag');
    }

    function testPostPutDeleteTagActions()
    {
        $this->loginAs('admin');

        /* create new tag */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/tags', json_encode(array(
            'name'          => 'super mario odyssey',
            'system'        => false
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created tag */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/tags/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('super mario odyssey', $data['name'], 'expected to find "comment"');
        $this->assertFalse($data['system'], 'expected to find tag system');

        /* modify tag */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/tags/' . $id, json_encode(array(
            'name'          => 'super mario sunshine',
            'system'        => true
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/tags/' . ($id+100), json_encode(array(
            'name'          => 'super mario sunshine',
            'system'        => true
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created tag */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/tags/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'super mario sunshine',
            $data['name'],
            'expected to find "comment"'
        );
        $this->assertTrue(
            $data['system'],
            'expected to find tag system'
        );

        /* delete tag */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/tags/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if tag still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/tags/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
