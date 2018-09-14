<?php
/**
 * Created by PhpStorm.
 * User: joni
 * Date: 14.09.18
 * Time: 16:12
 */

namespace Swo\CustomerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class PersonControllerTest extends DimeTestCase
{
    public function testAuthentication()
    {
        $this->assertEquals(401, $this->jsonRequest('GET', $this->api_prefix.'/customers')->getStatusCode());
        $this->loginAs('admin');
        $this->assertEquals(200, $this->jsonRequest('GET', $this->api_prefix.'/customers')->getStatusCode());
    }
    // TODO
}
