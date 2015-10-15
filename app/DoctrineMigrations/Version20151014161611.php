<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20151014161611 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE area_of_activity (id INT(255) NOT NULL, areaOfActivity VARCHAR(255) DEFAULT NULL,created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_71C44DB0A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE rateunittypes ADD CONSTRAINT FK_71C44DB0A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');

        $this->addSql('INSERT INTO rateunittypes(id, user_id, name, doTransform, factor, scale, roundMode, created_at, updated_at) VALUES("h", 1, "Stunden", TRUE, 3600, 2, 1, NOW(), NOW())');
        $this->addSql('INSERT INTO rateunittypes(id, user_id, name, doTransform, factor, scale, roundMode, symbol, created_at, updated_at) VALUES("t", 1, "Tage", TRUE, 30240, 2, 1, "d", NOW(), NOW())');
        $this->addSql('INSERT INTO rateunittypes(id, user_id, name, doTransform, factor, scale, roundMode, created_at, updated_at) VALUES("m", 1, "Minuten", TRUE, 60, 2, 1, NOW(), NOW())');
        $this->addSql('INSERT INTO rateunittypes(id, user_id, name, doTransform, factor, scale, roundMode, created_at, updated_at) VALUES("a", 1, "Anderes", FALSE, 1, 3, 1, NOW(), NOW())');

        $this->addSql('ALTER TABLE offer_positions CHANGE rate_unit_type rateUnitType_id VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offer_positions ADD CONSTRAINT FK_755A98B82BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id)');
        $this->addSql('CREATE INDEX IDX_755A98B82BE78CCE ON offer_positions (rateUnitType_id)');

        $this->addSql('ALTER TABLE activities CHANGE rate_unit_type rateUnitType_id VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE activities ADD CONSTRAINT FK_B5F1AFE52BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id)');
        $this->addSql('CREATE INDEX IDX_B5F1AFE52BE78CCE ON activities (rateUnitType_id)');

        $this->addSql('ALTER TABLE rates CHANGE rate_unit_type rateUnitType_id VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE rates ADD CONSTRAINT FK_44D4AB3C2BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id)');
        $this->addSql('CREATE INDEX IDX_44D4AB3C2BE78CCE ON rates (rateUnitType_id)');
        $this->addSql("UPDATE invoice_items SET amount=concat('',amount * 1) WHERE concat('',amount * 1) != amount");

    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs

    }
}
