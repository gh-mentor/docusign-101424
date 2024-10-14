/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database  'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
Details:
- Check if the database 'Inventory' exists:
-- If it exists, drop the database.
- Create a new database  'Inventory'.
- Sets the default database to 'Inventory'.
- Create the 'categories' table. Use the following columns:
-- id:  integer, primary key
-- name: 50 characters, not null
-- description:  255 characters, nullable
- Create the 'products' table. Use the following columns:
-- id: integer, primary key
-- name: 50 characters, not null
-- price: decimal (10, 2), not null
-- category_id: int, foreign key references categories(id)
- Populate the 'categories' table with sample data.
- Populate the 'products' table with sample data.
*/

-- Check if the database 'Inventory' exists:
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Inventory')
BEGIN
    -- Drop the database 'Inventory':
    DROP DATABASE Inventory;
END
GO

-- Create a new database 'Inventory':
CREATE DATABASE Inventory;
GO

-- Sets the default database to 'Inventory':
USE Inventory;

-- Create the 'categories' table:
CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);

-- Create the 'products' table:
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    -- Add a created_at column:
    created_at DATETIME DEFAULT GETDATE(),
    -- Add an updated_at column:
    updated_at DATETIME DEFAULT GETDATE()
);

-- Populate the 'categories' table with sample data:
INSERT INTO categories (id, name, description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Clothing and apparel'),
(3, 'Home Goods', 'Household items and decor'),
(4, 'Books', 'Books and reading materials'),
(5, 'Toys', 'Children''s toys and games');

-- Populate the 'products' table with sample data:
INSERT INTO products (id, name, price, category_id) VALUES
(1, 'Laptop', 999.99, 1),
(2, 'Smartphone', 599.99, 1),
(3, 'T-shirt', 19.99, 2),
(4, 'Jeans', 39.99, 2),
(5, 'Throw Pillow', 9.99, 3),
(6, 'Candle Holder', 14.99, 3),
(7, 'Novel', 12.99, 4),
(8, 'Cookbook', 24.99, 4),
(9, 'Action Figure', 7.99, 5),
(10, 'Board Game', 29.99, 5);


-- Create a stored procedure to get products by category.
CREATE PROCEDURE GetProductsByCategory
    @CategoryID INT
AS
BEGIN
    -- Using SELECT * instead of specifying columns
    SELECT * 
    FROM products 
    WHERE category_id = @CategoryID;

END;
GO

-- The following View will display the products with their category details.
CREATE VIEW ViewProducts AS
SELECT 
    p.id AS ProductID,
    p.name AS ProductName,
    p.price AS ProductPrice,
    c.name AS CategoryName,
    c.description AS CategoryDescription
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.id;
GO




