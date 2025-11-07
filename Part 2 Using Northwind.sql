

-- Part 2 Using Northwind :
--------------------------------
--------------------------------

 /* 1-Write a query to rank each customer based on the total value of their orders, with 1 being the highest order value.
		•
		Hint: Use the RANK() window function.
		•
		Expected Columns: CustomerID, TotalOrderValue, Rank */

SELECT 
		O.customer_id,
		SUM(OI.list_price*OI.list_price) AS TotalOrderValue,
		RANK() OVER ( ORDER BY SUM(OI.list_price*OI.list_price)DESC ) AS CustomerRank
FROM sales.orders AS O
INNER JOIN sales.order_items AS OI
	ON O.order_id=OI.order_id
GROUP BY O.customer_id

----------------------------------------------------------------------------------------

/* 2-Write a query to find the second highest unit price of products in each category.
		•
		Hint: Use the DENSE_RANK() window function.
		•
		Expected Columns: CategoryName, ProductName, Price */

WITH product_RANK AS (
SELECT 
		C.category_name,
		P.product_name,
		P.list_price,
		DENSE_RANK() OVER (PARTITION BY C.category_id ORDER BY P.list_price DESC ) AS RANK
FROM production.products AS P
INNER JOIN production.categories AS C
	ON P.category_id=C.category_id

)
SELECT*
FROM product_RANK
WHERE RANK=2

----------------------------------------------------------------------------------------

/* 3-Write a query to calculate the total sales amount each employee made and include a running total (cumulative sum) of these sales.
		•
		Hint: Use SUM() window function with OVER().
		•
		Expected Columns: EmployeeID, TotalSales, CumulativeSales */

SELECT 
		S.staff_id,
		SUM(OI.list_price*OI.quantity) AS total_sales_amount,
		SUM(SUM(OI.list_price*OI.quantity)) OVER (ORDER BY SUM(OI.list_price*OI.quantity) DESC) AS CumulativeSales
FROM sales.staffs AS S
INNER JOIN sales.orders AS O
	ON S.staff_id=O.staff_id
INNER JOIN sales.order_items AS OI
	ON O.order_id=OI.order_id
GROUP BY S.staff_id

----------------------------------------------------------------------------------------

/* 4-Write a query to find the employees whose average order value is higher than the average order value of all employees.
		•
		Hint: Use a subquery to calculate the overall average order value.
		•
		Expected Columns: EmployeeID, AverageOrderValue */

SELECT 
		S.staff_id,
		(SELECT 
		AVG(list_price*quantity)
		FROM sales.order_items)AS Averageorder_value_of_all_employees,
		AVG(OI.list_price*OI.quantity) AS AverageOrderValue
FROM sales.staffs AS S
INNER JOIN sales.orders AS O
	ON S.staff_id=O.staff_id
INNER JOIN sales.order_items AS OI
	ON O.order_id=OI.order_id
GROUP BY S.staff_id
HAVING  AVG(OI.list_price*OI.quantity) > (SELECT AVG(list_price*quantity)FROM sales.order_items)

----------------------------------------------------------------------------------------

/* 5-Write a query to find the employee who processed the most orders each year.
		•
		Hint: Use ROW_NUMBER() to rank employees by the number of orders in each year.
		•
		Expected Columns: EmployeeID, Year, OrderCount */

WITH OrderCount AS (
SELECT 
		S.staff_id AS EmployeeID, 
		YEAR(O.order_date) AS YEAR,
		COUNT(O.order_id) AS OrderCount,
		ROW_NUMBER() OVER (PARTITION BY YEAR(O.order_date) ORDER BY COUNT(O.order_id) DESC ) AS RANK
FROM sales.staffs AS S
INNER JOIN sales.orders AS O
	ON S.staff_id=O.staff_id
GROUP BY S.staff_id ,YEAR(O.order_date)
)
SELECT 
		EmployeeID,
		YEAR,
		OrderCount
FROM OrderCount
WHERE RANK=1

----------------------------------------------------------------------------------------

/* 6-Write a query to find the top 3 most expensive products in each category.
		•
		Hint: Use NTILE() or ROW_NUMBER() to limit the results.
		•
		Expected Columns: CategoryName, ProductName, Price */

WITH product_RANK AS (
SELECT 
		C.category_name,
		P.product_name,
		P.list_price,
		ROW_NUMBER() OVER (PARTITION BY C.category_id ORDER BY P.list_price DESC ) AS RANK
FROM production.products AS P
INNER JOIN production.categories AS C
	ON P.category_id=C.category_id

)
SELECT*
FROM product_RANK
WHERE RANK<=3

----------------------------------------------------------------------------------------