DROP TABLE Customer cascade constraints;
DROP TABLE MenuItem cascade constraints;
DROP TABLE Orders cascade constraints;
DROP TABLE OrderDetails cascade constraints;
DROP TABLE Transaction cascade constraints;
DROP TABLE FoodStation cascade constraints;
DROP TABLE Staff cascade constraints;
DROP TABLE ComboMeal cascade constraints;
DROP TABLE ComboMealDetail cascade constraints;
DROP TABLE Customization cascade constraints;


CREATE TABLE Customer (
    CustomerID NUMERIC(4) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255),
    RegistrationDate DATE,
    SunPoints NUMERIC DEFAULT 0
);


CREATE TABLE FoodStation (
    StationID VARCHAR(10) PRIMARY KEY,
    StationName VARCHAR(100) NOT NULL,
    OrderType VARCHAR(50),
    StaffCount NUMERIC(2),
    ContactInfo VARCHAR(100),
    StationCategory VARCHAR(50)
);


CREATE TABLE MenuItem (
    ItemID NUMERIC(4) PRIMARY KEY,
    StationID VARCHAR(10),
    ItemName VARCHAR(100) NOT NULL,
    ItemPrice NUMERIC(10,2) NOT NULL,
    ItemCategory VARCHAR(50),
    IsAvailable CHAR(1) DEFAULT 'Y',
    FOREIGN KEY (StationID) REFERENCES FoodStation(StationID)
);


CREATE TABLE Orders (
    OrderID NUMERIC(4) PRIMARY KEY,
    CustomerID NUMERIC(4),
    StationID VARCHAR(10),
    OrderDate DATE,
    PaymentStatus VARCHAR(50),
    TotalAmount NUMERIC(10,2),
    SunPointsEarned NUMERIC(5),
    DiscountApplied NUMERIC(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StationID) REFERENCES FoodStation(StationID)
);


CREATE TABLE OrderDetails (
    OrderDetailID NUMERIC(4) PRIMARY KEY,
    OrderID NUMERIC(4),
    ItemID NUMERIC(4),
    Quantity NUMERIC(3) NOT NULL,
    SubTotal NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID)
);


CREATE TABLE Transaction (
    TransactionID VARCHAR(50) PRIMARY KEY,
    OrderID NUMERIC(4),
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(50),
    AmountPaid NUMERIC(10,2) NOT NULL,
    CardDetails VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


CREATE TABLE Staff (
    StaffID VARCHAR(10) PRIMARY KEY,
    StationID VARCHAR(10),
    StaffName VARCHAR(100) NOT NULL,
    HireDate DATE,
    WorkHours NUMERIC(3),
    Position VARCHAR(50),
    Salary NUMERIC(10,2),
    FOREIGN KEY (StationID) REFERENCES FoodStation(StationID)
);


CREATE TABLE ComboMeal (
    ComboID VARCHAR(10) PRIMARY KEY,
    ComboName VARCHAR(100) NOT NULL,
    BasePrice NUMERIC(10,2) NOT NULL,
    Description VARCHAR(255)
);


CREATE TABLE ComboMealDetail (
    ComboDetailID VARCHAR(10) PRIMARY KEY,
    ComboID VARCHAR(10),
    ItemID NUMERIC(4),
    FOREIGN KEY (ComboID) REFERENCES ComboMeal(ComboID),
    FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID)
);


CREATE TABLE Customization (
    CustomizationID NUMERIC(4) PRIMARY KEY,
    OrderDetailID NUMERIC(4),
    CustomizationDetails VARCHAR(255),
    ModificationType VARCHAR(50),
    ItemSwappedFor VARCHAR(100),
    AdditionalCost NUMERIC(10,2) DEFAULT 0,
    FOREIGN KEY (OrderDetailID) REFERENCES OrderDetails(OrderDetailID)
);



INSERT INTO Customer VALUES (1001, 'Alice Johnson', '123-456-7890', 'alice@mail.com', '123 Sunway Street', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 50);
INSERT INTO Customer VALUES (1002, 'Bob Smith', '234-567-8901', 'bob@mail.com', '456 Moonlight Ave', TO_DATE('2024-02-15', 'YYYY-MM-DD'), 20);
INSERT INTO Customer VALUES (1003, 'Charlie Lee', '345-678-9012', 'charlie@mail.com', '789 Sunset Blvd', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 80);
INSERT INTO Customer VALUES (1004, 'Dana White', '456-789-0123', 'dana@mail.com', '321 Starview Road', TO_DATE('2024-01-25', 'YYYY-MM-DD'), 60);
INSERT INTO Customer VALUES (1005, 'Ethan Hunt', '567-890-1234', 'ethan@mail.com', '654 Adventure St', TO_DATE('2024-02-05', 'YYYY-MM-DD'), 40);
INSERT INTO Customer VALUES (1006, 'Fiona Adams', '678-901-2345', 'fiona@mail.com', '987 Journey Lane', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 90);
INSERT INTO Customer VALUES (1007, 'Grace Kim', '789-012-3456', 'grace@mail.com', '852 Horizon View', TO_DATE('2024-04-10', 'YYYY-MM-DD'), 30);
INSERT INTO Customer VALUES (1008, 'Harry Potter', '890-123-4567', 'harry@mail.com', '111 Wizard Lane', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 70);


