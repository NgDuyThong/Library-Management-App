USE master;
GO

-- Tạo cơ sở dữ liệu mới nếu chưa có
CREATE DATABASE CongNgheNet_DoAnQLTV;
GO

-- Chuyển sang sử dụng cơ sở dữ liệu mới được tạo
USE CongNgheNet_DoAnQLTV;
GO

-- Tạo bảng tblDocGia để lưu thông tin độc giả
CREATE TABLE tblDocGia (
    MaDG VARCHAR(10) CONSTRAINT pk_tblDocGia PRIMARY KEY,  
    TenDG NVARCHAR(30),                                  
    GioiTinhDG NVARCHAR(5),                             
    NgaySinhDG DATE,                                    -- Sử dụng kiểu DATE cho ngày sinh
    SDTDG VARCHAR(15),                                  -- Sử dụng VARCHAR để lưu số điện thoại
    DiaChiDG NVARCHAR(50),                             
    LoaiDG NVARCHAR(20),                               
    GhiChu NVARCHAR(30) DEFAULT N'Hoạt động',                              
    TenTaiKhoanDG VARCHAR(10),                         
    MatKhauDG VARCHAR(20)                              
);

-- Tạo bảng tblNXB để lưu thông tin nhà xuất bản
CREATE TABLE tblNXB (
    MaNXB NVARCHAR(10) PRIMARY KEY,        
    TenNXB NVARCHAR(100) NOT NULL,         
    DiaChi NVARCHAR(200),                  
    TacGia NVARCHAR(100),                  
    NamXuatBan INT,                        
    MoTa NVARCHAR(200)                     
);

-- Tạo bảng tblSach để lưu thông tin sách
CREATE TABLE tblSach (
    MaSach NVARCHAR(10) PRIMARY KEY,        
    TenSach NVARCHAR(100) NOT NULL,         
    ChuDe NVARCHAR(50),                    
    TacGia NVARCHAR(100),                  
    MaNXB NVARCHAR(10),                    
    NamXuatBan INT,                        
    SoLuong INT,                           
    GiaTien FLOAT,                
    TinhTrang NVARCHAR(50),                
    GhiChu NVARCHAR(200),                  
    FOREIGN KEY (MaNXB) REFERENCES tblNXB(MaNXB) 
);

-- Tạo bảng tblThuThu để lưu thông tin thủ thư
CREATE TABLE tblThuThu (
    MaTT VARCHAR(10) CONSTRAINT pk_tblThuThu PRIMARY KEY,  
    TenTT NVARCHAR(30),                                   
    GioiTinhTT NVARCHAR(5),                               
    NgaySinhTT DATE,                                      
    SDTTT VARCHAR(15),                                    
    DiaChiTT NVARCHAR(50),                                
    GhiChu NVARCHAR(30),                                  
    TenTaiKhoanTT VARCHAR(10),                            
    MatKhauTT VARCHAR(20)                                 
);

-- Tạo bảng tblNhapSach để lưu thông tin nhập sách
CREATE TABLE tblNhapSach (
    MaNhap NVARCHAR(50) PRIMARY KEY,        
    MaSach NVARCHAR(10),                   
    MaNXB NVARCHAR(10),                    
    NgayNhap DATE,                         
    SoLuong INT,                           
    GiaNhap FLOAT,  
    ThanhTien AS (SoLuong * GiaNhap) PERSISTED,          
    MaTT VARCHAR(10),                       -- Thêm mã thủ thư
    FOREIGN KEY (MaSach) REFERENCES tblSach(MaSach),
    FOREIGN KEY (MaNXB) REFERENCES tblNXB(MaNXB),
    FOREIGN KEY (MaTT) REFERENCES tblThuThu(MaTT)  -- Khóa ngoại đến tblThuThu
);

