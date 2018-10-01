<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20181001115727 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE persons ADD rate_group_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D32983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_A25CC7D32983C9E6 ON persons (rate_group_id)');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE persons DROP FOREIGN KEY FK_A25CC7D32983C9E6');
        $this->addSql('DROP INDEX IDX_A25CC7D32983C9E6 ON persons');
        $this->addSql('ALTER TABLE persons DROP rate_group_id');
    }
}
