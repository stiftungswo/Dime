<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20181005073541 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE offers ADD customer_id INT DEFAULT NULL, ADD address_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604279395C3F3 FOREIGN KEY (customer_id) REFERENCES Customer (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA460427F5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_DA4604279395C3F3 ON offers (customer_id)');
        $this->addSql('CREATE INDEX IDX_DA460427F5B7AF75 ON offers (address_id)');
        $this->addSql('ALTER TABLE invoices ADD customer_id INT DEFAULT NULL, ADD address_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F959395C3F3 FOREIGN KEY (customer_id) REFERENCES Customer (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F95F5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_6A2F2F959395C3F3 ON invoices (customer_id)');
        $this->addSql('CREATE INDEX IDX_6A2F2F95F5B7AF75 ON invoices (address_id)');
        $this->addSql('ALTER TABLE projects ADD customer_id INT DEFAULT NULL, ADD address_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A49395C3F3 FOREIGN KEY (customer_id) REFERENCES Customer (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A4F5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_5C93B3A49395C3F3 ON projects (customer_id)');
        $this->addSql('CREATE INDEX IDX_5C93B3A4F5B7AF75 ON projects (address_id)');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F959395C3F3');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F95F5B7AF75');
        $this->addSql('DROP INDEX IDX_6A2F2F959395C3F3 ON invoices');
        $this->addSql('DROP INDEX IDX_6A2F2F95F5B7AF75 ON invoices');
        $this->addSql('ALTER TABLE invoices DROP customer_id, DROP address_id');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604279395C3F3');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA460427F5B7AF75');
        $this->addSql('DROP INDEX IDX_DA4604279395C3F3 ON offers');
        $this->addSql('DROP INDEX IDX_DA460427F5B7AF75 ON offers');
        $this->addSql('ALTER TABLE offers DROP customer_id, DROP address_id');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A49395C3F3');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A4F5B7AF75');
        $this->addSql('DROP INDEX IDX_5C93B3A49395C3F3 ON projects');
        $this->addSql('DROP INDEX IDX_5C93B3A4F5B7AF75 ON projects');
        $this->addSql('ALTER TABLE projects DROP customer_id, DROP address_id');
    }
}
