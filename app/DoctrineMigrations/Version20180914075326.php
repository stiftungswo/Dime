<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20180914075326 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE company DROP FOREIGN KEY FK_4FBF094FF5B7AF75');
        $this->addSql('ALTER TABLE customers DROP FOREIGN KEY FK_62534E21F5B7AF75');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA460427F5B7AF75');
        $this->addSql('ALTER TABLE person DROP FOREIGN KEY FK_34DCD176F5B7AF75');
        $this->addSql('ALTER TABLE person DROP FOREIGN KEY FK_34DCD176979B1AD6');
        $this->addSql('ALTER TABLE phone DROP FOREIGN KEY FK_444F97DD979B1AD6');
        $this->addSql('ALTER TABLE customer_phones DROP FOREIGN KEY FK_52EDF2A43B7323CB');
        $this->addSql('ALTER TABLE person DROP FOREIGN KEY FK_34DCD176EBFCD53E');
        $this->addSql('CREATE TABLE addresses (id INT AUTO_INCREMENT NOT NULL, street VARCHAR(255) DEFAULT NULL, supplement VARCHAR(255) DEFAULT NULL, city VARCHAR(255) DEFAULT NULL, plz INT DEFAULT NULL, country VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE persons (id INT AUTO_INCREMENT NOT NULL, address_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, company_id INT DEFAULT NULL, phones_id INT DEFAULT NULL, user_id INT DEFAULT NULL, systemCustomer TINYINT(1) NOT NULL, comment LONGTEXT DEFAULT NULL, email VARCHAR(60) DEFAULT NULL, alias VARCHAR(30) NOT NULL, salutation VARCHAR(60) DEFAULT NULL, first_name VARCHAR(60) NOT NULL, last_name VARCHAR(60) NOT NULL, full_name VARCHAR(60) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_A25CC7D3F5B7AF75 (address_id), INDEX IDX_A25CC7D32983C9E6 (rate_group_id), INDEX IDX_A25CC7D3979B1AD6 (company_id), INDEX IDX_A25CC7D3EBFCD53E (phones_id), INDEX IDX_A25CC7D3A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE companies (id INT AUTO_INCREMENT NOT NULL, address_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, user_id INT DEFAULT NULL, systemCustomer TINYINT(1) NOT NULL, comment LONGTEXT DEFAULT NULL, email VARCHAR(60) DEFAULT NULL, alias VARCHAR(30) NOT NULL, name VARCHAR(255) NOT NULL, department VARCHAR(60) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_8244AA3AF5B7AF75 (address_id), INDEX IDX_8244AA3A2983C9E6 (rate_group_id), INDEX IDX_8244AA3AA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE phones (id INT AUTO_INCREMENT NOT NULL, company_id INT DEFAULT NULL, user_id INT DEFAULT NULL, phone_number VARCHAR(255) NOT NULL, type VARCHAR(255) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_E3282EF5979B1AD6 (company_id), INDEX IDX_E3282EF5A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D3F5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D32983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D3979B1AD6 FOREIGN KEY (company_id) REFERENCES companies (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D3EBFCD53E FOREIGN KEY (phones_id) REFERENCES phones (id)');
        $this->addSql('ALTER TABLE persons ADD CONSTRAINT FK_A25CC7D3A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE companies ADD CONSTRAINT FK_8244AA3AF5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE companies ADD CONSTRAINT FK_8244AA3A2983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE companies ADD CONSTRAINT FK_8244AA3AA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE phones ADD CONSTRAINT FK_E3282EF5979B1AD6 FOREIGN KEY (company_id) REFERENCES companies (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE phones ADD CONSTRAINT FK_E3282EF5A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('DROP TABLE address');
        $this->addSql('DROP TABLE company');
        $this->addSql('DROP TABLE person');
        $this->addSql('DROP TABLE phone');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA460427F5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id)');
        $this->addSql('ALTER TABLE customers ADD CONSTRAINT FK_62534E21F5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id)');
        $this->addSql('ALTER TABLE customer_phones ADD CONSTRAINT FK_52EDF2A43B7323CB FOREIGN KEY (phone_id) REFERENCES phones (id)');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA460427F5B7AF75');
        $this->addSql('ALTER TABLE customers DROP FOREIGN KEY FK_62534E21F5B7AF75');
        $this->addSql('ALTER TABLE persons DROP FOREIGN KEY FK_A25CC7D3F5B7AF75');
        $this->addSql('ALTER TABLE companies DROP FOREIGN KEY FK_8244AA3AF5B7AF75');
        $this->addSql('ALTER TABLE persons DROP FOREIGN KEY FK_A25CC7D3979B1AD6');
        $this->addSql('ALTER TABLE phones DROP FOREIGN KEY FK_E3282EF5979B1AD6');
        $this->addSql('ALTER TABLE customer_phones DROP FOREIGN KEY FK_52EDF2A43B7323CB');
        $this->addSql('ALTER TABLE persons DROP FOREIGN KEY FK_A25CC7D3EBFCD53E');
        $this->addSql('CREATE TABLE address (id INT AUTO_INCREMENT NOT NULL, street VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, supplement VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, city VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, plz INT DEFAULT NULL, country VARCHAR(255) DEFAULT NULL COLLATE utf8_unicode_ci, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE company (id INT AUTO_INCREMENT NOT NULL, address_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, user_id INT DEFAULT NULL, systemCustomer TINYINT(1) NOT NULL, comment LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, email VARCHAR(60) DEFAULT NULL COLLATE utf8_unicode_ci, alias VARCHAR(30) NOT NULL COLLATE utf8_unicode_ci, name VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, department VARCHAR(60) DEFAULT NULL COLLATE utf8_unicode_ci, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_4FBF094FF5B7AF75 (address_id), INDEX IDX_4FBF094F2983C9E6 (rate_group_id), INDEX IDX_4FBF094FA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE person (id INT AUTO_INCREMENT NOT NULL, address_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, company_id INT DEFAULT NULL, phones_id INT DEFAULT NULL, user_id INT DEFAULT NULL, systemCustomer TINYINT(1) NOT NULL, comment LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, email VARCHAR(60) DEFAULT NULL COLLATE utf8_unicode_ci, alias VARCHAR(30) NOT NULL COLLATE utf8_unicode_ci, salutation VARCHAR(60) DEFAULT NULL COLLATE utf8_unicode_ci, first_name VARCHAR(60) NOT NULL COLLATE utf8_unicode_ci, last_name VARCHAR(60) NOT NULL COLLATE utf8_unicode_ci, full_name VARCHAR(60) NOT NULL COLLATE utf8_unicode_ci, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_34DCD176F5B7AF75 (address_id), INDEX IDX_34DCD1762983C9E6 (rate_group_id), INDEX IDX_34DCD176979B1AD6 (company_id), INDEX IDX_34DCD176EBFCD53E (phones_id), INDEX IDX_34DCD176A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE phone (id INT AUTO_INCREMENT NOT NULL, company_id INT DEFAULT NULL, user_id INT DEFAULT NULL, phone_number VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, type VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_444F97DD979B1AD6 (company_id), INDEX IDX_444F97DDA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE company ADD CONSTRAINT FK_4FBF094F2983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE company ADD CONSTRAINT FK_4FBF094FA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE company ADD CONSTRAINT FK_4FBF094FF5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD1762983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176979B1AD6 FOREIGN KEY (company_id) REFERENCES company (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176EBFCD53E FOREIGN KEY (phones_id) REFERENCES phone (id)');
        $this->addSql('ALTER TABLE person ADD CONSTRAINT FK_34DCD176F5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE phone ADD CONSTRAINT FK_444F97DD979B1AD6 FOREIGN KEY (company_id) REFERENCES company (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE phone ADD CONSTRAINT FK_444F97DDA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('DROP TABLE addresses');
        $this->addSql('DROP TABLE persons');
        $this->addSql('DROP TABLE companies');
        $this->addSql('DROP TABLE phones');
        $this->addSql('ALTER TABLE customer_phones ADD CONSTRAINT FK_52EDF2A43B7323CB FOREIGN KEY (phone_id) REFERENCES phone (id)');
        $this->addSql('ALTER TABLE customers ADD CONSTRAINT FK_62534E21F5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id)');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA460427F5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id)');
    }
}
