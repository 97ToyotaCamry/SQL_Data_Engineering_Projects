SELECT
sd.skills,
ROUND(COUNT(jpf.*),0) as skill_demand,
MEDIAN(jpf.salary_year_avg) highest_payin
FROM
job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
ON sjd.skill_id = sd.skill_id
WHERE
jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = True
GROUP BY
sd.skills
HAVING
skill_demand > 1000
ORDER BY
highest_payin DESC

LIMIT 25;