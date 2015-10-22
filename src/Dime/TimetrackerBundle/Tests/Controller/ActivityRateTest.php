<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class ActivityRateTest extends DimeTestCase
{
    public function testActivityRate()
    {

        //generate testdata
        $this->loginAs('admin');

        //test rate group
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/rategroups',
            json_encode(array(
                'name' => 'Test rate group',
                'description' => 'specific rate group for testing'
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());
        $data = json_decode($response->getContent(), true);
        $testRateGroupId = $data['id'];


        //test service
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/services',
            json_encode(array(
                'name' => 'Test service',
                'alias' => 'Test service',
                'chargeable' => '1',
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());
        $data = json_decode($response->getContent(), true);
        $testServiceId = $data['id'];


        //default test rate
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/rates',
            json_encode(array(
                'rateValue' => 100,
                'service' => $testServiceId,
                'rateUnit' => 'h',
                'rateGroup' => 1
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());
        $data = json_decode($response->getContent(), true);
        $defaultTestRate = $data['id'];

        //specific test rate
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/rates',
            json_encode(array(
                'rateValue' => 200,
                'service' => $testServiceId,
                'rateUnit' => 'h',
                'rateGroup' => $testRateGroupId
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());
        $data = json_decode($response->getContent(), true);
        $specificTestRate = $data['id'];

        //test project
        $response = $this->jsonRequest(
            'POST',
            $this->api_prefix . '/projects',
            json_encode(array(
                'name' => 'Test Project for activity rate tests',
                'alias' => 'alias'
            ))
        );
        $data = json_decode($response->getContent(), true);
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());
        $testProjectId = $data['id'];

        //test activity
        $response = $this->jsonRequest('POST', $this->api_prefix . '/activities', json_encode(array(
            'description' => 'test',
            'service' => $testServiceId,
            'project' => $testProjectId,
            'user' => 1
        )));
        $data = json_decode($response->getContent(), true);

        $this->assertEquals(201, $response->getStatusCode());
        $testActivityId = $data['id'];


        // Testcases

        /**
         * PROJECT
         *  id=new
         *  rateGroup=default
         *   |
         * ACTIVITY
         *  id=new
         *  rate=null
         *   |
         * SERVICE
         *  id=new
         *   |  |_______________
         *   |                  |
         * RATE                RATE
         *  id=new              id=new
         *  rateGroup=1       rateGroupSpecific
         *  value=100           value=200
         *   |                  |
         * RATEGROUP           RATEGROUP
         *  id=1 (default)      id=new
         *
         */



        //rea rate on activity should be 100 because of default rate and not manually set
        $response = $this->jsonRequest('GET', $this->api_prefix . '/activities/' . $testActivityId);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals(100, $data['rateValue'], 'expected activity to use rate of default rate group with value 100');

        //set specific rategroup on project, expect rate on activity to be according specific rate
        /* modify project */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/projects/' . $testProjectId, json_encode(array(
            'rateGroup'     => $testRateGroupId
        )));
        $this->assertEquals(200, $response->getStatusCode());

        //rea rate on activity should be 100 because of default rate and not manually set
        $response = $this->jsonRequest('GET', $this->api_prefix . '/activities/' . $testActivityId);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals(100, $data['rateValue'], 'expected activity to use rate of test rate group with value 200');

        // modify activity
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/activities/' . $testActivityId, json_encode(array(
            'rateValue'          => 77
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('GET', $this->api_prefix . '/activities/' . $testActivityId);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals(77, $data['rateValue'], 'expected activity to use rate of test rate group with value 77');


        //cleanupt testdata

        if (true) {
            $response = $this->jsonRequest('DELETE', $this->api_prefix . '/activities/' . $testActivityId);
            $this->assertEquals(204, $response->getStatusCode());

            $response = $this->jsonRequest('DELETE', $this->api_prefix . '/projects/' . $testProjectId);
            $this->assertEquals(204, $response->getStatusCode());

            $response = $this->jsonRequest('DELETE', $this->api_prefix . '/rates/' . $defaultTestRate);
            $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

            $response = $this->jsonRequest('DELETE', $this->api_prefix . '/rates/' . $specificTestRate);
            $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

            $response = $this->jsonRequest('DELETE', $this->api_prefix . '/services/' . $testServiceId);
            $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

            $response = $this->jsonRequest('DELETE', $this->api_prefix . '/rategroups/' . $testRateGroupId);
            $this->assertEquals(204, $response->getStatusCode(), $response->getContent());
        }
    }
}
