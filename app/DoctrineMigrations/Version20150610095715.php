<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20150610095715 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE holidays (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, date DATE DEFAULT NULL, duration INT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_3A66A10CA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE holidays ADD CONSTRAINT FK_3A66A10CA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('DROP TABLE FreePeriods');
        $this->addSql('ALTER TABLE WorkingPeriods ADD holidays INT DEFAULT NULL, ADD realTime INT DEFAULT NULL, CHANGE start start DATE DEFAULT NULL, CHANGE end end DATE DEFAULT NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE FreePeriods (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, employee_id INT DEFAULT NULL, start DATE NOT NULL, end DATE NOT NULL, pensum NUMERIC(10, 2) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_1CFF23918C03F15C (employee_id), INDEX IDX_1CFF2391A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE FreePeriods ADD CONSTRAINT FK_1CFF2391A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE FreePeriods ADD CONSTRAINT FK_1CFF23918C03F15C FOREIGN KEY (employee_id) REFERENCES users (id)');
        $this->addSql('DROP TABLE holidays');
        $this->addSql('ALTER TABLE WorkingPeriods DROP holidays, DROP realTime, CHANGE start start DATE NOT NULL, CHANGE end end DATE NOT NULL');
    }
}
