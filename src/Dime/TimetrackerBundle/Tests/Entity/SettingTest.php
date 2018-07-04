<?php

namespace Dime\TimetrackerBundle\Test\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\Setting;

class SettingTest extends KernelTestCase
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
