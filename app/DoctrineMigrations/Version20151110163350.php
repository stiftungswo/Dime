<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20151110163350 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('INSERT INTO settings (name, namespace) VALUES ("Ferien", "/etc/projectassignments")');
        $this->addSql('INSERT INTO settings (name, namespace) VALUES ("Krank", "/etc/projectassignments")');

    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->addSql('DELETE FROM settings WHERE name = "Ferien" AND namespace = "/etc/projectassignments"');
        $this->addSql('DELETE FROM settings WHERE name = "Krank" AND namespace = "/etc/projectassignments"');
    }
}
