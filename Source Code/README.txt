************************************************ Cấu hình cài đặt ứng dụng *****************************************************************



1. Tạo cơ sở dữ liệu
	- Mở file Script bằng SQL Server
	- Nhấn F5 để CSDL tạo ra CSDL với tên "RealEstateWebsite"



2. Cấu hình file Web.config trong cây thư mục RealEstateWebsite/RealEstateWebsite/Web.config
	- Có thể bỏ qua bước này nếu Server name dùng (local) hoặc . hoặc máy bạn có thể kết nối tới cơ sở dữ liệu dưới server name (local)
	- Tại thẻ <connectionString> sửa data source=.; thành data source = 'tên server của bạn'



3. Mở solution lên và nhấn F5 để build và run ứng dụng



4. Tất cả mật khẩu trong cơ sở dữ liệu đều là "1", vì mật khẩu trong cở dữ liệu đã bị mã hóa nên bạn không thể đăng nhập bằng mật khẩu đó
	- Một số account ví dụ cho chương trình đã có:
		+ User: 	huonglt	1
		+ Censor: 	annc	1
		+ Admin:	thuydx	1



5. Đường link tới các trang chủ của 3 phần đã được cấu hình như sau

	- User: localhost:'số cổng IIS đã mở sẵn cho ứng dụng'
	- Censor: localhost:'số cổng IIS đã mở sẵn cho ứng dụng'/Censor
	- Admin: localhost:'số cổng IIS đã mở sẵn cho ứng dụng'/Admin




**************************************************** Chúc bạn thành công ********************************************************************
