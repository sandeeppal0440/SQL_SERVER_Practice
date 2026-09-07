----------Retrieve the data 

SELECT*
FROM customers;


------Retrieve each customer's name, country, and score

SELECT 
first_name, country, score
FROM customers;

---Retrieve customer with a score not equal to 0

SELECT*
FROM customers
WHERE score !=0;

---Retrieve customers from Germany

SELECT 
first_name,
country
FROM customers
WHERE country = 'Germany';

--Retrive all the customers and sort the result by the highest score first

SELECT*
FROM customers
ORDER BY score DESC;

--Retrive all the customers and sort the result by the highest score first

SELECT*
FROM customers
ORDER BY score ASC;

--Retrive all the customers and sort the result by the counrty and then by the highest score

SELECT*
FROM customers 
ORDER BY country ASC,
		score DESC;

-- Find the total score for each country

SELECT
	country, 
	sum(score) AS total_score
FROM customers
GROUP BY country;

-- Find the total score and total number of customer for each country

SELECT 
	SUM(score) AS total_score, count(first_name) AS total_customer, country
FROM customers
GROUP BY country;

/*Find the average score for each country 
considering only customers with a score not equal to 0,
and return only those countries with an average score greater than 430*/

SELECT
	country, AVG(score) AS avg_score 
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;

--Return Unique list of all countries

SELECT DISTINCT country
FROM customers;

--Retrieve only 3 customers

SELECT  TOP 3 *
FROM customers;

--Retreive the top 3 customers with the highest score

SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

--Retreive the lowest 2 customers based on the score

SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

-- Get the most 2 recent orders

SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;

--Create a new table call persons with columns: id, persone_name, birth_date, and phone

CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50),
	birth_date DATE,
	phone VARCHAR(15)NOT NULL
CONSTRAINT pk_person PRIMARY KEY(id)
);

SELECT*
FROM persons;

-- Add a new column call email to the persons table

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL;

-- Remove the column phone from the persons table

ALTER TABLE persons
DROP COLUMN phone;

---To Insert the add new records to the table

INSERT INTO customers
(id, first_name, country, score)
VALUES
(7, 'Rohan', NULL, 250),
(8, 'Riya', 'USA', NULL);

INSERT INTO customers
(id, first_name, country, score)
VALUES
(9, 'Hari', 'Germany', 500),
(10, 'Riyanshi', 'USA', 260);

--Insert the data with the help of SELECT
--Insert the data from 'customers' into 'persons'

INSERT INTO persons
(id, person_name, birth_date, email)
SELECT 
	id,
	first_name,
	NULL,
	'Unknown'
FROM customers;

--Update-- change the score of customer with ID 6 to 0.

UPDATE customers
SET score = 0
WHERE id = 6;

--change the score of customer with ID 10 to 0 and update the country to UK.

UPDATE customers
SET score = 0, country = 'UK'
WHERE id = 10;

--update all the customers with a null score by setting their score to 0.

UPDATE customers
SET score = 0
WHERE score is NULL;

-- Delete all customers with an ID greater then 5.

DELETE FROM customers
WHERE id > 5;

--Delete all the data from persons

DELETE FROM persons;

--Retrieve all the customers from Germany

SELECT*
FROM customers
WHERE UPPER(country) = 'GERMANY';

---Retrieve all the customers who are not from Germany

SELECT*
FROM customers
WHERE country <> 'Germany';

-- Retrieve all the customers with a score greater than 500

SELECT*
FROM customers 
WHERE score>500;

-- Retrieve all the customers with a score of 500 or more

SELECT*
FROM customers
WHERE score >= 500;

---Retrieve all the customers with a score less than 500

SELECT*
FROM customers
WHERE score<500;


---Retrieve all the customers with a score of 500 or less

SELECT*
FROM customers
WHERE score<= 500;

-- Retrieve all the customers who are from the USA and have a score greater than 500

SELECT*
FROM customers 
WHERE country = 'USA' AND score>500;

--Retrieve all the customers who are either from the USA or have a score greater than 500

SELECT*
FROM customers 
WHERE country='USA' OR score >500;

--Rerieve all the customers with a score not less than 500

SELECT*
FROM customers
WHERE NOT score < 500;

--Retrieve all the customers whose score falls in the range between 100 to 500

SELECT*
FROM customers
WHERE score BETWEEN 100 AND 500;


--Reterieve all the customers either from germany and USA

SELECT*
FROM customers 
WHERE country NOT IN ('Germany','USA');

--find the all customers whose first name starts with M

SELECT *
FROM customers
WHERE first_name LIKE 'M%';

--find the all customers whose first name ends with n

SELECT*
FROM customers
WHERE first_name LIKE '%n';

--find the all customers whose first name contains R

SELECT*
FROM customers
WHERE first_name LIKE '%R%';

--find the all customers whose first name has 'R' in the 3rd position

SELECT*
FROM customers
WHERE first_name LIKE '__r%';

-- Get all the customers along with their orders but only for customers who have placed an order

SELECT
	id, 
	first_name,
	order_id, 
	sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id= o.customer_id;

--Get all the customers along with their orders inclding those without orders.

SELECT
	id, first_name, order_id, sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id;

--Get all the customers along with their orders, including orders without matching customers

SELECT  id, first_name, order_id, sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;

--Get all the customers and all orders, even if there's no match

SELECT id, first_name, o.customer_id, order_id,  sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id;

--Get all customers who haven't placed any order
SELECT 
	id,
	first_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

--Get all the orders without matching customers

SELECT o.customer_id, order_id, sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;