INSERT INTO FoodStation VALUES ('FS01', 'Asian Delight', 'Combo Meals', 4, '123-001-4567', 'Asian');
INSERT INTO FoodStation VALUES ('FS02', 'Burger Hub', 'Fast Food', 3, '123-002-5678', 'Western');
INSERT INTO FoodStation VALUES ('FS03', 'Pizza Corner', 'Pizzas', 5, '123-003-6789', 'Italian');
INSERT INTO FoodStation VALUES ('FS04', 'Health Bar', 'Salads', 2, '123-004-7890', 'Healthy');
INSERT INTO FoodStation VALUES ('FS05', 'Dessert House', 'Desserts', 3, '123-005-8901', 'Sweet');
INSERT INTO FoodStation VALUES ('FS06', 'Grill Master', 'BBQ', 4, '123-006-9012', 'BBQ');
INSERT INTO FoodStation VALUES ('FS07', 'Beverage Stop', 'Drinks', 3, '123-007-0123', 'Drinks');
INSERT INTO FoodStation VALUES ('FS08', 'Taco Fiesta', 'Mexican', 3, '123-008-1234', 'Mexican');


INSERT INTO MenuItem VALUES (2001, 'FS01', 'Chicken Fried Rice', 8.99, 'Main Course', 'Y');
INSERT INTO MenuItem VALUES (2002, 'FS02', 'Cheese Burger', 5.49, 'Fast Food', 'Y');
INSERT INTO MenuItem VALUES (2003, 'FS03', 'Pepperoni Pizza', 12.99, 'Pizza', 'Y');
INSERT INTO MenuItem VALUES (2004, 'FS04', 'Caesar Salad', 7.99, 'Healthy', 'Y');
INSERT INTO MenuItem VALUES (2005, 'FS05', 'Chocolate Sundae', 4.99, 'Dessert', 'Y');
INSERT INTO MenuItem VALUES (2006, 'FS06', 'BBQ Ribs', 15.99, 'BBQ', 'Y');
INSERT INTO MenuItem VALUES (2007, 'FS07', 'Lemonade', 2.99, 'Beverage', 'Y');
INSERT INTO MenuItem VALUES (2008, 'FS08', 'Beef Taco', 6.49, 'Mexican', 'Y');


INSERT INTO Orders VALUES (3001, 1001, 'FS01', TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'Paid', 20.97, 5, 1.00);
INSERT INTO Orders VALUES (3002, 1002, 'FS02', TO_DATE('2024-04-11', 'YYYY-MM-DD'), 'Paid', 10.98, 2, 0.50);
INSERT INTO Orders VALUES (3003, 1003, 'FS03', TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'Paid', 25.98, 8, 2.00);
INSERT INTO Orders VALUES (3004, 1004, 'FS04', TO_DATE('2024-04-13', 'YYYY-MM-DD'), 'Paid', 15.98, 4, 1.50);
INSERT INTO Orders VALUES (3005, 1005, 'FS05', TO_DATE('2024-04-14', 'YYYY-MM-DD'), 'Paid', 9.98, 1, 0.25);
INSERT INTO Orders VALUES (3006, 1006, 'FS06', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 'Pending', 31.98, 10, 3.00);
INSERT INTO Orders VALUES (3007, 1007, 'FS07', TO_DATE('2024-04-16', 'YYYY-MM-DD'), 'Paid', 5.98, 2, 0.50);
INSERT INTO Orders VALUES (3008, 1008, 'FS08', TO_DATE('2024-04-17', 'YYYY-MM-DD'), 'Paid', 12.98, 3, 1.00);


