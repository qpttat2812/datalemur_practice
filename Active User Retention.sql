WITH tb1 AS(
  SELECT DISTINCT user_id,
          EXTRACT(MONTH FROM event_date) AS month
  FROM user_actions
)
,
tb2 AS (
  SELECT t1.user_id, t2.month
  FROM tb1 as t1, tb1 as t2
  WHERE t1.user_id = t2.user_id AND t2.month - 1 = t1.month
)

SELECT max_month AS month, COUNT(1) AS monthly_active_users
FROM (
  SELECT user_id, MAX(month) as max_month
  FROM tb2
  GROUP BY user_id
) AS t4
GROUP BY month