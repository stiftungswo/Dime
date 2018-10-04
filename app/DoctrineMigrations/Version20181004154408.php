<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20181004154408 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE addresses (id INT AUTO_INCREMENT NOT NULL, customer_id INT DEFAULT NULL, user_id INT DEFAULT NULL, street VARCHAR(255) DEFAULT NULL, supplement VARCHAR(255) DEFAULT NULL, city VARCHAR(255) NOT NULL, postcode INT NOT NULL, country VARCHAR(255) DEFAULT NULL, description VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_6FCA75169395C3F3 (customer_id), INDEX IDX_6FCA7516A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE Customer (id INT AUTO_INCREMENT NOT NULL, rate_group_id INT DEFAULT NULL, user_id INT DEFAULT NULL, company_id INT DEFAULT NULL, comment LONGTEXT DEFAULT NULL, email LONGTEXT DEFAULT NULL, chargeable TINYINT(1) DEFAULT NULL, hide_for_business TINYINT(1) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, discr VARCHAR(255) NOT NULL, salutation VARCHAR(60) DEFAULT NULL, first_name VARCHAR(60) DEFAULT NULL, last_name VARCHAR(60) DEFAULT NULL, department VARCHAR(255) DEFAULT NULL, name VARCHAR(255) DEFAULT NULL, INDEX IDX_784FEC5F2983C9E6 (rate_group_id), INDEX IDX_784FEC5FA76ED395 (user_id), INDEX IDX_784FEC5F979B1AD6 (company_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE new_customer_tags (customer_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_60ADD2BA9395C3F3 (customer_id), INDEX IDX_60ADD2BABAD26311 (tag_id), PRIMARY KEY(customer_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE phones (id INT AUTO_INCREMENT NOT NULL, customer_id INT DEFAULT NULL, user_id INT DEFAULT NULL, number VARCHAR(255) NOT NULL, category INT NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_E3282EF59395C3F3 (customer_id), INDEX IDX_E3282EF5A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE addresses ADD CONSTRAINT FK_6FCA75169395C3F3 FOREIGN KEY (customer_id) REFERENCES Customer (id)');
        $this->addSql('ALTER TABLE addresses ADD CONSTRAINT FK_6FCA7516A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE Customer ADD CONSTRAINT FK_784FEC5F2983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE Customer ADD CONSTRAINT FK_784FEC5FA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE Customer ADD CONSTRAINT FK_784FEC5F979B1AD6 FOREIGN KEY (company_id) REFERENCES Customer (id)');
        $this->addSql('ALTER TABLE new_customer_tags ADD CONSTRAINT FK_60ADD2BA9395C3F3 FOREIGN KEY (customer_id) REFERENCES Customer (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE new_customer_tags ADD CONSTRAINT FK_60ADD2BABAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE phones ADD CONSTRAINT FK_E3282EF59395C3F3 FOREIGN KEY (customer_id) REFERENCES Customer (id)');
        $this->addSql('ALTER TABLE phones ADD CONSTRAINT FK_E3282EF5A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE addresses DROP FOREIGN KEY FK_6FCA75169395C3F3');
        $this->addSql('ALTER TABLE Customer DROP FOREIGN KEY FK_784FEC5F979B1AD6');
        $this->addSql('ALTER TABLE new_customer_tags DROP FOREIGN KEY FK_60ADD2BA9395C3F3');
        $this->addSql('ALTER TABLE phones DROP FOREIGN KEY FK_E3282EF59395C3F3');
        $this->addSql('DROP TABLE addresses');
        $this->addSql('DROP TABLE Customer');
        $this->addSql('DROP TABLE new_customer_tags');
        $this->addSql('DROP TABLE phones');
    }
}
