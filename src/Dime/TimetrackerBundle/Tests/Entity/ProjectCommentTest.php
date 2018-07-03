<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\ProjectComment;

class ProjectCommentTest extends KernelTestCase
{

    function testGetSetProject()
    {
        // get and set Project
        $project_comment = new ProjectComment();
        $project = new Project();
        $this->assertEquals(null, $project_comment->getProject());
        $project_comment->setProject($project);
        $this->assertEquals($project, $project_comment->getProject());
    }

    function testGetSetComment()
    {
        // get and set Comment
        $project_comment = new ProjectComment();
        $this->assertEquals(null, $project_comment->getComment());
        $project_comment->setComment('neuer Comment');
        $this->assertEquals('neuer Comment', $project_comment->getComment());
    }

    function testGetSetDate()
    {
        // get and set Comment
        $project_comment = new ProjectComment();
        $dt = new \DateTime();
        $this->assertEquals(null, $project_comment->getDate());
        $project_comment->setDate($dt);
        $this->assertEquals($dt, $project_comment->getDate());
    }
}
