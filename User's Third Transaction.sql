WITH set_row_number1 AS (
  SELECT *,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) as rowno1
  FROM transactions
)
SELECT user_id, spend, transaction_date
FROM set_row_number1
WHERE rowno1 = 3