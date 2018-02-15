create database esaude_dw;
use esaude_dw;

GRANT ALL PRIVILEGES ON esaude_dw.* TO openmrs;
FLUSH PRIVILEGES;

create table location (
  id int(10) not null,
  description varchar(200),
  primary key (id)
);

create table patient (
  id int(10) not null,
  location_id int(10) not null,
  sex varchar(100) not null,
  birth_date date not null,
  primary key (id)
);
alter table patient add constraint fk_patient_location foreign key (location_id) references location (id);

create table pregnancy (
  id int(10) not null auto_increment,
  patient_id int(10) not null,
  start_date date,
  end_date date,
  breastfeeding_start_date date,
  breastfeeding_end_date date,
  primary key (id)
);
alter table pregnancy add constraint fk_pregnancy_patient foreign key (patient_id) references patient (id);

create table art_status (
  id int(10) not null auto_increment,
  patient_id int(10) not null,
  status varchar(100) not null,
  event varchar(100) not null,
  event_date date not null,
  next_event_date date,
  notified bit,
  age_in_months int(2),
  age_in_years int(2),
  first_event bit default false,
  primary key (id)
);
alter table art_status add constraint fk_tarv_status_patient foreign key (patient_id) references patient (id);

create table tb_treatment (
	patient_id int(10) not null,
	date date not null
);
alter table tb_treatment add constraint fk_tb_treatment_patient foreign key (patient_id) references patient (id);

create table viral_load (
	patient_id int(10) not null,
	date date not null,
        age_in_months int(2) not null,
        age_in_years int(2) not null,
	value decimal(19, 6) not null
);
alter table viral_load add constraint fk_viral_load_patient foreign key (patient_id) references patient (id);

--alter table art_status add after_one_year_status_id int(10);
--alter table art_status add after_two_year_status_id int(10);
--alter table art_status add after_three_year_status_id int(10);
--alter table art_status add constraint fk_art_status_to_one_year foreign key (after_one_year_status_id) references art_status (id);
--alter table art_status add constraint fk_art_status_to_two_year foreign key (after_two_year_status_id) references art_status (id);
--alter table art_status add constraint fk_art_status_to_three_year foreign key (after_three_year_status_id) references art_status (id);

create table art_status_after_period (
	art_status_id int(10) not null,
	months int not null,
	art_status_after_period_id  int(10) not null
);
alter table art_status_after_period add constraint fk_after_period_status_status foreign key (art_status_id) references art_status (id);
alter table art_status_after_period add constraint fk_after_period_status_after_status foreign key (art_status_after_period_id) references art_status (id);

DELIMITER $$
CREATE FUNCTION esaude_dw.inclusion_start_date_from_retention (base_date date, months int) 
RETURNS date
DETERMINISTIC
BEGIN 
  DECLARE start_date date;
  IF months = 12 THEN
	SET start_date = date_add(base_date, interval -24 month);
  ELSE
	SET start_date = date_add(base_date, interval -months-3 month);
  END IF;
  RETURN start_date;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION esaude_dw.inclusion_end_date_from_retention (base_date date, months int) 
RETURNS date
DETERMINISTIC
BEGIN 
  DECLARE end_date date;
  SET end_date = date_add(base_date, interval -months month);
  RETURN end_date;
END$$
DELIMITER ;

