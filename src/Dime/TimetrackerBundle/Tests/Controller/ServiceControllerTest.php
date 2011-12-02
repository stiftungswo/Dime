<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class ServiceControllerTest extends WebTestCase
{
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
        $client = static::createClient();

        // make get request with authentifaction
        $client->request($method, $url, $parameters, $files, $server, $content);
        return $client->getResponse();
    }

    public function testAuthentification()
    {
        $this->assertEquals(401, $this->request('GET', '/api/services.json', array(), array(), array())->getStatusCode());
        $this->assertEquals(200, $this->request('GET', '/api/services.json')->getStatusCode());
    }

    public function testGetServicesAction()
    {
        $response = $this->request('GET', '/api/services.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find services');
        $this->assertEquals($data[0]['name'], 'consulting', 'expected to find "consulting" first');
    }

    public function testGetServiceAction()
    {
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->request('GET', '/api/services/11111.json')->getStatusCode());

        /* check existing service */
        $response = $this->request('GET', '/api/services/1.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find services');
        $this->assertEquals($data['name'], 'consulting', 'expected to find "consulting"');
    }

    public function testPostPutDeleteServiceActions()
    {
        /* create new service */
        $response = $this->request('POST', '/api/services.json', array(), array(), null, '{"name": "Test", "rate": 555}');
        $this->assertEquals(200, $response->getStatusCode());
        
        // convert json to array
        $data = json_decode($response->getContent(), true);

        $serviceId = $data['id'];
        
        /* check created service */
        $response = $this->request('GET', '/api/services/' . $serviceId . '.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertEquals($data['name'], 'Test', 'expected to find "Test"');
        $this->assertEquals($data['rate'], 555, 'expected to find rate "555"');

        /* modify service */
        $response = $this->request('PUT', '/api/services/' . $serviceId . '.json', array(), array(), null, '{"name": "Modified Test", "rate": 111}');
        $this->assertEquals(200, $response->getStatusCode());
        
        /* check created service */
        $response = $this->request('GET', '/api/services/' . $serviceId . '.json');
        
        // convert json to array
        $data = json_decode($response->getContent(), true);
        
        // assert that data has content
        $this->assertEquals($data['name'], 'Modified Test', 'expected to find "Modified Test"');
        $this->assertEquals($data['rate'], 111, 'expected to find rate "111"');

        /* delete service */
        $response = $this->request('DELETE', '/api/services/' . $serviceId . '.json');
        $this->assertEquals(200, $response->getStatusCode());

        /* check if service still exists*/
        $response = $this->request('GET', '/api/services/' . $serviceId . '.json');
        $this->assertEquals(404, $response->getStatusCode());
    }
}
