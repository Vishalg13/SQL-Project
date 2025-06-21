use project_medical_data_history;

-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
select 
allergies, 
	count(*) as total
from patients
where allergies is not null
group by allergies
order by total desc;

-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date
from patients
where year(birth_date) = 1970
order by birth_date asc;

-- 28. We want to display each patient's full name in a single column. 
-- Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
-- Separate the last_name and first_name with a comma. Order the list by the first_name in decending order    EX: SMITH,jane

select 
upper(last_name) || ',' || lower(first_name) as full_name
from patients
order by first_name desc;

-- 29. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id, sum(height) as total_height
from patients
group by province_id
having total_height >=7000;

-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight) and 
min(weight) as overall_weight
from patients
where last_name = 'Maroni';

-- 31. . Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

select day(admission_date),
count(*) as no_of_admissions
from admissions
group by admission_date
order by no_of_admissions desc;

-- 32. Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group. 
-- Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select
  truncate(weight, -1) as weight_group,
  count(*)
from patients
group by weight_group
order by weight_group desc;

-- 33. Show patient_id, weight, height, isObese from the patients table.
-- Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). 
-- Weight is in units kg. Height is in units cm.
select patient_id, weight, height, 
  (case 
      when weight/(POWER(height/100.0,2)) >= 30 then
          1
      else
          0
      end) as isObese
from patients;

alter table admissions 
change attending_doctor_id doctor_id varchar(100);

-- 34. Show patient_id, first_name, last_name, and attending doctor's specialty. 
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. 
-- Check patients, admissions, and doctors tables for required information.
select
  p.patient_id,
  p.first_name as patient_first_name,
  p.last_name as patient_last_name,
  ph.specialty as attending_doctor_id
from patients p
  join admissions a on a.patient_id = p.patient_id
  join doctors ph on ph.doctor_id = a.attending_doctor_id
where
  ph.first_name = 'Lisa' and
  a.diagnosis = 'Epilepsy';
  
-- 35. All patients who have gone through admissions, can see their medical documents on our site. 
-- Those patients are given a temporary password after their first admission. 


select
  distinct P.patient_id,
  concat(
    P.patient_id,
    len(last_name),
    year(birth_date)
  ) as temp_password
from patients P
  join admissions A on A.patient_id = P.patient_id;