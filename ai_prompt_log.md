# Nhật ký Sử dụng AI
## Dự án: Sửa lỗi truy vấn JOIN - FlashMart

### 🎯 Prompt 1: Sự khác biệt JOIN mặc định
**Prompt:** "Trong MySQL, từ khóa JOIN (khi không ghi rõ LEFT/RIGHT) mặc định hoạt động như thế nào? Nó giữ hay bỏ các bản ghi không trùng khớp?"

**Trả lời:** `JOIN` mặc định = `INNER JOIN`. Chỉ giữ các bản ghi có **sự trùng khớp ở CẢ HAI bảng**. Bản ghi không trùng khớp sẽ bị **loại bỏ hoàn toàn**. Đây là lý do Charlie biến mất khỏi báo cáo Marketing.

**Áp dụng:** Đổi `JOIN` → `LEFT JOIN` để giữ toàn vẹn bảng Customers.

---

### 🎯 Prompt 2: COUNT(*) vs COUNT(cột)
**Prompt:** "Khi dùng LEFT JOIN, tôi nên dùng COUNT(*) hay COUNT(cột_khóa_bảng_phụ)? Sự khác biệt khi kết quả NULL là gì?"

**Trả lời:** 
- `COUNT(*)` đếm **tất cả dòng**, kể cả NULL → trả về 1 cho khách không mua.
- `COUNT(cột)` đếm dòng **không NULL** → trả về 0 chính xác.
- **Luôn dùng `COUNT(cột_phụ)`** khi LEFT JOIN.

**Áp dụng:** Dùng `COUNT(o.order_id)` trong báo cáo Marketing.

---

### 🎯 Prompt 3: Anti-Join với IS NULL
**Prompt:** "Làm sao để tìm sản phẩm chưa từng được bán trong MySQL?"

**Trả lời:** Dùng **Anti-Join**:
```sql
SELECT p.*
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;