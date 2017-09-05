<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20151028223057 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE projects ADD COLUMN accountant_id INT');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_projects_accountant FOREIGN KEY (accountant_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE projects ADD COLUMN deletedAt DATETIME NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_projects_accountant');
        $this->addSql('ALTER TABLE projects DROP COLUMN accountant_id');
        $this->addSql('ALTER TABLE projects DROP COLUMN deletedAt');
    }
}
