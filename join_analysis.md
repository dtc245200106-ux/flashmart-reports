# Giải trình: Tại sao dùng COUNT(o.order_id) thay vì COUNT(*)?

## 🎯 Vấn đề với COUNT(*)

Khi dùng **LEFT JOIN**, nếu khách hàng chưa mua hàng (như Charlie), bảng `Orders` sẽ trả về **1 dòng NULL** cho cột `order_id`. 

- `COUNT(*)` đếm **tất cả các dòng** trong kết quả, kể cả dòng NULL → **Charlie sẽ có 1 đơn hàng** (SAI).
- `COUNT(o.order_id)` chỉ đếm các dòng có `order_id` **KHÁC NULL** → **Charlie có 0 đơn hàng** (ĐÚNG).

## 📊 Minh họa

| customer_id | name | order_id | COUNT(*) | COUNT(o.order_id) |
|-------------|------|----------|----------|-------------------|
| 1 | Alice | 1001 | 2 | 2 |
| 1 | Alice | 1002 | 2 | 2 |
| 2 | Bob | 1003 | 1 | 1 |
| 3 | Charlie | **NULL** | **1 (SAI)** | **0 (ĐÚNG)** |

## ✅ Kết luận

Luôn dùng `COUNT(cột_khóa_bảng_phụ)` khi kết hợp với **LEFT JOIN** để đảm bảo kết quả `0` chính xác cho các bản ghi không có giao dịch.