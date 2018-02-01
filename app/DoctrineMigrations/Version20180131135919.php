<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180131135919 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\'');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\'');
        $this->addSql('ALTER TABLE invoice_items CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\'');
        $this->addSql('ALTER TABLE invoice_costgroups DROP FOREIGN KEY fk_invoice_costgroups_costgroup_id');
        $this->addSql('ALTER TABLE invoice_costgroups DROP FOREIGN KEY fk_invoice_costgroups_invoice_id');
        $this->addSql('ALTER TABLE invoice_costgroups DROP FOREIGN KEY fk_invoice_costgroups_user_id');
        $this->addSql('ALTER TABLE invoice_costgroups CHANGE invoice_id invoice_id INT DEFAULT NULL, CHANGE created_at created_at DATETIME NOT NULL, CHANGE updated_at updated_at DATETIME NOT NULL');
        $this->addSql('DROP INDEX fk_invoice_costgroups_invoice_id ON invoice_costgroups');
        $this->addSql('CREATE INDEX IDX_D80B13762989F1FD ON invoice_costgroups (invoice_id)');
        $this->addSql('DROP INDEX fk_invoice_costgroups_costgroup_id ON invoice_costgroups');
        $this->addSql('CREATE INDEX IDX_D80B1376CC72B005 ON invoice_costgroups (costgroup_id)');
        // generated but not needed $this->addSql('DROP INDEX fk_invoice_costgroups_user_id ON invoice_costgroups');
        $this->addSql('CREATE INDEX IDX_D80B1376A76ED395 ON invoice_costgroups (user_id)');
        $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT FK_D80B13762989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT FK_D80B1376A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT FK_D80B1376CC72B005 FOREIGN KEY (costgroup_id) REFERENCES costgroups (id)');
        // generated but not needed $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT fk_invoice_costgroups_user_id FOREIGN KEY (user_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F95CC72B005');
        $this->addSql('DROP INDEX IDX_6A2F2F95CC72B005 ON invoices');
        $this->addSql('ALTER TABLE invoices DROP costgroup_id, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\'');
        $this->addSql('ALTER TABLE users DROP locked, DROP expired, DROP expires_at, DROP credentials_expired, DROP credentials_expire_at');
        $this->addSql('ALTER TABLE activities CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\'');
        $this->addSql('ALTER TABLE rates CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\'');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\', CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COMMENT \'(DC2Type:money)\', CHANGE archived archived TINYINT(1) NOT NULL');
        /*mine*/$this->addSql('ALTER TABLE invoice_costgroups CHARACTER SET utf8, COLLATE utf8_unicode_ci;');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE activities CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE invoice_costgroups DROP FOREIGN KEY FK_D80B1376A76ED395');
        $this->addSql('ALTER TABLE invoice_costgroups DROP FOREIGN KEY FK_D80B13762989F1FD');
        $this->addSql('ALTER TABLE invoice_costgroups DROP FOREIGN KEY FK_D80B1376CC72B005');
        $this->addSql('ALTER TABLE invoice_costgroups CHANGE invoice_id invoice_id INT NOT NULL, CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP, CHANGE updated_at updated_at DATETIME DEFAULT NULL');
        $this->addSql('DROP INDEX IDX_D80B13762989F1FD ON invoice_costgroups');
        $this->addSql('CREATE INDEX fk_invoice_costgroups_invoice_id ON invoice_costgroups (invoice_id)');
        $this->addSql('DROP INDEX IDX_D80B1376CC72B005 ON invoice_costgroups');
        $this->addSql('CREATE INDEX fk_invoice_costgroups_costgroup_id ON invoice_costgroups (costgroup_id)');
        $this->addSql('DROP INDEX IDX_D80B1376A76ED395 ON invoice_costgroups');
        $this->addSql('CREATE INDEX fk_invoice_costgroups_user_id ON invoice_costgroups (user_id)');
        $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT fk_invoice_costgroups_user_id FOREIGN KEY (user_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT FK_D80B13762989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT FK_D80B1376CC72B005 FOREIGN KEY (costgroup_id) REFERENCES costgroups (id)');
        $this->addSql('ALTER TABLE invoice_costgroups ADD CONSTRAINT FK_D80B1376A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoice_items CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE invoices ADD costgroup_id INT DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F95CC72B005 FOREIGN KEY (costgroup_id) REFERENCES costgroups (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_6A2F2F95CC72B005 ON invoices (costgroup_id)');
        $this->addSql('ALTER TABLE offer_positions CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE offers CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE projects CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, CHANGE archived archived TINYINT(1) DEFAULT \'0\' NOT NULL');
        $this->addSql('ALTER TABLE rates CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE users ADD locked TINYINT(1) NOT NULL, ADD expired TINYINT(1) NOT NULL, ADD expires_at DATETIME DEFAULT NULL, ADD credentials_expired TINYINT(1) NOT NULL, ADD credentials_expire_at DATETIME DEFAULT NULL');
        /*mine*/$this->addSql('ALTER TABLE invoice_costgroups CHARACTER SET latin1;');
    }
}
