<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ProjectCategoryControllerTest extends DimeTestCase
{

    function testAuthentication()
    {
        $this->assertEquals(401, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcategories')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcategories')->getStatusCode());
    }

    function testGetProjectCategorysAction()
    {
        // should return project categories
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcategories')
            ->getStatusCode());
    }

    function testGetProjectCategoryAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing project category */
        $this->assertEquals(404, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcategories/111111')
            ->getStatusCode());

        /* check existing project category */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcategories/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find project category');
    }

    function testPostPutDeleteProjectCategoryActions()
    {
        $this->loginAs('admin');

        /* create new project category */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/projectcategories', json_encode(array(
            'name'       => 'sample name'
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created project category */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcategories/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'sample name',
            $data['name'],
            'expected to find "comment"'
        );

        /* modify project category */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/projectcategories/' . $id, json_encode(array(
            'name'       => 'Better name'
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/projectcategories/' . ($id+100), json_encode(array(
            'name'       => 'Better name'
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created project category */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcategories/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'Better name',
            $data['name'],
            'expected to find "comment"'
        );

        /* delete project category */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/projectcategories/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if project category still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcategories/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
