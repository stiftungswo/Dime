<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class SettingsControllerTest extends DimeTestCase
{

    function testAuthentication()
    {
        $this->assertEquals(401, $this
            ->jsonRequest('GET', $this->api_prefix.'/settings')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/settings')->getStatusCode());
    }

    function testGetSettingsAction()
    {
        // should return settings
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/settings')
            ->getStatusCode());
    }

    function testGetSettingAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing setting */
        $this->assertEquals(404, $this
            ->jsonRequest('GET', $this->api_prefix.'/settings/111111')
            ->getStatusCode());

        /* check existing setting */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/settings/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find setting');
    }

    function testPostPutDeleteSettingActions()
    {
        $this->loginAs('admin');

        /* create new setting */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/settings', json_encode(array(
            'name'          => 'Sample setting',
            'namespace'     => '/etc/defaults/1',
            'value'         => 'Sample value'
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created setting */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/settings/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'Sample setting',
            $data['name'],
            'expected to find name "Sample setting"'
        );
        $this->assertEquals(
            'Sample value',
            $data['value'],
            'expected to find value "Sample value"'
        );

        /* modify setting */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/settings/' . $id, json_encode(array(
            'name'          => 'New setting',
            'namespace'     => '/etc/defaults/45',
            'value'         => 'Better value'
        )));
        $this->assertEquals(200, $response->getStatusCode());

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/settings/' . ($id+100), json_encode(array(
            'name'          => 'New setting',
            'namespace'     => '/etc/defaults/45',
            'value'         => 'Better value'
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created setting */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/settings/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'New setting',
            $data['name'],
            'expected to find name "New setting"'
        );
        $this->assertEquals(
            'Better value',
            $data['value'],
            'expected to find value "Better value"'
        );

        /* delete setting */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/settings/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if setting still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/settings/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
