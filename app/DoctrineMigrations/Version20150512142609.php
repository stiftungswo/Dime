<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20150512142609 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE WorkingPeriods (id INT AUTO_INCREMENT NOT NULL, employee_id INT DEFAULT NULL, user_id INT DEFAULT NULL, start DATE NOT NULL, end DATE NOT NULL, pensum NUMERIC(10, 2) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_57C1BB888C03F15C (employee_id), INDEX IDX_57C1BB88A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE FreePeriods (id INT AUTO_INCREMENT NOT NULL, employee_id INT DEFAULT NULL, user_id INT DEFAULT NULL, start DATE NOT NULL, end DATE NOT NULL, pensum NUMERIC(10, 2) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_1CFF23918C03F15C (employee_id), INDEX IDX_1CFF2391A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE WorkingPeriods ADD CONSTRAINT FK_57C1BB888C03F15C FOREIGN KEY (employee_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE WorkingPeriods ADD CONSTRAINT FK_57C1BB88A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE FreePeriods ADD CONSTRAINT FK_1CFF23918C03F15C FOREIGN KEY (employee_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE FreePeriods ADD CONSTRAINT FK_1CFF2391A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('DROP TABLE address_city');
        $this->addSql('DROP TABLE address_country');
        $this->addSql('DROP TABLE address_state');
        $this->addSql('DROP TABLE address_street');
        $this->addSql('ALTER TABLE activities CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE vat vat NUMERIC(10, 3) DEFAULT NULL');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE rates CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE settings CHANGE value value LONGTEXT DEFAULT NULL');
	$this->addSql('UPDATE users SET discr=\'employee\'');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE vat vat NUMERIC(10, 3) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoices ADD customer_id INT DEFAULT NULL, CHANGE description description LONGTEXT DEFAULT NULL, CHANGE start start DATE DEFAULT NULL, CHANGE end end DATE DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F959395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_6A2F2F959395C3F3 ON invoices (customer_id)');
        $this->addSql('ALTER TABLE invoice_items CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE rateUnit rateUnit VARCHAR(255) DEFAULT NULL, CHANGE amount amount VARCHAR(255) DEFAULT NULL, CHANGE total total VARCHAR(255) DEFAULT NULL, CHANGE vat vat NUMERIC(10, 3) DEFAULT NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE address_city (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, plz INT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE address_country (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE address_state (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, shortcode VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE address_street (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('DROP TABLE WorkingPeriods');
        $this->addSql('DROP TABLE FreePeriods');
        $this->addSql('ALTER TABLE activities CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE vat vat NUMERIC(10, 2) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoice_items CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE rateUnit rateUnit VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, CHANGE vat vat NUMERIC(10, 2) DEFAULT NULL, CHANGE amount amount VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, CHANGE total total VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F959395C3F3');
        $this->addSql('DROP INDEX IDX_6A2F2F959395C3F3 ON invoices');
        $this->addSql('ALTER TABLE invoices DROP customer_id, CHANGE description description LONGTEXT NOT NULL COLLATE utf8_unicode_ci, CHANGE start start DATE NOT NULL, CHANGE end end DATE NOT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE vat vat NUMERIC(10, 2) DEFAULT NULL');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE rates CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE settings CHANGE value value LONGTEXT NOT NULL COLLATE utf8_unicode_ci');
    }
}
