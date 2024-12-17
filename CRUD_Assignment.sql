CREATE TYPE category AS ENUM ('Electronics', 'Clothing', 'Home', 'Books');
----Enumerated (enum) types are data types that comprise a static, ordered set of values. 


CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_Type category NOT NULL,
    price NUMERIC(10, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--- I have created a products table and assigned the type category enum 

select * from products;

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY, -- Auto-incremented unique identifier for each customer
    name VARCHAR(255) NOT NULL, -- Name of the customer, must not be null
    email VARCHAR(255) NOT NULL UNIQUE, -- Email address, must be unique and not null
    phone CHAR(10) UNIQUE, -- 10-digit phone number, must be unique
    joined_date DATE DEFAULT CURRENT_DATE -- Defaults to the current date
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY, -- Auto-incremented unique identifier for each order
    customer_id INT NOT NULL, -- References Customers table
    product_id INT NOT NULL, -- References Products table
    quantity INT NOT NULL CHECK (quantity > 0), -- Quantity must be greater than 0
    total_price NUMERIC(10, 2) NOT NULL CHECK (total_price > 0), -- Must be greater than 0
    order_date DATE DEFAULT CURRENT_DATE, -- Defaults to the current date
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Attempt to insert invalid category in Products
INSERT INTO Products (name, category_Type, price, stock)
VALUES ('Invalid Product', 'Gadgets', 199.99, 10); -- This will fail due to ENUM constraint.

-- Attempt to insert negative stock in Products
INSERT INTO Products (name, category_Type, price, stock)
VALUES ('Laptop', 'Electronics', 899.99, -5); -- This will fail due to CHECK constraint.

-- Attempt to insert duplicate email in Customers
INSERT INTO Customers (name, email, phone)
VALUES ('Duplicate Email', 'john.doe@example.com', '1122334455'); -- This will fail due to UNIQUE constraint.

INSERT INTO Customers (name, email, phone)
VALUES ('Duplicate Email', 'sri@example.com', '1122334457');
-- Attempt to insert an order with invalid customer_id
INSERT INTO Orders (customer_id, product_id, quantity, total_price)
VALUES (2, 1, 1, 699.99); -- This will fail due to FOREIGN KEY constraint.


select * from customers;

⚬ Retrieve all products with a price greater than 500 and available stock greater
than 10.
SELECT * 
FROM Products 
WHERE price > 500 AND stock > 10;

⚬ List all customers who placed orders in the last 30 days.
SELECT DISTINCT c.*
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '30 days';

⚬ Calculate the total revenue generated from all orders.
SELECT SUM(total_price) AS total_revenue
FROM Orders;

⚬ Find the most popular product category based on the number of orders.

SELECT p.category_type, COUNT(o.order_id) AS total_orders
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.category_type
ORDER BY total_orders DESC
LIMIT 1;

