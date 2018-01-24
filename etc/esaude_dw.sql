drop table patient;
drop table pregnancy;
drop table tarv_status;
drop table breastfeed;
drop table location;

create table patient (
  id int(10) not null,
  location_id int(10) not null,
  sex varchar(100) not null,
  birth_date date not null
);

create table pregnancy (
  patient_id int(10) not null,
  date date not null
);

create table tarv_status (
  patient_id int(10) not null,
  status varchar(100) not null,
  event varchar(100) not null,
  event_date date not null,
  next_event_date date,
  reason varchar(2000),
  notified bit,
  breastfeeding bit
);

create table breastfeed (
  patient_id int(10) not null,
  date date not null
);

create table location (
  id int(10) not null,
  description varchar(200)
);

create index tarv_status_patient on tarv_status (patient_id);

--not improving performance so much so far
--create index tarv_status_date on tarv_status (event_date);

