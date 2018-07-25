<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\ProjectComment;
use PHPUnit\Framework\TestCase;

class ProjectCommentTest extends TestCase
{
    public function testGetSetProject()
    {
        // get and set Project
        $project_comment = new ProjectComment();
        $project = new Project();
        $this->assertNull($project_comment->getProject());
        $project_comment->setProject($project);
        $this->assertEquals($project, $project_comment->getProject());
    }

    public function testGetSetComment()
    {
        // get and set Comment
        $project_comment = new ProjectComment();
        $this->assertNull($project_comment->getComment());
        $project_comment->setComment('neuer Comment');
        $this->assertEquals('neuer Comment', $project_comment->getComment());
    }

    public function testGetSetDate()
    {
        // get and set Comment
        $project_comment = new ProjectComment();
        $dt = new \DateTime();
        $this->assertNull($project_comment->getDate());
        $project_comment->setDate($dt);
        $this->assertEquals($dt, $project_comment->getDate());
    }
}
