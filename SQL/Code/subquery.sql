SELECT MAX(Salary) FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);


SELECT Salary
FROM (
  SELECT Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) rn
  FROM Employees
)
WHERE rn = 2;


SELECT sod.salesorderid,
       sod.productid,
       sod.orderqty
FROM sales.salesorderdetail sod
WHERE sod.orderqty >
      (SELECT AVG(sod2.orderqty)
       FROM sales.salesorderdetail sod2
       WHERE sod2.productid = sod.productid) limit 10; -- correlated with outer query


SELECT soh.salesorderid,
       soh.customerid,
       soh.totaldue
FROM sales.salesorderheader soh
WHERE soh.totaldue >
      (SELECT AVG(soh2.totaldue)
       FROM sales.salesorderheader soh2
       WHERE soh2.customerid = soh.customerid) limit 10;
--#######################################################ß
-- 1. Single-row subquery
-- Returns only one value (scalar result).
-- Find employees who earn more than the average salary

SELECT BusinessEntityID, '' as JobTitle, Rate
FROM HumanResources.EmployeePayHistory
WHERE Rate > (
    SELECT AVG(Rate)
    FROM HumanResources.EmployeePayHistory
);

-- 2. Multi-row subquery
-- Returns multiple values.
--  Used with operators like IN, ANY, ALL.
-- Find customers who placed orders in 2013
SELECT CustomerID, PersonID
FROM Sales.Customer
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Sales.SalesOrderHeader
    WHERE DATE_PART('year', OrderDate) = 2013
);


-- 3. Correlated subquery
-- The inner query depends on the outer query row by row.
-- Find sales orders where order qty is greater than the average order qty of that product
SELECT SalesOrderID, ProductID, OrderQty
FROM Sales.SalesOrderDetail sod
WHERE OrderQty > (
    SELECT AVG(OrderQty)
    FROM Sales.SalesOrderDetail
    WHERE ProductID = sod.ProductID
) limit 10;




-- 4. Subquery in SELECT clause
-- Used to derive a computed column. LineTotal /LineTotal
-- For each order, show total amount along with average order amount
SELECT SalesOrderID,
       SUM(unitprice) AS TotalOrderAmount,
       (SELECT AVG(unitprice) FROM sales.SalesOrderDetail) AS AvgOrderAmount
FROM sales.SalesOrderDetail
GROUP BY SalesOrderID;



-- 5. Subquery in FROM clause (Inline view)
-- Treats subquery as a temporary table.
-- Find top 5 products with the highest sales
SELECT  ProductID, TotalSales
FROM (
    SELECT ProductID, SUM(unitprice) AS TotalSales
    FROM Sales.SalesOrderDetail
    GROUP BY ProductID
) AS ProductSales
ORDER BY TotalSales DESC LIMIT 5;


-- 6. Subquery with EXISTS
-- Checks if rows exist in subquery result.
-- Find customers who have placed at least one order
SELECT CustomerID, PersonID
FROM Sales.Customer c
WHERE EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader soh
    WHERE soh.CustomerID = c.CustomerID
);

