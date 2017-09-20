<?php

namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20170920115249 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE address CHANGE street street VARCHAR(255) DEFAULT NULL, CHANGE streetnumber streetnumber VARCHAR(255) DEFAULT NULL, CHANGE city city VARCHAR(255) DEFAULT NULL, CHANGE plz plz INT DEFAULT NULL, CHANGE state state VARCHAR(255) DEFAULT NULL, CHANGE country country VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offer_discounts CHANGE offer_id offer_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE value value NUMERIC(10, 2) DEFAULT NULL, CHANGE percentage percentage TINYINT(1) DEFAULT NULL, CHANGE minus minus TINYINT(1) DEFAULT NULL');
        $this->addSql('ALTER TABLE offers CHANGE project_id project_id INT DEFAULT NULL, CHANGE status_id status_id INT DEFAULT NULL, CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE customer_id customer_id INT DEFAULT NULL, CHANGE accountant_id accountant_id INT DEFAULT NULL, CHANGE address_id address_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT NULL, CHANGE valid_to valid_to DATE DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offer_positions CHANGE service_id service_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE order_no order_no INT DEFAULT NULL, CHANGE amount amount NUMERIC(10, 2) DEFAULT NULL, CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE vat vat NUMERIC(10, 3) DEFAULT NULL, CHANGE chargeable chargeable TINYINT(1) DEFAULT NULL, CHANGE rateUnitType_id rateUnitType_id VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE offer_status_uc CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE invoiceDiscounts CHANGE invoice_id invoice_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE value value NUMERIC(10, 2) DEFAULT NULL, CHANGE percentage percentage TINYINT(1) DEFAULT NULL, CHANGE minus minus TINYINT(1) DEFAULT NULL');
        $this->addSql('ALTER TABLE costgroups DROP FOREIGN KEY FK_CG_USER');
        $this->addSql('ALTER TABLE costgroups CHANGE user_id user_id INT DEFAULT NULL, CHANGE number number INT DEFAULT NULL, CHANGE description description VARCHAR(255) DEFAULT NULL');
        $this->addSql('DROP INDEX fk_cg_user ON costgroups');
        $this->addSql('CREATE INDEX IDX_21D763E8A76ED395 ON costgroups (user_id)');
        $this->addSql('ALTER TABLE costgroups ADD CONSTRAINT FK_CG_USER FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_INVOICE_COSTGROUPS');
        $this->addSql('ALTER TABLE invoices CHANGE project_id project_id INT DEFAULT NULL, CHANGE customer_id customer_id INT DEFAULT NULL, CHANGE accountant_id accountant_id INT DEFAULT NULL, CHANGE costgroup_id costgroup_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE start start DATE DEFAULT NULL, CHANGE end end DATE DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL');
        $this->addSql('DROP INDEX fk_invoice_costgroups ON invoices');
        $this->addSql('CREATE INDEX IDX_6A2F2F95CC72B005 ON invoices (costgroup_id)');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_INVOICE_COSTGROUPS FOREIGN KEY (costgroup_id) REFERENCES costgroups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoice_items CHANGE invoice_id invoice_id INT DEFAULT NULL, CHANGE activity_id activity_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE rateUnit rateUnit VARCHAR(255) DEFAULT NULL, CHANGE vat vat NUMERIC(10, 3) DEFAULT NULL, CHANGE amount amount VARCHAR(255) DEFAULT NULL, CHANGE order_no order_no NUMERIC(10, 0) DEFAULT NULL');
        $this->addSql('ALTER TABLE WorkingPeriods CHANGE employee_id employee_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE start start DATE DEFAULT NULL, CHANGE end end DATE DEFAULT NULL, CHANGE pensum pensum NUMERIC(10, 2) DEFAULT NULL, CHANGE holidays holidays INT DEFAULT NULL, CHANGE last_year_holiday_balance last_year_holiday_balance VARCHAR(255) DEFAULT NULL, CHANGE realTime realTime INT DEFAULT NULL');
        $this->addSql('ALTER TABLE holidays CHANGE user_id user_id INT DEFAULT NULL, CHANGE date date DATE DEFAULT NULL, CHANGE duration duration INT DEFAULT NULL');
        $this->addSql('ALTER TABLE users CHANGE salt salt VARCHAR(255) DEFAULT NULL, CHANGE last_login last_login DATETIME DEFAULT NULL, CHANGE confirmation_token confirmation_token VARCHAR(180) DEFAULT NULL, CHANGE password_requested_at password_requested_at DATETIME DEFAULT NULL, CHANGE firstname firstname VARCHAR(255) DEFAULT NULL, CHANGE lastname lastname VARCHAR(255) DEFAULT NULL, CHANGE employeeholiday employeeholiday INT DEFAULT NULL, CHANGE extend_timetrack extend_timetrack TINYINT(1) DEFAULT NULL');
        $this->addSql('ALTER TABLE rateunittypes CHANGE user_id user_id INT DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT NULL, CHANGE factor factor NUMERIC(10, 3) DEFAULT NULL, CHANGE symbol symbol VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE services CHANGE user_id user_id INT DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT NULL, CHANGE vat vat NUMERIC(10, 4) DEFAULT NULL, CHANGE deleted_at deleted_at DATETIME DEFAULT NULL');
        $this->addSql('ALTER TABLE activities CHANGE project_id project_id INT DEFAULT NULL, CHANGE service_id service_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE chargeable chargeable TINYINT(1) DEFAULT NULL, CHANGE vat vat NUMERIC(10, 3) DEFAULT NULL, CHANGE deleted_at deleted_at DATETIME DEFAULT NULL, CHANGE rateUnitType_id rateUnitType_id VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE standard_discounts CHANGE user_id user_id INT DEFAULT NULL, CHANGE percentage percentage TINYINT(1) DEFAULT NULL, CHANGE minus minus TINYINT(1) DEFAULT NULL');
        $this->addSql('ALTER TABLE projects CHANGE customer_id customer_id INT DEFAULT NULL, CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE project_category_id project_category_id INT DEFAULT NULL, CHANGE accountant_id accountant_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE started_at started_at DATETIME DEFAULT NULL, CHANGE stopped_at stopped_at DATETIME DEFAULT NULL, CHANGE deadline deadline DATETIME DEFAULT NULL, CHANGE budget_price budget_price VARCHAR(255) DEFAULT NULL, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT NULL, CHANGE budget_time budget_time INT DEFAULT NULL, CHANGE chargeable chargeable TINYINT(1) DEFAULT NULL, CHANGE deleted_at deleted_at DATETIME DEFAULT NULL');
        $this->addSql('ALTER TABLE rates CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE service_id service_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE rate_value rate_value VARCHAR(255) DEFAULT NULL, CHANGE rateUnitType_id rateUnitType_id VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE rate_groups CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE settings CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE tags CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE customers CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE address_id address_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE company company VARCHAR(60) DEFAULT NULL, CHANGE department department VARCHAR(60) DEFAULT NULL, CHANGE fullname fullname VARCHAR(60) DEFAULT NULL, CHANGE salutation salutation VARCHAR(60) DEFAULT NULL');
        $this->addSql('ALTER TABLE timeslices CHANGE employee_id employee_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE started_at started_at DATETIME DEFAULT NULL, CHANGE stopped_at stopped_at DATETIME DEFAULT NULL, CHANGE deleted_at deleted_at DATETIME DEFAULT NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE WorkingPeriods CHANGE employee_id employee_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE start start DATE DEFAULT \'NULL\', CHANGE end end DATE DEFAULT \'NULL\', CHANGE pensum pensum NUMERIC(10, 2) DEFAULT \'NULL\', CHANGE holidays holidays INT DEFAULT NULL, CHANGE last_year_holiday_balance last_year_holiday_balance VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE realTime realTime INT DEFAULT NULL');
        $this->addSql('ALTER TABLE activities CHANGE project_id project_id INT DEFAULT NULL, CHANGE service_id service_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE rate_value rate_value VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE chargeable chargeable TINYINT(1) DEFAULT \'NULL\', CHANGE vat vat NUMERIC(10, 3) DEFAULT \'NULL\', CHANGE deleted_at deleted_at DATETIME DEFAULT \'NULL\', CHANGE rateUnitType_id rateUnitType_id VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE address CHANGE street street VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE streetnumber streetnumber VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE city city VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE plz plz INT DEFAULT NULL, CHANGE state state VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE country country VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE costgroups DROP FOREIGN KEY FK_21D763E8A76ED395');
        $this->addSql('ALTER TABLE costgroups CHANGE user_id user_id INT DEFAULT NULL, CHANGE number number INT NOT NULL, CHANGE description description VARCHAR(255) NOT NULL COLLATE utf8_unicode_ci');
        $this->addSql('DROP INDEX idx_21d763e8a76ed395 ON costgroups');
        $this->addSql('CREATE INDEX FK_CG_USER ON costgroups (user_id)');
        $this->addSql('ALTER TABLE costgroups ADD CONSTRAINT FK_21D763E8A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE customers CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE address_id address_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE company company VARCHAR(60) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE department department VARCHAR(60) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE fullname fullname VARCHAR(60) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE salutation salutation VARCHAR(60) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE holidays CHANGE user_id user_id INT DEFAULT NULL, CHANGE date date DATE DEFAULT \'NULL\', CHANGE duration duration INT DEFAULT NULL');
        $this->addSql('ALTER TABLE invoiceDiscounts CHANGE invoice_id invoice_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE value value NUMERIC(10, 2) DEFAULT \'NULL\', CHANGE percentage percentage TINYINT(1) DEFAULT \'NULL\', CHANGE minus minus TINYINT(1) DEFAULT \'NULL\'');
        $this->addSql('ALTER TABLE invoice_items CHANGE invoice_id invoice_id INT DEFAULT NULL, CHANGE activity_id activity_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE rate_value rate_value VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE rateUnit rateUnit VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE vat vat NUMERIC(10, 3) DEFAULT \'NULL\', CHANGE amount amount VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE order_no order_no NUMERIC(10, 0) DEFAULT \'NULL\'');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F95CC72B005');
        $this->addSql('ALTER TABLE invoices CHANGE project_id project_id INT DEFAULT NULL, CHANGE customer_id customer_id INT DEFAULT NULL, CHANGE accountant_id accountant_id INT DEFAULT NULL, CHANGE costgroup_id costgroup_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE start start DATE DEFAULT \'NULL\', CHANGE end end DATE DEFAULT \'NULL\', CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('DROP INDEX idx_6a2f2f95cc72b005 ON invoices');
        $this->addSql('CREATE INDEX FK_INVOICE_COSTGROUPS ON invoices (costgroup_id)');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F95CC72B005 FOREIGN KEY (costgroup_id) REFERENCES costgroups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offer_discounts CHANGE offer_id offer_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE value value NUMERIC(10, 2) DEFAULT \'NULL\', CHANGE percentage percentage TINYINT(1) DEFAULT \'NULL\', CHANGE minus minus TINYINT(1) DEFAULT \'NULL\'');
        $this->addSql('ALTER TABLE offer_positions CHANGE service_id service_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE order_no order_no INT DEFAULT NULL, CHANGE amount amount NUMERIC(10, 2) DEFAULT \'NULL\', CHANGE rate_value rate_value VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE vat vat NUMERIC(10, 3) DEFAULT \'NULL\', CHANGE chargeable chargeable TINYINT(1) DEFAULT \'NULL\', CHANGE rateUnitType_id rateUnitType_id VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE offer_status_uc CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE offers CHANGE project_id project_id INT DEFAULT NULL, CHANGE status_id status_id INT DEFAULT NULL, CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE customer_id customer_id INT DEFAULT NULL, CHANGE accountant_id accountant_id INT DEFAULT NULL, CHANGE address_id address_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE valid_to valid_to DATE DEFAULT \'NULL\', CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE projects CHANGE customer_id customer_id INT DEFAULT NULL, CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE project_category_id project_category_id INT DEFAULT NULL, CHANGE accountant_id accountant_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE started_at started_at DATETIME DEFAULT \'NULL\', CHANGE stopped_at stopped_at DATETIME DEFAULT \'NULL\', CHANGE deadline deadline DATETIME DEFAULT \'NULL\', CHANGE budget_price budget_price VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE fixed_price fixed_price VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE budget_time budget_time INT DEFAULT NULL, CHANGE chargeable chargeable TINYINT(1) DEFAULT \'NULL\', CHANGE deleted_at deleted_at DATETIME DEFAULT \'NULL\'');
        $this->addSql('ALTER TABLE rate_groups CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE rates CHANGE rate_group_id rate_group_id INT DEFAULT NULL, CHANGE service_id service_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE rate_value rate_value VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE rateUnitType_id rateUnitType_id VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE rateunittypes CHANGE user_id user_id INT DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE factor factor NUMERIC(10, 3) DEFAULT \'NULL\', CHANGE symbol symbol VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci');
        $this->addSql('ALTER TABLE services CHANGE user_id user_id INT DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE vat vat NUMERIC(10, 4) DEFAULT \'NULL\', CHANGE deleted_at deleted_at DATETIME DEFAULT \'NULL\'');
        $this->addSql('ALTER TABLE settings CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE standard_discounts CHANGE user_id user_id INT DEFAULT NULL, CHANGE percentage percentage TINYINT(1) DEFAULT \'NULL\', CHANGE minus minus TINYINT(1) DEFAULT \'NULL\'');
        $this->addSql('ALTER TABLE tags CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE timeslices CHANGE employee_id employee_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL, CHANGE started_at started_at DATETIME DEFAULT \'NULL\', CHANGE stopped_at stopped_at DATETIME DEFAULT \'NULL\', CHANGE deleted_at deleted_at DATETIME DEFAULT \'NULL\'');
        $this->addSql('ALTER TABLE users CHANGE salt salt VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE last_login last_login DATETIME DEFAULT \'NULL\', CHANGE confirmation_token confirmation_token VARCHAR(180) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE password_requested_at password_requested_at DATETIME DEFAULT \'NULL\', CHANGE firstname firstname VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE lastname lastname VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8_unicode_ci, CHANGE employeeholiday employeeholiday INT DEFAULT NULL, CHANGE extend_timetrack extend_timetrack TINYINT(1) DEFAULT \'1\' NOT NULL');
    }
}
