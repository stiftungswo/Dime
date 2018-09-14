<?php
/**
 * Created by PhpStorm.
 * User: joni
 * Date: 14.09.18
 * Time: 15:44
 */

namespace Swo\CustomerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class CompanyControllerTest extends DimeTestCase
{
    public function testAuthentication()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/companies')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/companies')->getStatusCode());
    }

//    public function testGetCompaniesAction()
//    {
//        $this->loginAs('admin');
//        $response = $this->jsonRequest('GET', $this->api_prefix.'/companies');
//
//        $data = json_decode($response->getContent(), true);
//
//        $this->assertTrue(count($data) > 0, 'expected to find companies');
//        $this->assertEquals('StiftungSWO', $data[0]['name'], 'expected to find "StiftungSWO" first');
//    }

    // TODO
}
