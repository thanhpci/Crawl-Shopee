
# Công Cụ Thu Thập Dữ liệu Trang Web Shopee.vn

## Giới Thiệu
Công cụ này được phát triển nhằm mục đích thu thập dữ liệu từ trang web [shopee.vn](https://shopee.vn/), chuyên về các sản phẩm trực tuyến. Thông tin chi tiết từ các danh mục hàng hoá lớn được thu thập và biến đổi sang định dạng CSV.

## Đặc Điểm Dữ Liệu Sản Phẩm
Mỗi sản phẩm thu thập được bao gồm các thông tin sau:
- **Thời Điểm Crawl:** Thời điểm dữ liệu được thu thập.
- **Loại Hàng Hoá:** Phân loại sản phẩm.
- **Tên Sản Phẩm:** Tên gọi của sản phẩm.
- **Đường Link:** Đường dẫn đến trang sản phẩm.
- **Đánh Giá Trung Bình:** Đánh giá trung bình từ người dùng.
- **Giá Sản Phẩm:** Giá bán của sản phẩm.
- **Địa Điểm Cung Cấp:** Nơi cung cấp sản phẩm.
- **Tổng Doanh Thu:** Doanh thu tổng cộng tại thời điểm crawl (tính theo giá trị cao nhất nếu sản phẩm có nhiều mức giá).

## Thống Kê
- **Số Lượng Dữ Liệu Thu Thập:** 4665 sản phẩm (tính đến thời điểm thống kê).
- **Tốc Độ Crawl:** Khoảng 8 sản phẩm/phút (từ 02:30:28 ngày 30/01/2024 đến 09:14:28 ngày 30/01/2024).

## Hướng Dẫn Sử Dụng
1. **Mở Trình Duyệt Edge:** Đăng nhập vào [shopee.vn](https://shopee.vn/).
2. **Cài Đặt Autohotkey:** Tải và cài đặt [Autohotkey v2](https://www.autohotkey.com/).
3. **Tải Dự Án:** Tải thư mục dự án từ Git về máy.
4. **Tắt Extension Edge:** Tắt tất cả tiện ích mở rộng trên Edge để không ảnh hưởng đến quá trình crawl.
5. **Đóng Các Cửa Sổ Edge:** Đóng tất cả cửa sổ Edge mở trước đó.
6. **Chạy File Main.ahk:** Truy cập `\CrawlShopee\main.ahk` trong thư mục dự án và chạy file.
7. **Không Tương Tác Khi Crawl:** Tránh tương tác với cửa sổ Edge trong quá trình thu thập dữ liệu.
8. **Thoát Ứng Dụng:** Sử dụng tổ hợp phím `Ctrl+Shift+F3` để thoát ứng dụng.
