<?php

namespace Swo\CustomerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class CompanyControllerTest extends DimeTestCase
{
    public function testAuthentication()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix . '/companies')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix . '/companies')->getStatusCode());
    }

    public function testGetCompanyAction()
    {
        $this->loginAs('admin');
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix . '/companies/123456')->getStatusCode());

        // check existing companies
        $response = $this->jsonRequest('GET', $this->api_prefix . '/companies/1');
        $this->assertEquals(200, $response->getStatusCode());

        // check that we have data
        $data = json_decode($response->getContent(), true);
        $this->assertTrue(count($data) > 0, 'expected to find companies');
    }

    public function testPostPutDeleteInvoiceActions()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/companies',
            json_encode(array(
                'comment' => 'Das ist eine Firma.',
                'email' => 'info@musterman.ag',
                'name' => 'Mustermann AG',
                'department' => 'Mustersachen',
                'rateGroup' => 1,
                'address' => array(
                    'street' => 'Bahnstrasse 18b',
                    'postcode' => 8603,
                    'city' => 'Schwerzenbach',
                    'country' => 'Schweiz'
                )
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json data to array
        $data = json_decode($response->getContent(), true);
        $id = $data['id'];

        // check that the entity got really created (and getter works)
        $response = $this->jsonRequest('GET', $this->api_prefix . '/companies/' . $id);
        $data = json_decode($response->getContent(), true);

        //assert that data has content
        $this->assertEquals('Das ist eine Firma.', $data['comment']);
        $this->assertEquals('info@musterman.ag', $data['email']);
        $this->assertEquals('Mustermann AG', $data['name']);
        $this->assertEquals('Bahnstrasse 18b', $data['address']['street']);
        $this->assertEquals('Schweiz', $data['address']['country']);

        // modify the object
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix . '/companies/' . $id,
            json_encode(array(
                'email' => 'neu@musterman.ag',
                'department' => 'Coole Sachen',
                'address' => array(
                    'street' => 'Im Schatzacker 5',
                    'postcode' => 8600,
                    'city' => 'Dübendorf',
                )
            ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest('GET', $this->api_prefix . '/companies/' . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals('neu@musterman.ag', $data['email']);
        $this->assertEquals('Coole Sachen', $data['department']);
        $this->assertEquals('Im Schatzacker 5', $data['address']['street']);
        $this->assertEquals('Dübendorf', $data['address']['city']);

        // check that invalid ids get 404 return
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/companies/' . ($id+100),
            json_encode(array(
                'name' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        // delete company
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/companies/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that company does not exist anymore
        $response = $this->jsonRequest('GET', $this->api_prefix.'/companies/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }
}
