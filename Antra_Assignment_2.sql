use AdventureWorks2019
GO

--1. Write a query that lists the country and province names from person.CountryRegion and
--    person.StateProvince tables. Join them and produce a result set similar to the following.

    --Country                        Province
SELECT cr.Name AS Country
FROM Person.CountryRegion cr

SELECT ps.Name AS [State/Province]
FROM Person.StateProvince ps

-- ANSWER:-------------------------------------
SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
ORDER BY c.Name


--2. Write a query that lists the country and province names from person.CountryRegion and  
--   person.StateProvince tables and list the countries filter them by Germany and Canada.
--   Join them and produce a result set similar to the following.

    --Country                        Province

SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.NAME IN ('Germany', 'Canada')
ORDER BY c.Name


 --Using Northwind Database: (Use aliases for all the Joins)
use Northwind
GO

--3. List all Products that has been sold at least once in last 25 years.
SELECT p.ProductID, p.ProductName
FROM Products p
ORDER BY p.ProductName

SELECT p.ProductID, p.ProductName, o.OrderDate
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY o.OrderDate

SELECT p.ProductID, p.ProductName, o.OrderDate
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >  '1997-07-09'
ORDER BY o.OrderDate

SELECT p.ProductName
FROM Products p
WHERE EXISTS
(SELECT p.ProductName, o.OrderDate 
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate > '1997-07-09')

-- ANSWER:-------------------------------------
SELECT p.ProductName
FROM Products p
WHERE EXISTS
(SELECT p.ProductName, o.OrderDate 
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate > '1997-07-09')
ORDER BY p.ProductName


--4. List top 5 locations (Zip Code) where the products sold most in last 25 years.
-- ANSWER:-------------------------------------
SELECT o.ShipPostalCode, o.OrderID
FROM Orders o
ORDER BY ShipPostalCode

-- Not mine, Another example
select top 5 o.ShipPostalCode, count(o.ShipPostalCode) NumZipCount 
from Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON o.OrderID = od.OrderID 
where o.OrderDate > '1997-07-09' 
group by o.ShipPostalCode 
order by NumZipCount desc

-- ANSWER:-------------------------------------
SELECT TOP 5 o.ShipPostalCode, COUNT(o.OrderID) AS ZipCount
FROM Orders o
WHERE EXISTS
(SELECT o.OrderDate
FROM Orders o
WHERE o.OrderDate > '1997-07-09')
GROUP BY o.ShipPostalCode
ORDER BY ZipCount DESC

SELECT TOP 5 o.ShipPostalCode, COUNT(o.ShipPostalCode) AS ZipCount
FROM Orders o
WHERE EXISTS
(SELECT o.OrderDate
FROM Orders o
WHERE o.OrderDate > '1997-07-09')
GROUP BY o.ShipPostalCode
ORDER BY ZipCount DESC


--5. List all city names and number of customers in that city.
SELECT o.ShipCity, o.CustomerID
FROM Orders o
ORDER BY ShipCity

SELECT o.ShipCity, o.CustomerID, c.ContactName, c.City
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY ShipCity

-- ANSWER:-------------------------------------
SELECT o.ShipCity, COUNT(DISTINCT o.CustomerID) AS CustomerCount
FROM Orders o
GROUP BY o.ShipCity
ORDER BY ShipCity



--6. List city names which have more than 2 customers, and number of customers in that city
WITH CityAndCount
AS
(
SELECT o.ShipCity, COUNT(DISTINCT o.CustomerID) AS CustomerCount
FROM Orders o
GROUP BY o.ShipCity
)
SELECT DISTINCT o.ShipCity, c.CustomerCount
FROM Orders o JOIN CityAndCount c ON o.ShipCity = c.ShipCity
WHERE c.CustomerCount > 2
ORDER BY c.CustomerCount

SELECT o.ShipCity, COUNT(DISTINCT o.CustomerID) AS CustomerCount
FROM Orders o
GROUP BY o.ShipCity
HAVING COUNT(DISTINCT o.CustomerID) > 2 
ORDER BY CustomerCount


--7. Display the names of all customers  along with the  count of products they bought
--Lists Names and all orders
SELECT c.ContactName, o.OrderID
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY c.ContactName



