<?php

namespace Dime\TimetrackerBundle\Tests\Parser;

use Dime\TimetrackerBundle\Parser\DurationParser;

class DurationTest extends \PHPUnit_Framework_TestCase
{
    public function testRun()
    {
        $parser = new DurationParser();

        // 02:30:00
        $parser->setResult(array());
        $result = $parser->run('02:30:00');
        $this->assertArrayHasKey('value', $result);
        $this->assertArrayHasKey('sign', $result['value']);
        $this->assertArrayHasKey('number', $result['value']);
        $this->assertEquals('', $result['value']['sign']);
        $this->assertEquals(9000, $result['value']['number']);

        // -02:30:00
        $parser->setResult(array());
        $result = $parser->run('-02:30:00');
        $this->assertEquals('-', $result['value']['sign']);
        $this->assertEquals(9000, $result['value']['number']);

        // 02:30h
        $parser->setResult(array());
        $result = $parser->run('02:30h');
        $this->assertEquals('', $result['value']['sign']);
        $this->assertEquals(9000, $result['value']['number']);

        // 02:30m
        $parser->setResult(array());
        $result = $parser->run('02:30m');
        $this->assertEquals('', $result['value']['sign']);
        $this->assertEquals(150, $result['value']['number']);

        // 2h 30m
        $parser->setResult(array());
        $result = $parser->run('2h 30m');
        $this->assertEquals('', $result['value']['sign']);
        $this->assertEquals(9000, $result['value']['number']);

        // 2.5h
        $parser->setResult(array());
        $result = $parser->run('2.5h');
        $this->assertEquals('', $result['value']['sign']);
        $this->assertEquals(9000, $result['value']['number']);

        // 2,5h
        $parser->setResult(array());
        $result = $parser->run('2,5h');
        $this->assertEquals('', $result['value']['sign']);
        $this->assertEquals(9000, $result['value']['number']);

        // substract 30 minutes
        $result = $parser->run('-30m');
        $this->assertEquals('-', $result['value']['sign']);
        $this->assertEquals(7200, $result['value']['number']);

        // Empty
        $parser->setResult(array());
        $result = $parser->run('');
        $this->assertEmpty($result);
    }

    public function testClean()
    {
        $parser = new DurationParser();
        $input = '02:30:00';

        $parser->run($input);

        $output = $parser->clean($input);

        $this->assertEquals('', $output);
    }
}
