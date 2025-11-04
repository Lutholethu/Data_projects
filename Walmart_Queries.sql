SELECT *
FROM "Walmart";

---------- Data Exploration ------------------
---- how many payment methods do we have
SELECT 
DISTINCT(payment_method)
FROM "Walmart"

----how many branches do we have
SELECT
COUNT(DISTINCT "Branch") AS TOT_Branches
FROM "Walmart"

---- Branch with the highest profit margin
SELECT MAX(profit_margin) AS Highest_profit_margin, "Branch"
FROM "Walmart"
GROUP BY "Branch"
Order by 1 DESC

---- Which payment method is used the most
SELECT payment_method,
COUNT(*)
FROM "Walmart"
GROUP BY 1

---- Total quantity sold and total transaction by each payment method
SELECT COUNT(total) AS tot_transaction, SUM(quantity) AS Tot_qty_sold, payment_method
FROM "Walmart"
GROUP BY 3

---- Identify the highest rated category in each branch, displaying the branch, categorgy, AVG Rating
SELECT *
FROM
	(SELECT "Branch", category,
	AVG (rating) AS avg_rating,
	RANK() OVER(PARTITION BY "Branch" ORDER BY AVG(rating) DESC) AS rank
	FROM "Walmart"
	GROUP BY 1,2
	)
WHERE rank = 1

---- Busiest day at each branch by number of transactions
SELECT *
FROM
(
	SELECT "Branch",
		 TO_CHAR(TO_DATE(date, 'YYYY/MM/DD'), 'DAY') AS Day_name,
		 COUNT(*) as no_transactions,
		 RANK() OVER(PARTITION BY "Branch" ORDER BY COUNT(*) DESC) as rank
	FROM "Walmart"
	GROUP BY 1,2
)
WHERE rank = 1

---- Total quantity of items sold per payment method. list payment method and total quantity
SELECT 
	DISTINCT payment_method,
	SUM (quantity) as qty_sold
FROM "Walmart"
GROUP BY 1

---- Determine the average, minimum and maximum rating of category for each city.
--List the city, average_rating, min_rating and max_rating
SELECT "City", category,
	AVG (rating) AS avg_rating,
	MAX(rating) AS max_rating,
	MIN(rating) AS min_rating
FROM "Walmart"
GROUP BY 1,2

---- Calculate the total profit for each category by considering total_profit as (unit_price * quantity * profit_margin).
--List category and total_profit, ordered from highest to lowest profit.

SELECT 
	DISTINCT (category),
	SUM(unit_price * quantity * profit_margin) as total_profit
	
FROM "Walmart"
GROUP BY 1
ORDER BY 2 DESC

---- Determine the most common payment method for each Branch. Display Branch and the preferred payment method.
SELECT *
FROM
(
	SELECT 
		"Branch",
		payment_method,
		COUNT(*) as no_pay,
		RANK() OVER (PARTITION BY "Branch" ORDER BY COUNT(*) DESC) AS rank
	FROM "Walmart"
	GROUP BY 1,2

)
WHERE rank = 1

---- Group sales into 3 shifts. Morning, Afternoon, evening. Find the shift with highest sales(invoices)

SELECT 
	COUNT(invoice_id) as no_invoices,
	shift
FROM
(
	SELECT *,
		CASE
			WHEN shift_hour <=11 THEN 'Morning'
			WHEN shift_hour >=18 THEN 'Evening'
			ELSE 'Afternoon'
		END AS shift
	
	FROM 
	(
		SELECT 
			EXTRACT(HOUR FROM time::time) as shift_hour,
			invoice_id
		FROM "Walmart"		
	)
)
GROUP BY 2

---- Identify 5 branches with the highest decrease ratio in revenue. Compare 2023 and 2022.
-- revenue decreased ratio(rdr) = last_rev - current_rev/ last_rev *100
WITH revenue_2022
AS
(
SELECT 
	"Branch",
	SUM(total) AS revenue 
FROM "Walmart"
WHERE EXTRACT(YEAR FROM TO_DATE(date, 'YYYY/MM/DD')) = 2022
GROUP BY 1
),

revenue_2023
AS
(
SELECT 
	"Branch",
	SUM(total) AS revenue 
FROM "Walmart"
WHERE EXTRACT(YEAR FROM TO_DATE(date, 'YYYY/MM/DD')) = 2023
GROUP BY 1
)

SELECT 
	last_Year_Rev."Branch",
	last_Year_Rev.revenue as Ls_rev,
	current_year.revenue as Cr_rev,
	ROUND
	(
		(last_Year_Rev.revenue - current_year.revenue)::numeric/last_Year_Rev.revenue::numeric * 100, 2
	
	) AS Revenue_Decrease_Ratio
FROM revenue_2022 as last_Year_Rev
JOIN
revenue_2023 as current_year
ON last_Year_Rev."Branch" = current_year."Branch"
WHERE last_Year_Rev.revenue > current_year.revenue 
ORDER BY 4 DESC
LIMIT 5

