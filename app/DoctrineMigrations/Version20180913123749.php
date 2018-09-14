<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180913123749 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE person (id INT AUTO_INCREMENT NOT NULL, address_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, company_id INT DEFAULT NULL, phones_id INT DEFAULT NULL, user_id INT DEFAULT NULL, systemCustomer TINYINT(1) NOT NULL, comment LONGTEXT DEFAULT NULL, email VARCHAR(60) DEFAULT NULL, alias VARCHAR(30) NOT NULL, salutation VARCHAR(60) DEFAULT NULL, first_name VARCHAR(60) NOT NULL, last_name VARCHAR(60) NOT NULL, full_name VARCHAR(60) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_34DCD176F5B7AF75 (address_id), INDEX IDX_34DCD1762983C9E6 (rate_group_id), INDEX IDX_34DCD176979B1AD6 (company_id), INDEX IDX_34DCD176EBFCD53E (phones_id), INDEX IDX_34DCD176A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE company (id INT AUTO_INCREMENT NOT NULL, address_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, user_id INT DEFAULT NULL, systemCustomer TINYINT(1) NOT NULL, comment LONGTEXT DEFAULT NULL, email VARCHAR(60) DEFAULT NULL, alias VARCHAR(30) NOT NULL, name VARCHAR(255) NOT NULL, department VARCHAR(60) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_4FBF094FF5B7AF75 (address_id), INDEX IDX_4FBF094F2983C9E6 (rate_group_id), INDEX IDX_4FBF094FA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176F5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD1762983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176979B1AD6 FOREIGN KEY (company_id) REFERENCES company (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176EBFCD53E FOREIGN KEY (phones_id) REFERENCES phone (id)');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE company ADD CONSTRAINT FK_4FBF094FF5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE company ADD CONSTRAINT FK_4FBF094F2983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE company ADD CONSTRAINT FK_4FBF094FA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE phone ADD company_id INT DEFAULT NULL, ADD user_id INT DEFAULT NULL, ADD phone_number VARCHAR(255) NOT NULL, ADD created_at DATETIME NOT NULL, ADD updated_at DATETIME NOT NULL, DROP number');
        $this->addSql('ALTER TABLE phone ADD CONSTRAINT FK_444F97DD979B1AD6 FOREIGN KEY (company_id) REFERENCES company (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE phone ADD CONSTRAINT FK_444F97DDA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('CREATE INDEX IDX_444F97DD979B1AD6 ON phone (company_id)');
        $this->addSql('CREATE INDEX IDX_444F97DDA76ED395 ON phone (user_id)');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE person DROP FOREIGN KEY FK_34DCD176979B1AD6');
        $this->addSql('ALTER TABLE phone DROP FOREIGN KEY FK_444F97DD979B1AD6');
        $this->addSql('DROP TABLE person');
        $this->addSql('DROP TABLE company');
        $this->addSql('ALTER TABLE phone DROP FOREIGN KEY FK_444F97DDA76ED395');
        $this->addSql('DROP INDEX IDX_444F97DD979B1AD6 ON phone');
        $this->addSql('DROP INDEX IDX_444F97DDA76ED395 ON phone');
        $this->addSql('ALTER TABLE phone ADD number VARCHAR(35) NOT NULL COLLATE utf8_unicode_ci COMMENT \'(DC2Type:phone_number)\', DROP company_id, DROP user_id, DROP phone_number, DROP created_at, DROP updated_at');
    }
}