--Find the customerw without orders, and orders without customers

SELECT id, first_name, order_id, sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE 
	o.customer_id IS NULL
	OR c.id IS NULL;

/*Get all the customer alongs with their orders,
but only for customer who have placed an order(wihtout using INNER JOIN)*/

SELECT id, first_name, order_id, sales
FROM customers AS c
LEFT JOIN orders AS o
On c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

--Generate all possible combination of customers and orders.

SELECT id, first_name, order_id, sales
FROM customers AS c
CROSS JOIN orders AS o;

/*Task:- Using SalesDB, Retrieve a list of all order,
along with the related customer, product, and employee details. 
For each order, display: OrderID, Sales, customers name, Product name, price, and sales person's name */

SELECT 
o.orderID,
o.sales,
c.FirstName AS CustomerFirstName,
c.LastName AS CustomerLastName,
p.Price, 
p.Product AS Product_Name,
e.FirstName AS SalesFirstName,
e.LastName AS SalesLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
On o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS P
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
On o.SalesPersonID = e.EmployeeID;

--SELF JOIN:	

CREATE TABLE Employees (
    employee_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT
);
INSERT INTO Employees
(employee_id, employee_name, department, salary, manager_id)
VALUES
(101, 'Arjun',  'IT',        90000, NULL),
(102, 'Neha',   'IT',        65000, 101),
(103, 'Rohan',  'IT',        60000, 101),
(104, 'Priya',  'Finance',   85000, NULL),
(105, 'Karan',  'Finance',   55000, 104),
(106, 'Sneha',  'Finance',   52000, 104),
(107, 'Vikas',  'HR',        75000, NULL),
(108, 'Anjali', 'HR',        50000, 107),
(109, 'Rahul',  'IT',        58000, 102),
(110, 'Pooja',  'IT',        54000, 103),
(111, 'Aman',   'Finance',   48000, 105),
(112, 'Meera',  'HR',        47000, 108);

--Display each employee along with their manager's name.

SELECT
	e.employee_id,
	e.employee_name AS EmpName,
	m.employee_name AS ManagerName
FROM Employees e
JOIN Employees m
ON e.manager_id = m.employee_id;

SELECT 
    e.employee_id,
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;

--Display employees whose salary is less than their manager's salary.

SELECT 
	e.employee_name AS EmpName,
	e.salary AS EmpSalary,
	m.employee_name AS ManName,
	m.salary AS ManSalary
FROM Employees AS e
JOIN Employees AS m
ON m.employee_id = e.manager_id
WHERE e.salary < m.salary;

--Find employees who belong to the same department as their manager.

SELECT 
	e.employee_name AS EmpName,
	m.employee_name AS ManagerName,
	m.department AS ManagerDepartment
FROM Employees e
JOIN Employees m
ON m.employee_id = e.manager_id
WHERE e.department = m.department;

-- SET Operators--
--Combine the data from employess and customer into one table

SELECT
	FirstName, 
	LastName
FROM Sales.Employees
UNION
SELECT
	FirstName, 
	LastName
FROM Sales.Customers ;

--Combine the data from employees and customers into one table including duplicates.

SELECT FirstName, LastName
FROM Sales.Employees
UNION ALL 
SELECT FirstName, LastName
FROM Sales.Customers;

--Find the employees who are not customers at the same time.

SELECT 
	FirstName, 
	LastName
FROM Sales.Employees
EXCEPT 
SELECT 
	FirstName, 
	LastName
FROM Sales.Customers;

--Find the employees who are also customers.

SELECT 
	FirstName, 
	LastName
FROM Sales.Employees
INTERSECT 
SELECT 
	FirstName, 
	LastName
FROM Sales.Customers;

/*Orders are stored in separate table (orders and ordersArchive).
Combine all orders into report without duplicates.*/

SELECT *
FROM Sales.Orders
UNION
SELECT*
FROM Sales.OrdersArchive;

--String Functions
--1.CONCAT function:-	Show a list of customers first name togther with their country name

SELECT CONCAT(FirstName, ' ', Country) AS Full_Name
FROM Sales.customers;

--2. UPPER function:- Tranform the customer's first name to Uppercase.

SELECT UPPER(first_name) AS upper_name
FROM customers;

--3. LOWER function:-	Tranform the customer's first name to lowercase.

SELECT LOWER(first_name) AS lower_name
FROM customers;

--4. TRIM:-	 Find the customers whose first name contains leading, and trailing spaces.

SELECT first_name
FROM customers
WHERE first_name != TRIM(first_name);

--5. REPLACE:-	Remove (-)dashes from phone number.

SELECT 
'123-456-6789' AS phone,
REPLACE('123-456-6789', '-', '') AS Mobile;

--6. LEN:-	Calculate the length of each customers first name.

SELECT LEN(first_name)
FROM customers;

--7. LEFT:-	Retrieve the first two characters of each first name.

SELECT first_name, LEFT(first_name, 2)
FROM customers;

--8. RIGHT:-	Retrieve the last two characters of each first name.

SELECT first_name, RIGHT(first_name, 2) AS last_name
FROM customers;

--9. SUBSTRING:-	Retrive a list of customers first names removing the first character. 

SELECT 
	first_name, SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS New_name
FROM customers;

--10. CHARINDEX/POSITION:-	Find the position of R in first name for each customer

SELECT 
	first_name, CHARINDEX('r', first_name) AS pos
FROM customers;

--NUMERIC function
--11. ROUND:- 

