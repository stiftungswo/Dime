<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180320124234 extends AbstractMigration
{

    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->addSql('
UPDATE offers SET status_id = 1 WHERE status_id = 2;
UPDATE offer_status_uc SET text = "Offeriert" WHERE id = 1;
UPDATE offer_status_uc SET text = "Bestätigt" WHERE id = 2;
UPDATE offer_status_uc SET text = "Abgelehnt" WHERE id = 3;');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->addSql('
UPDATE offer_status_uc SET text = "Potential" WHERE id = 1;
UPDATE offer_status_uc SET text = "Offered" WHERE id = 2;
UPDATE offer_status_uc SET text = "Lost" WHERE id = 3;');
    }
}
