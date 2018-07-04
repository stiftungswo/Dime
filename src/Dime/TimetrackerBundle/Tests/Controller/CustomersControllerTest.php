<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class CustomersControllerTest extends DimeTestCase
{
    public function testAuthentification()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/customers')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/customers')->getStatusCode());
    }

    public function testGetCustomersAction()
    {
        $this->loginAs('admin');
        $response = $this->jsonRequest('GET', $this->api_prefix.'/customers');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find customers');
        $this->assertEquals('StiftungSWO', $data[0]['name'], 'expected to find "StiftungSWO" first');
    }

    public function testGetCustomerAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing service */
        $this->assertEquals(404, $this->jsonRequest('GET', $this->api_prefix.'/customers/11111')->getStatusCode());

        /* check existing service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/customers/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find customers');
        $this->assertEquals('StiftungSWO', $data['name']);
    }

    public function testPostPutDeleteCustomerActions()
    {
        $this->loginAs('admin');
        /* create new service */
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix.'/customers',
            json_encode(array(
                'name' => 'Test',
                'alias' => 'test'
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/customers/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Test', $data['name'], 'expected to find "Test"');
        $this->assertEquals('test', $data['alias'], 'expected to find alias "Test"');

        /* modify service */
        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/customers/' . $id,
            json_encode(array(
                'name' => 'Modified Test',
                'alias' => 'Modified'
            ))
        );
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest(
            'PUT',
            $this->api_prefix.'/customers/' . ($id+100),
            json_encode(array(
                'name' => 'Modified Test',
                'alias' => 'Modified'
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        /* check created service */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/customers/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals('Modified Test', $data['name'], 'expected to find "Modified Test"');
        $this->assertEquals('modified', $data['alias'], 'expected to find alias "Modified"');

        /* delete service */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/customers/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if service still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/customers/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }

    public function testExportCsvAction()
    {
        $this->loginAs('admin');

        // load report
        $query = http_build_query([
            "search"         => '',
            "withTags"       => '',
            "systemCustomer" => '0',
        ]);
        $response = $this->jsonRequest('GET', $this->api_prefix . '/customers/export/csv?' . $query);

        $data = $response->getContent();

        // validate content
        $this->assertContains('Beschreibung', $data);
        $csvrows = explode("\n", $data);
        $csv = str_getcsv($csvrows[2], ',');
        $this->assertEquals('sep=,', $csvrows[0], 'expect first row to be excel marker');
        $this->assertGreaterThan(20, count($csvrows), 'expected more than 20 rows in CSV file');
        $this->assertEquals(16, count($csv), 'expected 14 columns in CSV file');



        $query = http_build_query([
            "search"         => '',
            "withTags"       => '',
            "systemCustomer" => '1',
        ]);
        $response = $this->jsonRequest('GET', $this->api_prefix . '/customers/export/csv?' . $query);

        $data = $response->getContent();
        $csvrows = explode("\n", $data);

        $this->assertLessThan(20, count($csvrows), 'expected less than 20 rows in CSV file');


        $query = http_build_query([
            "search"         => '',
            "withTags"       => '3',
            "systemCustomer" => '0',
        ]);
        $response = $this->jsonRequest('GET', $this->api_prefix . '/customers/export/csv?' . $query);

        $data = $response->getContent();
        $csvrows = explode("\n", $data);

        $this->assertSame(3, count($csvrows), 'expected exactly 3 rows in CSV file');


        $query = http_build_query([
            "search"         => 'StiftungSWO',
            "withTags"       => '',
            "systemCustomer" => '0',
        ]);
        $response = $this->jsonRequest('GET', $this->api_prefix . '/customers/export/csv?' . $query);

        $data = $response->getContent();
        $csvrows = explode("\n", $data);

        $this->assertSame(3, count($csvrows), 'expected exactly 3 rows in CSV file');
    }

    public function testImportCheckAction()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/customers/import/check',
            json_encode([
                'customers' => [
                    [ // this one shouldnt find anything
                        'name'     => 'sdfghjklkjhgfdfghjhgfghj',
                        'company'  => 'fghjjhgfhjhghjjhghj',
                        'email'    => 'bjhghjhgjhgjhghjkhg',
                        'fullname' => 'fhjghgfhhghjghjgghjh',
                    ],
                    [ // this one should
                        'name'     => 'StiftungSWO',
                        'company'  => '',
                        'email'    => '',
                        'fullname' => '',
                    ]
                ],
            ])
        );

        $data = json_decode($response->getContent(), true);

        $this->assertSame(2, count($data), 'expected exactly 2 rows in response');
        $this->assertSame($data[0], [], 'expected first result to be empty (no duplicates)');
        $this->assertNotEmpty($data[1], 'expected second result to not be empty (found duplicates)');
        $this->assertEquals($data[1][0]['name'], 'StiftungSWO', 'expected name to match the duplicate');
    }

    public function testImportAction()
    {
        $this->loginAs('admin');

        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/customers/import',
            json_encode([
                'customers' => [
                    [
                        'name' => 'Import1',
                    ],
                    [
                        'name' => 'Import2',
                    ]
                ],
            ])
        );

        $data = json_decode($response->getContent(), true);

        $this->assertSame(2, count($data), 'expected exactly 2 rows in response');
        $this->assertTrue(is_int($data[0]['id']), 'expected first response item to have an id');
        $this->assertSame($data[0]['name'], 'Import1', 'expected first response item to have the same name');


        // check if its in the DB
        $response = $this->jsonRequest('GET', $this->api_prefix.'/customers/' . $data[0]['id']);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find customer');
        $this->assertEquals('Import1', $data['name']);
    }
}
