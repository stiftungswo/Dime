<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ProjectCommentsControllerTest extends DimeTestCase
{

    function testAuthentication()
    {
        $this->assertEquals(401, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcomments')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcomments')->getStatusCode());
    }

    function testGetProjectCommentsAction()
    {
        // should return project comments
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcomments')
            ->getStatusCode());
    }

    function testGetProjectCommentAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing project comment */
        $this->assertEquals(404, $this
            ->jsonRequest('GET', $this->api_prefix.'/projectcomments/111111')
            ->getStatusCode());

        /* check existing project comment */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcomments/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find project comment');
    }

    function testPostPutDeleteProjectCommentActions()
    {
        $this->loginAs('admin');

        /* create new project comment */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/projectcomments', json_encode(array(
            'comment'       => 'Project comment comment',
            'date'          => '2018-01-05',
            'project'    => 1
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created project comment */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcomments/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'Project comment comment',
            $data['comment'],
            'expected to find "comment"'
        );
        $this->assertInternalType(
            'array',
            $data['project'],
            'expected to find project array'
        );

        /* modify project comment */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/projectcomments/' . $id, json_encode(array(
            'comment'       => 'Modified project comment',
            'date'          => '2018-05-06',
            'project'       => 2
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/projectcomments/' . ($id+100), json_encode(array(
            'comment'       => 'Modified project comment',
            'date'          => '2018-05-06',
            'project'       => 2
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created project comment */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcomments/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'Modified project comment',
            $data['comment'],
            'expected to find "Modified project comment"'
        );
        $this->assertInternalType('array', $data['project'], 'expected to find project array');

        /* delete project comment */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/projectcomments/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if project comment still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/projectcomments/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
