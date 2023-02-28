-- get the number of companies that have posted duplicate job listings
WITH GROUP_INFO AS (
  SELECT company_id, title, COUNT(*) AS job_count
  FROM job_listings
  GROUP BY 1, 2
)

SELECT COUNT(job_count) AS co_w_duplicate_jobs
FROM GROUP_INFO
WHERE job_count >= 2