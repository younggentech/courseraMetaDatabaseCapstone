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