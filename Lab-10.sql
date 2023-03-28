--CОздание БД

USE MobileShop
CREATE TABLE Phones (
ID INT NOT NULL PRIMARY KEY,
Model VARCHAR(50) NOT NULL,
Manufacturer VARCHAR(50) NOT NULL,
Color VARCHAR(20) NOT NULL,
Specs VARCHAR(MAX),
Price DECIMAL(10,2) NOT NULL,
TotalSales DECIMAL(10, 2) NOT NULL
);


CREATE TABLE Customers (
ID INT NOT NULL PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Address VARCHAR(100),
Phone VARCHAR(20) NOT NULL
);

CREATE TABLE Orders (
ID INT NOT NULL PRIMARY KEY,
OrderDate DATETIME NOT NULL,
CustomerID INT NOT NULL,
Quantity INT NOT NULL,
TotalPrice DECIMAL(10,2) NOT NULL,
Status VARCHAR(20) NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

CREATE TABLE Sales (
ID INT NOT NULL PRIMARY KEY,
SaleDate DATETIME NOT NULL,
PhoneID INT NOT NULL,
Quantity INT NOT NULL,
Price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (PhoneID) REFERENCES Phones(ID)
);


CREATE TABLE Suppliers (
ID INT NOT NULL PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Address VARCHAR(100),
Phone VARCHAR(20) NOT NULL
);

--Заполнение

INSERT INTO Phones (ID, Model, Manufacturer, Color, Specs, Price, TotalSales)
VALUES
(1, 'Redmni Note 8', 'Xiomi', 'Blue', 'A15 Bionic, 5G, OLED, 128GB', 199.99, 0.00),
(2, 'Galaxy S21', 'Samsung', 'Phantom Black', 'Snapdragon 888, 5G, Dynamic AMOLED, 128GB', 899.99, 0.00),
(3, 'Pixel 6', 'Google', 'Stormy Black', 'Tensor, 5G, AMOLED, 128GB', 699.99, 0.00),
(4, 'OnePlus 10', 'OnePlus', 'Starry Black', 'Snapdragon 8 Gen 1, 5G, AMOLED, 256GB', 899.99, 0.00),
(5, 'Xperia 1 III', 'Sony', 'Frosted Black', 'Snapdragon 888, 5G, OLED, 256GB', 1299.99, 0.00);


INSERT INTO Customers (ID, FirstName, LastName, Address, Phone)
VALUES
(1, 'Иван', 'Иванов', 'ул. Ленина, 1', '79991234567'),
(2, 'Петр', 'Петров', 'ул. Пушкина, 2', '79999876543'),
(3, 'Анна', 'Сидорова', 'ул. Гоголя, 3', '79991234568'),
(4, 'Елена', 'Михайлова', 'ул. Толстого, 4', '79991234569'),
(5, 'Сергей', 'Кузнецов', 'ул. Достоевского, 5', '79991234570');


INSERT INTO Orders (ID, OrderDate, CustomerID, Quantity, TotalPrice, Status)
VALUES
(1, '2022-01-15 10:30:00', 1, 2, 1599.98, 'Выполнен'),
(2, '2022-02-01 12:45:00', 2, 1, 899.99, 'Выполнен'),
(3, '2022-02-10 14:20:00', 3, 3, 2099.97, 'Выполнен'),
(4, '2022-03-01 11:10:00', 4, 1, 1299.99, 'В обработке'),
(5, '2022-03-20 15:30:00', 5, 2, 2599.98, 'В обработке');

INSERT INTO Sales (ID, SaleDate, PhoneID, Quantity, Price) VALUES
(1, '2022-01-02 15:30:00', 1, 2, 2198.00),
(2, '2022-01-03 11:45:00', 3, 1, 799.00),
(3, '2022-01-05 13:15:00', 5, 3, 1785.00),
(4, '2022-01-06 10:00:00', 2, 1, 899.00),
(5, '2022-01-08 16:20:00', 4, 2, 1100.00);

INSERT INTO Suppliers (ID, Name, Address, Phone) VALUES
(1, 'Samsung Electronics Co., Ltd', 'Seocho District, Seoul, South Korea', '+82-2-2255-0114'),
(2, 'Apple Inc.', 'Cupertino, California, USA', '+1-408-996-1010'),
(3, 'Xiaomi Corporation', 'Haidian District, Beijing, China', '+86-10-6060-1188'),
(4, 'Huawei Technologies Co., Ltd', 'Shenzhen, Guangdong, China', '+86-755-28780808'),
(5, 'LG Electronics Inc.', 'Yeouido-dong, Seoul, South Korea', '+82-2-3777-1114');

--Задачи

--1 

CREATE TRIGGER Sales_ValidateQuantity
ON Sales
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS(SELECT * FROM inserted WHERE Quantity <= 0)
    BEGIN
        RAISERROR('Количество должно быть положительным числом.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Sales (SaleDate, PhoneID, Quantity, Price)
        SELECT SaleDate, PhoneID, Quantity, Price
        FROM inserted;
    END
END



--2

CREATE TRIGGER Sales_UpdateTotalPrice
ON Sales
AFTER INSERT
AS
BEGIN
    UPDATE Phones
    SET TotalSales = TotalSales + (SELECT SUM(Price * Quantity) FROM inserted WHERE PhoneID = Phones.ID)
    FROM Phones
    JOIN inserted ON Phones.ID = inserted.PhoneID
END


--3


CREATE TRIGGER Sales_PreventPriceUpdate
ON Sales
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS(SELECT * FROM deleted JOIN Sales ON deleted.ID = Sales.ID WHERE Sales.SaleDate IS NOT NULL)
    BEGIN
        RAISERROR('Цена не может быть обновлена ​​для уже проданных товаров.', 16, 1);
    END
    ELSE
    BEGIN
        UPDATE Sales SET Price = inserted.Price
        FROM Sales
        JOIN inserted ON Sales.ID = inserted.ID
    END
END

