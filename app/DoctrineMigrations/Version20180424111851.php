<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

class Version20180424111851 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        //set the rate_group_id of a project to the one in its offer, if it is currently null
        $this->addSql("update projects p
    inner join offers o on p.id = o.project_id
    set p.rate_group_id = coalesce(p.rate_group_id, o.rate_group_id)
where p.rate_group_id is null;");
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
    }
}
