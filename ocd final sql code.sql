-- COUNT AND PERCENT OF MALE AND FEMALE DIAGNOSED WITH OCD &
-- -- AVERAGE OBSSESSION SCORE BY GENDER 

WITH DATA AS (
SELECT
Gender,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM ocd_dataset.ocd_patient_dataset
Group By GENDER 
Order by patient_count
)

select
	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

	round(sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_female,

    round(sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_male

from data;

-- -- 2. Count of Patients by Ethnicity and their respective Average Obsession Score

select Ethnicity,
	count(`Patient ID`) as patient_count,
    round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
    
from  ocd_dataset.ocd_patient_dataset
group by Ethnicity
order by patient_count;

-- 3. Number of people diagnosed with OCD MoM

ALTER TABLE ocd_dataset.ocd_patient_dataset
MODIFY `OCD Diagnosis Date` DATE;

UPDATE ocd_dataset.ocd_patient_dataset
SET `OCD Diagnosis Date` = str_to_date(`OCD Diagnosis Date`, '%d-%m-%y');

select
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
count(`Patient ID`) patient_count
from ocd_dataset.ocd_patient_dataset
group by 1
Order by 1;

-- 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score

select `Obsession Type`,
count(`Patient ID`) pat_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) Avg_Obsession_Score
from ocd_dataset.ocd_patient_dataset
group by `Obsession Type`
order by 2 ;

-- 5. What is the most common Compulsion type (Count) & it's respective Average Obsession Score

select `Compulsion Type`,
count(`Patient ID`) pat_count,
round(avg(`Y-BOCS Score (Compulsions)`),2) Avg_Obsession_Score
from ocd_dataset.ocd_patient_dataset
group by 1
order by 2 ;

