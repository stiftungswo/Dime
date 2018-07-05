<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\ProjectCategory;
use PHPUnit\Framework\TestCase;

class ProjectCategoryTest extends TestCase
{
    public function testGetSetName()
    {
        // get and set name
        $project_category = new ProjectCategory();
        $this->assertNull($project_category->getName());
        $project_category->setName('some_name');
        $this->assertEquals('some_name', $project_category->getName());
    }

    public function testGetSetId()
    {
        // get and set id
        $project_category = new ProjectCategory();
        $this->assertNull($project_category->getId());
        $project_category->setId('some_Id');
        $this->assertEquals('some_Id', $project_category->getId());
    }
}
