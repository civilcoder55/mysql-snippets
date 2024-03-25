with target_table as (
	select
		unnest(array [15, 16, 15.5, 1000, 1]) as price
),
MedianTab (MedianWt) as (
	select
		PERCENTILE_CONT(0.5) within group (
			order by
				price
		) as MedianWeight
	from
		target_table
),
DispersionTab (AbsDispersion) as (
	select
		PERCENTILE_CONT(0.5) within group (
			order by
				(Abs(price - MedianWt))
		) as AbsDispersion
	from
		MedianTab
		join target_table on 1 = 1
)
select
	distinct *,
	ABS((price - MedianWt) / AbsDispersion)
from
	target_table
	join DispersionTab on 1 = 1
	join MedianTab on 1 = 1