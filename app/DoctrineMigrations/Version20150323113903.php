<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

class Version20150323113903 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE tbbc_money_doctrine_storage_ratios (id INT AUTO_INCREMENT NOT NULL, currency_code VARCHAR(3) NOT NULL, ratio DOUBLE PRECISION NOT NULL, UNIQUE INDEX UNIQ_1168A609FDA273EC (currency_code), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE tbbc_money_ratio_history (id INT AUTO_INCREMENT NOT NULL, currency_code VARCHAR(3) NOT NULL, reference_currency_code VARCHAR(3) NOT NULL, ratio DOUBLE PRECISION NOT NULL, saved_at DATETIME NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE activities CHANGE rate rateValue NUMERIC(10, 2) DEFAULT NULL, ADD vat NUMERIC(10, 2) DEFAULT NULL');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoices ADD start DATE NOT NULL, ADD end DATE NOT NULL, ADD fixed_price VARCHAR(255) DEFAULT NULL, DROP gross');
        $this->addSql('ALTER TABLE invoice_items CHANGE type name VARCHAR(255) NOT NULL, CHANGE rate rate_value VARCHAR(255) DEFAULT NULL, ADD vat NUMERIC(10, 2) DEFAULT NULL, CHANGE value amount VARCHAR(255) NOT NULL, CHANGE charge total VARCHAR(255) NOT NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE tbbc_money_doctrine_storage_ratios');
        $this->addSql('DROP TABLE tbbc_money_ratio_history');
        $this->addSql('ALTER TABLE activities CHANGE ratevalue rate NUMERIC(10, 2) DEFAULT NULL, DROP vat');
        $this->addSql('ALTER TABLE invoice_items CHANGE name type VARCHAR(255) NOT NULL, CHANGE rate_value rate INT NOT NULL, CHANGE amount value VARCHAR(255) NOT NULL, CHANGE total charge NUMERIC(10, 2) NOT NULL, DROP vat');
        $this->addSql('ALTER TABLE invoices ADD gross NUMERIC(4, 2) DEFAULT NULL, DROP start, DROP end, DROP fixed_price');
        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value NUMERIC(10, 2) DEFAULT NULL');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price INT DEFAULT NULL');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price INT DEFAULT NULL, CHANGE fixed_price fixed_price INT DEFAULT NULL');
    }
}
