with tb1 as (
  select user_id, count(post_date) as count_row
  from posts
  where extract('year' from post_date) = 2021
  group by user_id
  having count(post_date) > 1
)

select user_id, max(post_date::date) - min(post_date::date) as days_between
from posts
where user_id in (select user_id from tb1)
group by 1