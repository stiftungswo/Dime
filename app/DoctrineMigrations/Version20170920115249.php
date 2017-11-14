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

        $this->addSql('CREATE TABLE phone (id INT AUTO_INCREMENT NOT NULL, number VARCHAR(35) NOT NULL COMMENT \'(DC2Type:phone_number)\', type VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE address (id INT AUTO_INCREMENT NOT NULL, street VARCHAR(255) DEFAULT NULL, streetnumber VARCHAR(255) DEFAULT NULL, city VARCHAR(255) DEFAULT NULL, plz INT DEFAULT NULL, state VARCHAR(255) DEFAULT NULL, country VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE offers (id INT AUTO_INCREMENT NOT NULL, project_id INT DEFAULT NULL, status_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, customer_id INT DEFAULT NULL, accountant_id INT DEFAULT NULL, address_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) DEFAULT NULL, valid_to DATE DEFAULT NULL, short_description LONGTEXT DEFAULT NULL, description LONGTEXT DEFAULT NULL, fixed_price VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_DA460427166D1F9C (project_id), INDEX IDX_DA4604276BF700BD (status_id), INDEX IDX_DA4604272983C9E6 (rate_group_id), INDEX IDX_DA4604279395C3F3 (customer_id), INDEX IDX_DA4604279582AA74 (accountant_id), INDEX IDX_DA460427F5B7AF75 (address_id), INDEX IDX_DA460427A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE offer_standard_discounts (offer_id INT NOT NULL, standard_discount_id INT NOT NULL, INDEX IDX_84D719D953C674EE (offer_id), INDEX IDX_84D719D97EAA7D27 (standard_discount_id), PRIMARY KEY(offer_id, standard_discount_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE offer_tags (offer_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_9144BA3153C674EE (offer_id), INDEX IDX_9144BA31BAD26311 (tag_id), PRIMARY KEY(offer_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE offer_positions (id INT AUTO_INCREMENT NOT NULL, offer_id INT NOT NULL, service_id INT DEFAULT NULL, user_id INT DEFAULT NULL, order_no INT DEFAULT NULL, amount NUMERIC(10, 2) DEFAULT NULL, rate_value VARCHAR(255) DEFAULT NULL, rate_unit LONGTEXT DEFAULT NULL, vat NUMERIC(10, 3) DEFAULT NULL, discountable TINYINT(1) NOT NULL, chargeable TINYINT(1) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, rateUnitType_id VARCHAR(255) DEFAULT NULL, INDEX IDX_755A98B853C674EE (offer_id), INDEX IDX_755A98B8ED5CA9E6 (service_id), INDEX IDX_755A98B82BE78CCE (rateUnitType_id), INDEX IDX_755A98B8A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE offer_discounts (id INT AUTO_INCREMENT NOT NULL, offer_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, value NUMERIC(10, 2) DEFAULT NULL, percentage TINYINT(1) DEFAULT NULL, minus TINYINT(1) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_5F927F7C53C674EE (offer_id), INDEX IDX_5F927F7CA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE offer_status_uc (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, text VARCHAR(255) NOT NULL, active TINYINT(1) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_B021B587A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE invoice_items (id INT AUTO_INCREMENT NOT NULL, invoice_id INT DEFAULT NULL, activity_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, rate_value VARCHAR(255) DEFAULT NULL, rateUnit VARCHAR(255) DEFAULT NULL, vat NUMERIC(10, 3) DEFAULT NULL, amount VARCHAR(255) DEFAULT NULL, order_no NUMERIC(10, 0) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_DCC4B9F82989F1FD (invoice_id), INDEX IDX_DCC4B9F881C06096 (activity_id), INDEX IDX_DCC4B9F8A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE costgroups (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, number INT DEFAULT NULL, description VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_21D763E8A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE invoices (id INT AUTO_INCREMENT NOT NULL, project_id INT DEFAULT NULL, customer_id INT DEFAULT NULL, accountant_id INT DEFAULT NULL, costgroup_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, alias VARCHAR(30) NOT NULL, description LONGTEXT DEFAULT NULL, start DATE DEFAULT NULL, end DATE DEFAULT NULL, fixed_price VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_6A2F2F95166D1F9C (project_id), INDEX IDX_6A2F2F959395C3F3 (customer_id), INDEX IDX_6A2F2F959582AA74 (accountant_id), INDEX IDX_6A2F2F95CC72B005 (costgroup_id), INDEX IDX_6A2F2F95A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE invoice_standard_discounts (invoice_id INT NOT NULL, standard_discount_id INT NOT NULL, INDEX IDX_A1BE84202989F1FD (invoice_id), UNIQUE INDEX UNIQ_A1BE84207EAA7D27 (standard_discount_id), PRIMARY KEY(invoice_id, standard_discount_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE invoice_tags (invoice_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_6D79F6432989F1FD (invoice_id), INDEX IDX_6D79F643BAD26311 (tag_id), PRIMARY KEY(invoice_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE invoiceDiscounts (id INT AUTO_INCREMENT NOT NULL, invoice_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, value NUMERIC(10, 2) DEFAULT NULL, percentage TINYINT(1) DEFAULT NULL, minus TINYINT(1) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_4F4E9F232989F1FD (invoice_id), INDEX IDX_4F4E9F23A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE WorkingPeriods (id INT AUTO_INCREMENT NOT NULL, employee_id INT DEFAULT NULL, user_id INT DEFAULT NULL, start DATE DEFAULT NULL, end DATE DEFAULT NULL, pensum NUMERIC(10, 2) DEFAULT NULL, holidays INT DEFAULT NULL, last_year_holiday_balance VARCHAR(255) DEFAULT NULL, realTime INT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_57C1BB888C03F15C (employee_id), INDEX IDX_57C1BB88A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE holidays (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, date DATE DEFAULT NULL, duration INT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_3A66A10CA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE users (id INT AUTO_INCREMENT NOT NULL, username VARCHAR(180) NOT NULL, username_canonical VARCHAR(180) NOT NULL, email VARCHAR(180) NOT NULL, email_canonical VARCHAR(180) NOT NULL, enabled TINYINT(1) NOT NULL, salt VARCHAR(255) DEFAULT NULL, password VARCHAR(255) NOT NULL, last_login DATETIME DEFAULT NULL, confirmation_token VARCHAR(180) DEFAULT NULL, password_requested_at DATETIME DEFAULT NULL, roles LONGTEXT NOT NULL COMMENT \'(DC2Type:array)\', firstname VARCHAR(255) DEFAULT NULL, lastname VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, employeeholiday INT DEFAULT NULL, discr VARCHAR(255) NOT NULL, extend_timetrack TINYINT(1) DEFAULT NULL, UNIQUE INDEX UNIQ_1483A5E992FC23A8 (username_canonical), UNIQUE INDEX UNIQ_1483A5E9A0D96FBF (email_canonical), UNIQUE INDEX UNIQ_1483A5E9C05FB297 (confirmation_token), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE rateunittypes (id VARCHAR(255) NOT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) DEFAULT NULL, doTransform TINYINT(1) NOT NULL, factor NUMERIC(10, 3) DEFAULT NULL, scale INT NOT NULL, roundMode INT NOT NULL, symbol VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_71C44DB0A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE rate_groups (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, description LONGTEXT DEFAULT NULL, name VARCHAR(255) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_529A081BA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE project_categories (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE customers (id INT AUTO_INCREMENT NOT NULL, rate_group_id INT DEFAULT NULL, address_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, alias VARCHAR(30) NOT NULL, company VARCHAR(60) DEFAULT NULL, department VARCHAR(60) DEFAULT NULL, fullname VARCHAR(60) DEFAULT NULL, salutation VARCHAR(60) DEFAULT NULL, chargeable TINYINT(1) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_62534E212983C9E6 (rate_group_id), INDEX IDX_62534E21F5B7AF75 (address_id), INDEX IDX_62534E21A76ED395 (user_id), UNIQUE INDEX unique_customer_alias_user (alias, user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE customer_tags (customer_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_3B2D30519395C3F3 (customer_id), INDEX IDX_3B2D3051BAD26311 (tag_id), PRIMARY KEY(customer_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE customer_phones (customer_id INT NOT NULL, phone_id INT NOT NULL, INDEX IDX_52EDF2A49395C3F3 (customer_id), UNIQUE INDEX UNIQ_52EDF2A43B7323CB (phone_id), PRIMARY KEY(customer_id, phone_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE settings (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, namespace VARCHAR(255) NOT NULL, value LONGTEXT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_E545A0C5A76ED395 (user_id), UNIQUE INDEX unique_setting_name_namespace_user (`name`, namespace, user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE rates (id INT AUTO_INCREMENT NOT NULL, rate_group_id INT DEFAULT NULL, service_id INT DEFAULT NULL, user_id INT DEFAULT NULL, rate_unit LONGTEXT DEFAULT NULL, rate_value VARCHAR(255) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, rateUnitType_id VARCHAR(255) DEFAULT NULL, INDEX IDX_44D4AB3C2983C9E6 (rate_group_id), INDEX IDX_44D4AB3C2BE78CCE (rateUnitType_id), INDEX IDX_44D4AB3CED5CA9E6 (service_id), INDEX IDX_44D4AB3CA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE standard_discounts (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, value NUMERIC(10, 2) NOT NULL, percentage TINYINT(1) DEFAULT NULL, minus TINYINT(1) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_57041CB0A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE services (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) DEFAULT NULL, alias VARCHAR(30) NOT NULL, description LONGTEXT DEFAULT NULL, chargeable TINYINT(1) NOT NULL, vat NUMERIC(10, 4) DEFAULT NULL, archived TINYINT(1) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, deleted_at DATETIME DEFAULT NULL, INDEX IDX_7332E169A76ED395 (user_id), UNIQUE INDEX unique_service_alias_user (alias, user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE service_tags (service_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_A1FF20CAED5CA9E6 (service_id), INDEX IDX_A1FF20CABAD26311 (tag_id), PRIMARY KEY(service_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE activities (id INT AUTO_INCREMENT NOT NULL, project_id INT DEFAULT NULL, service_id INT DEFAULT NULL, user_id INT DEFAULT NULL, description LONGTEXT DEFAULT NULL, rate_value VARCHAR(255) DEFAULT NULL, chargeable TINYINT(1) DEFAULT NULL, cargeable_reference SMALLINT NOT NULL, vat NUMERIC(10, 3) DEFAULT NULL, rate_unit LONGTEXT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, deleted_at DATETIME DEFAULT NULL, rateUnitType_id VARCHAR(255) DEFAULT NULL, INDEX IDX_B5F1AFE5166D1F9C (project_id), INDEX IDX_B5F1AFE5ED5CA9E6 (service_id), INDEX IDX_B5F1AFE52BE78CCE (rateUnitType_id), INDEX IDX_B5F1AFE5A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE activity_tags (activity_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_6C784FB481C06096 (activity_id), INDEX IDX_6C784FB4BAD26311 (tag_id), PRIMARY KEY(activity_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE timeslices (id INT AUTO_INCREMENT NOT NULL, activity_id INT NOT NULL, employee_id INT DEFAULT NULL, user_id INT DEFAULT NULL, value NUMERIC(10, 4) NOT NULL, started_at DATETIME DEFAULT NULL, stopped_at DATETIME DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, deleted_at DATETIME DEFAULT NULL, INDEX IDX_72C53BF481C06096 (activity_id), INDEX IDX_72C53BF48C03F15C (employee_id), INDEX IDX_72C53BF4A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE timeslice_tags (timeslice_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_4231EEB94FB5678C (timeslice_id), INDEX IDX_4231EEB9BAD26311 (tag_id), PRIMARY KEY(timeslice_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE projects (id INT AUTO_INCREMENT NOT NULL, customer_id INT DEFAULT NULL, rate_group_id INT DEFAULT NULL, project_category_id INT DEFAULT NULL, accountant_id INT DEFAULT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, alias VARCHAR(30) NOT NULL, started_at DATETIME DEFAULT NULL, stopped_at DATETIME DEFAULT NULL, deadline DATETIME DEFAULT NULL, description LONGTEXT DEFAULT NULL, budget_price VARCHAR(255) DEFAULT NULL, fixed_price VARCHAR(255) DEFAULT NULL, budget_time INT DEFAULT NULL, chargeable TINYINT(1) DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, deleted_at DATETIME DEFAULT NULL, INDEX IDX_5C93B3A49395C3F3 (customer_id), INDEX IDX_5C93B3A42983C9E6 (rate_group_id), INDEX IDX_5C93B3A4DA896A19 (project_category_id), INDEX IDX_5C93B3A49582AA74 (accountant_id), INDEX IDX_5C93B3A4A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE project_tags (project_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_562D5C3E166D1F9C (project_id), INDEX IDX_562D5C3EBAD26311 (tag_id), PRIMARY KEY(project_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE tags (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, system TINYINT(1) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX IDX_6FBC9426A76ED395 (user_id), UNIQUE INDEX unique_tag_name_user (name, user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE tbbc_money_ratio_history (id INT AUTO_INCREMENT NOT NULL, currency_code VARCHAR(3) NOT NULL, reference_currency_code VARCHAR(3) NOT NULL, ratio DOUBLE PRECISION NOT NULL, saved_at DATETIME NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE tbbc_money_doctrine_storage_ratios (id INT AUTO_INCREMENT NOT NULL, currency_code VARCHAR(3) NOT NULL, ratio DOUBLE PRECISION NOT NULL, UNIQUE INDEX UNIQ_1168A609FDA273EC (currency_code), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA460427166D1F9C FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604276BF700BD FOREIGN KEY (status_id) REFERENCES offer_status_uc (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604272983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604279395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA4604279582AA74 FOREIGN KEY (accountant_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA460427F5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id)');
        $this->addSql('ALTER TABLE offers ADD CONSTRAINT FK_DA460427A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offer_standard_discounts ADD CONSTRAINT FK_84D719D953C674EE FOREIGN KEY (offer_id) REFERENCES offers (id)');
        $this->addSql('ALTER TABLE offer_standard_discounts ADD CONSTRAINT FK_84D719D97EAA7D27 FOREIGN KEY (standard_discount_id) REFERENCES standard_discounts (id)');
        $this->addSql('ALTER TABLE offer_tags ADD CONSTRAINT FK_9144BA3153C674EE FOREIGN KEY (offer_id) REFERENCES offers (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE offer_tags ADD CONSTRAINT FK_9144BA31BAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE offer_positions ADD CONSTRAINT FK_755A98B853C674EE FOREIGN KEY (offer_id) REFERENCES offers (id)');
        $this->addSql('ALTER TABLE offer_positions ADD CONSTRAINT FK_755A98B8ED5CA9E6 FOREIGN KEY (service_id) REFERENCES services (id)');
        $this->addSql('ALTER TABLE offer_positions ADD CONSTRAINT FK_755A98B82BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id)');
        $this->addSql('ALTER TABLE offer_positions ADD CONSTRAINT FK_755A98B8A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offer_discounts ADD CONSTRAINT FK_5F927F7C53C674EE FOREIGN KEY (offer_id) REFERENCES offers (id)');
        $this->addSql('ALTER TABLE offer_discounts ADD CONSTRAINT FK_5F927F7CA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE offer_status_uc ADD CONSTRAINT FK_B021B587A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoice_items ADD CONSTRAINT FK_DCC4B9F82989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('ALTER TABLE invoice_items ADD CONSTRAINT FK_DCC4B9F881C06096 FOREIGN KEY (activity_id) REFERENCES activities (id)');
        $this->addSql('ALTER TABLE invoice_items ADD CONSTRAINT FK_DCC4B9F8A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE costgroups ADD CONSTRAINT FK_21D763E8A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F95166D1F9C FOREIGN KEY (project_id) REFERENCES projects (id)');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F959395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F959582AA74 FOREIGN KEY (accountant_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F95CC72B005 FOREIGN KEY (costgroup_id) REFERENCES costgroups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoices ADD CONSTRAINT FK_6A2F2F95A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE invoice_standard_discounts ADD CONSTRAINT FK_A1BE84202989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('ALTER TABLE invoice_standard_discounts ADD CONSTRAINT FK_A1BE84207EAA7D27 FOREIGN KEY (standard_discount_id) REFERENCES standard_discounts (id)');
        $this->addSql('ALTER TABLE invoice_tags ADD CONSTRAINT FK_6D79F6432989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE invoice_tags ADD CONSTRAINT FK_6D79F643BAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE invoiceDiscounts ADD CONSTRAINT FK_4F4E9F232989F1FD FOREIGN KEY (invoice_id) REFERENCES invoices (id)');
        $this->addSql('ALTER TABLE invoiceDiscounts ADD CONSTRAINT FK_4F4E9F23A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE WorkingPeriods ADD CONSTRAINT FK_57C1BB888C03F15C FOREIGN KEY (employee_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE WorkingPeriods ADD CONSTRAINT FK_57C1BB88A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE holidays ADD CONSTRAINT FK_3A66A10CA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE rateunittypes ADD CONSTRAINT FK_71C44DB0A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE rate_groups ADD CONSTRAINT FK_529A081BA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE customers ADD CONSTRAINT FK_62534E212983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE customers ADD CONSTRAINT FK_62534E21F5B7AF75 FOREIGN KEY (address_id) REFERENCES address (id)');
        $this->addSql('ALTER TABLE customers ADD CONSTRAINT FK_62534E21A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE customer_tags ADD CONSTRAINT FK_3B2D30519395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE customer_tags ADD CONSTRAINT FK_3B2D3051BAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE customer_phones ADD CONSTRAINT FK_52EDF2A49395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id)');
        $this->addSql('ALTER TABLE customer_phones ADD CONSTRAINT FK_52EDF2A43B7323CB FOREIGN KEY (phone_id) REFERENCES phone (id)');
        $this->addSql('ALTER TABLE settings ADD CONSTRAINT FK_E545A0C5A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE rates ADD CONSTRAINT FK_44D4AB3C2983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE rates ADD CONSTRAINT FK_44D4AB3C2BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id)');
        $this->addSql('ALTER TABLE rates ADD CONSTRAINT FK_44D4AB3CED5CA9E6 FOREIGN KEY (service_id) REFERENCES services (id)');
        $this->addSql('ALTER TABLE rates ADD CONSTRAINT FK_44D4AB3CA76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE standard_discounts ADD CONSTRAINT FK_57041CB0A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE services ADD CONSTRAINT FK_7332E169A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE service_tags ADD CONSTRAINT FK_A1FF20CAED5CA9E6 FOREIGN KEY (service_id) REFERENCES services (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE service_tags ADD CONSTRAINT FK_A1FF20CABAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE activities ADD CONSTRAINT FK_B5F1AFE5166D1F9C FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE activities ADD CONSTRAINT FK_B5F1AFE5ED5CA9E6 FOREIGN KEY (service_id) REFERENCES services (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE activities ADD CONSTRAINT FK_B5F1AFE52BE78CCE FOREIGN KEY (rateUnitType_id) REFERENCES rateunittypes (id)');
        $this->addSql('ALTER TABLE activities ADD CONSTRAINT FK_B5F1AFE5A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE activity_tags ADD CONSTRAINT FK_6C784FB481C06096 FOREIGN KEY (activity_id) REFERENCES activities (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE activity_tags ADD CONSTRAINT FK_6C784FB4BAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE timeslices ADD CONSTRAINT FK_72C53BF481C06096 FOREIGN KEY (activity_id) REFERENCES activities (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE timeslices ADD CONSTRAINT FK_72C53BF48C03F15C FOREIGN KEY (employee_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE timeslices ADD CONSTRAINT FK_72C53BF4A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE timeslice_tags ADD CONSTRAINT FK_4231EEB94FB5678C FOREIGN KEY (timeslice_id) REFERENCES timeslices (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE timeslice_tags ADD CONSTRAINT FK_4231EEB9BAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A49395C3F3 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A42983C9E6 FOREIGN KEY (rate_group_id) REFERENCES rate_groups (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A4DA896A19 FOREIGN KEY (project_category_id) REFERENCES project_categories (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A49582AA74 FOREIGN KEY (accountant_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE projects ADD CONSTRAINT FK_5C93B3A4A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE project_tags ADD CONSTRAINT FK_562D5C3E166D1F9C FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE project_tags ADD CONSTRAINT FK_562D5C3EBAD26311 FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE tags ADD CONSTRAINT FK_6FBC9426A76ED395 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE customer_phones DROP FOREIGN KEY FK_52EDF2A43B7323CB');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA460427F5B7AF75');
        $this->addSql('ALTER TABLE customers DROP FOREIGN KEY FK_62534E21F5B7AF75');
        $this->addSql('ALTER TABLE offer_standard_discounts DROP FOREIGN KEY FK_84D719D953C674EE');
        $this->addSql('ALTER TABLE offer_tags DROP FOREIGN KEY FK_9144BA3153C674EE');
        $this->addSql('ALTER TABLE offer_positions DROP FOREIGN KEY FK_755A98B853C674EE');
        $this->addSql('ALTER TABLE offer_discounts DROP FOREIGN KEY FK_5F927F7C53C674EE');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604276BF700BD');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F95CC72B005');
        $this->addSql('ALTER TABLE invoice_items DROP FOREIGN KEY FK_DCC4B9F82989F1FD');
        $this->addSql('ALTER TABLE invoice_standard_discounts DROP FOREIGN KEY FK_A1BE84202989F1FD');
        $this->addSql('ALTER TABLE invoice_tags DROP FOREIGN KEY FK_6D79F6432989F1FD');
        $this->addSql('ALTER TABLE invoiceDiscounts DROP FOREIGN KEY FK_4F4E9F232989F1FD');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604279582AA74');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA460427A76ED395');
        $this->addSql('ALTER TABLE offer_positions DROP FOREIGN KEY FK_755A98B8A76ED395');
        $this->addSql('ALTER TABLE offer_discounts DROP FOREIGN KEY FK_5F927F7CA76ED395');
        $this->addSql('ALTER TABLE offer_status_uc DROP FOREIGN KEY FK_B021B587A76ED395');
        $this->addSql('ALTER TABLE invoice_items DROP FOREIGN KEY FK_DCC4B9F8A76ED395');
        $this->addSql('ALTER TABLE costgroups DROP FOREIGN KEY FK_21D763E8A76ED395');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F959582AA74');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F95A76ED395');
        $this->addSql('ALTER TABLE invoiceDiscounts DROP FOREIGN KEY FK_4F4E9F23A76ED395');
        $this->addSql('ALTER TABLE WorkingPeriods DROP FOREIGN KEY FK_57C1BB888C03F15C');
        $this->addSql('ALTER TABLE WorkingPeriods DROP FOREIGN KEY FK_57C1BB88A76ED395');
        $this->addSql('ALTER TABLE holidays DROP FOREIGN KEY FK_3A66A10CA76ED395');
        $this->addSql('ALTER TABLE rateunittypes DROP FOREIGN KEY FK_71C44DB0A76ED395');
        $this->addSql('ALTER TABLE rate_groups DROP FOREIGN KEY FK_529A081BA76ED395');
        $this->addSql('ALTER TABLE customers DROP FOREIGN KEY FK_62534E21A76ED395');
        $this->addSql('ALTER TABLE settings DROP FOREIGN KEY FK_E545A0C5A76ED395');
        $this->addSql('ALTER TABLE rates DROP FOREIGN KEY FK_44D4AB3CA76ED395');
        $this->addSql('ALTER TABLE standard_discounts DROP FOREIGN KEY FK_57041CB0A76ED395');
        $this->addSql('ALTER TABLE services DROP FOREIGN KEY FK_7332E169A76ED395');
        $this->addSql('ALTER TABLE activities DROP FOREIGN KEY FK_B5F1AFE5A76ED395');
        $this->addSql('ALTER TABLE timeslices DROP FOREIGN KEY FK_72C53BF48C03F15C');
        $this->addSql('ALTER TABLE timeslices DROP FOREIGN KEY FK_72C53BF4A76ED395');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A49582AA74');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A4A76ED395');
        $this->addSql('ALTER TABLE tags DROP FOREIGN KEY FK_6FBC9426A76ED395');
        $this->addSql('ALTER TABLE offer_positions DROP FOREIGN KEY FK_755A98B82BE78CCE');
        $this->addSql('ALTER TABLE rates DROP FOREIGN KEY FK_44D4AB3C2BE78CCE');
        $this->addSql('ALTER TABLE activities DROP FOREIGN KEY FK_B5F1AFE52BE78CCE');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604272983C9E6');
        $this->addSql('ALTER TABLE customers DROP FOREIGN KEY FK_62534E212983C9E6');
        $this->addSql('ALTER TABLE rates DROP FOREIGN KEY FK_44D4AB3C2983C9E6');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A42983C9E6');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A4DA896A19');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA4604279395C3F3');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F959395C3F3');
        $this->addSql('ALTER TABLE customer_tags DROP FOREIGN KEY FK_3B2D30519395C3F3');
        $this->addSql('ALTER TABLE customer_phones DROP FOREIGN KEY FK_52EDF2A49395C3F3');
        $this->addSql('ALTER TABLE projects DROP FOREIGN KEY FK_5C93B3A49395C3F3');
        $this->addSql('ALTER TABLE offer_standard_discounts DROP FOREIGN KEY FK_84D719D97EAA7D27');
        $this->addSql('ALTER TABLE invoice_standard_discounts DROP FOREIGN KEY FK_A1BE84207EAA7D27');
        $this->addSql('ALTER TABLE offer_positions DROP FOREIGN KEY FK_755A98B8ED5CA9E6');
        $this->addSql('ALTER TABLE rates DROP FOREIGN KEY FK_44D4AB3CED5CA9E6');
        $this->addSql('ALTER TABLE service_tags DROP FOREIGN KEY FK_A1FF20CAED5CA9E6');
        $this->addSql('ALTER TABLE activities DROP FOREIGN KEY FK_B5F1AFE5ED5CA9E6');
        $this->addSql('ALTER TABLE invoice_items DROP FOREIGN KEY FK_DCC4B9F881C06096');
        $this->addSql('ALTER TABLE activity_tags DROP FOREIGN KEY FK_6C784FB481C06096');
        $this->addSql('ALTER TABLE timeslices DROP FOREIGN KEY FK_72C53BF481C06096');
        $this->addSql('ALTER TABLE timeslice_tags DROP FOREIGN KEY FK_4231EEB94FB5678C');
        $this->addSql('ALTER TABLE offers DROP FOREIGN KEY FK_DA460427166D1F9C');
        $this->addSql('ALTER TABLE invoices DROP FOREIGN KEY FK_6A2F2F95166D1F9C');
        $this->addSql('ALTER TABLE activities DROP FOREIGN KEY FK_B5F1AFE5166D1F9C');
        $this->addSql('ALTER TABLE project_tags DROP FOREIGN KEY FK_562D5C3E166D1F9C');
        $this->addSql('ALTER TABLE offer_tags DROP FOREIGN KEY FK_9144BA31BAD26311');
        $this->addSql('ALTER TABLE invoice_tags DROP FOREIGN KEY FK_6D79F643BAD26311');
        $this->addSql('ALTER TABLE customer_tags DROP FOREIGN KEY FK_3B2D3051BAD26311');
        $this->addSql('ALTER TABLE service_tags DROP FOREIGN KEY FK_A1FF20CABAD26311');
        $this->addSql('ALTER TABLE activity_tags DROP FOREIGN KEY FK_6C784FB4BAD26311');
        $this->addSql('ALTER TABLE timeslice_tags DROP FOREIGN KEY FK_4231EEB9BAD26311');
        $this->addSql('ALTER TABLE project_tags DROP FOREIGN KEY FK_562D5C3EBAD26311');
        $this->addSql('DROP TABLE phone');
        $this->addSql('DROP TABLE address');
        $this->addSql('DROP TABLE offers');
        $this->addSql('DROP TABLE offer_standard_discounts');
        $this->addSql('DROP TABLE offer_tags');
        $this->addSql('DROP TABLE offer_positions');
        $this->addSql('DROP TABLE offer_discounts');
        $this->addSql('DROP TABLE offer_status_uc');
        $this->addSql('DROP TABLE invoice_items');
        $this->addSql('DROP TABLE costgroups');
        $this->addSql('DROP TABLE invoices');
        $this->addSql('DROP TABLE invoice_standard_discounts');
        $this->addSql('DROP TABLE invoice_tags');
        $this->addSql('DROP TABLE invoiceDiscounts');
        $this->addSql('DROP TABLE WorkingPeriods');
        $this->addSql('DROP TABLE holidays');
        $this->addSql('DROP TABLE users');
        $this->addSql('DROP TABLE rateunittypes');
        $this->addSql('DROP TABLE rate_groups');
        $this->addSql('DROP TABLE project_categories');
        $this->addSql('DROP TABLE customers');
        $this->addSql('DROP TABLE customer_tags');
        $this->addSql('DROP TABLE customer_phones');
        $this->addSql('DROP TABLE settings');
        $this->addSql('DROP TABLE rates');
        $this->addSql('DROP TABLE standard_discounts');
        $this->addSql('DROP TABLE services');
        $this->addSql('DROP TABLE service_tags');
        $this->addSql('DROP TABLE activities');
        $this->addSql('DROP TABLE activity_tags');
        $this->addSql('DROP TABLE timeslices');
        $this->addSql('DROP TABLE timeslice_tags');
        $this->addSql('DROP TABLE projects');
        $this->addSql('DROP TABLE project_tags');
        $this->addSql('DROP TABLE tags');
        $this->addSql('DROP TABLE tbbc_money_ratio_history');
        $this->addSql('DROP TABLE tbbc_money_doctrine_storage_ratios');
    }
}
