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

        $this->addSql('CREATE TABLE setting_assign_projects(id INT(6) AUTO_INCREMENT PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, project_id INT NULL ,created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE setting_assign_projects ADD CONSTRAINT FK_setting_assign_projects_projects FOREIGN KEY (project_id) REFERENCES projects (id)');

        $this->addSql('INSERT INTO setting_assign_projects VALUES (1,"Urlaub", NULL , NOW(), NOW())');
        $this->addSql('INSERT INTO setting_assign_projects VALUES (2,"Krank", NULL , NOW(), NOW())');

    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->addSql('ALTER TABLE setting_assign_projects DROP FOREIGN KEY FK_setting_assign_projects_projects');
        $this->addSql('Drop TABLE setting_assign_projects ');
    }
}
