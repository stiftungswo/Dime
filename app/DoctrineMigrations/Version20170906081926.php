<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20170906081926 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->addSql('ALTER TABLE projects ADD deleted_at datetime NULL');
        $this->addSql('ALTER TABLE activities ADD deleted_at datetime NULL');
        $this->addSql('ALTER TABLE timeslices ADD deleted_at datetime NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->addSql('ALTER TABLE projects DROP COLUMN deleted_at');
        $this->addSql('ALTER TABLE activities DROP COLUMN deleted_at');
        $this->addSql('ALTER TABLE timeslices DROP COLUMN deleted_at');
    }
}
