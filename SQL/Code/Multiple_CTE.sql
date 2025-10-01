/*****************************Use NorthwindDB Database /* Working  */ *******************************************************/
/*Step 1*/
--DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    ProductID INT NOT NULL,
    SalesAmount NUMERIC(10, 2) NOT NULL,
    SaleDate DATE DEFAULT CURRENT_DATE
);
/*Step 2*/

INSERT INTO Sales (ProductID, SalesAmount, SaleDate) VALUES
-- Product 101 sales
(101, 1200.00, '2025-07-01'),
(101, 1800.00, '2025-07-02'),

-- Product 102 sales
(102, 500.00, '2025-07-01'),
(102, 700.00, '2025-07-03'),

-- Product 103 sales
(103, 2200.00, '2025-07-02'),
(103, 2800.00, '2025-07-03'),

-- Product 104 sales
(104, 1500.00, '2025-07-01'),

-- Product 105 sales
(105, 3000.00, '2025-07-02'),
(105, 3200.00, '2025-07-04'),

-- Product 106 sales
(106, 250.00, '2025-07-01');


/* Working  */
 

WITH ProductSales AS (
    -- Step 1: Calculate total sales for each product
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
),
AverageSales AS (
    -- Step 2: Calculate the average total sales across all products
    SELECT AVG(TotalSales) AS AverageTotalSales
    FROM ProductSales
),
HighSalesProducts AS (
    -- Step 3: Filter products with above-average total sales
    SELECT ProductID, TotalSales
    FROM ProductSales
    WHERE TotalSales > (SELECT AverageTotalSales FROM AverageSales)
)

-- Step 4: Rank the high-sales products
SELECT ProductID, TotalSales, RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
FROM HighSalesProducts;


/* Working */

/* SELECT * FROM Employees1 */
	
-- Define a CTE to find employees hired more than 5 years ago
WITH LongTermEmployees AS (
    SELECT Employee_ID,Hire_Date
    FROM Employees1
    --WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5
	WHERE CURRENT_DATE - Hire_Date > 5
)
-- Update salaries by 10% for long-term employees identified in the CTE
UPDATE Employees1
SET  Salary =  Salary * 1.1
WHERE Employee_ID IN (SELECT Employee_ID FROM LongTermEmployees);

/*Merge*/
CREATE TABLE Inventory (
