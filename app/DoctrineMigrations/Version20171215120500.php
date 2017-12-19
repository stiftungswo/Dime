<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

class Version20171215120500 extends AbstractMigration
{
    /**
	 * @param Schema $schema
	 */
	public function up(Schema $schema)
    {
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql("
            create table invoice_costgroups(
              id int primary key auto_increment,
              invoice_id int not null,
              costgroup_id int default null,
              user_id int,
              weight float,
              created_at datetime default now(),
              updated_at datetime default null
              );
            alter table invoice_costgroups add CONSTRAINT fk_invoice_costgroups_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices (id);
            alter table invoice_costgroups add CONSTRAINT fk_invoice_costgroups_costgroup_id FOREIGN KEY (costgroup_id) REFERENCES costgroups (id);
            alter table invoice_costgroups add CONSTRAINT fk_invoice_costgroups_user_id FOREIGN KEY (user_id) REFERENCES users (id);
        ");
	}

	/**
	 * @param Schema $schema
	 */
	public function down(Schema $schema)
	{
		$this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');
	}
}
