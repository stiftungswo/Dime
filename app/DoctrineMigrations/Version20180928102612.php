<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180928102612 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE addresses DROP INDEX UNIQ_6FCA7516979B1AD6, ADD INDEX IDX_6FCA7516979B1AD6 (company_id)');
        $this->addSql('ALTER TABLE addresses DROP INDEX UNIQ_6FCA7516217BBB47, ADD INDEX IDX_6FCA7516217BBB47 (person_id)');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE addresses DROP INDEX IDX_6FCA7516979B1AD6, ADD UNIQUE INDEX UNIQ_6FCA7516979B1AD6 (company_id)');
        $this->addSql('ALTER TABLE addresses DROP INDEX IDX_6FCA7516217BBB47, ADD UNIQUE INDEX UNIQ_6FCA7516217BBB47 (person_id)');
    }
}
