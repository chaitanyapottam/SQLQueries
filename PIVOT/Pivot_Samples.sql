-- Static Pivoting

select * from
(
	select 
		c.category_name, p.product_id, p.model_year
	from production.products p
	join production.categories c on p.category_id = c.category_id
)t
pivot
(
	count(product_id)
	for category_name in
	(
		[Children Bicycles]
		, [Comfort Bicycles]
		, [Cruisers Bicycles]
		, [Cyclocross Bicycles]
		, [Electric Bikes]
		, [Mountain Bikes]
		, [Road Bikes]
	)
) as pivot_table

go

-- Dynamic pivoting
declare @colnames nvarchar(max) = '';
declare @sql nvarchar(max) = '';

select @colnames += QUOTENAME(category_name) + ','from production.categories

set @colnames = LEFT(@colnames, LEN(@colnames) - 1)

set @sql = 
'select * from 
(
	select c.category_name, p.product_id, p.model_year
	from production.products p
	join production.categories c on p.category_id = c.category_id
) t
pivot
(
	count(product_id)
	for category_name in (' + @colnames + ')
) as pivot_table
'

execute sp_executesql @sql