-- Lists 1 name with count of orders
SELECT c.ContactName, COUNT(o.OrderID) AS OrderCount
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY c.ContactName

-- Counts different types of products bought, not quantity 
SELECT c.ContactName, COUNT(od.ProductID) AS BoughtProductCount
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName
ORDER BY c.ContactName


-- Lists the info needed, Name and Quantity
SELECT c.ContactName, od.ProductID, od.Quantity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
ORDER BY c.ContactName, ProductID

-- ANSWER:------------------------------------------------------
SELECT c.ContactName, SUM(od.Quantity) AS ProductBought
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName
ORDER BY c.ContactName


--8. Display the customer ids who bought more than 100 Products with count of products.
-- Info Needed
SELECT c.ContactName, c.CustomerID, SUM(od.Quantity) AS ProductBought
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName, c.CustomerID
ORDER BY ProductBought

-- ANSWER:------------------------------------------------------
WITH ProductQuantity
AS
(
SELECT c.ContactName, c.CustomerID, SUM(od.Quantity) AS ProductBought
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName, c.CustomerID
)
SELECT c.CustomerID, pq.ProductBought
FROM Customers c JOIN ProductQuantity pq ON c.CustomerID = pq.CustomerID
WHERE pq.ProductBought > 100
ORDER BY pq.ProductBought

SELECT c.CustomerID, SUM(od.Quantity) ProductBought 
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON od.OrderID = o.OrderID 
GROUP BY c.CustomerID 
HAVING SUM(Quantity) > 100
ORDER BY ProductBought

--9. List all of the possible ways that suppliers can ship their products. Display the results as below
    --Supplier Company Name                Shipping Company Name
SELECT su.CompanyName AS [Supplier Company Name]
FROM Suppliers su

SELECT sh.CompanyName AS [Shipping Company Name]
FROM Shippers sh

-- ANSWER:--------------------------------------------------------------------------------------------
SELECT DISTINCT su.CompanyName AS [Supplier Company Name], sh.CompanyName AS [Shipping Company Name]
FROM Suppliers su JOIN Products p ON su.SupplierID = p.SupplierID JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID JOIN Shippers sh ON o.ShipVia = sh.ShipperID
ORDER BY su.CompanyName


    ---------------------------------            ----------------------------------


--10. Display the products order each day. Show Order date and Product Name.
SELECT o.OrderDate, p.ProductName
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate 


--11. Displays pairs of employees who have the same job title.
--SELECT e.FirstName, e.LastName
--FROM Employees e

-- Display all combo's?

WITH TitleTable
AS
(
SELECT e.Title, COUNT(e.Title) AS TitleCount
FROM Employees e
GROUP BY e.Title
)
SELECT e.FirstName, e.LastName, e.Title
FROM Employees e JOIN TitleTable t ON e.Title = t.Title
WHERE t.TitleCount >= 2

select FirstName, LastName, Title 
from Employees 
Where Title in 
(Select Title 
from Employees 
group by Title 
Having count(Title)>=2)

--12. Display all the Managers who have more than 2 employees reporting to them.
SELECT e.FirstName, e.ReportsTo, e.EmployeeID
FROM Employees e
ORDER BY e.EmployeeID

-- Returns Total amount of reports to (8)
SELECT COUNT(e.ReportsTo) 
FROM Employees e

-- Return Count of Report to type
SELECT e.ReportsTo
FROM Employees e
ORDER BY e.ReportsTo

-- ANSWER:--------------------------------------------------------------------------------------------
SELECT COUNT(e.FirstName) as EmployeeNum, m.FirstName  as ManagerName
FROM Employees e INNER JOIN Employees m ON e.ReportsTo = m.EmployeeID
GROUP BY m.FirstName
HAVING COUNT(e.FirstName) > 2



--13. Display the customers and suppliers by city. The results should have the following columns

--City--Name--Contact Name,--Type (Customer or Supplier)

SELECT c.City, c.CompanyName, c.ContactName, c.Relationship
FROM [Customer and Suppliers by City] c
ORDER BY c.City


