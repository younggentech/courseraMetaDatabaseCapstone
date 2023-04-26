Setting up a repository


**Week2**

Part 1.

Task 1. In the first task, Little Lemon need you to create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2.

```
CREATE VIEW OrdersView AS 
SELECT OrderID, Quantity, TotalCost FROM Orders WHERE Quantity > 2;
```


Task 2.

For your second task, Little Lemon need information from four tables on all customers with orders that cost more than $150

```
SELECT Customer.CustomerID, Customer.Name, Orders.OrderID, Orders.TotalCost, Menu.Cuisine, MenuItem.ItemName 
FROM Orders 
INNER JOIN Bookings ON (Bookings.Orders_OrderID = Orders.OrderID) 
INNER JOIN Customer ON (Bookings.Customer_CustomerID = Customer.CustomerID) 
INNER JOIN OrderItems ON (OrderItems.Orders_OrderID = Orders.OrderID) 
INNER JOIN MenuItem ON (OrderItems.MenuItem_MenuItemID = MenuItem.MenuItemID)
INNER JOIN Menu ON MenuItem.Menu_MenuID = Menu.MenuID 
WHERE Orders.TotalCost > 150;
```


Task 3.
```
SELECT ItemName FROM MenuItem WHERE 
(SELECT COUNT(MenuItem_MenuItemID) 
FROM OrderItems 
INNER JOIN MenuItem ON
MenuItem.MenuItemID=OrderItems.MenuItem_MenuItemID) > 2;
```

Part 2.

Task 1.

In this first task, Little Lemon need you to create a procedure that displays the maximum ordered quantity in the Orders table.

```
CREATE PROCEDURE IF NOT EXISTS GetMaxQuantity() SELECT MAX(Quantity) FROM Orders;
```

Task 2.

In the second task, Little Lemon need you to help them to create a prepared statement called GetOrderDetail. This prepared statement will help to reduce the parsing time of queries. It will also help to secure the database from SQL injections.

The prepared statement should accept one input argument, the CustomerID value, from a variable. 

The statement should return the order id, the quantity and the order cost from the Orders table. 



```
PREPARE GetOrderDetail FROM 
'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE OrderID=?';
```

Task 3.

Your third and final task is to create a stored procedure called CancelOrder. Little Lemon want to use this stored procedure to delete an order record based on the user input of the order id.

Creating this procedure will allow Little Lemon to cancel any order by specifying the order id value in the procedure parameter without typing the entire SQL delete statement. 

```
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS CancelOrder(IN ID INT)
BEGIN
DELETE FROM Orders WHERE OrderID=ID;
SELECT CONCAT('Order ', ID, ' is cancelled') AS Confirmation;
END//

DELIMITER ;
```

Table booking section.

Task 1.

Little Lemon wants to populate the Bookings table of their database with some records of data. Your first task is to replicate the list of records in the following table by adding them to the Little Lemon booking table. 

```
INSERT INTO Customer (CustomerID, Name, Email, PhoneNumber) VALUES (1, "test", "test@test.com", 123), (2, "test1", "test1@test.com", 223), (3, "test3", "test3@test.com", 323);

INSERT INTO OrderDeliveryStatus (OrderDeliveryStatusID, DeliveryDate, Status) VALUES (1, '2022-10-10', 'Done');

INSERT INTO Orders (OrderID, OrderDate, Quantity, TotalCost, OrderDeliveryStatus_OrderDeliveryStatusID) VALUES (1, "2022-10-10", 1, 100, 1);

INSERT INTO Staff (StaffID, Name, Position, AnnualSalary) VALUES (1, "Alex", "Waiter", 12000);

INSERT INTO Bookings 
(BookingID, Customer_CustomerID, Orders_OrderID, TabbleNum, BookingDate, Staff_StaffID) 
VALUES 
(1, 1, 1, 5, '2022-10-10', 1), 
(2, 3, 1, 3, '2022-11-12', 1),
(3, 2, 1, 2, '2022-10-11', 1), 
(4, 1, 1, 2, '2022-10-13', 1);

SELECT BookingID, BookingDate, TabbleNum, Customer_CustomerID AS CustomerID FROM Bookings;
```


