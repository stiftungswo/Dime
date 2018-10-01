<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20181001150708 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE new_customer_tags (customer_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_60ADD2BA9395C3F3 (customer_id), INDEX IDX_60ADD2BABAD26311 (tag_id), PRIMARY KEY(customer_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE new_customer_tags ADD CONSTRAINT FK_60ADD2BA9395C3F3 FOREIGN KEY (customer_id) REFERENCES Customer (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE new_customer_tags ADD CONSTRAINT FK_60ADD2BABAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE new_customer_tags');
    }
}