--All scenarios are based on Database NORTHWIND.
--14. List all cities that have both Employees and Customers.
SELECT c.City, c.Relationship
FROM [Customer and Suppliers by City] c
WHERE c.Relationship = 'Customers' OR c.Relationship = 'Suppliers'

SELECT c.City, c.Relationship
FROM [Customer and Suppliers by City] c
WHERE c.Relationship = 'Suppliers'


SELECT c.City, c.Relationship
FROM [Customer and Suppliers by City] c
WHERE c.Relationship = 'Customers'

WITH CustomerTable
AS
(
SELECT c.City, c.Relationship
FROM [Customer and Suppliers by City] c
WHERE c.Relationship = 'Customers'
),
SupplierTable
AS
(
SELECT c.City, c.Relationship
FROM [Customer and Suppliers by City] c
WHERE c.Relationship = 'Suppliers'
)
SELECT DISTINCT c.City, c.Relationship
FROM [Customer and Suppliers by City] c JOIN SupplierTable st ON c.City = st.City JOIN CustomerTable ct ON c.City = ct.City


--- ANSWER-------------------------
WITH CustomerTable
AS
(
SELECT c.City, c.Relationship
FROM [Customer and Suppliers by City] c
WHERE c.Relationship = 'Customers'
),
SupplierTable
AS
(
SELECT c.City, c.Relationship
FROM [Customer and Suppliers by City] c
WHERE c.Relationship = 'Suppliers'
)
SELECT DISTINCT c.City
FROM [Customer and Suppliers by City] c JOIN SupplierTable st ON c.City = st.City JOIN CustomerTable ct ON c.City = ct.City



--15. List all cities that have Customers but no Employee.
--a.  
-- Use
--sub-query
SELECT DISTINCT c.City
FROM Customers c
ORDER BY c.City

SELECT DISTINCT e.City
FROM Employees e
ORDER BY e.City


-- ANSWER--------------------------
WITH CustomerTable
AS
(
SELECT DISTINCT c.City
FROM Customers c
),
EmployeeTable
AS
(
SELECT DISTINCT e.City
FROM Employees e
)
SELECT DISTINCT ct.City
FROM CustomerTable ct LEFT JOIN EmployeeTable et ON ct.City = et.City
WHERE et.City IS NULL


--b. 
    
 --Do
--not use sub-query
SELECT DISTINCT e.City
FROM Employees e

SELECT DISTINCT c.City
FROM Customers c JOIN Employees e ON c.City = e.City

-- ANSWER--------------------
SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL


--16. List all products and their total order quantities throughout all orders.
SELECT p.ProductName
FROM Products p
ORDER BY p.ProductName

SELECT o.OrderID
FROM Orders o
ORDER BY o.OrderID

SELECT p.ProductName, SUM(od.Quantity) AS ProductBought
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY p.ProductName

--17. List all Customer Cities that have at least two customers.

SELECT c.City, COUNT(c.City)
FROM Customers c
GROUP BY c.city
HAVING COUNT(c.city) >= 2
ORDER BY c.City

--a. 
-- Use
--union


--b. 
--Use
--sub-query and no union


--18. List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City, od.ProductID
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
ORDER BY c.City

SELECT c.City, COUNT(od.ProductID)
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(od.ProductID) >= 2
ORDER BY COUNT(od.ProductID)


--19. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
SELECT p.ProductName, o.ShipCity, Count(od.Quantity) AS [Quantity Bought]
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductName, o.ShipCity
ORDER BY p.ProductName

SELECT p.ProductName, o.ShipCity
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductName, o.ShipCity
ORDER BY p.ProductName

WITH CustomerCity
AS
(
SELECT od.ProductID, o.ShipCity, COUNT(od.Quantity) AS QuantityBought
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY od.ProductID, o.ShipCity
)
SELECT TOP 5 p.ProductName, p.UnitPrice, cc.ShipCity, COUNT(o.ShipCity)
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID JOIN CustomerCity cc ON cc.ShipCity = o.ShipCity
GROUP BY p.ProductName, p.UnitPrice, cc.ShipCity
ORDER BY COUNT(o.ShipCity) DESC



--20. List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered
--    from. (tip: join  sub-query)




--21. How do you remove the duplicates record of a table?
--Use DISTINCT or UNION