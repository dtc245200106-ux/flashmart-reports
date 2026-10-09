-- ============================================================
-- HỆ THỐNG FLASHMART - BÁO CÁO ĐÃ TỐI ƯU
-- Phiên bản: 2.0 - Sửa lỗi JOIN
-- Tác giả: Data Engineer
-- Ngày: 2026
-- ============================================================

-- ============================================
-- PHẦN 1: TẠO DATABASE VÀ BẢNG
-- ============================================
DROP DATABASE IF EXISTS flashmart_db;
CREATE DATABASE flashmart_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE flashmart_db;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- ============================================
-- PHẦN 2: CHÈN DỮ LIỆU MẪU
-- ============================================
INSERT INTO Customers VALUES 
    (1, 'Alice'), 
    (2, 'Bob'), 
    (3, 'Charlie');  -- Charlie chưa từng mua hàng

INSERT INTO Products VALUES 
    (101, 'Laptop'), 
    (102, 'Mouse'), 
    (103, 'Keyboard');  -- Keyboard chưa từng được mua

INSERT INTO Orders VALUES 
    (1001, 1, 101), 
    (1002, 1, 102), 
    (1003, 2, 101);

-- ============================================
-- PHẦN 3: BÁO CÁO CHO MARKETING (ĐÃ SỬA)
-- ============================================
-- ✅ FIX LỖI 1: Dùng LEFT JOIN thay INNER JOIN
-- ✅ FIX LỖI 2: Dùng COUNT(o.order_id) thay COUNT(*)
SELECT 
    c.customer_id, 
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

-- ============================================
-- PHẦN 4: BÁO CÁO CHO KHO VẬN (ĐÃ SỬA)
-- ============================================
-- ✅ FIX LỖI 3: Dùng LEFT JOIN + WHERE IS NULL (Anti-Join)
SELECT 
    p.product_id, 
    p.product_name
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

-- ============================================
-- PHẦN 5: TRUY VẤN KIỂM TRA
-- ============================================

-- 5.1. Xem tất cả khách hàng
SELECT * FROM Customers;

-- 5.2. Xem tất cả sản phẩm
SELECT * FROM Products;

-- 5.3. Xem tất cả đơn hàng
SELECT * FROM Orders;