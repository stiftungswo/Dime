<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180914081923 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE persons_phones (person_id INT NOT NULL, phone_id INT NOT NULL, INDEX IDX_965C0DE6217BBB47 (person_id), UNIQUE INDEX UNIQ_965C0DE63B7323CB (phone_id), PRIMARY KEY(person_id, phone_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE persons_phones ADD CONSTRAINT FK_965C0DE6217BBB47 FOREIGN KEY (person_id) REFERENCES persons (id)');
        $this->addSql('ALTER TABLE persons_phones ADD CONSTRAINT FK_965C0DE63B7323CB FOREIGN KEY (phone_id) REFERENCES phones (id)');
        $this->addSql('ALTER TABLE persons DROP FOREIGN KEY FK_A25CC7D3EBFCD53E');
        $this->addSql('DROP INDEX IDX_A25CC7D3EBFCD53E ON persons');
        $this->addSql('ALTER TABLE persons DROP phones_id');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE persons_phones');
        $this->addSql('ALTER TABLE persons ADD phones_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D3EBFCD53E FOREIGN KEY (phones_id) REFERENCES phones (id)');
        $this->addSql('CREATE INDEX IDX_A25CC7D3EBFCD53E ON persons (phones_id)');
    }
}
