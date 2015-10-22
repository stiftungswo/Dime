<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20151014161611 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE project_categories(id INT(6) AUTO_INCREMENT PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');

        $this->addSql('INSERT INTO project_categories VALUES (1,"Artenschutz", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (2,"Beweidung", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (3,"Biotopvernetzung", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (4,"Gewässer-Neuschaffung und -Pflege", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (5,"Hecken.- und Waldrandpflege", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (6,"Fliessgewässerrenaturierung", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (7,"Korb- und Kopfweiden", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (8,"Obstgarten", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (9,"Trockenwiesenpfl.", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (10,"Infrastruktur", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (11,"Feuchtwiesenpflege", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (12,"Altlastensanierung", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (13,"keine", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (66,"Konzeptentwicklung", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (67,"Umweltbidung", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (68,"Pionierstandort", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (69,"Lichter Wald", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (70,"Trockenmauern", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (71,"Unterer Greifensee", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (72,"Neophyten", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (73,"Naturgarten", NOW(), NOW())');
        $this->addSql('INSERT INTO project_categories VALUES (74,"Steinriegel", NOW(), NOW())');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('Drop TABLE project_categories ');
    }
}