Task 2.

For your second task, Little Lemon need you to create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.

```
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS CheckBooking(IN Date DATETIME, IN Tabble INT)
BEGIN
SELECT
CASE
WHEN EXISTS (SELECT BookingID FROM Bookings WHERE BookingDate=Date AND TabbleNum=Tabble) THEN CONCAT("Table ", Tabble, " is already booked for ", Date) 
ELSE CONCAT("Table ", Tabble, " is free for ", Date) 
END AS "Booking status";
END//

DELIMITER ;
```

Task 3.

For your third and final task, Little Lemon need to verify a booking, and decline any reservations for tables that are already booked under another name. 

Since integrity is not optional, Little Lemon need to ensure that every booking attempt includes these verification and decline steps. However, implementing these steps requires a stored procedure and a transaction. 

To implement these steps, you need to create a new procedure called AddValidBooking. This procedure must use a transaction statement to perform a rollback if a customer reserves a table that’s already booked under another name.  

```
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS AddValidBooking(
    IN Date DATETIME, 
    IN NumTable INT
)
BEGIN
    DECLARE Bid INT;
    SET @Bid = (SELECT MAX(BookingID) FROM Bookings);
    START TRANSACTION;
    CASE
        WHEN NOT EXISTS (SELECT BookingID FROM Bookings WHERE BookingDate=Date AND TabbleNum=NumTable)
        THEN
        INSERT INTO Bookings (BookingID, Customer_CustomerID, Orders_OrderID, TabbleNum, BookingDate, Staff_StaffID) VALUES (@Bid+1, 1, 1, NumTable, Date, 1);
        SELECT CONCAT("Table ", NumTable, " is successfully booked for ", Date) AS "Booking status";
        COMMIT;
        ELSE
        SELECT CONCAT("Table ", NumTable, " is already booked for ", Date, " - booking canceled") AS "Booking status";
        ROLLBACK;
    END CASE;
END //

DELIMITER ;

CALL AddValidBooking('2022-10-10', 5);
CALL AddValidBooking('2022-10-10', 6);
SELECT * FROM Bookings;
```

Exercise: Create SQL queries to add and update bookings

Task 1.

In this first task you need to create a new procedure called AddBooking to add a new table booking record.

```
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS
AddBooking(
    IN BID INT,
    IN CID INT,
    IN TableNum INT,
    IN Date DATETIME
)
BEGIN
    INSERT INTO Bookings 
    (BookingID, Customer_CustomerID, Orders_OrderID, TabbleNum, BookingDate, Staff_StaffID) 
    VALUES (BID, CID, 1, TableNum, Date, 1);
    SELECT "New Booking Added" AS Confirmation;
END//

DELIMITER ;

CALL AddBooking(6, 3, 4, "2022-12-30");
SELECT * FROM Bookings;
```

Task 2.

For your second task, Little Lemon need you to create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table.

The procedure should have two input parameters in the form of booking id and booking date. You must also include an UPDATE statement inside the procedure. 

```
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS UpdateBooking(
    IN BID INT,
    IN Date DATETIME
)
BEGIN
    UPDATE Bookings SET BookingDate=Date WHERE BookingID=BID;
    SELECT CONCAT("Booking ", BID, " Updated") AS Confirmation;
END//

DELIMITER ; 

SELECT * FROM Bookings;
```

Task 3.

For the third and final task, Little Lemon need you to create a new procedure called CancelBooking that they can use to cancel or remove a booking.

The procedure should have one input parameter in the form of booking id. You must also write a DELETE statement inside the procedure. 

```
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS CancelBooking(
    IN BID INT
)
BEGIN
    DELETE FROM Bookings WHERE BookingID=BID;
    SELECT CONCAT("Booking ", BID, " Cancelled") AS Confirmation;
END//

DELIMITER ;

SELECT * FROM Bookings;
```