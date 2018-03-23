<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180322111442 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE invoice_standard_discounts DROP FOREIGN KEY FK_A1BE84207EAA7D27');
        $this->addSql('ALTER TABLE offer_standard_discounts DROP FOREIGN KEY FK_84D719D97EAA7D27');
        $this->addSql('DROP TABLE invoice_standard_discounts');
        $this->addSql('DROP TABLE offer_standard_discounts');
        $this->addSql('DROP TABLE standard_discounts');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE invoice_standard_discounts (invoice_id INT NOT NULL, standard_discount_id INT NOT NULL, UNIQUE INDEX UNIQ_A1BE84207EAA7D27 (standard_discount_id), INDEX IDX_A1BE84202989F1FD (invoice_id), PRIMARY KEY(invoice_id, standard_discount_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE offer_standard_discounts (offer_id INT NOT NULL, standard_discount_id INT NOT NULL, INDEX IDX_84D719D953C674EE (offer_id), INDEX IDX_84D719D97EAA7D27 (standard_discount_id), PRIMARY KEY(offer_id, standard_discount_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE standard_discounts (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, value NUMERIC(10, 2) NOT NULL, percentage TINYINT(1) DEFAULT NULL, minus TINYINT(1) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_57041CB0A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE invoice_standard_discounts ADD CONSTRAINT FK_A1BE84202989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('ALTER TABLE invoice_standard_discounts ADD CONSTRAINT FK_A1BE84207EAA7D27 FOREIGN KEY (standard_discount_id) REFERENCES standard_discounts (id)');
        $this->addSql('ALTER TABLE offer_standard_discounts ADD CONSTRAINT FK_84D719D953C674EE FOREIGN KEY (offer_id) REFERENCES offers (id)');
        $this->addSql('ALTER TABLE offer_standard_discounts ADD CONSTRAINT FK_84D719D97EAA7D27 FOREIGN KEY (standard_discount_id) REFERENCES standard_discounts (id)');
        $this->addSql('ALTER TABLE standard_discounts ADD CONSTRAINT FK_57041CB0A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
    }
}
