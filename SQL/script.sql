USE [QLBANHANG]
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertProduct]
	-- Add the parameters for the stored procedure here
	@TenHang varchar(250),
	@LoaiHangId int,
	@DonViTinhId int,
	@NhaSanXuatId int,
	@GiaNhap int,
	@GiaXuat int,
	@SoLuong int,
	@KichThuocId int
AS
BEGIN
	Insert into Product
	([TenHang]
      ,[LoaiHangId]
      ,[DonViTinhId]
      ,[NhaSanXuatId]
      ,[GiaNhap]
      ,[GiaXuat]
      ,[SoLuong]
      ,[KichThuocId]
	  ,NgayTao) 
	  values(
	  @TenHang ,
	@LoaiHangId ,
	@DonViTinhId ,
	@NhaSanXuatId ,
	@GiaNhap ,
	@GiaXuat ,
	@SoLuong ,
	@KichThuocId ,
	GETDATE()
	  )
END

GO
/****** Object:  StoredProcedure [dbo].[SelectLookupData]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectLookupData]
	@GroupConfigName varchar(250) = NULL
AS
BEGIN
	SET NOCOUNT ON;

    Select Id, Ten from Lookup where 
	@GroupConfigName is null 
	or Nhom = (Select Id from Lookup where ConfigName = @GroupConfigName and Nhom is null)
END
GO
/****** Object:  StoredProcedure [dbo].[SelectProduct]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectProduct]
	@Id int = NULL
AS
BEGIN
	SET NOCOUNT ON;

    Select p.Id, p.TenHang, LoaiHang.Ten as LoaiHang, DonViTinh.Ten as DonViTinh,
	NhaSanXuat.Ten as NhaSanXuat, p.GiaNhap, p.GiaXuat, p.SoLuong, KichThuoc.Ten as KichThuoc
	from Product P 
		left join Lookup as LoaiHang on p.LoaiHangId = LoaiHang.Id
		left join Lookup as DonViTinh on p.DonViTinhId = DonViTinh.Id
		left join Lookup as NhaSanXuat on p.NhaSanXuatId = NhaSanXuat.Id
		left join Lookup as KichThuoc on p.KichThuocId = KichThuoc.Id
	where @Id is null or p.Id = @Id
END

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachHang] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SoDienThoai] [varchar](15) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](50) NULL,
	[ChucVuId] [int] NULL,
	[GioiTinhId] [bit] NULL,
	[SoDienThoai] [varchar](15) NULL,
	[NgaySinh] [date] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExportBill]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExportBill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[KhachHangId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[NgayXuat] [datetime] NULL,
	[TongGia] [int] NOT NULL,
 CONSTRAINT [PK_ExportBill] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExportBillDetail]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExportBillDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HoaDonXuatId] [int] NOT NULL,
	[SanPhamId] [int] NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
	[NgayXuat] [datetime] NULL,
 CONSTRAINT [PK_ExportBillDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImportBill]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportBill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NhaCungCapId] [int] NULL,
	[NhanVienId] [int] NULL,
	[NgayNhap] [datetime] NULL,
	[TongGia] [int] NULL,
 CONSTRAINT [PK_ImportBill] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImportBillDetail]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportBillDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HoaDonNhapId] [int] NOT NULL,
	[SanPhamId] [int] NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
	[NgaySanXuat] [date] NULL,
 CONSTRAINT [PK_ImportBillDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lookup]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Lookup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](250) NOT NULL,
	[ConfigName] [varchar](250) NULL,
	[MoTa] [nvarchar](250) NULL,
	[Nhom] [int] NULL,
 CONSTRAINT [PK_Lookup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenHang] [nvarchar](250) NOT NULL,
	[LoaiHangId] [int] NULL,
	[DonViTinhId] [int] NULL,
	[NhaSanXuatId] [int] NULL,
	[GiaNhap] [int] NOT NULL,
	[GiaXuat] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[KichThuocId] [int] NULL,
	[NgayTao] [datetime] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 1/16/2018 9:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Supplier](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[DienThoai] [varchar](15) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Lookup] FOREIGN KEY([ChucVuId])
REFERENCES [dbo].[Lookup] ([Id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Lookup]
GO
ALTER TABLE [dbo].[ExportBill]  WITH CHECK ADD  CONSTRAINT [FK_ExportBill_Customer] FOREIGN KEY([KhachHangId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[ExportBill] CHECK CONSTRAINT [FK_ExportBill_Customer]
GO
ALTER TABLE [dbo].[ExportBill]  WITH CHECK ADD  CONSTRAINT [FK_ExportBill_Employee] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ExportBill] CHECK CONSTRAINT [FK_ExportBill_Employee]
GO
ALTER TABLE [dbo].[ExportBillDetail]  WITH CHECK ADD  CONSTRAINT [FK_ExportBillDetail_ExportBill] FOREIGN KEY([HoaDonXuatId])
REFERENCES [dbo].[ExportBill] ([Id])
GO
ALTER TABLE [dbo].[ExportBillDetail] CHECK CONSTRAINT [FK_ExportBillDetail_ExportBill]
GO
ALTER TABLE [dbo].[ExportBillDetail]  WITH CHECK ADD  CONSTRAINT [FK_ExportBillDetail_Product] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ExportBillDetail] CHECK CONSTRAINT [FK_ExportBillDetail_Product]
GO
ALTER TABLE [dbo].[ImportBill]  WITH CHECK ADD  CONSTRAINT [FK_ImportBill_Employee] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ImportBill] CHECK CONSTRAINT [FK_ImportBill_Employee]
GO
ALTER TABLE [dbo].[ImportBill]  WITH CHECK ADD  CONSTRAINT [FK_ImportBill_Supplier] FOREIGN KEY([NhaCungCapId])
REFERENCES [dbo].[Supplier] ([Id])
GO
ALTER TABLE [dbo].[ImportBill] CHECK CONSTRAINT [FK_ImportBill_Supplier]
GO
ALTER TABLE [dbo].[ImportBillDetail]  WITH CHECK ADD  CONSTRAINT [FK_ImportBillDetail_ImportBill] FOREIGN KEY([HoaDonNhapId])
REFERENCES [dbo].[ImportBill] ([Id])
GO
ALTER TABLE [dbo].[ImportBillDetail] CHECK CONSTRAINT [FK_ImportBillDetail_ImportBill]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Lookup] FOREIGN KEY([LoaiHangId])
REFERENCES [dbo].[Lookup] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Lookup]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Lookup1] FOREIGN KEY([DonViTinhId])
REFERENCES [dbo].[Lookup] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Lookup1]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Lookup2] FOREIGN KEY([NhaSanXuatId])
REFERENCES [dbo].[Lookup] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Lookup2]
GO
