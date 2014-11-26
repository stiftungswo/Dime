<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ProjectsControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/projects')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/projects')->getStatusCode());
    }

    public function testGetProjectsAction()
    {
        $this->loginAs('admin');
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projects');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find projects');
        $this->assertEquals('Büro', $data[0]['name'], 'expected to find "Büro" first');
    }

    public function testGetProjectAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing project */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/projects/11111')->getStatusCode());

        /* check existing project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projects/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find projects');
        $this->assertEquals('Büro', $data['name'], 'expected to find "Büro"');
    }

    public function testPostPutDeleteProjectActions()
    {
        $this->loginAs('admin');
        /* create new project */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/projects', json_encode(array(
            'name'          => 'Test',
            'alias'         => 'test',
            'description'   => 'Project test description',
            'customer'      => 1,
            'user'          => 1
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projects/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name'], 'expected to find "Test"');
        $this->assertEquals('test', $data['alias'], 'expected to find alias "test"');

        /* modify project */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/projects/' . $id, json_encode(array(
            'name'          => 'Modified Test',
            'alias'         => 'test2',
            'description'   => 'Project test description update',
            'customer'      => 1,
            'user'          => 1
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/projects/' . ($id+100), json_encode(array(
            'name'          => 'Modified Test',
            'alias'         => 'test',
            'description'   => 'Project test description update',
            'customer'      => 1,
            'user'          => 1
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created project */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projects/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals('test2', $data['alias'], 'expected to find alias "test2"');

        /* delete project */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/projects/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if project still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projects/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
