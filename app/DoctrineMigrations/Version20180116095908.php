<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;


class Version20180116095908 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql("
            CREATE TABLE `project_comments` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `project_id` int(11) NOT NULL,
              `user_id` int(11) DEFAULT NULL,
              `comment` longtext COLLATE utf8_unicode_ci NOT NULL,
              `date` datetime NOT NULL,
              `created_at` datetime NOT NULL,
              `updated_at` datetime NOT NULL,
              `deleted_at` datetime DEFAULT NULL,
              PRIMARY KEY (`id`),
              KEY `IDX_62D01DF1166D1F9C` (`project_id`),
              KEY `IDX_62D01DF1A76ED395` (`user_id`),
              CONSTRAINT `FK_62D01DF1166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
              CONSTRAINT `FK_62D01DF1A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
            ) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
        ");

    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql("DROP TABLE `project_comments`;");
    }
}
