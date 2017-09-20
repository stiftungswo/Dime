<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

class Version20170920065233 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
      $this->addSql('ALTER TABLE users ADD extend_timetrack tinyint(1) DEFAULT 1 NOT NULL AFTER employeeholiday');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->addSql('ALTER TABLE users DROP COLUMN extend_timetrack');
    }
}
