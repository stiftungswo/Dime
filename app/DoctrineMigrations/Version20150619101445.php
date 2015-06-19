<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20150619101445 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE invoice_invoicediscounts');
        $this->addSql('ALTER TABLE invoiceDiscounts ADD invoice_id INT DEFAULT NULL, CHANGE value value NUMERIC(10, 2) DEFAULT NULL');
        $this->addSql('ALTER TABLE invoiceDiscounts ADD CONSTRAINT FK_4F4E9F232989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('CREATE INDEX IDX_4F4E9F232989F1FD ON invoiceDiscounts (invoice_id)');
        $this->addSql('ALTER TABLE timeslices CHANGE value value NUMERIC(10, 4) NOT NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE invoice_invoicediscounts (invoice_id INT NOT NULL, invoicediscount_id INT NOT NULL, UNIQUE INDEX UNIQ_C596C402D6EBE1F9 (invoicediscount_id), INDEX IDX_C596C4022989F1FD (invoice_id), PRIMARY KEY(invoice_id, invoicediscount_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE invoice_invoicediscounts ADD CONSTRAINT FK_C596C4022989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('ALTER TABLE invoice_invoicediscounts ADD CONSTRAINT FK_C596C402D6EBE1F9 FOREIGN KEY (invoicediscount_id) REFERENCES invoiceDiscounts (id)');
        $this->addSql('ALTER TABLE invoiceDiscounts DROP FOREIGN KEY FK_4F4E9F232989F1FD');
        $this->addSql('DROP INDEX IDX_4F4E9F232989F1FD ON invoiceDiscounts');
        $this->addSql('ALTER TABLE invoiceDiscounts DROP invoice_id, CHANGE value value NUMERIC(10, 2) NOT NULL');
        $this->addSql('ALTER TABLE timeslices CHANGE value value INT NOT NULL');
    }
}
