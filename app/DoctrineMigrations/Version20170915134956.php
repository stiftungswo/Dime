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
        $this->addSql('CREATE TABLE cost_groups (id int(11) NOT NULL, user_id int(11) DEFAULT NULL, created_at datetime NOT NULL, updated_at datetime NOT NULL, name varchar(255) COLLATE utf8_unicode_ci NOT NULL, PRIMARY KEY (id), CONSTRAINT FK_CG_USER FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci');
        $this->addSql('INSERT INTO cost_groups VALUES (100, NULL, "2017-09-15", "2017-09-15", "100 name"),(200, NULL, "2017-09-15", "2017-09-15", "200 name"),(300, NULL, "2017-09-15", "2017-09-15", "300 name"),(400, NULL, "2017-09-15", "2017-09-15", "400 name"),(500, NULL, "2017-09-15", "2017-09-15", "500 name"),(600, NULL, "2017-09-15", "2017-09-15", "600 name")');

        $this->addSql('ALTER TABLE invoices ADD cost_group_id int(11) DEFAULT NULL AFTER accountant_id');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_INVOICE_COSTGROUPS FOREIGN KEY (cost_group_id) REFERENCES cost_groups(id) ON DELETE SET NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_INVOICE_COSTGROUPS');
        $this->addSql('ALTER TABLE cost_groups DROP FOREIGN KEY FK_CG_USER');
        $this->addSql('ALTER TABLE invoices DROP COLUMN cost_group_id');
        $this->addSql('DROP TABLE IF EXISTS cost_groups');
    }
}