INSERT INTO OrderDetails VALUES (4001, 3001, 2001, 2, 17.98);
INSERT INTO OrderDetails VALUES (4002, 3002, 2005, 1, 4.99);
INSERT INTO OrderDetails VALUES (4003, 3003, 2002, 2, 10.98);
INSERT INTO OrderDetails VALUES (4004, 3004, 2003, 2, 25.98);
INSERT INTO OrderDetails VALUES (4005, 3005, 2004, 2, 15.98);
INSERT INTO OrderDetails VALUES (4006, 3006, 2005, 2, 9.98);
INSERT INTO OrderDetails VALUES (4007, 3007, 2006, 2, 31.98);
INSERT INTO OrderDetails VALUES (4008, 3008, 2007, 2, 5.98);
INSERT INTO OrderDetails VALUES (4009, 3001, 2002, 1, 5.49);
INSERT INTO OrderDetails VALUES (4010, 3002, 2006, 2, 31.98);
INSERT INTO OrderDetails VALUES (4011, 3003, 2004, 1, 7.99); 
INSERT INTO OrderDetails VALUES (4012, 3004, 2008, 3, 19.47); 
INSERT INTO OrderDetails VALUES (4013, 3005, 2003, 1, 12.99); 
INSERT INTO OrderDetails VALUES (4014, 3007, 2001, 2, 17.98); 
INSERT INTO OrderDetails VALUES (4015, 3008, 2005, 1, 4.99); 
INSERT INTO OrderDetails VALUES (4016, 3001, 2001, 1, 8.99);
INSERT INTO OrderDetails VALUES (4017, 3001, 2007, 1, 2.99);
INSERT INTO OrderDetails VALUES (4018, 3002, 2002, 1, 5.49);
INSERT INTO OrderDetails VALUES (4019, 3003, 2003, 2, 12.99); 
INSERT INTO OrderDetails VALUES (4020, 3003, 2007, 1, 2.99); 
INSERT INTO OrderDetails VALUES (4021, 3004, 2004, 2, 15.98); 
INSERT INTO OrderDetails VALUES (4022, 3004, 2008, 1, 6.49); 
INSERT INTO OrderDetails VALUES (4023, 3005, 2006, 2, 15.99);
INSERT INTO OrderDetails VALUES (4024, 3005, 2007, 1, 2.99);
INSERT INTO OrderDetails VALUES (4025, 3006, 2002, 2, 10.98);
INSERT INTO OrderDetails VALUES (4026, 3006, 2003, 1, 12.99); 
INSERT INTO OrderDetails VALUES (4027, 3007, 2004, 2, 15.98); 
INSERT INTO OrderDetails VALUES (4028, 3007, 2007, 1, 2.99); 
INSERT INTO OrderDetails VALUES (4029, 3008, 2008, 2, 12.98); 
INSERT INTO OrderDetails VALUES (4030, 3008, 2005, 1, 4.99); 
INSERT INTO OrderDetails VALUES (4031, 3008, 2005, 1, 4.99); 



INSERT INTO Transaction VALUES ('T001', 3001, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'Credit Card', 'Paid', 35.50, '4111111111111111');
INSERT INTO Transaction VALUES ('T002', 3002, TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'Cash', 'Paid', 20.00, 'N/A');
INSERT INTO Transaction VALUES ('T003', 3003, TO_DATE('2024-04-13', 'YYYY-MM-DD'), 'Credit Card', 'Pending', 45.75, '4222222222222222');
INSERT INTO Transaction VALUES ('T004', 3004, TO_DATE('2024-04-15', 'YYYY-MM-DD'), 'Debit Card', 'Paid', 60.00, '4533333333333333');
INSERT INTO Transaction VALUES ('T005', 3005, TO_DATE('2024-04-17', 'YYYY-MM-DD'), 'Credit Card', 'Paid', 50.25, '4444444444444444');
INSERT INTO Transaction VALUES ('T006', 3006, TO_DATE('2024-04-18', 'YYYY-MM-DD'), 'PayPal', 'Paid', 22.50, 'N/A');
INSERT INTO Transaction VALUES ('T007', 3007, TO_DATE('2024-04-20', 'YYYY-MM-DD'), 'Cash', 'Paid', 18.00, 'N/A');
INSERT INTO Transaction VALUES ('T008', 3008, TO_DATE('2024-04-22', 'YYYY-MM-DD'), 'Credit Card', 'Pending', 75.00, '4555555555555555');



INSERT INTO Staff VALUES ('S001', 'FS01', 'John Doe', TO_DATE('2020-03-15', 'YYYY-MM-DD'), 40, 'Cook', 2500.00);
INSERT INTO Staff VALUES ('S002', 'FS02', 'Alice Smith', TO_DATE('2021-06-22', 'YYYY-MM-DD'), 38, 'Waiter', 2200.00);
INSERT INTO Staff VALUES ('S003', 'FS03', 'Bob Johnson', TO_DATE('2019-11-10', 'YYYY-MM-DD'), 45, 'Manager', 3000.00);
INSERT INTO Staff VALUES ('S004', 'FS04', 'Charlie Brown', TO_DATE('2022-01-30', 'YYYY-MM-DD'), 40, 'Cook', 2400.00);
INSERT INTO Staff VALUES ('S005', 'FS05', 'Diana Green', TO_DATE('2020-07-05', 'YYYY-MM-DD'), 35, 'Cashier', 2100.00);
INSERT INTO Staff VALUES ('S006', 'FS01', 'Eve White', TO_DATE('2023-02-11', 'YYYY-MM-DD'), 40, 'Waiter', 2300.00);
INSERT INTO Staff VALUES ('S007', 'FS02', 'Frank Black', TO_DATE('2018-09-20', 'YYYY-MM-DD'), 50, 'Supervisor', 2800.00);
INSERT INTO Staff VALUES ('S008', 'FS03', 'Grace Lee', TO_DATE('2022-05-12', 'YYYY-MM-DD'), 38, 'Cook', 2500.00);