SELECT 
3.156 AS num, 
ROUND(3.156, 2) AS round_2,
ROUND(3.156, 1) AS round_1,
ROUND(3.156, 0) AS round_0;

--11.A.		ABS:- convert a string from negative to positive.

SELECT -10 AS neg, 
ABS(-10) AS positive;

---DATE & TIME function---

--12. DAY, MONTH, YEAR
SELECT 
	OrderID, 
	CreationTime,
	YEAR(CreationTime) AS year,
	MONTH(CreationTime) AS month,
	DAY(CreationTime) AS day
FROM Sales.Orders;

--13. GETNAME():-	it is used to find the current date and time acc to sqlserver.

SELECT GETDATE() AS datetime;

--14. DATEPART():-	it is used to extract specific day, year, hour, month, qtr, week, many more.

SELECT 
	OrderDate,
	OrderID, 
	CreationTime, 
	DATEPART(weekday, CreationTime) AS week_day,
	DATEPART(quarter, CreationTime) AS qtr,
	DATEPART(day, OrderDate) AS days,
	DATEPART(hour, CreationTime) AS hrs,
	DATEPART(second, creationTime) AS sec,
	DATEPART(week, creationTime) AS week
FROM Sales.Orders

--15. DATENAME():-	it returns the specific part of date like weekday, and month into string in char type.

SELECT 
	OrderDate,
	OrderID, 
	CreationTime, 
	DATENAME(weekday, CreationTime) AS week_day,
	DATENAME(month, creationTime) AS months
FROM Sales.Orders

--16. DATETRUNC():- It truncate date, datetime value specified date part

SELECT 
	OrderDate,
	OrderID, 
	CreationTime, 
	DATETRUNC(day, CreationTime) AS day,
	DATETRUNC(year, CreationTime) AS year,
	DATETRUNC(month, CreationTime) AS month,
	DATETRUNC(hour, CreationTime) AS hrs,
	DATETRUNC(minute, CreationTime) AS min,
	DATETRUNC(second, CreationTime) AS sec
FROM Sales.Orders

--17. EOMONTH:-	it returns last day of the month.

SELECT 
	orderID, 
	Orderdate,
	EOMONTH(OrderDate) AS EOD
FROM Sales.Orders;

--How many orders were placed each year 

SELECT YEAR(OrderDate),
COUNT(*) AS Nroforders
FROM Sales.Orders
GROUP BY YEAR(OrderDate);

--How many orders were placed each month

SELECT DATENAME(month, OrderDate) AS mnth_name, COUNT(*) AS Nroforder
FROM Sales.orders
GROUP BY DATENAME(month, OrderDate);

--Show all orders that were placed during the month of february.
--1) 

SELECT*
FROM Sales.Orders
WHERE MONTH(OrderDate)=2 ;

--2)
SELECT DATENAME(month, OrderDate) AS mthname, COUNT(*) AS nroforder
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)
HAVING UPPER(DATENAME(month, OrderDate))= 'FEBRUARY'; 

--18. FORMAT:-	
SELECT CreationTime, 
FORMAT(CreationTime, 'dd/MM/yyyy') AS ind_style,
FORMAT(CreationTime, 'MM-dd-yyyy') AS usa_style
FROM Sales.Orders;

--Show CreationTiime using th following format:- Day Wed Jan Q1 2025 12:34:56 PM

SELECT CreationTime,
'Day' + FORMAT(CreationTime, ' ddd MMM') + ' Q' + DATENAME(quarter, CreationTime)+
FORMAT(CreationTime, ' yyyy HH:mm:ss tt') AS Cstmformat
FROM Sales.Orders;

--Numeric format specified 

SELECT 'N' AS FormatType, FORMAT(1234.56, 'N') AS FormattedValue
UNION ALL
SELECT 'P' AS FormatType, FORMAT(1234.56, 'P') AS FormattedValue
UNION ALL
SELECT 'C' AS FormatType, FORMAT(1234.56, 'C') AS FormattedValue
UNION ALL
SELECT 'N0' AS FormatType, FORMAT(1234.56, 'N0') AS FormattedValue
UNION ALL
SELECT 'N1' AS FormatType, FORMAT(1234.56, 'N1') AS FormattedValue;

--19. CONVERT:- it is helps to convert data type 

SELECT CreationTime,
	CONVERT(INT,'500')AS str_to_int,
	CONVERT(VARCHAR, 500)AS int_to_str,
	CONVERT(DATE, CreationTime) AS date, 
	CONVERT(TIME, CreationTime) AS Time, 
	CONVERT(VARCHAR, CreationTime, 32) AS USA_style,
	CONVERT(VARCHAR, CreationTime, 102) AS EURO_style,
	CONVERT(VARCHAR, CreationTime, 109) AS time_date
FROM Sales.orders

---20. CAST

SELECT CreationTime,
	CAST('500' AS INT) AS str_to_int,
	CAST(500 AS VARCHAR)AS int_to_str,
	CAST(CreationTime AS DATE ) AS date, 
	CAST(CreationTime AS TIME) AS Time, 
	CAST('12-08-2026' AS DATETIME2) AS date_time
FROM Sales.orders

--21. DATEADD:-

SELECT OrderID, OrderDate,
	DATEADD(day, -10, OrderDate) AS TenDaysBefore,
	DATEADD(MONTH, 3, OrderDate) AS ThreeMonthslater,
	DATEADD(year, 2, OrderDate) AS TwoYearLater
FROM Sales.Orders;

-- find the today, date & time.

  SELECT CAST(GETDATE() AS TIME) as time

