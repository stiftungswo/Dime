<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180928070842 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE addresses (id INT AUTO_INCREMENT NOT NULL, company_id INT DEFAULT NULL, person_id INT DEFAULT NULL, user_id INT DEFAULT NULL, street VARCHAR(255) DEFAULT NULL, supplement VARCHAR(255) DEFAULT NULL, city VARCHAR(255) NOT NULL, postcode INT NOT NULL, country VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, UNIQUE INDEX UNIQ_6FCA7516979B1AD6 (company_id), UNIQUE INDEX UNIQ_6FCA7516217BBB47 (person_id), INDEX IDX_6FCA7516A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE persons (id INT AUTO_INCREMENT NOT NULL, company_id INT DEFAULT NULL, user_id INT DEFAULT NULL, salutation VARCHAR(60) DEFAULT NULL, first_name VARCHAR(60) NOT NULL, last_name VARCHAR(60) NOT NULL, comment LONGTEXT DEFAULT NULL, email LONGTEXT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_A25CC7D3979B1AD6 (company_id), INDEX IDX_A25CC7D3A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE companies (id INT AUTO_INCREMENT NOT NULL, rate_group_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, department VARCHAR(255) DEFAULT NULL, comment LONGTEXT DEFAULT NULL, email LONGTEXT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_8244AA3A2983C9E6 (rate_group_id), INDEX IDX_8244AA3AA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE phones (id INT AUTO_INCREMENT NOT NULL, company_id INT DEFAULT NULL, person_id INT DEFAULT NULL, user_id INT DEFAULT NULL, number VARCHAR(255) NOT NULL, category INT NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_E3282EF5979B1AD6 (company_id), INDEX IDX_E3282EF5217BBB47 (person_id), INDEX IDX_E3282EF5A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE addresses ADD CONSTRAINT FK_6FCA7516979B1AD6 FOREIGN KEY (company_id) REFERENCES companies (id)');
        $this->addSql('ALTER TABLE addresses ADD CONSTRAINT FK_6FCA7516217BBB47 FOREIGN KEY (person_id) REFERENCES persons (id)');
        $this->addSql('ALTER TABLE addresses ADD CONSTRAINT FK_6FCA7516A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D3979B1AD6 FOREIGN KEY (company_id) REFERENCES companies (id)');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D3A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE companies ADD CONSTRAINT FK_8244AA3A2983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE companies ADD CONSTRAINT FK_8244AA3AA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE phones ADD CONSTRAINT FK_E3282EF5979B1AD6 FOREIGN KEY (company_id) REFERENCES companies (id)');
        $this->addSql('ALTER TABLE phones ADD CONSTRAINT FK_E3282EF5217BBB47 FOREIGN KEY (person_id) REFERENCES persons (id)');
        $this->addSql('ALTER TABLE phones ADD CONSTRAINT FK_E3282EF5A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE activities DROP FOREIGN KEY FK_B5F1AFE52BE78CCE');
        $this->addSql('ALTER TABLE activities ADD CONSTRAINT FK_B5F1AFE52BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id) ON DELETE SET NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE addresses DROP FOREIGN KEY FK_6FCA7516217BBB47');
        $this->addSql('ALTER TABLE phones DROP FOREIGN KEY FK_E3282EF5217BBB47');
        $this->addSql('ALTER TABLE addresses DROP FOREIGN KEY FK_6FCA7516979B1AD6');
        $this->addSql('ALTER TABLE persons DROP FOREIGN KEY FK_A25CC7D3979B1AD6');
        $this->addSql('ALTER TABLE phones DROP FOREIGN KEY FK_E3282EF5979B1AD6');
        $this->addSql('DROP TABLE addresses');
        $this->addSql('DROP TABLE persons');
        $this->addSql('DROP TABLE companies');
        $this->addSql('DROP TABLE phones');
        $this->addSql('ALTER TABLE activities DROP FOREIGN KEY FK_B5F1AFE52BE78CCE');
        $this->addSql('ALTER TABLE activities ADD CONSTRAINT FK_B5F1AFE52BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id)');
    }
}
