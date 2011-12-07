<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class ActivityControllerTest extends WebTestCase
{
    public function setUp()
    {
        $this->client = static::createClient();
    }

    /**
     * do a request using HTTP authentification
     */
    protected function request(
        $method,
        $url,
        $parameters = array(),
        $files = array(),
        $server = null,
        $content = null
    ) {
        if (is_null($server)) {
            $server=array('PHP_AUTH_USER' => 'admin', 'PHP_AUTH_PW' => 'kitten');
        }
        $this->client->restart();

        // make get request with authentifaction
        $this->client->request($method, $url, $parameters, $files, $server, $content);
        return $this->client->getResponse();
    }

    public function testAuthentification()
    {
        $this->assertEquals(401, $this->request('GET', '/api/activities.json', array(), array(), array())->getStatusCode());
        $this->assertEquals(200, $this->request('GET', '/api/activities.json')->getStatusCode());
    }

    public function testGetActivitysAction()
    {
        $response = $this->request('GET', '/api/activities.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find activities');
        $this->assertEquals($data[0]['description'], 'cwe: initial requirements meeting with customer', 'expected to find "consulting" first');
    }

    public function testGetActivityAction()
    {
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->request('GET', '/api/activities/11111.json')->getStatusCode());

        /* check existing service */
        $response = $this->request('GET', '/api/activities/1.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find activities');
        $this->assertEquals($data['description'], 'cwe: initial requirements meeting with customer', 'expected to find "consulting"');
    }

    public function testPostPutDeleteActivityActions()
    {
        $data = json_encode(array(
            'duration'      => 1800,
            'startedAt'     => '2011-12-05 20:15:00',
            'stoppedAt'     => '2011-12-05 20:45:00',
            'description'   => 'Test',
            'rate'          => 65,
            'rateReference' => 'customer',
            'service'       => 1,
            'customer'      => 1,
            'project'       => 1,
        ));
        
        /* create new service */
        $response = $this->request('POST', '/api/activity.json', array(), array(), null, $data);
        $this->assertEquals(200, $response->getStatusCode());
        
        // convert json to array
        $data = json_decode($response->getContent(), true);

        $activityId = $data['id'];
        
        /* check created service */
        $response = $this->request('GET', '/api/activities/' . $activityId . '.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertEquals($data['description'], 'Test', 'expected to find "Test"');
        $this->assertEquals($data['rate'], 65, 'expected to find rate "65"');

        $data = json_encode(array(
            'description'   => 'Modified Test',
            'rate'          => 111,
            'service'       => 1,
            'customer'      => 1,
            'project'       => 1,
        ));
        /* modify service */
        $response = $this->request('PUT', '/api/activities/' . $activityId . '.json', array(), array(), null, $data);
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->request('PUT', '/api/activities/' . ($activityId+1) . '.json', array(), array(), null, $data);
        $this->assertEquals(404, $response->getStatusCode());
        
        /* check created service */
        $response = $this->request('GET', '/api/activities/' . $activityId . '.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertEquals($data['description'], 'Modified Test', 'expected to find "Modified Test"');
        $this->assertEquals($data['rate'], 111, 'expected to find rate "111"');

        /* delete service */
        $response = $this->request('DELETE', '/api/activities/' . $activityId . '.json');
        $this->assertEquals(200, $response->getStatusCode());

        /* check if service still exists*/
        $response = $this->request('GET', '/api/activities/' . $activityId . '.json');
        $this->assertEquals(404, $response->getStatusCode());
    }

    public function tearDown()
    {
        parent::tearDown();

        // workaround for https://github.com/symfony/symfony/issues/2531
        if (ob_get_length() == 0) {
            ob_start();
        }
    }
}
