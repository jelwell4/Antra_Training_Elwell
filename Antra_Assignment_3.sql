use Northwind


--Use Northwind database. All questions are based on assumptions described by the Database Diagram sent to you yesterday. 
--When inserting, make up info if necessary. Write query for each step. Do not use IDE. BE CAREFUL WHEN DELETING DATA OR DROPPING TABLE.

--1.      Create a view named “view_product_order_[your_last_name]”, 
--        list all products and total ordered quantity for that product.
GO
CREATE VIEW view_product_order_Elwell
AS
SELECT p.ProductName, SUM(od.Quantity) AS QuantitySum
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
GO

--DROP VIEW view_product_order_Elwell

SELECT p.ProductName, p.QuantitySum
FROM view_product_order_Elwell p
ORDER BY p.ProductName

--2.      Create a stored procedure “sp_product_order_quantity_[your_last_name]” 
--        that accept product id as an input and total quantities of order as output parameter.

GO
CREATE PROC sp_product_order_quantity_Elwell
@id int,
@quantity int out
AS
BEGIN
SELECT @quantity = Sum(od.Quantity) FROM [Order Details] od WHERE od.ProductID = @id
END

--DROP PROC sp_product_order_quantity_Elwell

BEGIN 
DECLARE @quantity2 int
EXEC sp_product_order_quantity_Elwell 2, @quantity2 out
PRINT @quantity2
END 

--3.      Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name 
--        as an input and top 5 cities that ordered most that product combined with the total quantity of 
--        that product ordered from that city as output.

DROP PROC sp_product_order_city_Elwell

GO
CREATE PROC sp_product_order_city_Elwell
@pName varChar(20),
@cityAndQuantity varChar(20) out
AS
BEGIN

SELECT TOP 5  o.ShipCity, p.ProductName , SUM(od.Quantity)
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE p.ProductName = @pName
GROUP BY p.ProductName, o.ShipCity
ORDER BY SUM(od.Quantity) DESC

END

BEGIN
DECLARE @output1 varChar(20)
EXEC sp_product_order_city_Elwell 'Chang', @output1 out
PRINT @output1  
END


SELECT  p.ProductName, o.ShipCity, COUNT(o.OrderID) AS OrderCount
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductName, o.ShipCity


--4.      Create 2 new tables “people_your_last_name” “city_your_last_name”. City table has two records: 
--        {Id:1, City: Seattle}, {Id:2, City: Green Bay}. People has three records: {id:1, Name: Aaron Rodgers, City: 2},
--        {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}. Remove city of Seattle.
--        If there was anyone from Seattle, put them into a new city “Madison”. 
--        Create a view “Packers_your_name” lists all people from Green Bay. If any error occurred, no changes should be made to DB. 
--        (after test) Drop both tables and view.




CREATE TABLE city_Elwell
(
cityId int Primary Key,
cityName varChar(20) not null
)

CREATE TABLE people_Elwell
(
peopleId int Primary Key,
peopleName varChar(20) not null,
cityLocation int FOREIGN KEY REFERENCES city_Elwell(cityId)
)



INSERT INTO city_Elwell VALUES(1, 'Seattle')
INSERT INTO city_Elwell VALUES(2, 'Green Bay')
INSERT INTO people_Elwell VALUES(1, 'Aaron Rodger', 2)
INSERT INTO people_Elwell VALUES(2, 'Russell Wilson', 1)
INSERT INTO people_Elwell VALUES(3, 'Jody Nelson', 2)


UPDATE city_Elwell
SET cityName = 'Madison'
WHERE cityId = 1


GO
CREATE VIEW Packers_Jacob
AS
SELECT pe.peopleName
FROM city_Elwell ce JOIN people_Elwell pe ON ce.cityId = pe.cityLocation
WHERE ce.cityName = 'Green Bay'
GO

--DELETE FROM people_Elwell WHERE peopleId = 1 OR peopleID = 2 OR peopleId = 3
--DELETE FROM city_Elwell WHERE cityId = 1 OR cityId = 2
DROP TABLE city_Elwell
DROP TABLE people_Elwell
DROP TABLE view_product_order_Elwell


--5.       Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table
--         “birthday_employees_your_last_name” and fill it with all employees that have a birthday on Feb.
--         (Make a screen shot) drop the table. Employee table should not be affected.

CREATE PROC sp_birthday_employees_Elwell
AS

BEGIN

SELECT * INTO birthday_employees_Elwell
FROM Employees e WHERE MONTH (BirthDate) = '02'

END

BEGIN
EXEC sp_birthday_employees_Elwell
END

SELECT * FROM birthday_employees_Elwell

DROP TABLE birthday_employees_Elwell
DROP PROC sp_birthday_employees_Elwell

--6.      How do you make sure two tables have the same data?
--		  If I full join and there are no null values for the shared keys, then they have the same data, else they don't
