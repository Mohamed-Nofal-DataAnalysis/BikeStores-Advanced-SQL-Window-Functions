# BikeStores Advanced SQL – Window Functions Mastery

![SQL](https://img.shields.io/badge/Level-Advanced-blueviolet)
![Window Functions](https://img.shields.io/badge/Window_Functions-6-critical)
![Database](https://img.shields.io/badge/DB-BikeStores-orange)
![License](https://img.shields.io/badge/License-MIT-green)
![Stars](https://img.shields.io/github/stars/yourname/BikeStores-Advanced-SQL-Window-Functions?style=social)

**6 interview-killing SQL queries** using the most powerful Window Functions:
`RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, Cumulative SUM, Subqueries + HAVING

Perfect for **Senior Data Analyst** & **BI Developer** interviews!

## Queries Included

| # | Challenge | Window Function Used |
|---|--------- |-----------------------|
| 1 | Rank customers by total order value | `RANK()` |
| 2 | 2nd most expensive product per category | `DENSE_RANK()` |
| 3 | Running total of employee sales | `SUM() OVER()` |
| 4 | Employees above overall average order value | Subquery + `HAVING` |
| 5 | Top employee per year by order count | `ROW_NUMBER()` |
| 6 | Top 3 most expensive products per category | `ROW_NUMBER()` |

## Usage Example

### Customer Ranking by Total Order Value
```sql
SELECT
    O.customer_id,
    SUM(OI.list_price * OI.quantity) AS TotalOrderValue,
    RANK() OVER (ORDER BY SUM(OI.list_price * OI.quantity) DESC) AS CustomerRank
FROM sales.orders AS O
INNER JOIN sales.order_items AS OI ON O.order_id = OI.order_id
GROUP BY O.customer_id
ORDER BY CustomerRank;

How to Run

Download BikeStores DB: https://www.sqlservertutorial.net/sql-server-sample-database/
Run in SSMS, Azure Data Studio, or MySQL Workbench

Pro Tips

Add these indexes for lightning speed:
CREATE INDEX idx_orders_staff ON sales.orders(staff_id);
CREATE INDEX idx_order_items_price ON sales.order_items(list_price DESC);

Contributing
Fork → Add your crazy window function query → PR → Become a legend
License
MIT © 2025 SQL Ninjas Community
Star if these queries just saved your interview!
