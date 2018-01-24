drop table pregnancy;
drop table tarv_status;
drop table breastfeed;
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
  patient_id int(10) not null,
  date date not null
);
alter table pregnancy add constraint fk_pregnancy_patient foreign key (patient_id) references patient (id);

create table breastfeed (
  patient_id int(10) not null,
  date date not null
);
alter table breastfeed add constraint fk_breastfeed_patient foreign key (patient_id) references patient (id);

create table tarv_status (
  patient_id int(10) not null,
  status varchar(100) not null,
  event varchar(100) not null,
  event_date date not null,
  next_event_date date,
  reason varchar(2000),
  notified bit
);
alter table tarv_status add constraint fk_tarv_status_patient foreign key (patient_id) references patient (id);

