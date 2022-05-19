drop database if exists dbms_proj;
create database dbms_proj;
use dbms_proj;

create table phoenix_customer(
phoenix_customer_id int primary key,
phoenix_customer_fname VARCHAR(20) not null,
phoenix_customer_lname VARCHAR(20) ,
phoenix_customer_dob DATE,
phoenix_customer_gender CHAR(2),
phoenix_customer_address VARCHAR(100),
phoenix_customer_mob_number numeric(10) not null unique,
phoenix_customer_email VARCHAR(50),
phoenix_customer_aadhar_number numeric(12) not null unique,
phoenix_customer_marital_status CHAR(8),
phoenix_customer_pan_number varchar(20) not null unique);

create table phoenix_company(
phoenix_company_id int primary key,
phoenix_company_name varchar(100),
phoenix_company_address varchar(100),
phoenix_company_website varchar(40),
phoenix_company_contact_number numeric(10));

create table phoenix_product(
phoenix_product_id int primary key,
phoenix_product_company_id int,
phoenix_product_price float,
phoenix_product_type CHAR(15),
foreign key (phoenix_product_company_id) references phoenix_company(phoenix_company_id));

create table phoenix_department(
phoenix_department_id int primary key,
phoenix_department_company_id int,
phoenix_department_name	VARCHAR(50), 
phoenix_department_location varchar(20),
phoenix_department_leader CHAR(18),
foreign key (phoenix_department_company_id) references phoenix_company(phoenix_company_id));

create table phoenix_nok(
phoenix_nok_id int primary key,
phoenix_nok_customer_id int,
phoenix_nok_name VARCHAR(40),
phoenix_nok_address	VARCHAR(100),
phoenix_nok_mob_number numeric(10) not null unique,
phoenix_nok_gender CHAR(2),
phoenix_nok_marital_status CHAR(15),
phoenix_nok_relation_to_customer varchar(20),
foreign key (phoenix_nok_customer_id) references phoenix_customer(phoenix_customer_id));

create table phoenix_vehicle(
phoenix_vehicle_id int primary key,
phoenix_vehicle_customer_id int,
phoenix_vehicle_manufacturer varchar(20),
phoenix_vehicle_model varchar(20),
phoenix_vehicle_type varchar(45),
phoenix_vehicle_registration_number varchar(45) not null unique,
phoenix_vehicle_engine_number varchar(45),
phoenix_vehicle_chasis_number varchar(45),
phoenix_vehicle_colour varchar(10),
phoenix_vehicle_date_of_purchase date,
foreign key (phoenix_vehicle_customer_id) references phoenix_customer(phoenix_customer_id));

create table phoenix_coverage(
phoenix_coverage_id int primary key,
phoenix_coverage_product_id int,
phoenix_coverage_amount	float,
phoenix_coverage_type	varchar(50),
phoenix_coverage_level	CHAR(15),
phoenix_coverage_description VARCHAR(100),
phoenix_covearge_term VARCHAR(50),
foreign key (phoenix_coverage_product_id) references phoenix_product(phoenix_product_id));

create table phoenix_staff(
phoenix_staff_id int primary key,
phoenix_staff_department_id int,
phoenix_staff_fname	VARCHAR(20),
phoenix_staff_lname	VARCHAR(20),
phoenix_staff_address VARCHAR(100),
phoenix_staff_contact numeric(10) not null unique,
phoenix_staff_gender CHAR(2) ,
phoenix_staff_marital_status CHAR(20),
phoenix_staff_nationality CHAR(15),
phoenix_staff_qualification VARCHAR(20),
phoenix_staff_allowance	float,
phoenix_staff_addhar_number numeric(12) not null unique,
foreign key (phoenix_staff_department_id) references phoenix_department(phoenix_department_id));

create table phoenix_insurance_policy(
phoenix_insurance_policy_id int primary key,
phoenix_insurance_policy_vehicle_id int,
phoenix_insurance_policy_product_id int,
phoenix_insurance_policy_start_date date,
phoenix_insurance_policy_expire_date date,
foreign key (phoenix_insurance_policy_vehicle_id) references phoenix_vehicle(phoenix_vehicle_id),
foreign key (phoenix_insurance_policy_product_id) references phoenix_product(phoenix_product_id));

create table phoenix_incident(
phoenix_incident_id int primary key,
phoenix_incident_vehicle_id int,
phoenix_incident_staff_id int,
phoenix_incident_type VARCHAR(30), 
phoenix_incident_date DATE, 
phoenix_incident_description VARCHAR(200),
foreign key (phoenix_incident_vehicle_id) references phoenix_vehicle(phoenix_vehicle_id),
foreign key (phoenix_incident_staff_id) references phoenix_staff(phoenix_staff_id));

create table phoenix_premium_payment(
phoenix_premium_payment_id int primary key,
phoenix_premium_payment_insurance_policy_id int,
phoenix_premium_payment_amount float,
phoenix_premium_payment_schedule DATE,
phoenix_premium_payment_status char(8),
constraint phoenix_premium_payment_check check(phoenix_premium_payment_status='done' or phoenix_premium_payment_status='pending'),
foreign key (phoenix_premium_payment_insurance_policy_id) references phoenix_insurance_policy(phoenix_insurance_policy_id)); 

create table phoenix_receipt(
phoenix_receipt_id int primary key,
phoenix_receipt_premium_payment_id int,
phoenix_receipt_amount float,
foreign key (phoenix_receipt_premium_payment_id) references phoenix_premium_payment(phoenix_premium_payment_id));

create table phoenix_claim(
phoenix_claim_id int primary key,
phoenix_claim_insurance_policy_id int,
phoenix_claim_amount float,
phoenix_claim_damage_type VARCHAR(50),
phoenix_claim_date_of_claim DATE,
phoenix_claim_status CHAR(10),
constraint phoenix_claim_check check(phoenix_claim_status = 'pending' or phoenix_claim_status = 'approved' or phoenix_claim_status = 'paid'),
foreign key (phoenix_claim_insurance_policy_id) references phoenix_insurance_policy(phoenix_insurance_policy_id));

create table phoenix_claim_payment(
phoenix_claim_payment_id int primary key,
phoenix_claim_payment_claim_id int,
phoenix_claim_payment_date_settled date,
phoenix_claim_payment_amount_paid float,
foreign key (phoenix_claim_payment_claim_id) references phoenix_claim(phoenix_claim_id));

create table phoenix_application(
phoenix_application_id int primary key,
phoenix_application_vehicle_id int,
phoenix_application_product_id int,
phoenix_application_staff_id int,
phoenix_application_status CHAR(8),
constraint phoenix_application_check check(phoenix_application_status='approved' or phoenix_application_status='pending'),
foreign key (phoenix_application_vehicle_id) references phoenix_vehicle(phoenix_vehicle_id),
foreign key (phoenix_application_product_id) references phoenix_product(phoenix_product_id),
foreign key (phoenix_application_staff_id) references phoenix_staff(phoenix_staff_id));
