<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20150326110111 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE activities CHANGE rateValue rate_value VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE rates CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoices CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoice_items CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE total total VARCHAR(255) NOT NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE activities CHANGE rate_value rateValue NUMERIC(10, 2) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoice_items CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE total total VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE invoices CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE rates CHANGE rate_value rate_value NUMERIC(10, 2) DEFAULT NULL');
    }
}
