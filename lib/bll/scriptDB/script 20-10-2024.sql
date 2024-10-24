
/****** Object:  Table [dbo].[Dealing_Clients]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Clients]') AND type in (N'U'))
DROP TABLE [dbo].[Dealing_Clients]
GO
/****** Object:  Table [dbo].[Dealing_Employees]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Employees]') AND type in (N'U'))
DROP TABLE [dbo].[Dealing_Employees]
GO
/****** Object:  Table [dbo].[Dealing_Users]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Users]') AND type in (N'U'))
DROP TABLE [dbo].[Dealing_Users]
GO
/****** Object:  Table [dbo].[Dealing_Vendors]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Vendors]') AND type in (N'U'))
DROP TABLE [dbo].[Dealing_Vendors]
GO
/****** Object:  Table [dbo].[Def_Categories]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Categories]') AND type in (N'U'))
DROP TABLE [dbo].[Def_Categories]
GO
/****** Object:  Table [dbo].[Def_CompanyStructure]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_CompanyStructure]') AND type in (N'U'))
DROP TABLE [dbo].[Def_CompanyStructure]
GO
/****** Object:  Table [dbo].[Def_FinancialCluses]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_FinancialCluses]') AND type in (N'U'))
DROP TABLE [dbo].[Def_FinancialCluses]
GO
/****** Object:  Table [dbo].[Def_Jobs]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Jobs]') AND type in (N'U'))
DROP TABLE [dbo].[Def_Jobs]
GO
/****** Object:  Table [dbo].[Def_ProductionCompanies]    Script Date: 10/20/2024 16:33:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_ProductionCompanies]') AND type in (N'U'))
DROP TABLE [dbo].[Def_ProductionCompanies]
GO
/****** Object:  Table [dbo].[Def_ProductStructure]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_ProductStructure]') AND type in (N'U'))
DROP TABLE [dbo].[Def_ProductStructure]
GO
/****** Object:  Table [dbo].[Def_Sections]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Sections]') AND type in (N'U'))
DROP TABLE [dbo].[Def_Sections]
GO
/****** Object:  Table [dbo].[Def_Stocks]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Stocks]') AND type in (N'U'))
DROP TABLE [dbo].[Def_Stocks]
GO
/****** Object:  Table [dbo].[Def_Treasures]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Treasures]') AND type in (N'U'))
DROP TABLE [dbo].[Def_Treasures]
GO
/****** Object:  Table [dbo].[Def_Units]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Units]') AND type in (N'U'))
DROP TABLE [dbo].[Def_Units]
GO
/****** Object:  Table [dbo].[Fix_Address_City]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Address_City]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_Address_City]
GO
/****** Object:  Table [dbo].[Fix_Address_DistrictArea]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Address_DistrictArea]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_Address_DistrictArea]
GO
/****** Object:  Table [dbo].[Fix_Address_Government]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Address_Government]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_Address_Government]
GO
/****** Object:  Table [dbo].[Fix_BalanceType]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_BalanceType]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_BalanceType]
GO
/****** Object:  Table [dbo].[Fix_DocumentsType]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_DocumentsType]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_DocumentsType]
GO
/****** Object:  Table [dbo].[Fix_FinacialType]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_FinacialType]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_FinacialType]
GO
/****** Object:  Table [dbo].[Fix_Gender]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Gender]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_Gender]
GO
/****** Object:  Table [dbo].[Fix_MaritalStatus]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_MaritalStatus]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_MaritalStatus]
GO
/****** Object:  Table [dbo].[Fix_MilitaryStatus]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_MilitaryStatus]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_MilitaryStatus]
GO
/****** Object:  Table [dbo].[Fix_Monthes]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Monthes]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_Monthes]
GO
/****** Object:  Table [dbo].[Fix_PriceType]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_PriceType]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_PriceType]
GO
/****** Object:  Table [dbo].[Fix_Religions]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Religions]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_Religions]
GO
/****** Object:  Table [dbo].[Fix_RequestStatus]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_RequestStatus]') AND type in (N'U'))
DROP TABLE [dbo].[Fix_RequestStatus]
GO
/****** Object:  Table [dbo].[Inv_PermissionAdd]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionAdd]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_PermissionAdd]
GO
/****** Object:  Table [dbo].[Inv_PermissionAddDetails]    Script Date: 10/20/2024 16:33:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionAddDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_PermissionAddDetails]
GO
/****** Object:  Table [dbo].[Inv_PermissionDiscount]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionDiscount]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_PermissionDiscount]
GO
/****** Object:  Table [dbo].[Inv_PermissionDiscountDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionDiscountDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_PermissionDiscountDetails]
GO
/****** Object:  Table [dbo].[Inv_ProductsQty]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_ProductsQty]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_ProductsQty]
GO
/****** Object:  Table [dbo].[Inv_RecivedQty]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_RecivedQty]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_RecivedQty]
GO
/****** Object:  Table [dbo].[Inv_RecivedQtyDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_RecivedQtyDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_RecivedQtyDetails]
GO
/****** Object:  Table [dbo].[Inv_Settlement]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_Settlement]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_Settlement]
GO
/****** Object:  Table [dbo].[Inv_SettlementDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_SettlementDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_SettlementDetails]
GO
/****** Object:  Table [dbo].[Inv_Transfer]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_Transfer]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_Transfer]
GO
/****** Object:  Table [dbo].[Inv_TransferDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_TransferDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Inv_TransferDetails]
GO
/****** Object:  Table [dbo].[Invoices_Purchase]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_Purchase]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_Purchase]
GO
/****** Object:  Table [dbo].[Invoices_PurchaseDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_PurchaseDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_PurchaseDetails]
GO
/****** Object:  Table [dbo].[Invoices_PurchaseReturned]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_PurchaseReturned]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_PurchaseReturned]
GO
/****** Object:  Table [dbo].[Invoices_PurchaseReturnedDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_PurchaseReturnedDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_PurchaseReturnedDetails]
GO
/****** Object:  Table [dbo].[Invoices_Sales]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_Sales]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_Sales]
GO
/****** Object:  Table [dbo].[Invoices_SalesDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_SalesDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_SalesDetails]
GO
/****** Object:  Table [dbo].[Invoices_SalesReturned]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_SalesReturned]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_SalesReturned]
GO
/****** Object:  Table [dbo].[Invoices_SalesReturnedDetails]    Script Date: 10/20/2024 16:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_SalesReturnedDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_SalesReturnedDetails]
GO
/****** Object:  Table [dbo].[Invoices_SalesReturnedDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_SalesReturnedDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_SalesReturnedDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDInvoices_Sales] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Qty] [int] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [int] NULL,
	[isBigUnit] [bit] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices_SalesReturned]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_SalesReturned]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_SalesReturned](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](50) NULL,
	[Time] [nvarchar](50) NULL,
	[IDBranch] [bigint] NULL,
	[IDStock] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDClient] [bigint] NULL,
	[TotalValue] [decimal](18, 2) NULL,
	[DiscountValue] [decimal](18, 2) NULL,
	[DiscountPercent] [decimal](18, 2) NULL,
	[NetValue] [decimal](18, 2) NULL,
	[IsClosed] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[UID] [nvarchar](500) NULL,
	[CurrentBalance] [decimal](18, 2) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices_SalesDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_SalesDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_SalesDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDInvoices_Sales] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Qty] [int] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [int] NULL,
	[isBigUnit] [bit] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices_Sales]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_Sales]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_Sales](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](50) NULL,
	[Time] [nvarchar](50) NULL,
	[IDBranch] [bigint] NULL,
	[IDStock] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDClient] [bigint] NULL,
	[TotalValue] [decimal](18, 2) NULL,
	[DiscountValue] [decimal](18, 2) NULL,
	[DiscountPercent] [decimal](18, 2) NULL,
	[NetValue] [decimal](18, 2) NULL,
	[IsClosed] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[UID] [nvarchar](500) NULL,
	[CurrentBalance] [decimal](18, 2) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices_PurchaseReturnedDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_PurchaseReturnedDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_PurchaseReturnedDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDPurchaseInvoice] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Qty] [int] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [int] NULL,
	[isBigUnit] [bit] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices_PurchaseReturned]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_PurchaseReturned]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_PurchaseReturned](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](50) NULL,
	[Time] [nvarchar](50) NULL,
	[IDBranch] [bigint] NULL,
	[IDStock] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDVendor] [bigint] NULL,
	[VendorSerial] [nvarchar](50) NULL,
	[TotalValue] [decimal](18, 2) NULL,
	[DiscountValue] [decimal](18, 2) NULL,
	[DiscountPercent] [decimal](18, 2) NULL,
	[NetValue] [decimal](18, 2) NULL,
	[IsClosed] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[UID] [nvarchar](500) NULL,
	[CurrentBalance] [decimal](18, 2) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices_PurchaseDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_PurchaseDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_PurchaseDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDPurchaseInvoice] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Qty] [int] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [int] NULL,
	[isBigUnit] [bit] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices_Purchase]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_Purchase]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices_Purchase](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](50) NULL,
	[Time] [nvarchar](50) NULL,
	[IDBranch] [bigint] NULL,
	[IDStock] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDVendor] [bigint] NULL,
	[VendorSerial] [nvarchar](50) NULL,
	[TotalValue] [decimal](18, 2) NULL,
	[DiscountValue] [decimal](18, 2) NULL,
	[DiscountPercent] [decimal](18, 2) NULL,
	[NetValue] [decimal](18, 2) NULL,
	[IsClosed] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[UID] [nvarchar](500) NULL,
	[CurrentBalance] [decimal](18, 2) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_TransferDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_TransferDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_TransferDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDTranfer] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitBig_Qty] [bigint] NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [bigint] NULL,
	[isBigUnit] [bit] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_Transfer]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_Transfer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_Transfer](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](500) NULL,
	[Time] [nvarchar](50) NULL,
	[IDRequestStatus] [bigint] NULL,
	[IDBranchFrom] [bigint] NULL,
	[IDStockFrom] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDBranchTo] [bigint] NULL,
	[IDStockTo] [bigint] NULL,
	[TotalValueFrom] [decimal](18, 2) NULL,
	[TotalValueTo] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[UID] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_SettlementDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_SettlementDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_SettlementDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDSettlement] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[IDUnit] [bigint] NULL,
	[BookingQty] [int] NULL,
	[ActualQty] [int] NOT NULL,
	[PriceType] [bigint] NULL,
	[Price] [decimal](18, 2) NULL,
	[DiffQty] [int] NULL,
	[DiffTotalPrice] [decimal](18, 2) NULL,
	[AddQty] [int] NULL,
	[AddTotalPrice] [decimal](18, 2) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_Settlement]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_Settlement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_Settlement](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDBranch] [bigint] NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](50) NULL,
	[Time] [nvarchar](50) NULL,
	[IDStock] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDRequestStatus] [bigint] NULL,
	[Note] [nvarchar](500) NULL,
	[SettlementAddValue] [decimal](18, 2) NULL,
	[SettlementDiscountValue] [decimal](18, 2) NULL,
	[NetValue] [decimal](18, 2) NULL,
	[UID] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_RecivedQtyDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_RecivedQtyDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_RecivedQtyDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDRecived] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitBig_Qty] [bigint] NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [bigint] NULL,
	[isBigUnit] [bit] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL,
	[RecivedUnitBig_ID] [bigint] NULL,
	[RecivedUnitBig_Price] [decimal](18, 2) NULL,
	[RecivedUnitBig_Qty] [bigint] NULL,
	[RecivedUnitSmall_ID] [bigint] NULL,
	[RecivedUnitSmall_Price] [decimal](18, 2) NULL,
	[RecivedUnitSmall_Qty] [bigint] NULL,
	[RecivedisBigUnit] [bit] NULL,
	[RecivedTotalPrice] [decimal](18, 2) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_RecivedQty]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_RecivedQty]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_RecivedQty](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](500) NULL,
	[Time] [nvarchar](50) NULL,
	[IDRequestStatus] [bigint] NULL,
	[IDBranchFrom] [bigint] NULL,
	[IDStockFrom] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDBranchTo] [bigint] NULL,
	[IDStockTo] [bigint] NULL,
	[TotalValueFrom] [decimal](18, 2) NULL,
	[TotalValueTo] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[UID] [nvarchar](50) NULL,
	[IDTransfer] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_ProductsQty]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_ProductsQty]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_ProductsQty](
	[ID] [nvarchar](50) NOT NULL,
	[IDStock] [bigint] NULL,
	[StockName] [nvarchar](50) NULL,
	[BarCode] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[ProductName] [nvarchar](50) NULL,
	[IDClassefications] [bigint] NULL,
	[ClasseficationsName] [nvarchar](50) NULL,
	[IDProductionCompanies] [bigint] NULL,
	[ProductionCompaniesName] [nvarchar](50) NULL,
	[IDUnit] [bigint] NULL,
	[UnitName] [nvarchar](50) NULL,
	[QtyBefore] [int] NULL,
	[Qty] [int] NULL,
	[QtyAfter] [int] NULL,
	[QtyRepresents] [int] NULL,
	[TotalQty] [int] NULL,
	[DateInserted] [nvarchar](50) NULL,
	[IDDocument] [bigint] NULL,
	[IDDocumentType] [bigint] NULL,
	[DocumentTypeName] [nvarchar](50) NULL,
	[LineNumber] [bigint] NULL,
	[Price] [decimal](18, 2) NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[IDPriceType] [bigint] NULL,
	[PriceTypeName] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_PermissionDiscountDetails]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionDiscountDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_PermissionDiscountDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDPermission] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitBig_Qty] [bigint] NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [bigint] NULL,
	[isBigUnit] [bit] NULL,
	[Balance] [int] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_PermissionDiscount]    Script Date: 10/20/2024 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionDiscount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_PermissionDiscount](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDBranch] [bigint] NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](500) NULL,
	[Time] [nvarchar](500) NULL,
	[IDStock] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDRequestStatus] [bigint] NULL,
	[Note] [nvarchar](500) NULL,
	[Value] [decimal](18, 2) NULL,
	[UID] [nvarchar](500) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_PermissionAddDetails]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionAddDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_PermissionAddDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDPermission] [bigint] NULL,
	[IDProduct] [bigint] NULL,
	[Barcode] [bigint] NULL,
	[IDClassefication] [bigint] NULL,
	[IDProductionCompanies] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_Price] [decimal](18, 2) NULL,
	[UnitBig_Qty] [bigint] NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_Price] [decimal](18, 2) NULL,
	[UnitSmall_Qty] [bigint] NULL,
	[isBigUnit] [bit] NULL,
	[Balance] [int] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[PriceType] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Inv_PermissionAdd]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inv_PermissionAdd]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inv_PermissionAdd](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDBranch] [bigint] NULL,
	[Code] [bigint] NULL,
	[Date] [nvarchar](500) NULL,
	[Time] [nvarchar](500) NULL,
	[IDStock] [bigint] NULL,
	[IDEmployee] [bigint] NULL,
	[IDRequestStatus] [bigint] NULL,
	[Note] [nvarchar](500) NULL,
	[Value] [decimal](18, 2) NULL,
	[UID] [nvarchar](500) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_RequestStatus]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_RequestStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_RequestStatus](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_Religions]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Religions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_Religions](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_PriceType]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_PriceType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_PriceType](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_Monthes]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Monthes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_Monthes](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_MilitaryStatus]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_MilitaryStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_MilitaryStatus](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_MaritalStatus]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_MaritalStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_MaritalStatus](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_Gender]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Gender]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_Gender](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_FinacialType]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_FinacialType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_FinacialType](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_DocumentsType]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_DocumentsType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_DocumentsType](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_BalanceType]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_BalanceType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_BalanceType](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_Address_Government]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Address_Government]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_Address_Government](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_Address_DistrictArea]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Address_DistrictArea]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_Address_DistrictArea](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CityID] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Fix_Address_City]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix_Address_City]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fix_Address_City](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IDGovernment] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_Units]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Units]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_Units](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_Treasures]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Treasures]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_Treasures](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Name] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsBindBranch] [bit] NULL,
	[IDBranch] [bigint] NULL,
	[Balance] [decimal](18, 2) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_Stocks]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Stocks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_Stocks](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Name] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsBindBranch] [bit] NULL,
	[IDBranch] [bigint] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_Sections]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Sections]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_Sections](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_ProductStructure]    Script Date: 10/20/2024 16:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_ProductStructure]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_ProductStructure](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[BarCode] [bigint] NULL,
	[Name] [nvarchar](1000) NULL,
	[IDCategory] [bigint] NULL,
	[IDProductionCompany] [bigint] NULL,
	[UnitBig_ID] [bigint] NULL,
	[UnitBig_PurchasePrice] [decimal](18, 2) NULL,
	[UnitBig_Sales1] [decimal](18, 2) NULL,
	[UnitBig_Sales2] [decimal](18, 2) NULL,
	[UnitBig_Sales3] [decimal](18, 2) NULL,
	[UnitBig_Sales4] [decimal](18, 2) NULL,
	[UnitBig_Sales5] [decimal](18, 2) NULL,
	[UnitCountOf] [int] NULL,
	[UnitSmall_ID] [bigint] NULL,
	[UnitSmall_PurchasePrice] [decimal](18, 2) NULL,
	[UnitSmall_Sales1] [decimal](18, 2) NULL,
	[UnitSmall_Sales2] [decimal](18, 2) NULL,
	[UnitSmall_Sales3] [decimal](18, 2) NULL,
	[UnitSmall_Sales4] [decimal](18, 2) NULL,
	[UnitSmall_Sales5] [decimal](18, 2) NULL,
	[LimitedQty] [bigint] NULL,
	[IsActive] [bit] NULL,
	[IsPOS] [bit] NULL,
	[IsUpdated] [bit] NULL,
	[controller] [nvarchar](max) NULL,
	[ImageName1] [nvarchar](max) NULL,
	[ImageURL1] [nvarchar](max) NULL,
	[ImageName2] [nvarchar](max) NULL,
	[ImageURL2] [nvarchar](max) NULL,
	[ImageName3] [nvarchar](max) NULL,
	[ImageURL3] [nvarchar](max) NULL,
	[ImageName4] [nvarchar](max) NULL,
	[ImageURL4] [nvarchar](max) NULL,
	[ImageName5] [nvarchar](max) NULL,
	[ImageURL5] [nvarchar](max) NULL,
	[Discription] [nvarchar](max) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_ProductionCompanies]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_ProductionCompanies]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_ProductionCompanies](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NULL,
	[IsSalesCategory] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_Jobs]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Jobs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_Jobs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_FinancialCluses]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_FinancialCluses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_FinancialCluses](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [bigint] NULL,
	[Name] [nvarchar](50) NULL,
	[IsViewToRepresent] [bit] NULL,
	[IDFinancialType] [bigint] NULL,
	[IsDefaultToTransferMony] [bit] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_CompanyStructure]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_CompanyStructure]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_CompanyStructure](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [int] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[DateCreate] [nvarchar](500) NULL,
	[Adress] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Logo] [nvarchar](500) NULL,
	[isActive] [bit] NULL,
	[isOwner] [bit] NULL,
	[defaultStock] [nvarchar](500) NULL,
	[defaultTreasure] [nvarchar](500) NULL,
	[defaultEmployee] [nvarchar](500) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Def_Categories]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Def_Categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Def_Categories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NULL,
	[IsSalesCategory] [bit] NULL,
	[IsViewAllProducts] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Dealing_Vendors]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Vendors]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dealing_Vendors](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDBranch] [bigint] NULL,
	[Code] [bigint] NULL,
	[Name] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[CurrentBalance] [decimal](18, 2) NULL,
	[BalanceType] [bigint] NULL,
	[Mobile] [nvarchar](20) NULL,
	[Phone] [nvarchar](20) NULL,
	[Address] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Dealing_Users]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dealing_Users](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UID] [nvarchar](250) NULL,
	[IDBranch] [bigint] NULL,
	[Code] [bigint] NULL,
	[Name] [nvarchar](250) NULL,
	[EMail] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[IsAdminAccount] [bit] NULL,
	[IDEmployeeBind] [bigint] NULL,
	[Mobile] [nvarchar](20) NULL,
	[Phone] [nvarchar](20) NULL,
	[Address] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
	[ImageName] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Dealing_Employees]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Employees]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dealing_Employees](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDBranch] [bigint] NULL,
	[Code] [bigint] NULL,
	[Name] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[Phone] [nvarchar](20) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Address] [nvarchar](1000) NULL,
	[NationalID] [nvarchar](20) NULL,
	[BirthDate] [nvarchar](20) NULL,
	[Age] [decimal](18, 2) NULL,
	[IDMaritalStatus] [bigint] NULL,
	[ChildrenCount] [bigint] NULL,
	[IDReligions] [bigint] NULL,
	[IDGender] [bigint] NULL,
	[IDMilitaryStatus] [bigint] NULL,
	[Qualification] [nvarchar](100) NULL,
	[IDJob] [bigint] NULL,
	[IDDepartment] [bigint] NULL,
	[DateHiring] [nvarchar](20) NULL,
	[TimeWorkFrom] [nvarchar](20) NULL,
	[TimeWorkTo] [nvarchar](20) NULL,
	[TimeTotalWorkHour] [decimal](18, 2) NULL,
	[MonthlyVacationDays] [int] NULL,
	[ExpiryDateJob] [nvarchar](20) NULL,
	[LeavingReson] [nvarchar](500) NULL,
	[SalaryMonthValue] [decimal](18, 2) NULL,
	[SalaryWeekValue] [decimal](18, 2) NULL,
	[SalaryDayValue] [decimal](18, 2) NULL,
	[SalaryHourValue] [decimal](18, 2) NULL,
	[MonthlyTarget] [decimal](18, 2) NULL,
	[MonthlyCommissionExecute] [decimal](18, 2) NULL,
	[MonthlyCommissionNotExecute] [decimal](18, 2) NULL,
	[DailyTarget] [decimal](18, 2) NULL,
	[DailyCommissionExecute] [decimal](18, 2) NULL,
	[DailyCommissionNotExecute] [decimal](18, 2) NULL,
	[CommissionSales1] [decimal](18, 2) NULL,
	[CommissionSalesReturned1] [decimal](18, 2) NULL,
	[CommissionSales2] [decimal](18, 2) NULL,
	[CommissionSalesReturned2] [decimal](18, 2) NULL,
	[CommissionSales3] [decimal](18, 2) NULL,
	[CommissionSalesReturned3] [decimal](18, 2) NULL,
	[CommissionSales4] [decimal](18, 2) NULL,
	[CommissionSalesReturned4] [decimal](18, 2) NULL,
	[CommissionSales5] [decimal](18, 2) NULL,
	[CommissionSalesReturned5] [decimal](18, 2) NULL,
	[RelativeName1] [nvarchar](50) NULL,
	[RelativeMobile1] [nvarchar](50) NULL,
	[RelativeType1] [nvarchar](50) NULL,
	[RelativeName2] [nvarchar](50) NULL,
	[RelativeMobile2] [nvarchar](50) NULL,
	[RelativeType2] [nvarchar](50) NULL,
	[RelativeName3] [nvarchar](50) NULL,
	[RelativeMobile3] [nvarchar](50) NULL,
	[RelativeType3] [nvarchar](50) NULL,
	[RelativeName4] [nvarchar](50) NULL,
	[RelativeMobile4] [nvarchar](50) NULL,
	[RelativeType4] [nvarchar](50) NULL,
	[ImageName] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Dealing_Clients]    Script Date: 10/20/2024 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dealing_Clients]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dealing_Clients](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDBranch] [bigint] NULL,
	[Code] [bigint] NULL,
	[Name] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[CurrentBalance] [decimal](18, 2) NULL,
	[BalanceType] [bigint] NULL,
	[Mobile] [nvarchar](20) NULL,
	[Phone] [nvarchar](20) NULL,
	[Address] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
	[IDPriceType] [bigint] NULL,
	[CreditLimit] [decimal](18, 2) NULL,
	[LocationLink] [nvarchar](50) NULL,
	[LocationLatitude] [decimal](18, 0) NULL,
	[LocationLongitude] [decimal](18, 0) NULL,
	[LocationImage] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
