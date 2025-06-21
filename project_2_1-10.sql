-- Project ID- PTID-CDA-APR-25-447
-- Project Name - PRSQL-02-Medical Data History

use project_medical_data_history;
select * from patients;
-- 1.Show first name, last name, and gender of patients who's gender is 'M'
select first_name,last_name,gender
from patients
where gender = 'M';

-- 2. Show first name and last name of patients who does not have allergies.
select first_name,last_name
from patients
where allergies is null;

-- 3. Show first name of patients that start with the letter 'C'
select first_name from patients
where first_name like 'C%';

-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name,last_name, weight 
from patients
where weight between 100 and 120;

-- 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients
set allergies = 'NKA'
where allergies is null;

-- 6. Show first name and last name concatenated into one column to show their full name.
select concat(first_name,last_name) as full_name
from patients;

-- 7. Show first name, last name, and the full province name of each patient.
select first_name, last_name,province_name 
from patients
join province_names on province_names.province_id = patients.province_id;

-- 8. Show how many patients have a birth_date with 2010 as the birth year.
select count(birth_date) 
from patients
where 
year(birth_date) = 2010;

-- 9. Show the first_name, last_name, and height of the patient with the greatest height.
select first_name,last_name,height
from patients
where height = (
	select max(height)
    from patients
);

-- 10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from patients
where patient_id in (1,45,534,879,1000);
