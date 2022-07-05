use BikeStores
go

/*
	The following query returns data from the sales.sales_summary table:
*/


SELECT
	*
FROM
	sales.sales_summary
ORDER BY
	brand,
	category,
	model_year;


/*
For example, the following query defines a grouping set that includes brand and category which is denoted as (brand, category). 
The query returns the sales amount grouped by brand and category:
*/
SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    category
ORDER BY
    brand,
    category;

/*
	The following query returns the sales amount by brand. It defines a grouping set (brand):
*/

SELECT
    brand,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand
ORDER BY
    brand;

/*
	The following query returns the sales amount by category. It defines a grouping set (category):
*/

SELECT
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    category
ORDER BY
    category;

/*
	The following query defines an empty grouping set (). It returns the sales amount for all brands and categories.
*/

SELECT
    SUM (sales) sales
FROM
    sales.sales_summary;

/*

The four queries above return four result sets with four grouping sets:

(brand, category)
(brand)
(category)
()

To get a unified result set with the aggregated data for all grouping sets, you can use the UNION ALL operator.

Because UNION ALL operator requires all result set to have the same number of columns, 
you need to add NULL to the select list to the queries like this:

*/

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    category
UNION ALL
SELECT
    brand,
    NULL,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand
UNION ALL
SELECT
    NULL,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    category
UNION ALL
SELECT
    NULL,
    NULL,
    SUM (sales)
FROM
    sales.sales_summary
ORDER BY brand, category;

/*

	The query generated a single result with the aggregates for all grouping sets as we expected.

	However, it has two major problems:

	The query is quite lengthy.
	The query is slow because SQL Server needs to execute four subqueries and combines the result sets into a single one.
	To fix these problems, SQL Server provides a subclause of the GROUP BY clause called GROUPING SETS.

	The GROUPING SETS defines multiple grouping sets in the same query. The following shows the general syntax of the GROUPING SETS:

	This query creates four grouping sets:

	SELECT
	column1,
	column2,
	aggregate_function (column3)
	FROM
	table_name
	GROUP BY
	GROUPING SETS 
	(
		(column1, column2),
		(column1),
		(column2),
		()
	);

	You can use this GROUPING SETS to rewrite the query that gets the sales data as follows:
*/

SELECT
	brand,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	GROUPING SETS (
		(brand, category),
		(brand),
		(category),
		()
	)
ORDER BY
	brand,
	category;
/*
	As you can see, the query produces the same result as the one that uses the UNION ALL operator. 
	However, this query is much more readable and of course more efficient.
*/

/*

	GROUPING function
	The GROUPING function indicates whether a specified column in a GROUP BY clause is aggregated or not. It returns 1 for aggregated or 0 for not aggregated in the result set.

	See the following query example:

*/

SELECT
    GROUPING(brand) grouping_brand,
    GROUPING(category) grouping_category,
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    GROUPING SETS (
        (brand, category),
        (brand),
        (category),
        ()
    )
ORDER BY
    brand,
    category;

/*

	The value in the grouping_brand column indicates that the row is aggregated or not, 
	1 means that the sales amount is aggregated by brand, 0 means that the sales amount is not aggregated by brand. 
	The same concept is applied to the grouping_category column.

*/