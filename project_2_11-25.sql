use project_medical_data_history;
-- 11.Show the total number of admissions
select count(admission_date) from admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions
where admission_date = discharge_date;

-- 13. Show the total number of admissions for patient_id 579.
select count(admission_date) from admissions
where patient_id = 579;

-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select distinct city from patients
where province_id = 'NS';

-- 15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
select first_name,last_name,birth_date
from patients
where height >160 and weight>70;

-- 16. Show unique birth years from patients and order them by ascending.
select distinct year(birth_date)
from patients
order by year(birth_date);

-- 17. Show unique first names from the patients table which only occurs once in the list.
select first_name from patients
group by first_name
having count(1);

-- 18. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id,first_name from patients
where first_name like 'S%____%S';

-- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table.
select patients.patient_id,first_name,last_name
from patients
	join admissions on admissions.patient_id = patients.patient_id
where diagnosis ='Dementia';

-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphbetically
select first_name from patients
order by length(first_name) asc;

-- 21. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select
	sum(gender = 'M') as Male_count, sum(gender = 'F') as Female_count
from patients;

-- 23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id,diagnosis from admissions
group by patient_id,diagnosis
having count(*) > 1;

-- 24. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select city,
count(*) as no_patients from patients
group by city
order by no_patients desc, city asc;


-- 25. Show first name, last name and role of every person that is either patient or doctor.    The roles are either "Patient" or "Doctor"
select first_name,last_name, 'Patient' as role from patients
	union all
select first_name,last_name, 'Doctor' from doctors;
