<?php

namespace Swo\CustomerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class PhoneControllerTest extends DimeTestCase
{
    public function testAuthentication()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix . '/phones')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix . '/phones')->getStatusCode());
    }

    public function testGetPhoneAction()
    {
        $this->loginAs('admin');
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix . '/phones/123456')->getStatusCode());

        // check existing phones
        $response = $this->jsonRequest('GET', $this->api_prefix . '/phones/1');
        $this->assertEquals(200, $response->getStatusCode());

        // check that we have data
        $data = json_decode($response->getContent(), true);
        $this->assertTrue(count($data) > 0, 'expected to find a phone');
    }

    public function testPostPutDeleteCompletePhoneActions()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/phones',
            json_encode(array(
                'number' => '022 333 44 55',
                'type' => 'mobile',
                'company' => 13,
                'persons' => [13,20]
                ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert response data to an array
        $data = json_decode($response->getContent(), true);
        $id = $data['id'];

        // check that the entity really exists
        $response = $this->jsonRequest('GET', $this->api_prefix . '/phones/' . $id);
        $data = json_decode($response->getContent(), true);

        // check that everything was filled in correctly
        // person and company can't be checked because they get rendered out during serialization
        $this->assertEquals('022 333 44 55', $data['number']);
        $this->assertEquals('mobile', $data['type']);

        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix . '/phones/' . $id,
            json_encode(array(
                'number' => '011 222 33 99',
                'type' => 'private',
                'company' => 11,
                'persons' => [15,20]
                ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest('GET', $this->api_prefix . '/phones/' . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals('011 222 33 99', $data['number']);
        $this->assertEquals('private', $data['type']);

        // check that invalid ids get 404 return
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/phones/' . ($id+100),
            json_encode(array(
                'name' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        // delete phone
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/phones/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that phone does not exist anymore
        $response = $this->jsonRequest('GET', $this->api_prefix.'/phones/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }

    public function testPostPutDeleteCompanyPhoneActions()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/phones',
            json_encode(array(
                    'number' => '022 333 44 55',
                    'type' => 'mobile',
                    'company' => 13,
                ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert response data to an array
        $data = json_decode($response->getContent(), true);
        $id = $data['id'];

        // check that the entity really exists
        $response = $this->jsonRequest('GET', $this->api_prefix . '/phones/' . $id);
        $data = json_decode($response->getContent(), true);

        // check that everything was filled in correctly
        // person and company can't be checked because they get rendered out during serialization
        $this->assertEquals('022 333 44 55', $data['number']);
        $this->assertEquals('mobile', $data['type']);

        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix . '/phones/' . $id,
            json_encode(array(
                    'number' => '011 222 33 99',
                    'type' => 'private',
                    'company' => 11,
                ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest('GET', $this->api_prefix . '/phones/' . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals('011 222 33 99', $data['number']);
        $this->assertEquals('private', $data['type']);

        // check that invalid ids get 404 return
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/phones/' . ($id+100),
            json_encode(array(
                'name' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        // delete phone
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/phones/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that phone does not exist anymore
        $response = $this->jsonRequest('GET', $this->api_prefix.'/phones/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }

    public function testPostPutDeletePersonPhoneActions()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/phones',
            json_encode(array(
                    'number' => '022 333 44 55',
                    'type' => 'mobile',
                    'persons' => [13,20]
                ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert response data to an array
        $data = json_decode($response->getContent(), true);
        $id = $data['id'];

        // check that the entity really exists
        $response = $this->jsonRequest('GET', $this->api_prefix . '/phones/' . $id);
        $data = json_decode($response->getContent(), true);

        // check that everything was filled in correctly
        // person and company can't be checked because they get rendered out during serialization
        $this->assertEquals('022 333 44 55', $data['number']);
        $this->assertEquals('mobile', $data['type']);

        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix . '/phones/' . $id,
            json_encode(array(
                    'number' => '011 222 33 99',
                    'type' => 'private',
                    'persons' => [15,20]
                ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest('GET', $this->api_prefix . '/phones/' . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals('011 222 33 99', $data['number']);
        $this->assertEquals('private', $data['type']);

        // check that invalid ids get 404 return
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/phones/' . ($id+100),
            json_encode(array(
                'name' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        // delete phone
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/phones/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that phone does not exist anymore
        $response = $this->jsonRequest('GET', $this->api_prefix.'/phones/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
