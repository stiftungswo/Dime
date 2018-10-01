<?php

namespace Swo\CustomerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class AddressControllerTest extends DimeTestCase
{
    public function testAuthentication()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix . '/addresses')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix . '/addresses')->getStatusCode());
    }

    public function testGetAddressAction()
    {
        $this->loginAs('admin');
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix . '/addresses/123456')->getStatusCode());

        // check existing addresses
        $response = $this->jsonRequest('GET', $this->api_prefix . '/addresses/1');
        $this->assertEquals(200, $response->getStatusCode());

        // check that we have data
        $data = json_decode($response->getContent(), true);
        $this->assertTrue(count($data) > 0, 'expected to find an address');
    }

    public function testPostPutDeleteAddressActions()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/addresses',
            json_encode(array(
                'street' => 'Bahnstrasse 18b',
                'supplement' => 'Kein Postfach',
                'postcode' => 8603,
                'city' => 'Schwerzenbach',
                'country' => 'Schweiz',
                'description' => 'Eine Beschreibung',
                'customer' => 13,
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert response data to an array
        $data = json_decode($response->getContent(), true);
        $id = $data['id'];

        // check that the entity really exists
        $response = $this->jsonRequest('GET', $this->api_prefix . '/addresses/' . $id);
        $data = json_decode($response->getContent(), true);

        // check that everything was filled in correctly
        // person and company can't be checked because they get rendered out during serialization
        $this->assertEquals('Bahnstrasse 18b', $data['street']);
        $this->assertEquals('Kein Postfach', $data['supplement']);
        $this->assertEquals(8603, $data['postcode']);
        $this->assertEquals('Schwerzenbach', $data['city']);
        $this->assertEquals('Schweiz', $data['country']);
        $this->assertEquals('Eine Beschreibung', $data['description']);

        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix . '/addresses/' . $id,
            json_encode(array(
                'street' => 'Im Schatzacker 5',
                'supplement' => 'Immer noch kein Postfach',
                'postcode' => 8600,
                'city' => 'Dübendorf',
                'country' => 'Still Schweiz',
                'customer' => 11,
                'description' => 'Eine neue Beschreibung'
            ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest('GET', $this->api_prefix . '/addresses/' . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals('Im Schatzacker 5', $data['street']);
        $this->assertEquals('Immer noch kein Postfach', $data['supplement']);
        $this->assertEquals(8600, $data['postcode']);
        $this->assertEquals('Dübendorf', $data['city']);
        $this->assertEquals('Still Schweiz', $data['country']);
        $this->assertEquals('Eine neue Beschreibung', $data['description']);

        // check that invalid ids get 404 return
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/addresses/' . ($id+100),
            json_encode(array(
                'name' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        // delete address
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/addresses/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that address does not exist anymore
        $response = $this->jsonRequest('GET', $this->api_prefix.'/addresses/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
