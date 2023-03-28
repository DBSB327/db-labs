INSERT INTO clients (name, surname, phone, email, address)
VALUES 
    ('Don', 'Ping', '515-1234', 'pingdon324.@gmail.com', '33 Prim St'),
    ('Paul', 'Chu', '552-5678', 'Paul4325@gmail.com', '53 Land St');

INSERT INTO products (product_name, price)
VALUES 
    ('Red Roses', 20.00),
    ('White Lilies', 15.00),
    ('Tulips', 10.00);


INSERT INTO orders (client_id, order_date, amount_due, status)
VALUES 
    (1, '2023-03-28 10:00:00', 20.00, 'Pending'),
    (2, '2023-03-27 11:00:00', 25.00, 'Shipped');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES 
    (1, 1, 1),
    (1, 2, 2),
    (2, 3, 3);
