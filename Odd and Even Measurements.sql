WITH tb1 AS (
  SELECT *,
        CONCAT(EXTRACT('DAY' FROM measurement_time), '-', EXTRACT('MONTH' FROM measurement_time)) as month_day,
        ROUND(EXTRACT(hour from measurement_time) + EXTRACT(MINUTE FROM measurement_time)/60, 2) as hour_minute
  FROM measurements
)
,
tb2 AS (
  SELECT *, 
        DENSE_RANK() OVER(PARTITION BY month_day ORDER BY hour_minute asc) as rno 
  FROM tb1
)
,
tb3 AS (
  SELECT DATE_TRUNC('day', measurement_time) as measurement_day,
        CASE WHEN (rno % 2 = 0) THEN measurement_value ELSE 0 END as even_measurement,
        CASE WHEN (rno % 2 != 0) THEN measurement_value ELSE 0 END as odd_measurement
  FROM tb2
)
SELECT measurement_day,
      SUM(odd_measurement) as odd_sum,
      SUM(even_measurement) as even_sum
FROM tb3
GROUP BY measurement_day
ORDER BY 1