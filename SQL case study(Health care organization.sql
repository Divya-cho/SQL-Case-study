create database Hospital;
use Hospital;

#creating Patient table
create table Patient(patient_id int primary key,name varchar(25),address char,date_of_birth date,contact_information bigint);
desc Patient;
select * from Patient;

#creating Medical_history table
create table Medical_history(patient_id int,diagnoses char,treatment char,surgeries char,medication char);
alter table Medical_history add constraint foreign key(patient_id) references Patient(patient_id);
alter table Medical_history add constraint foreign key(medication) references Prescriptions(medication_name);
desc Medical_history;
select * from Medical_history;

#creating Lab_results table
create table Lab_results(patient_id int,Blood_test boolean,urine_test boolean,imaging_test boolean);
alter table Lab_results add constraint foreign key(patient_id) references Patient(patient_id);
desc Lab_results;
select * from Lab_results;

#creating Prescriptions table
create table Prescriptions(medication_name char primary key,dosage char(20),frequency int);
desc Prescriptions;
select * from Prescriptions;

#creating outcome table
create table outcome(reAdmission_rate float,medication_adherence char);
desc outcome;
select * from outcome;