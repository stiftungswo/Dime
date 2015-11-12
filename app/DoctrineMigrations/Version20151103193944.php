<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20151103193944 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE timeslices DROP FOREIGN KEY FK_72C53BF4A76ED395');
        $this->addSql('ALTER TABLE timeslices CHANGE user_id employee_id INT');
        $this->addSql('ALTER TABLE timeslices ADD CONSTRAINT FK_timeslices_employee FOREIGN KEY (employee_id) REFERENCES users (id) ON DELETE SET NULL');

        $this->addSql('ALTER TABLE timeslices ADD COLUMN user_id INT');
        $this->addSql('ALTER TABLE timeslices ADD CONSTRAINT FK_timeslices_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE timeslices DROP FOREIGN KEY FK_timeslices_user');
        $this->addSql('ALTER TABLE timeslices DROP COLUMN user_id');

        $this->addSql('ALTER TABLE timeslices DROP FOREIGN KEY FK_timeslices_employee');
        $this->addSql('ALTER TABLE timeslices CHANGE employee_id user_id INT');
        $this->addSql('ALTER TABLE timeslices ADD CONSTRAINT FK_72C53BF4A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
    }
}
