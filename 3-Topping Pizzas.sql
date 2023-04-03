with tb1 as (
	select *,
		row_number() over(order by topping_name) as rnw_order
	from pizza_toppings
)

select DISTINCT concat(p1.topping_name, ',', p2.topping_name, ',', p3.topping_name) as pizza,
		p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost as total_cost
from tb1 p1, tb1 p2, tb1 p3
where p1.rnw_order < p2.rnw_order and  p2.rnw_order < p3.rnw_order
order by total_cost desc