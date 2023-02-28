WITH tb1 AS 
(
  SELECT a.user_id, a.activity_type, a.time_spent, ab.age_bucket,
          count(1) OVER(PARTITION BY age_bucket) AS count_time
  FROM activities a
  INNER JOIN age_breakdown ab 
  ON a.user_id = ab.user_id
  GROUP BY 1, 2, 3, 4
)
, 
tb2 AS (
  SELECT age_bucket,
        count_time,
         SUM(CASE activity_type WHEN 'open' THEN time_spent ELSE 0 END) as open_time_spent,
         SUM(CASE activity_type WHEN 'send' THEN time_spent ELSE 0 END) as send_time_spent,
         SUM(CASE activity_type WHEN 'chat' THEN time_spent ELSE 0 END) as chat_time_spent
  FROM tb1   
  GROUP BY 1, 2
)

SELECT age_bucket, 
        round(send_time_spent/(send_time_spent + open_time_spent)*100.0, 2) AS send_perc,
        round(open_time_spent/(open_time_spent + send_time_spent)*100.0, 2) AS open_perc
FROM tb2
ORDER BY age_bucket