--22. DATEDIFF:-	find the difference between two dates
--Calculate the age of employee

SELECT BirthDate, EmployeeID,
	DATEDIFF(year, BirthDate, GETDATE())
FROM Sales.Employees;

--Find the avarage sipping duration in days for each month

SELECT  
	MONTH(OrderDate),  
	AVG(DATEDIFF(day, OrderDate, ShipDate)) AS Avg_month
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

--Time Gap Aanalysis
--Find the number of days between each order and previous orders.

SELECT OrderDate,
LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(day,LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate)
FROM Sales.Orders

--23. ISDATE:- Validate date and time

SELECT 
	ISDATE(123) Datecheck1,
	ISDATE('2025') Datecheck2,
	ISDATE('2025-12-13') Datecheck3,
	ISDATE('13-01-2025') Datecheck4,
	ISDATE('08') Datecheck5,
	ISDATE('17:03:05') Datecheck6

--NUll functions--
--24. ISNULL/IFNULL:-	it replace the NULL value from specified value

SELECT BillAddress,ShipAddress,
	ISNULL(BillAddress,ShipAddress) new_add
FROM Sales.Orders

--25. COALESCE:- it returns first non null value from a list.

SELECT BillAddress,ShipAddress,
COALESCE(BillAddress,ShipAddress, 'N/A') AS new_add
FROM Sales.Orders

--Find the average score of customer.
SELECT AVG(ISNULL(score, 0)) AS average
FROM Sales.Customers;

SELECT AVG(COALESCE(score, 0)) OVER() AS average
FROM Sales.Customers;

-- Display the full name of customers in a single field 
--by merging their first name and 10 bonus points to each customers score

SELECT CONCAT(FirstName,' ', LastName) fullname, score,
	ISNULL(score, 0)+10 as ScoreWithBonus
FROM Sales.customers;

--Sort the customers from lowest to highest scores, with null appearing last.

SELECT CustomerID, Score
FROM Sales.Customers
ORDER BY ISNULL(score, 999)

SELECT CustomerID, Score
FROM Sales.Customers
ORDER BY CASE WHEN score IS NULL THEN 1 ELSE 0 END, score

--26. NULLIF:-	it returns null if both value are equal otherwise first value.

SELECT ShipAddress,BillAddress,
NULLIF(ShipAddress,BillAddress) AS new_add
FROM Sales.Orders;

--Find the sales price for each order by dividing the sales by the quantity.

SELECT 
	OrderID, 
	Quantity, 
	Sales, 
	Sales/NULLIF(Quantity,0) AS price
FROM Sales.Orders

--27. IS NULL/IS NOT NULL:- Both are opposite IS not returns true if the value is null otherwise False.
--Identify the customers who have no scores.

SELECT*
FROM Sales.Customers
WHERE Score IS NULL;

--List all the customer who have not placed any order

SELECT c.*, o.OrderID
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

----DATA POLICY (using the NULL function during handling null values)---
WITH Orders As(
	SELECT 1 ID, 'A' Category UNION
	SELECT 2, NULL  UNION
	SELECT 3, ''  UNION
	SELECT 4, '  '  
)
SELECT*, 
	TRIM(Category) policy1,
	NULLIF(TRIM(Category), '') policy2,
	COALESCE(NULLIF(TRIM(Category), ''), 'Unknown') policy3
FROM Orders;

---  CASE STATEMENT --------
/*Creat report showing total sales for each of the following categories: High(sales over 50), 
Medium(sales 21-50), and Low(sales 20 or less). Sort the categories from highest sales to lowest.*/

SELECT Category, SUM(Sales) AS total_sales
FROM(
	SELECT OrderID, Sales,
	CASE
		WHEN sales>50 THEN 'High'
		WHEN sales>20 THEN 'Medium'
		ELSE 'Low'
	END AS Category
	FROM Sales.Orders
)t
GROUP BY Category
ORDER BY total_sales DESC;

--Retrieve employees details with gender displayed as full text

SELECT 
EmployeeID, 
FirstName, 
LastName, 
Gender, 
Case
	WHEN Gender = 'M' THEN 'Male'
	ELSE 'Female'
	END as GenderFullText
FROM Sales.Employees;

--Retrieve customer's details with abbreviated country code

SELECT 
CustomerID, 
FirstName, 
LastName, 
Country,
Case
	WHEN Country = 'Germany' THEN 'DE'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'n/a'
END  Country_code
FROM Sales.Customers;

--Find the average scored of customers and treat Nulls as 0, Additionally provide details such as customerID, and LastName.

SELECT CustomerID, LastName, score,
AVG(CASE
		WHEN score IS NULL THEN 0
		ELSE score
	END) OVER() as new_score
FROM Sales.Customers

--How many times each customer has made an order with sales greater than 30.

SELECT CustomerID, 
	SUM(Case
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) AS totalorder
FROM Sales.Orders
GROUP BY CustomerID; 

-----AGGREGATE FUNCTIONS------
--Find the total numbers of customers.

SELECT COUNT(*) AS TotalNrOfCustomer
FROM Sales.Customers;

--Find the total sales of orders.

SELECT SUM(Sales) AS totalsales
FROM Orders;

--Find the average sales of all orders.

SELECT AVG(Sales) AS totalsales
FROM Orders;

--Find the highest score of among customers.

SELECT MAX(Score) AS Highest_score
FROM Customers;

--Find the lowest score of among customers.
SELECT MIN(Score) AS Highest_score
FROM Customers;

---WINDOW functions---
--Find the total sales across all orders.

SELECT 
	SUM(sales) total_sales
