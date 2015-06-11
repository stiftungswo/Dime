<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20150611154518 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('UPDATE rates set rate_unit_type=\'a\' WHERE rate_unit_type=\'0\';');
	    $this->addSql('UPDATE offer_positions set rate_unit_type=\'a\' WHERE rate_unit_type=\'0\';');
	    $this->addSql('UPDATE activities set rate_unit_type=\'a\' WHERE rate_unit_type=\'0\';');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

	    $this->addSql('UPDATE rates set rate_unit_type=\'0\' WHERE rate_unit_type=\'a\';');
	    $this->addSql('UPDATE offer_positions set rate_unit_type=\'0\' WHERE rate_unit_type=\'a\';');
	    $this->addSql('UPDATE activities set rate_unit_type=\'0\' WHERE rate_unit_type=\'a\';');
    }
}
