<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20181004164954 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604279395C3F3');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA460427F5B7AF75');
        $this->addSql('DROP INDEX IDX_DA4604279395C3F3 ON offers');
        $this->addSql('DROP INDEX IDX_DA460427F5B7AF75 ON offers');
        $this->addSql('ALTER TABLE offers CHANGE customer_id old_customer_id INT DEFAULT NULL, CHANGE address_id old_address_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604271FFA9C37 FOREIGN KEY (old_customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604274994982B FOREIGN KEY (old_address_id) REFERENCES address (id)');
        $this->addSql('CREATE INDEX IDX_DA4604271FFA9C37 ON offers (old_customer_id)');
        $this->addSql('CREATE INDEX IDX_DA4604274994982B ON offers (old_address_id)');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F959395C3F3');
        $this->addSql('DROP INDEX IDX_6A2F2F959395C3F3 ON invoices');
        $this->addSql('ALTER TABLE invoices CHANGE customer_id old_customer_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F951FFA9C37 FOREIGN KEY (old_customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_6A2F2F951FFA9C37 ON invoices (old_customer_id)');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A49395C3F3');
        $this->addSql('DROP INDEX IDX_5C93B3A49395C3F3 ON projects');
        $this->addSql('ALTER TABLE projects CHANGE customer_id old_customer_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A41FFA9C37 FOREIGN KEY (old_customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_5C93B3A41FFA9C37 ON projects (old_customer_id)');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F951FFA9C37');
        $this->addSql('DROP INDEX IDX_6A2F2F951FFA9C37 ON invoices');
        $this->addSql('ALTER TABLE invoices CHANGE old_customer_id customer_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F959395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_6A2F2F959395C3F3 ON invoices (customer_id)');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604271FFA9C37');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604274994982B');
        $this->addSql('DROP INDEX IDX_DA4604271FFA9C37 ON offers');
        $this->addSql('DROP INDEX IDX_DA4604274994982B ON offers');
        $this->addSql('ALTER TABLE offers CHANGE old_customer_id customer_id INT DEFAULT NULL, CHANGE old_address_id address_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604279395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA460427F5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id)');
        $this->addSql('CREATE INDEX IDX_DA4604279395C3F3 ON offers (customer_id)');
        $this->addSql('CREATE INDEX IDX_DA460427F5B7AF75 ON offers (address_id)');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A41FFA9C37');
        $this->addSql('DROP INDEX IDX_5C93B3A41FFA9C37 ON projects');
        $this->addSql('ALTER TABLE projects CHANGE old_customer_id customer_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A49395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_5C93B3A49395C3F3 ON projects (customer_id)');
    }
}
