select * from emp_compensation;

-- pivot
select emp_id,
		sum(case when salary_component_type = 'salary' then val end) as salary,
		sum(case when salary_component_type = 'bonus' then val end) as bonus,
		sum(case when salary_component_type = 'hike_percent' then val end) as hike_percent,
into pivot_emp_compensation
from emp_compensation
group by 1
order by 1;

select * from pivot_emp_compensation;

-- unpivot
select emp_id,
	'salary' as salary_component_type, salary as val --"salary" is OK, refer to column
from pivot_emp_compensation
union all
select emp_id,
	'bonus' as salary_component_type, bonus as val --"bonus" is OK, refer to column
from pivot_emp_compensation
union all
select emp_id,
	'hike_percent' as salary_component_type, hike_percent as val --"hike_percent" is OK, refer to column
from pivot_emp_compensation
order by emp_id