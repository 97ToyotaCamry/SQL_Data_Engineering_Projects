SELECT
sd.skills,
ROUND(MEDIAN(jpf.salary_year_avg),0) as median_salary,
COUNT(jpf.*) as demand_count,
ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2) AS optimal_score
FROM
job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
ON sjd.skill_id = sd.skill_id
WHERE
jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = True
AND jpf.salary_year_avg IS NOT NULL
GROUP BY
sd.skills
HAVING
count(jpf.*) > 100
ORDER BY
optimal_score DESC

LIMIT 25;