-- Tạo bảng tblHSPhieuMuon để lưu thông tin phiếu mượn sách
CREATE TABLE tblHSPhieuMuon (
    MaPhieu VARCHAR(10) CONSTRAINT pk_tblMuonTra PRIMARY KEY,  
    MaDG VARCHAR(10),                                         
    MaSach NVARCHAR(10),                                      
    NgayMuon DATE,                                            
    NgayQuyDinhTra DATE,                                      
    NgayTra DATE NULL,                                        
    SLMuon INT,                                              
    TinhTrang NVARCHAR(20),                                  
    GhiChu NVARCHAR(75),                                     
    MaTT VARCHAR(10),                       -- Thêm mã thủ thư
    CONSTRAINT fk_tblMuonTra_tblDocGia FOREIGN KEY(MaDG) REFERENCES tblDocGia(MaDG),  
    CONSTRAINT fk_tblMuonTra_tblSach FOREIGN KEY(MaSach) REFERENCES tblSach(MaSach),  
    CONSTRAINT fk_tblMuonTra_tblThuThu FOREIGN KEY(MaTT) REFERENCES tblThuThu(MaTT)  -- Khóa ngoại đến tblThuThu
);




USE CongNgheNet_DoAnQLTV;
GO

-- Thêm dữ liệu vào bảng tblDocGia
INSERT INTO tblDocGia (MaDG, TenDG, GioiTinhDG, NgaySinhDG, SDTDG, DiaChiDG, LoaiDG, GhiChu, TenTaiKhoanDG, MatKhauDG)
VALUES 
('DG001', N'Nguyễn Minh Hoàng', N'Nam', '2002-05-12', '0901234567', N'Hà Nội', N'Sinh viên', N'Hoạt động', '2001224990', 'pass123'),
('DG002', N'Lê Thị Lan', N'Nữ', '2001-09-23', '0902345678', N'Hải Phòng', N'Sinh viên', N'Hoạt động', '2001224395', 'pass456'),
('DG003', N'Phạm Văn Đức', N'Nam', '2003-07-15', '0903456789', N'Hồ Chí Minh', N'Sinh viên', N'Hoạt động', '2001225003', 'pass789'),
('DG004', N'Trần Hồng Hạnh', N'Nữ', '2000-11-05', '0904567890', N'Đà Nẵng', N'Sinh viên', N'Hoạt động', '2001221827', 'pass012'),
('DG005', N'Vũ Ngọc Quỳnh', N'Nữ', '2004-03-30', '0905678901', N'Bình Dương', N'Sinh viên', N'Hoạt động', '2001223222', 'pass345'),
('DG006', N'Nguyễn Văn An', N'Nam', '2002-11-11', '0906789012', N'Bắc Ninh', N'Sinh viên', N'Hoạt động', '2001221234', 'pass678'),
('DG007', N'Hoàng Thu Hà', N'Nữ', '2003-02-25', '0907890123', N'Cần Thơ', N'Sinh viên', N'Hoạt động', '2001223456', 'pass890'),
('DG008', N'Trần Hải Đăng', N'Nam', '2001-04-17', '0908901234', N'Phú Yên', N'Sinh viên', N'Hoạt động', '2001225678', 'pass111'),
('DG009', N'Lý Thị Phương', N'Nữ', '2004-10-05', '0909012345', N'An Giang', N'Sinh viên', N'Hoạt động', '2001227890', 'pass222'),
('DG010', N'Võ Thanh Tùng', N'Nam', '2003-12-20', '0900123456', N'Tây Ninh', N'Sinh viên', N'Hoạt động', '2001228901', 'pass333');

