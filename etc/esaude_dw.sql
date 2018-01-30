drop table pregnancy;
drop table art_status;
drop table patient;
drop table location;

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

