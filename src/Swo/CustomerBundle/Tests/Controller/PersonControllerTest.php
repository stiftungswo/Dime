<?php

namespace Swo\CustomerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class PersonControllerTest extends DimeTestCase
{
    public function testAuthentication()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix . '/persons')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix . '/persons')->getStatusCode());
    }
    
    public function testGetPersonAction()
    {
        $this->loginAs('admin');
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix . '/persons/123456')->getStatusCode());

        $response = $this->jsonRequest('GET', $this->api_prefix . '/persons/1');
        $this->assertEquals(200, $response->getStatusCode());

        // check that we have data
        $data = json_decode($response->getContent(), true);
        $this->assertTrue(count($data) > 0, 'expected to find persons');
    }

    public function testPostPutDeleteCompanyPersonActions()
    {
        $this->loginAs('admin');

        // first, create a person with a company and an address
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/persons',
            json_encode(array(
                'comment' => 'Das ist eine Person',
                'email' => 'p.person@musterman.ag',
                'company' => 1,
                'salutation' => 'Monsieur',
                'firstName' => 'Peter',
                'lastName' => 'Person',
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json data to array
        $data = json_decode($response->getContent(), true);
        $id = $data['id'];

        // check that entity got really created
        $response = $this->jsonRequest('GET', $this->api_prefix . '/persons/' . $id);
        $data = json_decode($response->getContent(), true);

        // assert that data has desired content
        $this->assertEquals('Das ist eine Person', $data['comment']);
        $this->assertEquals('p.person@musterman.ag', $data['email']);
        $this->assertEquals('Peter', $data['firstName']);
        $this->assertEquals(1, $data['company']['id']);

        // modify the object
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix . '/persons/' . $id,
            json_encode(array(
                    'email' => 'peter.person@musterman.ag',
                    'comment' => 'Keine Person mehr.',
                    'company' => 10,
                ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest('GET', $this->api_prefix . '/persons/' . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals('Keine Person mehr.', $data['comment']);
        $this->assertEquals('peter.person@musterman.ag', $data['email']);
        $this->assertEquals(10, $data['company']['id']);

        // delete peter
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/persons/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that peter does not exist anymore
        $response = $this->jsonRequest('GET', $this->api_prefix.'/persons/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }

    public function testPostPutDeleteCompanyActions()
    {
        $this->loginAs('admin');

        // do the things for a person without a company
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/persons',
            json_encode(array(
                'comment' => 'Das ist eine Person',
                'email' => 'p.person@musterman.ag',
                'salutation' => 'Monsieur',
                'firstName' => 'Peter',
                'lastName' => 'Person',
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json data to array
        $data = json_decode($response->getContent(), true);
        $id = $data['id'];

        // check that entity got really created
        $response = $this->jsonRequest('GET', $this->api_prefix . '/persons/' . $id);
        $data = json_decode($response->getContent(), true);

        // assert that data has desired content
        $this->assertEquals('Das ist eine Person', $data['comment']);
        $this->assertEquals('p.person@musterman.ag', $data['email']);
        $this->assertEquals('Peter', $data['firstName']);

        // modify the object
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix . '/persons/' . $id,
            json_encode(array(
                    'email' => 'peter.person@musterman.ag',
                    'comment' => 'Keine Person mehr.',
                ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest('GET', $this->api_prefix . '/persons/' . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals('Keine Person mehr.', $data['comment']);
        $this->assertEquals('peter.person@musterman.ag', $data['email']);

        // delete peter
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/persons/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that peter does not exist anymore
        $response = $this->jsonRequest('GET', $this->api_prefix.'/persons/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
