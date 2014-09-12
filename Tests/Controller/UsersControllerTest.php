<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class UsersControllerTest extends DimeTestCase
{
    protected $postarray;
    
    protected $putarray;
     
    /* (non-PHPdoc)
    * @see \Dime\TimetrackerBundle\Tests\Controller\DimeTestCase::setUp()
    */
    public function setUp() {
        parent::setUp();
        $this->postarray = array();
        $this->putarray = array();
    }

    
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
        $this->postarray = array(
            'username'    => 'test-user',
            'password'    => 'test',
            'firstname'   => 'Test',
            'lastname'    => 'User',
            'email'       => 'test@user.com'
        );
        
        $this->putarray = array(
            'firstname' => 'Modified_User', 
            'lastname'  => 'User',
            'email'     => 'test1@user.com'
        );
        
        $this->loginAs('admin');
        /* create new service */
        $response = $this->request('POST', $this->api_prefix.'/users.json', json_encode($this->postarray), array('CONTENT_TYPE' => 'application/json'));
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
        $this->assertEquals($data['firstname'], $this->postarray['firstname'], 'expected to find '.$this->postarray['firstname']);
        $this->assertEquals($data['email'], $this->postarray['email'], 'expected to find '.$this->postarray['email']);

        /* modify service */
        $response = $this->request('PUT', $this->api_prefix.'/users/' . $id.'.json', json_encode($this->putarray), array('CONTENT_TYPE' => 'application/json'));
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        /* Test that wrong id results in 404 */
        $response = $this->request('PUT', $this->api_prefix.'/users/' . ($id+15).'.json', json_encode($this->putarray), array('CONTENT_TYPE' => 'application/json'));
        $this->assertEquals(404, $response->getStatusCode());
        
        /* check created service */
        $response = $this->request('GET', $this->api_prefix.'/users/' . $id.'.json');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals($data['firstname'], $this->putarray['firstname'], 'expected to find '.$this->putarray['firstname']);
        $this->assertEquals($data['email'], $this->putarray['email'], 'expected to find '.$this->putarray['email']);

        /* delete service */
        $response = $this->request('DELETE', $this->api_prefix.'/users/' . $id.'.json');
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->request('GET', $this->api_prefix.'/users/' . $id.'.json');
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
