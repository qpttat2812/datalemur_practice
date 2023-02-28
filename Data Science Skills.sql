-- solution 1 
-- filter candidate if they have 3 skills
SELECT candidate_id
FROM candidates
WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3

-- solution 2
-- using INTERSECT
SELECT candidate_id
FROM (
  SELECT candidate_id
  FROM candidates 
  WHERE skill = 'Python'
  INTERSECT 
  SELECT candidate_id
  FROM candidates 
  WHERE skill = 'Tableau'
  INTERSECT 
  SELECT candidate_id
  FROM candidates 
  WHERE skill = 'PostgreSQL'
) candidates_tb
ORDER BY 1 ASC