-- Thêm dữ liệu vào bảng tblNXB
INSERT INTO tblNXB (MaNXB, TenNXB, DiaChi, TacGia, NamXuatBan, MoTa)
VALUES 
('NXB001', N'Nhà Xuất Bản Trẻ', N'TP.HCM', N'Nguyễn Nhật Ánh', 2019, N'Sách thiếu nhi và văn học tuổi mới lớn'),
('NXB002', N'Nhà Xuất Bản Kim Đồng', N'Hà Nội', N'Tô Hoài', 2020, N'Sách thiếu nhi và giáo dục'),
('NXB003', N'Nhà Xuất Bản Văn Học', N'Hà Nội', N'Nguyễn Huy Thiệp', 2018, N'Sách văn học hiện đại'),
('NXB004', N'Nhà Xuất Bản Khoa Học', N'TP.HCM', N'Nguyễn Khánh', 2021, N'Sách khoa học và công nghệ'),
('NXB005', N'Nhà Xuất Bản Giáo Dục', N'Hà Nội', N'Trần Văn An', 2022, N'Sách giáo dục và đào tạo'),
('NXB006', N'Nhà Xuất Bản Y Học', N'Hà Nội', N'Trịnh Văn Định', 2023, N'Sách y học và sức khỏe'),
('NXB007', N'Nhà Xuất Bản Văn Hóa', N'TP.HCM', N'Nguyễn Văn Dũng', 2022, N'Sách văn hóa và xã hội'),
('NXB008', N'Nhà Xuất Bản Thể Thao', N'Hà Nội', N'Phạm Văn Tú', 2021, N'Sách thể thao và rèn luyện sức khỏe'),
('NXB009', N'Nhà Xuất Bản Mỹ Thuật', N'TP.HCM', N'Nguyễn Minh Anh', 2020, N'Sách nghệ thuật và mỹ thuật'),
('NXB010', N'Nhà Xuất Bản Kỹ Thuật', N'Bình Dương', N'Lê Trung Kiên', 2021, N'Sách kỹ thuật và công nghệ');