FROM Sales.Orders;

--Find the total sales for each product. 
SELECT 
	ProductID, 
	SUM(Sales) TotalSalesByProduct
FROM Sales.Orders
GROUP BY ProductID

--Find the total sales for each product, aditionally provide details such as OrderID, OrderDate.
SELECT 
	OrderID, 
	OrderDate, 
	ProductID, 
	SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSalesByProduct
FROM Sales.Orders;

--Find the total sales for each combination of product and order status.

SELECT 
	ProductID, 
	OrderStatus, 
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS SalesByProductStatus
FROM Sales.Orders;

--Rank Each Order Based on their sales from highest to lowest, additionally provide details such OrderId, OrderDAate.

SELECT 
	OrderId,
	OrderDate, 
	Sales,
	Rank() OVER(ORDER BY Sales DESC) AS RankOrderDesc
FROM Sales.Orders;

----Rank customers base on their total sales.

SELECT 
    CustomerID,
    SUM(Sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS Sales_rank
FROM Sales.Orders
GROUP BY CustomerID

--1. COUNT()
--Check whether the table orders contains any duplicated row
SELECT 
	OrderId, 
	COUNT(*) OVER(PARTITION BY OrderID) checkpk
FROM Sales.Orders;

--2.SUM()
/*Find the total sales acorss all order, and the totale sales for each product, 
additionally provide th details such OorderID, OrderDate.*/

SELECT 
	OrderID, 
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSalesByProduct
FROM Sales.Orders;

--Find the percentage contribution of each product's sales to the total sales.

SELECT 
	OrderID,
	ProductID, 
	Sales, 
	SUM(Sales) OVER() AS totalsales,
	ROUND(CAST(Sales AS FLOAT)/SUM(Sales) OVER() * 100, 2) PercentageOfTotal
FROM Sales.Orders;

--3. AVG()
/*Find the average sales acorss all orders, And find the average sales for each product, 
Additionally provide details such OrderID, OrderDate.*/

SELECT 
	OrderID, 
	OrderDate,
	Sales,
	ProductID, 
	AVG(Sales) Over() Avg_sales,
	AVG(Sales) Over(PARTITION BY ProductID) AvgSalesByProduct
FROM Sales.orders;

--Find the average scores of customers, additionally provide details such CustomerID, and LastName.

SELECT
	CustomerID,
	LastName,
	Score,
	AVG(COALESCE(Score,0)) OVER() AS AvgScoresWithoutNull
FROM Sales.Customers;

--Find the orders where sales are higher than the average sales acorss all orders.

SELECT *
FROM(
	SELECT
		OrderID,
		Sales,
		ProductID,
		AVG(sales) OVER () AvgSales
	FROM Sales.Orders)t
WHERE Sales>AvgSales

--4.) MIN, & 5.)MAX
/* Find the highest & lowest sales acorss all orders and the highest & lowest sales for each product.
additionally provide details such as OrderId, &, OrderDate.*/

SELECT
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSales,
	MIN(Sales) OVER(PARTITION BY ProductID) LowestSales
FROM Sales.Orders

--Show the employee who have highest salary.
SELECT*
FROM(
	SELECT*, 
		MAX(Salary) Over() HighestSalary
	FROM Sales.Employees
	)t
WHERE Salary = HighestSalary;

--Calculate the deviation of each sale from both the minimum and maximum sale amounts.
SELECT
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSales,
	MIN(Sales) OVER(PARTITION BY ProductID) LowestSales,
	Sales-MIN(Sales) OVER(PARTITION BY ProductID) AS DeviationFromMin,
	MAX(Sales) OVER(PARTITION BY ProductID)- Sales AS DeviationFromMax
FROM Sales.Orders

--Calculate moving average of sales for each product over time
--Calculate moving average of sales for each product over time, including only the next orders.
SELECT 
	OrderID, 
	ProductID, 
	OrderDate,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,					     --this is only for avg by product
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,		 --this is running total
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg		 --this is rolling total 
FROM Sales.Orders;

/*Window functions
 1.) ROW_NUMBER():- it assign the unique sequance number based on the order ASC DESC
--Rank the orders based on their sales from highest to lowest.*/

SELECT 
	OrderID, 
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesByRank
FROM Sales.Orders;

--2.) RANK():- it assign the rank number of rows based on the order ASC DESC, also get the gap and assign the same rank for the duplicate rows
--Rank the orders based on their sales from highest to lowest.

SELECT *,
	RANK() OVER(ORDER BY Sales DESC) SalesByRank
FROM Sales.Orders;

--3.) DENS_RANK():- it assign the rank number of rows based on the order ASC DESC, and assign the same rank for the duplicate rows but without leaves gap after ties
--Rank the orders based on their sales from highest to lowest.

SELECT *,
	DENSE_RANK() OVER(ORDER BY Sales DESC) SalesByRank
FROM Sales.Orders;

--Find the top highest sales for each month. (Top N analysis)

SELECT *
FROM(
	SELECT 
		OrderId,	
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSalesForMonth
	FROM Sales.Orders)t
WHERE HighestSalesForMonth = 1;

--Find the lowest 2 customers based on their sales.(Bottom N analysis)

SELECT*
FROM(
	SELECT 
		CustomerID, 
		SUM(Sales)  TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) LowestSalesByRank
	FROM Sales.Orders
	GROUP BY CustomerID)t
WHERE LowestSalesByRank <=2;

--Assign unique IDs to the row of the Orders Archive table.(Unique IDs generative)

SELECT*, 
	ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueIDs
