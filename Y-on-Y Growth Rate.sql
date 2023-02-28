WITH tb1 AS (
  SELECT EXTRACT(YEAR FROM transaction_date) as year,
          product_id, 
          spend as curr_year_spend,
          lag(spend) OVER(PARTITION BY product_id ORDER BY 
          EXTRACT(YEAR FROM transaction_date) ASC) AS prev_year_spend
  FROM user_transactions
)

SELECT * ,
      ROUND((curr_year_spend - prev_year_spend)/prev_year_spend * 100, 2) as yoy_rate
FROM tb1 