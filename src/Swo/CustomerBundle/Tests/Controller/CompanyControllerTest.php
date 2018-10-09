<?php

namespace Swo\CustomerBundle\Tests\Controller;

use Dime\TimetrackerBundle\Tests\Controller\DimeTestCase;

class CompanyControllerTest extends DimeTestCase
{
    public function testAuthentication()
    {
        $this->assertEquals(401, $this->jsonRequest("GET", $this->api_prefix . "/companies")->getStatusCode());
        $this->loginAs("admin");
        $this->assertEquals(200, $this->jsonRequest("GET", $this->api_prefix . "/companies")->getStatusCode());
    }

    public function testGetCompanyAction()
    {
        $this->loginAs("admin");
        $this->assertEquals(404, $this->jsonRequest("GET", $this->api_prefix . "/companies/123456")->getStatusCode());

        // check existing companies
        $response = $this->jsonRequest("GET", $this->api_prefix . "/companies/1");
        $this->assertEquals(200, $response->getStatusCode());

        // check that we have data
        $data = json_decode($response->getContent(), true);
        $this->assertTrue(count($data) > 0, "expected to find companies");
    }

    public function testPostPutDeleteInvoiceActions()
    {
        $this->loginAs("admin");

        $response = $this->jsonRequest(
            "POST",
            $this->api_prefix . "/companies",
            json_encode(array(
                "comment" => "Das ist eine Firma.",
                "email" => "info@musterman.ag",
                "name" => "Mustermann AG",
                "rateGroup" => 1,
                "chargeable" => true,
                "hideForBusiness" => true
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // convert json data to array
        $data = json_decode($response->getContent(), true);
        $id = $data["id"];

        // check that the entity got really created (and getter works)
        $response = $this->jsonRequest("GET", $this->api_prefix . "/companies/" . $id);
        $data = json_decode($response->getContent(), true);

        //assert that data has content
        $this->assertEquals("Das ist eine Firma.", $data["comment"]);
        $this->assertEquals("info@musterman.ag", $data["email"]);
        $this->assertEquals("Mustermann AG", $data["name"]);
        $this->assertTrue($data["chargeable"]);
        $this->assertTrue($data["hideForBusiness"]);

        // modify the object
        $response = $this->jsonRequest(
            "PUT",
            $this->api_prefix . "/companies/" . $id,
            json_encode(array(
                "email" => "neu@musterman.ag",
                "chargeable" => false,
                "hideForBusiness" => false
            ))
        );
        $this->assertEquals(200, $response->getStatusCode(), $response->getContent());

        // check data
        $response = $this->jsonRequest("GET", $this->api_prefix . "/companies/" . $id);
        $data = json_decode($response->getContent(), true);
        $this->assertEquals("neu@musterman.ag", $data["email"]);
        $this->assertFalse($data["chargeable"]);
        $this->assertFalse($data["hideForBusiness"]);

        // check that invalid ids get 404 return
        $response = $this->jsonRequest(
            "PUT",
            $this->api_prefix."/companies/" . ($id+100),
            json_encode(array(
                "name" => "Modified Test (to be failed)"
            ))
        );
        $this->assertEquals(404, $response->getStatusCode());

        // delete company
        $response = $this->jsonRequest("DELETE", $this->api_prefix."/companies/" . $id);
        $this->assertEquals(204, $response->getStatusCode(), $response->getContent());

        // check that company does not exist anymore
        $response = $this->jsonRequest("GET", $this->api_prefix."/companies/" . $id);
        $this->assertEquals(404, $response->getStatusCode(), $response->getContent());
    }

    public function testPostCompaniesImportCheck()
    {
        $this->loginAs("admin");

        // send a new company to have a duplicate
        $response = $this->jsonRequest(
            "POST",
            $this->api_prefix . "/companies",
            json_encode(array(
                "comment" => "Das ist eine Firma.",
                "email" => "info@musterman.ag",
                "name" => "Mustermann AG",
                "rateGroup" => 1,
                "chargeable" => true,
                "hideForBusiness" => true
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());

        // send the data
        $response = $this->jsonRequest(
            "POST",
            $this->api_prefix . "/companies/import/check",
            json_encode(array(
                "companies" => array(
                    array(
                        "name" => "Mustermann AG",
                        "email" => "info@musterman.ag"
                    ), array (
                        "name" => "Kein Duplikat",
                        "email" => "kein@duplikat.com"
                    )
                )
            ))
        );
        $this->assertEquals([true, false], json_decode($response->getContent(), true));
    }
    
    public function testCompaniesImportAction()
    {
        $this->loginAs("admin");
        
        // just send a huge chunk of data
        $response = $this->jsonRequest(
            "POST",
            $this->api_prefix . "/companies/import",
            json_encode(array(
                "companies" => array(
                    array(
                        "comment" => "Das ist eine Firma.",
                        "email" => "info@musterman.ag",
                        "name" => "Stiftung Wirtschaft und Ökologie",
                        "rateGroup" => 1,
                        "chargeable" => true,
                        "hideForBusiness" => true,
                        "phoneNumbers" => array(
                            array(
                                "number" => "088 777 33 22",
                                "category" => 5
                            ), array(
                                "number" => "077 666 55 44",
                                "category" => 3
                            )),
                        "addresses" => array(
                            array(
                                "street" => "Im Schatzacker 5",
                                "supplement" => "Immer noch kein Postfach",
                                "postcode" => 8600,
                                "city" => "Dübendorf",
                                "country" => "Still Schweiz",
                                "description" => "Eine neue Beschreibung"
                            ), array(
                                "street" => "Bahnstrasse 18b",
                                "supplement" => "Immer noch kein Postfach",
                                "postcode" => 8603,
                                "city" => "Schwerzenbach",
                                "country" => "Schweiz",
                                "description" => "Eine Beschreibung"
                            )
                        )
                    )
                )
            ))
        );
        $this->assertEquals(201, $response->getStatusCode(), $response->getContent());
        $response = json_decode($response->getContent(), true);
        $this->assertEquals(1, sizeof($response));
    }
}
