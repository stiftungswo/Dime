<?php

namespace Dime\TimetrackerBundle\Test\Entity;

use Dime\TimetrackerBundle\Entity\Setting;
use PHPUnit\Framework\TestCase;

class SettingTest extends TestCase
{

    function testGetSetName()
    {
        // get and set Name
        $setting = new Setting();
        $this->assertNull($setting->getName());
        $setting->setName('neuer Name');
        $this->assertEquals('neuer Name', $setting->getName());
    }

    function testGetSetNamespace()
    {
        // get and set Namespace
        $setting = new Setting();
        $this->assertNull($setting->getNamespace());
        $setting->setNamespace('neuer Namespace');
        $this->assertEquals('neuer Namespace', $setting->getNamespace());
    }

    function testGetSetValue()
    {
        // get and set Value
        $setting = new Setting();
        $this->assertNull($setting->getValue());
        $setting->setValue('neuer Value');
        $this->assertEquals('neuer Value', $setting->getValue());
    }
}