-- Thêm dữ liệu vào bảng tblSach
INSERT INTO tblSach (MaSach, TenSach, ChuDe, TacGia, MaNXB, NamXuatBan, SoLuong, GiaTien, TinhTrang, GhiChu)
VALUES 
('S001', N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', N'Tiểu thuyết', N'Nguyễn Nhật Ánh', 'NXB001', 2018, 10, 55000, N'Còn mới', N'Sách văn học'),
('S002', N'Dế Mèn Phiêu Lưu Ký', N'Thiếu nhi', N'Tô Hoài', 'NXB002', 2019, 15, 45000, N'Còn mới', N'Sách giáo dục'),
('S003', N'Trò Chơi Của Thiên Thần', N'Trinh thám', N'Carlos Ruiz Zafón', 'NXB003', 2017, 12, 62000, N'Tốt', N'Sách trinh thám'),
('S004', N'Vật Lý Đại Cương', N'Khoa học', N'Nguyễn Khánh', 'NXB004', 2021, 8, 78000, N'Mới', N'Sách khoa học'),
('S005', N'Tâm Lý Học Đám Đông', N'Tâm lý học', N'Gustave Le Bon', 'NXB003', 2020, 5, 90000, N'Còn tốt', N'Sách tâm lý'),
('S006', N'Những Đứa Con Của Biển Cả', N'Tiểu thuyết', N'Herman Melville', 'NXB007', 2019, 6, 68000, N'Còn mới', N'Sách văn học'),
('S007', N'Lịch Sử Nghệ Thuật', N'Mỹ thuật', N'Nguyễn Minh Anh', 'NXB009', 2020, 4, 74000, N'Mới', N'Sách nghệ thuật'),
('S008', N'Cẩm Nang Thể Thao', N'Thể thao', N'Phạm Văn Tú', 'NXB008', 2021, 10, 52000, N'Còn mới', N'Sách thể thao'),
('S009', N'Bí Quyết Sống Khỏe', N'Y học', N'Trịnh Văn Định', 'NXB006', 2023, 7, 87000, N'Mới', N'Sách y học'),
('S010', N'Kỹ Thuật Hiện Đại', N'Kỹ thuật', N'Lê Trung Kiên', 'NXB010', 2021, 9, 99000, N'Còn mới', N'Sách kỹ thuật');

-- Thêm dữ liệu vào bảng tblThuThu
INSERT INTO tblThuThu (MaTT, TenTT, GioiTinhTT, NgaySinhTT, SDTTT, DiaChiTT, GhiChu, TenTaiKhoanTT, MatKhauTT)
VALUES 
('TT001', N'Nguyễn Thị Hằng', N'Nữ', '1990-11-15', '0903456789', N'Đà Nẵng', N'Nhân viên chính thức', 'TT001', 'admin1'),
('TT002', N'Lê Văn Long', N'Nam', '1988-08-08', '0904567890', N'Quảng Nam', N'Nhân viên chính thức', 'TT002', 'admin2'),
('TT003', N'Phạm Quốc Bình', N'Nam', '1992-06-20', '0905678901', N'Hà Nội', N'Nhân viên chính thức', 'TT003', 'admin3'),
('TT004', N'Vũ Thị Mai', N'Nữ', '1993-02-12', '0906789012', N'Hồ Chí Minh', N'Nhân viên chính thức', 'TT004', 'admin4'),
('TT005', N'Trần Văn Sơn', N'Nam', '1989-12-30', '0907890123', N'Bình Dương', N'Nhân viên chính thức', 'TT005', 'admin5'),
('TT006', N'Ngô Thị Thảo', N'Nữ', '1991-03-08', '0908901234', N'Vĩnh Long', N'Nhân viên chính thức', 'TT006', 'admin6'),
('TT007', N'Phan Văn Hoàng', N'Nam', '1994-05-27', '0909012345', N'Hà Nam', N'Nhân viên chính thức', 'TT007', 'admin7'),
('TT008', N'Trương Thị Thu', N'Nữ', '1987-01-15', '0900123456', N'Hải Dương', N'Nhân viên chính thức', 'TT008', 'admin8'),
('TT009', N'Lương Văn Bảo', N'Nam', '1986-12-09', '0901234567', N'Quảng Bình', N'Nhân viên chính thức', 'TT009', 'admin9'),
('TT010', N'Đoàn Thị Hằng', N'Nữ', '1995-04-22', '0902345678', N'Bắc Ninh', N'Nhân viên chính thức', 'TT010', 'admin10');

-- Thêm dữ liệu vào bảng tblNhapSach
INSERT INTO tblNhapSach (MaNhap, MaSach, MaNXB, NgayNhap, SoLuong, GiaNhap, MaTT)
VALUES 
('NS001', 'S001', 'NXB001', '2023-02-15', 5, 53000, 'TT001'),
('NS002', 'S002', 'NXB002', '2023-03-20', 8, 42000, 'TT002'),
('NS003', 'S003', 'NXB003', '2023-04-25', 10, 60000, 'TT003'),
('NS004', 'S004', 'NXB004', '2023-05-30', 3, 75000, 'TT004'),
('NS005', 'S005', 'NXB003', '2023-06-18', 7, 85000, 'TT005'),
('NS006', 'S006', 'NXB007', '2023-07-25', 6, 66000, 'TT006'),
('NS007', 'S007', 'NXB009', '2023-08-10', 4, 72000, 'TT007'),
('NS008', 'S008', 'NXB008', '2023-09-05', 10, 51000, 'TT008'),
('NS009', 'S009', 'NXB006', '2023-10-01', 7, 85000, 'TT009'),
('NS010', 'S010', 'NXB010', '2023-11-15', 9, 95000, 'TT010');

-- Thêm dữ liệu vào bảng tblHSPhieuMuon
INSERT INTO tblHSPhieuMuon (MaPhieu, MaDG, MaSach, NgayMuon, NgayQuyDinhTra, NgayTra, SLMuon, TinhTrang, GhiChu, MaTT)
VALUES 
('PM01', 'DG001', 'S001', '2023-03-01', '2023-03-15', '2023-03-17', 1, N'Mới', N'Đã hoàn thành trả sách', 'TT001'), --QuaHan
('PM02', 'DG002', 'S003', '2023-04-10', '2023-04-25', '2023-04-24', 2, N'Mới', N'Đã hoàn thành trả sách', 'TT002'), 
('PM03', 'DG003', 'S002', '2023-05-05', '2023-05-20', NULL, 1, N'Cũ', N'Hỏng cấp 1', 'TT003'), --NULL
('PM04', 'DG004', 'S004', '2023-06-01', '2023-06-15', '2023-06-13', 1, N'Cũ', N'Hỏng cấp 2', 'TT004'),
('PM05', 'DG005', 'S005', '2023-07-10', '2023-07-25', '2023-07-26', 1, N'Cũ', N'Hỏng cấp 3', 'TT005'), --QuaHan
('PM06', 'DG006', 'S001', '2023-08-05', '2023-08-20', '2023-08-20', 2, N'Cũ', N'Không thay đổi', 'TT001'), 
('PM07', 'DG007', 'S002', '2023-09-01', '2023-09-15', '2023-09-14', 1, N'Mới', N'Đã hoàn thành trả sách', 'TT002'),
('PM08', 'DG006', 'S006', '2023-10-15', '2023-10-30', '2023-10-29', 1, N'Cũ', N'Hỏng cấp 1', 'TT006'),
('PM09', 'DG007', 'S007', '2023-09-20', '2023-10-05', '2023-10-06', 1, N'Cũ', N'Hỏng cấp 2', 'TT007'), --QuaHan
('PM10', 'DG008', 'S008', '2023-10-01', '2023-10-20', '2023-10-18', 1, N'Cũ', N'Hỏng cấp 3', 'TT008'), 
('PM11', 'DG009', 'S009', '2023-10-05', '2023-10-25', '2023-10-27', 1, N'Cũ', N'Không thay đổi', 'TT009'), --QuaHan
('PM12', 'DG010', 'S010', '2023-10-10', '2023-10-30', '2023-10-29', 1, N'Mới', N'Đã hoàn thành trả sách', 'TT010');

-- Tạo Login cho Thủ thư
CREATE LOGIN thuthu WITH PASSWORD = '123';
CREATE USER thuthu FOR LOGIN thuthu;

-- Gán Role db_owner cho Thủ thư (toàn quyền)
ALTER ROLE db_owner ADD MEMBER thuthu;

-- Tạo Login cho Độc giả
CREATE LOGIN docgia WITH PASSWORD = '123';
CREATE USER docgia FOR LOGIN docgia;

-- Gán Role db_datareader cho Độc giả (chỉ đọc)
ALTER ROLE db_datareader ADD MEMBER docgia;

-- Phân quyền cụ thể cho Độc giả
GRANT SELECT ON SACH TO docgia;
GRANT SELECT ON tblHSPhieuMuon TO docgia;

-- Tạo Role cho Thủ thư
CREATE ROLE ThuThuRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON tblSach TO ThuThuRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDocGia TO ThuThuRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON tblHSPhieuMuon TO ThuThuRole;

-- Tạo Role cho Độc giả
CREATE ROLE DocGiaRole;
GRANT SELECT ON tblSach TO DocGiaRole;
GRANT SELECT ON tblHSPhieuMuon TO DocGiaRole;

-- Gán User vào Role
EXEC sp_addrolemember 'ThuThuRole', 'thuthu';
EXEC sp_addrolemember 'DocGiaRole', 'docgia';

BACKUP DATABASE CongNgheNet_DoAnQLTV
TO DISK = 'D:\Backups\CongNgheNet_DoAnQLTV_Full.bak';
BACKUP DATABASE CongNgheNet_DoAnQLTV
TO DISK = 'D:\Backups\CongNgheNet_DoAnQLTV_Diff.bak'
WITH DIFFERENTIAL;
BACKUP LOG CongNgheNet_DoAnQLTV
TO DISK = 'D:\Backups\CongNgheNet_DoAnQLTV_Log.trn';

RESTORE DATABASE CongNgheNet_DoAnQLTV
FROM DISK = 'D:\Backups\CongNgheNet_DoAnQLTV_Full.bak'
WITH REPLACE;

RESTORE DATABASE CongNgheNet_DoAnQLTV
FROM DISK = 'D:\Backups\CongNgheNet_DoAnQLTV_Full.bak'
WITH NORECOVERY; -- Khôi phục bản sao lưu đầy đủ nhưng giữ cơ sở dữ liệu ở trạng thái khôi phục (chưa hoàn tất)
GO

RESTORE DATABASE CongNgheNet_DoAnQLTV
FROM DISK = 'D:\Backups\CongNgheNet_DoAnQLTV_Diff.bak'
WITH RECOVERY; -- Khôi phục bản sao lưu phân biệt và hoàn tất quá trình khôi phục

RESTORE LOG CongNgheNet_DoAnQLTV
FROM DISK = 'D:\Backups\CongNgheNet_DoAnQLTV_Log.trn'
WITH RECOVERY;