FROM Sales.orders;

--Identify the duplicates rows in the table 'OrdersArchive' and return a clean result without any duplicates. 

SELECT*
FROM(
	SELECT*, 
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER by CreationTime) Rn
	FROM Sales.OrdersArchive)t
WHERE Rn = 1;

--4) NTILE():- it devided rows into bucked based on order.

SELECT*, 
NTILE(2) OVER(ORDER BY Sales) Bucket2,
NTILE(3) OVER(ORDER BY Sales) Bucket3,
NTILE(4) OVER(ORDER BY Sales) Bucket4
FROM Sales.Orders;

--Segment all order into 3 categories: high, medium, and low sales.(Data Segementation)

SELECT*,
	CASE Buckets
	WHEN 1 THEN 'High'
	WHEN 2 THEN 'Medium'
	ELSE 'Low'
	END AS SalesSegmentation
FROM(
	SELECT
	OrderID, 
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) Buckets
	FROM Sales.Orders)t;

--In order to export the data divide the orders into 2 group. (Equalizing Load Processing)

SELECT*,
	NTILE(2) OVER(ORDER BY OrderID) Buckets
FROM Sales.Orders;

/* PERCENTAGE BASED RANK FUNCTION
--1) CUME_DIST()
Find the product that fall within the highest 40% of prices*/

SELECT*,
	CONCAT(DistRank * 100, '%') DistRankPerc
FROM(
	SELECT
	Product, 
	Price,
	CUME_DIST() OVER(ORDER BY Price DESC) DistRank
	FROM Sales.Products)t
WHERE DistRank <=0.4;

--2)PERCENTAGE_RANK()
--Find the product that fall within the highest 40% of prices.
	
SELECT*,
	CONCAT(DistRank * 100, '%') DistRankPerc
FROM(
	SELECT
	Product, 
	Price,
	PERCENT_RANK() OVER(ORDER BY Price DESC) DistRank 
	FROM Sales.Products)t
WHERE DistRank <=0.4;

/*WINDOW VALUE FUNCTIONS: 
1) LEAD():- Retruns the value of nexr row followed by current row based on order.
2) LAG():- Retruns the value of Previous row followed by current row based on order.

Analysze the month over month performance by finding the percentage change in 
sales between the current and previous month.*/

SELECT*,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100, 1) as MoM_Percentage
FROM(
	SELECT
		MONTH(OrderDate) AS OrderMonth,
		SUM(Sales) AS CurrentMonthSales,
		LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate))t

--Analyze customer loyalty by ranking customers base on the average numbers of days between orders.

SELECT 
	CustomerID,
	AVG(DaysUntilNextOrder) AvgDays,
	RANK() OVER(ORDER BY ISNULL(AVG(DaysUntilNextOrder), 9999)) RankAvg
FROM(
	SELECT OrderID, 
		CustomerID,
		OrderDate CurrentDate,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
		DATEDIFF(DAY,OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
	FROM Sales.Orders
)t
GROUP BY CustomerID

--3) FIRST_VALUE():- Find the first value for rows based on order but frame is not rquired.
--4) LAST_VALUE():- Find the last value for rows based on order but frame is rquired without frame maybe result is not accurate.

--Find the lowest & Highes sales for each product.
--Find the difference in sales between the current and lowest Sales.

SELECT 
	OrderID, 
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) SalesDifference
FROM Sales.Orders;

--IIF-Inline If:-	It is like CASE but it divides rows based on TRUE & FALSE.

SELECT OrderID, Sales,
IIF(Sales>50 , 'High', 'Low') sales_category
FROM Sales.Orders

--OFFSET Clause:-	it is use to skip the specified rows from the beginning, also we can fetch the specified rows after skip.
--Write a query to skip the first 4 rows from Sales.Orders after sorting by Sales.

SELECT*
FROM Sales.Orders
ORDER BY Sales
	OFFSET 4 ROWS

---OFFSET with FETCH 
SELECT*
FROM Sales.Orders
ORDER BY Sales 
	OFFSET 4 ROWS
	FETCH NEXT 4 ROWS ONLY

/*SUBQUERY:- A query which is written into a query, and it called nested query as well.
1) FROM:-	a subquery into from clause
--Find the product that have a price higher than average price of all products.*/

SELECT*
FROM(
	SELECT 
		ProductID, 
		Price,
		AVG(Price) OVER() AvgPrice
	FROM Sales.Products)t
WHERE Price>AvgPrice;

--Rank customer based on their total amount of sales.

SELECT*,
	RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
FROM(
	SELECT 
		CustomerId,
		SUM(Sales)AS TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
)t;

--2)SELECT:-	subquery in select clause
--Show the ProductID, names, prices, and total number of order.

SELECT
	ProductID,
	Category,
	Price,
	(SELECT COUNT(*) FROM Sales.Orders) AS TotalOrders
FROM Sales.Products;
 
--3)JOINs:- subquery in join clause
--Show all customer details and find the total orders of each cutomers.

SELECT 
	c.*, 
	o.TotalOrders
FROM Sales.Customers c
LEFT JOIN (
	SELECT
		CustomerID, 
		COUNT(*) AS TotalOrders
	FROM Sales.Orders
	GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID;

--4) WHERE:-	Subqueries in WHERE Clause.
--Find the products that have a price higher than the average price of all products.

SELECT ProductID, Price
FROM Sales.Products
WHERE Price >
	(SELECT AVG(Price) FROM Sales.Products)
	 

--IN operator:- Show the details of orders made by customers in Germany.