INSERT INTO ComboMeal VALUES ('C001', 'Asian Combo', 12.99, 'Rice + Drink');
INSERT INTO ComboMeal VALUES ('C002', 'Burger Combo', 10.49, 'Burger + Drink');
INSERT INTO ComboMeal VALUES ('C003', 'Pizza Combo', 15.99, 'Pizza + Drink');


INSERT INTO ComboMealDetail VALUES ('CD01', 'C001', 2001);
INSERT INTO ComboMealDetail VALUES ('CD02', 'C001', 2007);
INSERT INTO ComboMealDetail VALUES ('CD03', 'C002', 2002);
INSERT INTO ComboMealDetail VALUES ('CD04', 'C002', 2007);
INSERT INTO ComboMealDetail VALUES ('CD05', 'C003', 2003);
INSERT INTO ComboMealDetail VALUES ('CD06', 'C003', 2007);


INSERT INTO Customization VALUES (5001, 4001, 'Extra Chicken', 'Add', 'Chicken Fried Rice', 2.00);
INSERT INTO Customization VALUES (5002, 4004, 'Extra Cheese', 'Add', 'Pepperoni Pizza', 1.50);


SELECT * FROM Customer;
SELECT * FROM MenuItem;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Transaction;
SELECT * FROM FoodStation;
SELECT * FROM Staff;
SELECT * FROM ComboMeal;
SELECT * FROM ComboMealDetail;
SELECT * FROM Customization;



--Queries
--a
--This query displays all orders along with their customizations even if there are no customizations for the order
SELECT O.OrderID, O.CustomerID, O.OrderDate, OD.OrderDetailID, C.CustomizationDetails
FROM Orders O
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
LEFT JOIN Customization C ON OD.OrderDetailID = C.OrderDetailID;


--b
-- This query displays the total number of orders each food station has had
SELECT FS.StationName, COUNT(O.OrderID) AS TotalOrders
FROM FoodStation FS
JOIN Orders O ON FS.StationID = O.StationID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN MenuItem MI ON OD.ItemID = MI.ItemID
GROUP BY FS.StationName;


--c
--This query displays the names of customers who have a phone number starting with '123' and whose registration date is in the year 2024. 
SELECT CustomerName, PhoneNumber, RegistrationDate
FROM Customer
WHERE PhoneNumber LIKE '123%' 
AND EXTRACT(YEAR FROM RegistrationDate) = 2024;


--d
--This query diaplays all menu items that are either beverages or below $6 and are available
SELECT ItemID, ItemName, ItemCategory, ItemPrice, IsAvailable
FROM MenuItem
WHERE (ItemCategory = 'Beverage' OR ItemPrice < 6)
AND IsAvailable = 'Y'
ORDER BY ItemPrice;


--e
-- This query displays the names of customers who have placed orders with a TotalAmount greater than the average order total.
SELECT C.CustomerName
FROM Customer C
WHERE C.CustomerID IN (
    SELECT O.CustomerID
    FROM Orders O
    WHERE O.TotalAmount > (
        SELECT AVG(TotalAmount) 
        FROM Orders
    )
);

--f
-- Scenario based query: Identify dishes that are frequently ordered together to create combo meals or special offers that encourage customers to order these combinations.
SELECT 
    mi1.ItemName AS Dish1,
    mi2.ItemName AS Dish2,
    pairs.Frequency
FROM 
    (SELECT 
        od1.ItemID AS Item1,
        od2.ItemID AS Item2,
        COUNT(*) AS Frequency
     FROM 
        OrderDetails od1
     JOIN 
        OrderDetails od2
     ON 
        od1.OrderID = od2.OrderID
        AND od1.ItemID < od2.ItemID
     GROUP BY 
        od1.ItemID, od2.ItemID
    ) pairs
JOIN 
    MenuItem mi1 ON pairs.Item1 = mi1.ItemID
JOIN 
    MenuItem mi2 ON pairs.Item2 = mi2.ItemID
ORDER BY 
    pairs.Frequency DESC;
