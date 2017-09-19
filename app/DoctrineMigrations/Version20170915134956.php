<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20170915134956 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->addSql('CREATE TABLE costgroups (id int(11) NOT NULL, user_id int(11) DEFAULT NULL, created_at datetime NOT NULL, updated_at datetime NOT NULL, number int(11) NOT NULL, description varchar(255) COLLATE utf8_unicode_ci NOT NULL, PRIMARY KEY (id), CONSTRAINT FK_CG_USER FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci');
        $this->addSql('INSERT INTO costgroups VALUES (1, NULL, "2017-09-15", "2017-09-15", 100, "100 name"),(2, NULL, "2017-09-15", "2017-09-15", 200, "200 name"),(3, NULL, "2017-09-15", "2017-09-15", 300, "300 name"),(4, NULL, "2017-09-15", "2017-09-15", 400, "400 name"),(5, NULL, "2017-09-15", "2017-09-15", 500, "500 name"),(6, NULL, "2017-09-15", "2017-09-15", 600, "600 name")');
        $this->addSql('ALTER TABLE invoices ADD costgroup_id int(11) DEFAULT NULL AFTER accountant_id');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_INVOICE_COSTGROUPS FOREIGN KEY (costgroup_id) REFERENCES costgroups(id) ON DELETE SET NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_INVOICE_COSTGROUPS');
        $this->addSql('ALTER TABLE costgroups DROP FOREIGN KEY FK_CG_USER');
        $this->addSql('ALTER TABLE invoices DROP COLUMN costgroup_id');
        $this->addSql('DROP TABLE IF EXISTS costgroups');
    }
}
