<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

class RateUnitTypeControllerTest extends DimeTestCase
{

    function testAuthentication()
    {
        $this->assertEquals(401, $this
            ->jsonRequest('GET', $this->api_prefix.'/rateunittypes')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/rateunittypes')->getStatusCode());
    }

    function testGetRateUnitTypesAction()
    {
        // should return rate unit types
        $this->loginAs('admin');
        $this->assertEquals(200, $this
            ->jsonRequest('GET', $this->api_prefix.'/rateunittypes')
            ->getStatusCode());
    }

    function testGetRateUnitTypeAction()
    {
        $this->loginAs('admin');
        /* expect to get 404 on non-existing rate unit type */
        $this->assertEquals(404, $this
            ->jsonRequest('GET', $this->api_prefix.'/rateunittypes/111111')
            ->getStatusCode());

        /* check existing rate unit type */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rateunittypes/1');

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertTrue(count($data) > 0, 'expected to find rate unit type');
    }

    function testPostPutDeleteRateUnitTypeActions()
    {
        $this->loginAs('admin');

        /* create new rate unit type */
        $response = $this->jsonRequest('POST', $this->api_prefix.'/rateunittypes', json_encode(array(
            'id'            => 'k',
            'name'          => 'Kelvin',
            'doTransform'   => true,
            'factor'        => 1.0,
            'scale'         => 3,
            'roundMode'     => 9,
            'symbol'        => 'k'
        )));

        $this->assertEquals(201, $response->getStatusCode());

        // convert json to array
        $data = json_decode($response->getContent(), true);

        $id = $data['id'];

        /* check created rate unit type */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rateunittypes/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'Kelvin',
            $data['name'],
            'expected to find name "Kelvin"'
        );
        $this->assertTrue($data['doTransform'], 'expected doTransform to be true');

        /* modify rate unit type */
        $response = $this->jsonRequest('PUT', $this->api_prefix.'/rateunittypes/' . $id, json_encode(array(
            'id'            => 'f',
            'name'          => 'Fahrenheit',
            'doTransform'   => false,
            'factor'        => 2.0,
            'scale'         => 3,
            'roundMode'     => 9,
            'symbol'        => 'f'
        )));
        $this->assertEquals(200, $response->getStatusCode());
        $id = 'f';

        $response = $this->jsonRequest('PUT', $this->api_prefix.'/rateunittypes/aolkjdald', json_encode(array(
            'id'            => 'f',
            'name'          => 'Fahrenheit',
            'doTransform'   => false,
            'factor'        => 2.0,
            'scale'         => 3,
            'roundMode'     => 9,
            'symbol'        => 'f'
        )));
        $this->assertEquals(404, $response->getStatusCode());

        /* check created rate unit type */
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rateunittypes/' . $id);

        // convert json to array
        $data = json_decode($response->getContent(), true);

        // assert that data has content
        $this->assertEquals(
            'Fahrenheit',
            $data['name'],
            'expected to find name "Fahrenheit"'
        );
        $this->assertFalse($data['doTransform'], 'expected doTransform to be false');

        /* delete rate unit type */
        $response = $this->jsonRequest('DELETE', $this->api_prefix.'/rateunittypes/' . $id);
        $this->assertEquals(204, $response->getStatusCode());

        /* check if rate unit type still exists*/
        $response = $this->jsonRequest('GET', $this->api_prefix.'/rateunittypes/' . $id);
        $this->assertEquals(404, $response->getStatusCode());
    }
}
