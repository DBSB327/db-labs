USE flower_shop

--1

DECLARE @a INT = 10, @b INT = 15, @c INT = 0;
BEGIN TRANSACTION;
IF @c >= 0
BEGIN
    SELECT @a + @b AS Sum;
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
END

--2

BEGIN TRANSACTION;
INSERT INTO clients (name, surname, phone, email)
VALUES ('Tommy', 'Cash', '521-1234', 'Cash43.@gmail.com');
IF @@ERROR <> 0 OR @@ROWCOUNT = 0
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END

--3

BEGIN TRANSACTION;
INSERT INTO clients (name, surname, phone, email)
VALUES ('Tommy', 'Cash', '521-1234', 'Cash43.@gmail.com');
IF @@ERROR <> 0 OR @@ROWCOUNT = 0
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END

--4.1 Обновление статуса заказа: если заказ уже был отправлен, то нельзя изменить его статус. Если статус не может быть изменен, откатить транзакцию.

BEGIN TRANSACTION;
UPDATE orders SET status = 'Shipped' WHERE order_id = 123;
IF @@ERROR <> 0 OR @@ROWCOUNT = 0
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE IF (SELECT status FROM orders WHERE order_id = 123) = 'Shipped'
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END

--4.2 Добавление нового товара: если в таблице товаров уже есть товар с таким же именем, то откатить транзакцию. 

BEGIN TRANSACTION;
INSERT INTO products (product_name, price) VALUES ('New Product', 10.00);
IF @@ERROR <> 0 OR @@ROWCOUNT = 0
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE IF (SELECT COUNT(*) FROM products WHERE product_name = 'New Product') > 1
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END

--4.3 Удаление клиента: если у клиента есть неоплаченные заказы, то откатить транзакцию.

BEGIN TRANSACTION;
DELETE FROM clients WHERE client_id = 123;
IF @@ERROR <> 0 OR @@ROWCOUNT = 0
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE IF (SELECT COUNT(*) FROM orders WHERE client_id = 123 AND amount_due > 0) > 0
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END
