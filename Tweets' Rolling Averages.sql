WITH tb1 AS (
  SELECT *,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY tweet_date) AS rno 
  FROM (
      SELECT user_id, tweet_date, count(1) as count_tweet
      FROM tweets
      GROUP BY 1, 2
  ) AS counttweet_tb
),
tb2 AS (
  SELECT user_id, tweet_date, count_tweet, rno,
        CASE WHEN rno <= 3 THEN (SUM(count_tweet) OVER(PARTITION BY user_id ORDER BY tweet_date))
          ELSE 1 END AS consecutive_tweets
FROM tb1
)

SELECT user_id, tweet_date,
      CASE WHEN rno <= 3 THEN ROUND(consecutive_tweets/rno, 2) 
          ELSE ROUND(consecutive_tweets, 2) END AS rolling_avg_3days
FROM tb2



