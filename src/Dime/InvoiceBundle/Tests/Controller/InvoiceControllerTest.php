<?php

namespace Dime\InvoiceBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class InvoiceControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(302, $this->jsonRequest('GET', $this->api_prefix.'/invoices')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/invoices')->getStatusCode());
    }

    public function testGetInvoiceAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/invoices/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/invoices/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find invoices');
        $this->assertEquals('Default Invoice', $data['name'], 'expected to find "Default Invoice"');
    }

    public function testPostPutDeleteInvoiceActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/invoices',
            json_encode(array(
                'name' => 'Test',
                'alias' => 'new-test',
                'description' => 'hello world...',
                'start' => '2017-01-01',
                'end' => '2017-02-21',
                'fixedPrice' => '1337'
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created  */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/invoices/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name']);
        $this->assertEquals('new-test', $data['alias']);
        $this->assertEquals('hello world...', $data['description']);
        $this->assertEquals('2017-01-01 00:00:00', $data['start']);
        $this->assertEquals('2017-02-21 00:00:00', $data['end']);
        $this->assertEquals('1337', $data['fixedPrice']);

        /* modify  */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/invoices/' . $id,
            json_encode(array(
                'name' => 'Modified Test',
                'alias' => 'new-test-modified',
                'description' => 'foo bar äöü',
                'start' => '2018-01-01',
                'end' => '2019-02-21',
                'fixedPrice' => null
            ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name']);
        $this->assertEquals('new-test-modified', $data['alias']);
        $this->assertEquals('foo bar äöü', $data['description']);
        $this->assertEquals('2018-01-01 00:00:00', $data['start']);
        $this->assertEquals('2019-02-21 00:00:00', $data['end']);
        $this->assertFalse(isset($data['fixedPrice']));

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/invoices/' . ($id+100),
        json_encode(array(
                'name' => 'Modified Test (to be failed)'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/invoices/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name']);

        /* delete service */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/invoices/' . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        /* check if service still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/invoices/' . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }

    public function testPrintInvoiceAction() {
        $this->loginAs('admin');

        $response = $this->jsonRequest('GET', $this->api_prefix.'/invoices/1/print');

        // test if pdf seems valid
        $data = $response->getContent();
        $this->assertEquals('%PDF-1.4', substr($data, 0, 8), $data);
        $this->assertContains('Rechnung Nr. 1',$data);
    }

}