SELECT*
FROM Sales.Orders
WHERE CustomerID IN (
					SELECT CustomerID
					FROM Sales.Customers
					WHERE Country = 'Germany')

/*NOT IN:-	Show the details of orders who are not made from Germany.*/

SELECT*
FROM Sales.Orders
WHERE CustomerID NOT IN (
					SELECT CustomerID
					FROM Sales.Customers
					WHERE Country = 'Germany')

/* ANY/ALL operators:-	Find female employees whose salaries greater than the salaries of any male employees.*/

SELECT 
	EmployeeID,
	FirstName, 
	Salary
FROM Sales.Employees
WHERE Gender = 'F' AND 
		Salary >ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

--Find female employees whose salaries greater than the salaries of all male employees.

SELECT 
	EmployeeID,
	FirstName, 
	Salary
FROM Sales.Employees
WHERE Gender = 'F' AND 
		Salary >ALL (SELECT Salary FROM Sales.Employees WHERE Gender = 'M')	

--Correlated Subquery:-	Show all customers and find the total orders for each customer.

SELECT*, (SELECT COUNT(*) 
			FROM Sales.Orders o
			WHERE o.CustomerID = c.CustomerID) TotalSales
FROM Sales.Customers c

--Show all details of orders made by customers in germany.

SELECT*
FROM Sales.Orders o
WHERE EXISTS(
			SELECT 1
			FROM Sales.customers c
			WHERE Country = 'Germany'
			AND o.customerID =c.CustomerID)

--CTE(Common Table Expression):-	
--1(i)Standalone CTE:- Find the total sales per customer.

WITH CTE_Total_Sales AS
(	SELECT  
	CustomerID, 
	SUM(Sales) AS TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
)
SELECT 
	c.CustomerID,
	c.FirstName,
	cts.TotalSales
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID;

--Multiple Standalone CTE:- Find the last order date per customer.

WITH CTE_Total_Sales AS
(				SELECT  
				CustomerID, 
				SUM(Sales) AS TotalSales
				FROM Sales.Orders
				GROUP BY CustomerID
),
CTE_Last_Order AS
(				SELECT 
				CustomerID,
				MAX(OrderDate) AS LastOrderDate
				FROM Sales.Orders
				GROUP BY CustomerID
)
SELECT 
	c.CustomerID,
	c.FirstName,
	cts.TotalSales,
	clo.LastOrderDate
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID;

--1(ii)Nested CTE:-	Rank customers base on total sales per customers.

WITH CTE_Total_Sales AS
(				SELECT  
				CustomerID, 
				SUM(Sales) AS TotalSales
				FROM Sales.Orders
				GROUP BY CustomerID
),
CTE_Customer_Rank AS (
					SELECT 
					CustomerID,
					TotalSales,
					RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
					FROM CTE_Total_Sales
)
SELECT 
	c.CustomerID,
	c.FirstName,
	cts.TotalSales,
	cre.CustomerRank
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank cre
ON cre.CustomerID = c.CustomerID;

 --Segment customers bease on their total sales.

 WITH CTE_Total_Sales AS
(				SELECT  
				CustomerID, 
				SUM(Sales) AS TotalSales
				FROM Sales.Orders
				GROUP BY CustomerID
),
CTE_Segment_Sales AS
(					SELECT 
					CustomerID,
					CASE 
					WHEN TotalSales>100 THEN 'High'
					WHEN TotalSales>80 THEN 'Medium'
					ELSE 'Low' 
					END AS SegmentSales
					FROM CTE_Total_Sales
)
SELECT 
	c.CustomerID,
	c.FirstName,
	cts.TotalSales,
	css.SegmentSales
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Segment_Sales css
ON css.CustomerID = c.CustomerID;

--2.) Recursive CTE:-	it works like looping until the condition is met.
--Generate a Sequence of number from 1 to 20

WITH Series AS(
		SELECT 1 AS MyNumber
		UNION ALL 
		SELECT MyNumber + 1
		FROM Series
		WHERE MyNumber<20
)
SELECT*
FROM Series;

--Show the employee hirerarchy by displaying each employees level withn the organisation.

WITH CTE_Employee_Hirerarchy AS
(
	SELECT 
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL
	SELECT 
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level+1
	FROM Sales.Employees e
	INNER JOIN CTE_Employee_Hirerarchy ceh
	ON ceh.EmployeeID = e.ManagerID
)
SELECT*
FROM CTE_Employee_Hirerarchy

-- VIEWS:- How to create a view

CREATE VIEW Sales.V_New_Table AS
(
		SELECT 
		CustomerID,
		Country, 
		Score
		FROM Sales.Customers
		WHERE Country = 'USA'
);

--DROP a view
DROP VIEW IF EXISTS Sales.V_New_Table

