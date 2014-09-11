<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class UsersControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->request('GET', $this->api_prefix.'/users.json')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->request('GET', $this->api_prefix.'/users.json')->getStatusCode());
    }

    public function testGetUsersAction()
    {
        $this->loginAs('admin');
        $response = $this->request('GET', $this->api_prefix.'/users.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find users found '.$response->getContent().' with Responce Code: '.$response->getStatusCode());
        $this->assertEquals($data[0]['firstname'], 'Default', 'expected to find "Default" first');
    }

    public function testGetUserAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->request('GET', $this->api_prefix.'/users/11111.json')->getStatusCode());

        /* check existing service */
        $response = $this->request('GET', $this->api_prefix.'/users/1.json', null, array('CONTENT_TYPE'=> 'application/json'));

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find users found '.$response->getContent().' with Responce Code: '.$response->getStatusCode());
        $this->assertEquals($data['firstname'], 'Default', 'expected to find "Default"');
    }

    public function testPostPutDeleteUserActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->request('POST', $this->api_prefix.'/users.json', json_encode(array(
            'username'    => 'test-user',
            'password'    => 'test',
            'firstname'   => 'Test',
            'lastname'    => 'User',
            'email'       => 'test@user.com'
            )),
            array('CONTENT_TYPE'=> 'application/json')
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $this->assertInternalType("int", $data['id'], 'expected $data[id] to be of Type integer got: '.$response->getContent());

        $id = $data['id'];

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/users/' . $id . '.json');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals($data['firstname'], 'Test', 'expected to find "Test", got response'.$response->getContent());
        $this->assertEquals($data['email'], "test@user.com", 'expected to find rate "test@user.com"');

        /* modify service */
        $response = $this->request('PUT', $this->api_prefix.'/users/' . $id.'.json', '{"firstname": "Modified Test", "lastname": "User", "email": "test1@user.com", "foo": "bar"}');
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        $response = $this->request('PUT', $this->api_prefix.'/users/' . ($id+1).'.json', '{"firstname": "Modified Test", "lastname": "User", "email": "test1@user.com", "foo": "bar"}');
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/users/' . $id.'.json');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals($data['firstname'], 'Modified Test', 'expected to find "Modified Test"');
        $this->assertEquals($data['email'], "test1@user.com", 'expected to find rate "test1@user.com"');

        /* delete service */
        $response = $this->request('DELETE', $this->api_prefix.'/users/' . $id.'.json');
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->request('GET', $this->api_prefix.'/users/' . $id.'.json');
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
