USE `recruitment_data`;

SELECT *
FROM recruitment 
;

-- Average Expected Salary
SELECT FORMAT(AVG(expected_salary),0)
FROM recruitment 
;

-- Average Years of Experience
SELECT AVG(years_of_experience)
FROM recruitment 
;

-- Average Age
SELECT AVG(age) AS Avg_age
FROM recruitment 
;

-- Distribution of Sources
SELECT source, COUNT(*)
FROM recruitment 
GROUP BY source
;

-- Interview Status Distribution
SELECT interview_status, COUNT(*)
FROM recruitment 
GROUP BY interview_status
;


-- Updating the table 
SELECT interview_status
FROM recruitment 
WHERE interview_status = ''
;

UPDATE recruitment
SET interview_status = 'Not Interviewed'
WHERE interview_status = ''
;

-- Offer Status Distribution
SELECT offer_status, COUNT(*)
FROM recruitment
GROUP BY offer_status
;

-- The format of the columns heading had to be changed 
ALTER TABLE recruitment
CHANGE COLUMN `time-to-hire` time_to_hire INT
;

ALTER TABLE recruitment
CHANGE COLUMN `cost-per-hire` cost_per_hire INT
;

-- Average Time-to-Hire
SELECT AVG(time_to_hire)
FROM recruitment
;

-- Average Cost-per-Hire

SELECT `cost-per-hire`
FROM recruitment
WHERE `cost-per-hire` NOT REGEXP '^[0-9]+$';
;

UPDATE recruitment
SET `cost-per-hire` = NULL 
WHERE `cost-per-hire` NOT REGEXP '^[0-9]+$'
;

ALTER TABLE recruitment
CHANGE COLUMN `cost-per-hire` cost_per_hire INT 
;

SELECT AVG(cost_per_hire)
FROM recruitment
;

-- Diversity Distribution
SELECT diversity, COUNT(*)
FROM recruitment
GROUP BY diversity
;


-- Average Time-to-Hire per role
SELECT role, AVG(time_to_hire) AS Avg_time
FROM recruitment
GROUP BY role
ORDER BY Avg_time DESC
;


-- Average Cost_per_hire per role
SELECT role, FORMAT(AVG(cost_per_hire), 0) AS Avg_cost
FROM recruitment
GROUP BY role
ORDER BY AVG(cost_per_hire) DESC
;

-- Average expected salary for diversity
SELECT diversity, AVG(expected_salary)
FROM recruitment
GROUP BY diversity
;

-- Average years of experience for diversity
SELECT diversity, AVG(years_of_experience) AS Avg_years
FROM recruitment
GROUP BY diversity
;

-- Average age vs diversity
SELECT diversity, AVG(age)
FROM recruitment
GROUP BY diversity
;

-- Diversity in hiring process
SELECT diversity, interview_status, offer_status, COUNT(*)
FROM recruitment
GROUP BY diversity, interview_status, offer_status
ORDER BY diversity
;

-- Average Time-to-Hire by Source
SELECT source, AVG(time_to_hire) 
FROM recruitment
GROUP BY source
ORDER BY AVG(time_to_hire) DESC
;

-- Interview-to-offer Ratio
SELECT interview_status, COUNT(*)
FROM recruitment
GROUP BY interview_status
;

SELECT offer_status, COUNT(*)
FROM recruitment
GROUP BY offer_status
;

WITH interview_count_cte AS 
(
SELECT interview_status, COUNT(*) AS interview_count
FROM recruitment
GROUP BY interview_status
),
offer_count_cte AS 
(
SELECT offer_status, COUNT(*) AS offer_count
FROM recruitment
GROUP BY offer_status
)

SELECT ic.interview_status,
oc.offer_status,
ic.interview_count,
oc.offer_count,
CAST(ic.interview_count AS FLOAT) /oc.offer_count AS ratio
FROM interview_count_cte AS ic
JOIN offer_count_cte AS oc
	ON ic.interview_count = oc.offer_count
;

-- Average Years of Experience vs. Role
SELECT role, AVG(years_of_experience)
FROM recruitment
GROUP BY role
ORDER BY AVG(years_of_experience)
;


-- Average Salary by Role
SELECT role, AVG(expected_salary)
FROM recruitment
GROUP BY role
ORDER BY AVG(expected_salary) DESC
;

-- Average Years of Experience by Role
SELECT role, AVG(years_of_experience)
FROM recruitment
GROUP BY role
ORDER BY AVG(years_of_experience) DESC
;






























