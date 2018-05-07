<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180426065050 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        //set the rate_group_id of a project to the one in its customer, if it is currently null
        $this->addSql("update projects p
  inner join customers c on p.customer_id = c.id
    set p.rate_group_id = coalesce(p.rate_group_id, c.rate_group_id)
where p.rate_group_id is null;");
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
    }
}
