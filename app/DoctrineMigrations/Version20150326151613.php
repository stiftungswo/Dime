<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20150326151613 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE invoice_items ADD activity_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE invoice_items ADD CONSTRAINT FK_DCC4B9F881C06096 FOREIGN KEY (activity_id) REFERENCES activities (id)');
        $this->addSql('CREATE INDEX IDX_DCC4B9F881C06096 ON invoice_items (activity_id)');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE invoice_items DROP FOREIGN KEY FK_DCC4B9F881C06096');
        $this->addSql('DROP INDEX IDX_DCC4B9F881C06096 ON invoice_items');
        $this->addSql('ALTER TABLE invoice_items DROP activity_id');
    }
}
