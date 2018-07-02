<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\ProjectCategory;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class ProjectCategoryTest extends KernelTestCase
{

    public function testGetSetName()
    {
        // get and set name
        $project_category = new ProjectCategory();
        $this->assertEquals(null, $project_category->getName());
        $project_category->setName('some_name');
        $this->assertEquals('some_name', $project_category->getName());
    }

    public function testGetSetId()
    {
        // get and set id
        $project_category = new ProjectCategory();
        $this->assertEquals(null, $project_category->getId());
        $project_category->setId('some_Id');
        $this->assertEquals('some_Id', $project_category->getId());
    }
}