--Provides view that combines details from orders, products, and Employees.
 
 CREATE VIEW Sales.V_Order_Details AS (
	 SELECT 
	 o.OrderID,
	 o.OrderDate,
	 o.Sales,
	 o.Quantity,
	 p.Product,
	 p.Category,
	 COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') CustomerName,
	 COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') SalesName,
	 e.Department, 
	 c.Country
	 FROM Sales.Orders o
	 LEFT JOIN Sales.Products p
	 ON p.ProductID = o.ProductID
	 LEFT JOIN Sales.Customers c
	 ON c.CustomerID = o.CustomerID
	 LEFT JOIN Sales.Employees e
	 ON e.EmployeeID = o.SalesPersonID
 );

 --Provide a view for the EU Sales Team that combines details from all tables and excludes data related to the USA.
  
 CREATE VIEW Sales.EU_Sales_Team AS (
	 SELECT 
	 o.OrderID,
	 o.OrderDate,
	 o.Sales,
	 o.Quantity,
	 p.Product,
	 p.Category,
	 COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') CustomerName,
	 COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') SalesName,
	 e.Department, 
	 c.Country AS CustomerCountry
	 FROM Sales.Orders o
	 LEFT JOIN Sales.Products p
	 ON p.ProductID = o.ProductID
	 LEFT JOIN Sales.Customers c
	 ON c.CustomerID = o.CustomerID
	 LEFT JOIN Sales.Employees e
	 ON e.EmployeeID = o.SalesPersonID
	 WHERE Country != 'USA'
 );

 --CTAS(Create Table AS Select)
--Create a table with CTAS and store totalsales for each month.

SELECT 
	DATENAME(month, OrderDate) OrderMonth,
	COUNT(orderID) TotalOrders
INTO Sales.MonthlyOrders						--this is for CTAS
FROM Sales.Orders
GROUP BY DATENAME(month,OrderDate)

--To drop the table
DROP TABLE Sales.MonthlyOrders		

--TEMPORARY TABLES:-	 it stores data until the seesion end.

CREATE TABLE #TempEmployees (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO #TempEmployees
VALUES
(101, 'Arjun', 90000),
(102, 'Neha', 75000);

SELECT *
FROM #TempEmployees;

--Also we can make temporary table like this into query(this syntax only for SQL Server)

SELECT*
INTO #temp_OrderTable
FROM Sales.Orders
WHERE OrderStatus = 'Delivered'

--Stored Procedures
--Step:1	Write a query for US customers find the total numbers of customers and the average score. 

SELECT
		COUNT(*) TotalCustomers,
		AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country='USA';

--Step:2	Turning the query into stored prodcedure.

CREATE PROCEDURE GetCustomerSummary AS
BEGIN
	SELECT
			COUNT(*) TotalCustomers,
			AVG(Score) AvgScore
	FROM Sales.Customers
	WHERE Country='USA'
END;

--Step:-3	Execute the Stored Procedure

EXEC GetCustomerSummary

--Parameters into Procedure

CREATE PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS   --USA is default value is we do not pass anything then it will give USA
BEGIN
	SELECT
			COUNT(*) TotalCustomers,
			AVG(Score) AvgScore
	FROM Sales.Customers
	WHERE Country = @Country
END;

--Excution to see for both country

EXEC GetCustomerSummary;  -- we can still find the USA without writing 

EXEC GetCustomerSummary @Country = 'Germany';

--DROP Procedures
DROP PROCEDURE GetCustomerSummary

--Multiple Statement in procedure

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS
BEGIN
	SELECT
			COUNT(*) TotalCustomers,
			AVG(Score) AvgScore
	FROM Sales.Customers
	WHERE Country = @Country
--Find the total number of orders and total sales.
SELECT 
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country
END;

--Execute the procedure

EXEC GetCustomerSummary; 
EXEC GetCustomerSummary @Country = 'Germany';

--Stored Procedure with Multiple statement, and creating variable, also cleaning NUll Values.

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS
BEGIN

DECLARE @TotalCustomers INT, @AvgScore FLOAT

IF EXISTS (SELECT 1
			FROM Sales.Customers
			WHERE Score IS NULL AND Country = @Country)
BEGIN
	PRINT('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country
END

ELSE
BEGIN
	PRINT('NO NULL scores found');
END

SELECT
	@TotalCustomers = COUNT(*),
	@AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country

PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

SELECT 
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country
END
GO

EXEC GetCustomerSummary; 
EXEC GetCustomerSummary @Country = 'Germany';

--Error Handling in Procedure

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS
BEGIN
	BEGIN TRY

		DECLARE @TotalCustomers INT, @AvgScore FLOAT

	--=========================================
		--STEP:-1	 Prepare & Cleanup Data
	--=========================================
		IF EXISTS (SELECT 1
					FROM Sales.Customers
					WHERE Score IS NULL AND Country = @Country)
		BEGIN
			PRINT('Updating NULL Scores to 0');
			UPDATE Sales.Customers
			SET Score = 0
			WHERE Score IS NULL AND Country = @Country
		END

		ELSE
		BEGIN
			PRINT('NO NULL scores found');
		END

		--=========================================
		--STEP:2	Generating Summary Report
		--=========================================
		--Calculate Total customers and Average Scores for specific country

		SELECT
			@TotalCustomers = COUNT(*),
			@AvgScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country


		PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
		PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

		--Calculate Total Numbers of Orders and Total Sales for specific country
		SELECT 
			COUNT(OrderID) TotalOrders,
			SUM(Sales) TotalSales,
			1/0							--This select for Error.
		FROM Sales.Orders o
		JOIN Sales.Customers c
		ON c.CustomerID = o.CustomerID
		WHERE c.Country = @Country
	END TRY

	BEGIN CATCH
	--==================
	--ERROR Handling
	--==================
		PRINT('An Error Occurred.')
		PRINT('Error Message ' + ERROR_MESSAGE())
		PRINT('Error Procedure ' + ERROR_PROCEDURE())
		PRINT('Error Number ' + CAST(ERROR_NUMBER() AS NVARCHAR))
		PRINT('Error Line ' + CAST(ERROR_LINE() AS NVARCHAR))
	END CATCH
END
GO

EXEC GetCustomerSummary; 
EXEC GetCustomerSummary @Country = 'Germany';

