USE [master]
GO
/****** Object:  Database [Online_Store]    Script Date: 1/3/2025 3:38:30 PM ******/
CREATE DATABASE [Online_Store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'P5 - OnlineShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\P5 - OnlineShop.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'P5 - OnlineShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\P5 - OnlineShop_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Online_Store] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Online_Store].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Online_Store] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Online_Store] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Online_Store] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Online_Store] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Online_Store] SET ARITHABORT OFF 
GO
ALTER DATABASE [Online_Store] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Online_Store] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Online_Store] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Online_Store] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Online_Store] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Online_Store] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Online_Store] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Online_Store] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Online_Store] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Online_Store] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Online_Store] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Online_Store] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Online_Store] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Online_Store] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Online_Store] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Online_Store] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Online_Store] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Online_Store] SET RECOVERY FULL 
GO
ALTER DATABASE [Online_Store] SET  MULTI_USER 
GO
ALTER DATABASE [Online_Store] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Online_Store] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Online_Store] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Online_Store] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Online_Store] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Online_Store] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Online_Store', N'ON'
GO
ALTER DATABASE [Online_Store] SET QUERY_STORE = ON
GO
ALTER DATABASE [Online_Store] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Online_Store]
GO
/****** Object:  Table [dbo].[ChartData]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChartData](
	[ChartDataID] [int] IDENTITY(1,1) NOT NULL,
	[Month] [nvarchar](50) NOT NULL,
	[TotalOrders] [int] NOT NULL,
	[TotalVisitors] [int] NOT NULL,
	[TotalMonthSales] [int] NOT NULL,
 CONSTRAINT [PK_ChartData] PRIMARY KEY CLUSTERED 
(
	[ChartDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompeleteOrders]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompeleteOrders](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[TotalAmount] [smallmoney] NOT NULL,
	[Status] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__Customer__A4AE64B86563B9B8] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favourites]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favourites](
	[FavouritItemID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[AddedToFavourite] [bit] NOT NULL,
 CONSTRAINT [PK_Favourites] PRIMARY KEY CLUSTERED 
(
	[FavouritItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
	[DateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationCustomer]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationCustomer](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[NewProductID] [int] NULL,
	[NewCategoryID] [int] NULL,
	[DateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_NotificationCustomer] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationOwner]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationOwner](
	[NoticficationID] [int] IDENTITY(1,1) NOT NULL,
	[NewCustomerID] [int] NULL,
	[NewPaymentID] [int] NULL,
	[DateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_NotificationOwner] PRIMARY KEY CLUSTERED 
(
	[NoticficationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 1/3/2025 3:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Size] [nvarchar](10) NULL,
	[Color] [nvarchar](50) NULL,
	[Price] [smallmoney] NOT NULL,
	[TotalItemsPrice] [smallmoney] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[TotalAmount] [smallmoney] NOT NULL,
	[Status] [smallint] NOT NULL,
 CONSTRAINT [PK__Orders__C3905BAF37153F67] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[Amount] [smallmoney] NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[TransactionDate] [date] NOT NULL,
 CONSTRAINT [PK__Payments__9B556A583CAD2638] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PendingOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PendingOrders](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[TotalAmount] [smallmoney] NOT NULL,
	[Status] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessingOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessingOrders](
	[OrderID] [int] NOT NULL,
	[CustomerID] [nvarchar](100) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[TotalAmount] [smallmoney] NOT NULL,
	[Status] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCatalog]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCatalog](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[LongDescription] [nvarchar](max) NOT NULL,
	[Price] [smallmoney] NOT NULL,
	[QuantityInStock] [int] NOT NULL,
	[ImageURL] [nvarchar](200) NOT NULL,
	[VideoURL] [nvarchar](200) NULL,
	[CategoryID] [int] NOT NULL,
	[SubCategoryID] [int] NOT NULL,
	[Taxes] [decimal](18, 0) NULL,
	[ADS] [decimal](18, 0) NULL,
	[Discount] [int] NULL,
	[InsertionDate] [date] NULL,
	[InsertByUserID] [int] NULL,
 CONSTRAINT [PK__ProductC__B40CC6EDEB4EC44B] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[CategoryImage] [nvarchar](500) NOT NULL,
	[InsertByUserID] [int] NULL,
 CONSTRAINT [PK__ProductC__19093A2B4AA82D9C] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductColor]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductColor](
	[ColorID] [int] IDENTITY(1,1) NOT NULL,
	[Color] [nvarchar](100) NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_ProductColor] PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImageURL] [nvarchar](200) NOT NULL,
	[ImageOrder] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSize]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSize](
	[SizeID] [int] IDENTITY(1,1) NOT NULL,
	[Size] [nvarchar](50) NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_ProductSize] PRIMARY KEY CLUSTERED 
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Responses]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Responses](
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[OwnerID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Response] [nvarchar](500) NOT NULL,
	[MessageID] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[CustomerID] [int] NOT NULL,
 CONSTRAINT [PK_Responses] PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[CustomerID] [int] NULL,
	[ReviewText] [nvarchar](500) NULL,
	[Rating] [decimal](2, 1) NOT NULL,
	[ReviewDate] [datetime] NOT NULL,
 CONSTRAINT [PK__Reviews__74BC79AE335944D9] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesReport]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesReport](
	[SalesID] [int] IDENTITY(1,1) NOT NULL,
	[Month] [nvarchar](50) NOT NULL,
	[Year] [int] NULL,
	[TotalSales] [int] NOT NULL,
	[TotalRevenue] [decimal](19, 4) NOT NULL,
 CONSTRAINT [PK_SalesReport] PRIMARY KEY CLUSTERED 
(
	[SalesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shippers]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippers](
	[CarrierID] [int] IDENTITY(1,1) NOT NULL,
	[CarrierName] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[InsertByUserID] [int] NULL,
 CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED 
(
	[CarrierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shippings]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippings](
	[ShippingID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[CarrierID] [int] NOT NULL,
	[TrackingNumber] [nvarchar](50) NOT NULL,
	[ShippingStatus] [smallint] NOT NULL,
	[EstimatedDeliveryDate] [datetime] NOT NULL,
	[ActualDeliveryDate] [datetime] NULL,
 CONSTRAINT [PK_Shippings] PRIMARY KEY CLUSTERED 
(
	[ShippingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategory](
	[SubCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[SubCategoryName] [nvarchar](200) NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED 
(
	[SubCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[ImageURL] [nvarchar](200) NULL,
	[Permissions] [int] NOT NULL,
 CONSTRAINT [PK_Owners] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WeeklySales]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeeklySales](
	[WeeklySalesID] [int] IDENTITY(1,1) NOT NULL,
	[Month] [nvarchar](50) NOT NULL,
	[Week1Sales] [int] NOT NULL,
	[Week2Sales] [int] NOT NULL,
	[Week3Sales] [int] NOT NULL,
	[Week4Sales] [int] NOT NULL,
 CONSTRAINT [PK_WeeklySales] PRIMARY KEY CLUSTERED 
(
	[WeeklySalesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChartData] ON 

INSERT [dbo].[ChartData] ([ChartDataID], [Month], [TotalOrders], [TotalVisitors], [TotalMonthSales]) VALUES (1, N'January', 20, 10, 19)
INSERT [dbo].[ChartData] ([ChartDataID], [Month], [TotalOrders], [TotalVisitors], [TotalMonthSales]) VALUES (3, N'February', 15, 13, 13)
INSERT [dbo].[ChartData] ([ChartDataID], [Month], [TotalOrders], [TotalVisitors], [TotalMonthSales]) VALUES (4, N'March', 32, 22, 29)
INSERT [dbo].[ChartData] ([ChartDataID], [Month], [TotalOrders], [TotalVisitors], [TotalMonthSales]) VALUES (5, N'April', 19, 10, 19)
INSERT [dbo].[ChartData] ([ChartDataID], [Month], [TotalOrders], [TotalVisitors], [TotalMonthSales]) VALUES (6, N'May', 25, 11, 24)
INSERT [dbo].[ChartData] ([ChartDataID], [Month], [TotalOrders], [TotalVisitors], [TotalMonthSales]) VALUES (7, N'June', 8, 1, 8)
INSERT [dbo].[ChartData] ([ChartDataID], [Month], [TotalOrders], [TotalVisitors], [TotalMonthSales]) VALUES (8, N'July', 4, 3, 4)
SET IDENTITY_INSERT [dbo].[ChartData] OFF
GO
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (2008, 1, CAST(N'2024-04-29T00:15:05.607' AS DateTime), 12000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1014, 1, CAST(N'2024-04-25T18:35:30.590' AS DateTime), 52000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (2008, 1, CAST(N'2024-04-29T00:15:05.607' AS DateTime), 12000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5, 1, CAST(N'2024-04-22T15:22:52.183' AS DateTime), 81000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1018, 1, CAST(N'2024-04-25T20:39:02.580' AS DateTime), 26000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (7, 1, CAST(N'2024-04-22T22:18:14.620' AS DateTime), 4000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1012, 1, CAST(N'2024-04-25T18:29:26.970' AS DateTime), 52000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1008, 1, CAST(N'2024-04-25T15:20:05.763' AS DateTime), 22000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1017, 1, CAST(N'2024-04-25T20:38:25.113' AS DateTime), 20000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1015, 1, CAST(N'2024-04-25T20:35:40.990' AS DateTime), 10000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1010, 1, CAST(N'2024-04-25T15:38:02.490' AS DateTime), 26000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3008, 1, CAST(N'2024-06-12T12:54:08.843' AS DateTime), 4000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4, 1, CAST(N'2024-04-22T15:22:52.183' AS DateTime), 81000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (8, 1, CAST(N'2024-04-25T15:09:12.017' AS DateTime), 39000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (6, 1, CAST(N'2024-04-22T15:27:30.077' AS DateTime), 44000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3, 1, CAST(N'2024-04-22T15:21:40.077' AS DateTime), 81000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (2, 1, CAST(N'2024-04-22T11:57:07.777' AS DateTime), 19000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1, 1, CAST(N'2024-04-22T11:55:44.390' AS DateTime), 19000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3009, 1, CAST(N'2024-06-14T11:27:18.947' AS DateTime), 2500.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3010, 1, CAST(N'2024-06-14T11:28:26.327' AS DateTime), 4000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3015, 1, CAST(N'2024-06-21T17:18:04.100' AS DateTime), 16000.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3012, 1, CAST(N'2024-06-14T11:37:13.420' AS DateTime), 5400.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3011, 1, CAST(N'2024-06-14T11:31:34.467' AS DateTime), 16000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1013, 1, CAST(N'2024-04-25T18:33:11.250' AS DateTime), 52000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1016, 1, CAST(N'2024-04-25T20:36:40.137' AS DateTime), 16000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1009, 1, CAST(N'2024-04-25T15:28:28.510' AS DateTime), 35000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1011, 1, CAST(N'2024-04-25T15:42:30.223' AS DateTime), 12000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4022, 1, CAST(N'2024-07-19T21:14:10.290' AS DateTime), 72.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4024, 1, CAST(N'2024-07-19T23:07:12.947' AS DateTime), 359.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5050, 5017, CAST(N'2024-12-15T21:03:39.410' AS DateTime), 1183.0000, 4)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3014, 1, CAST(N'2024-06-21T17:14:01.417' AS DateTime), 16000.0000, 2)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4021, 1, CAST(N'2024-07-19T21:09:40.517' AS DateTime), 19.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5051, 5017, CAST(N'2024-12-22T22:44:18.357' AS DateTime), 538.0000, 4)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4027, 1, CAST(N'2024-07-21T18:35:01.433' AS DateTime), 19.5000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4026, 1, CAST(N'2024-07-21T18:32:39.103' AS DateTime), 39.0000, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4028, 1, CAST(N'2024-07-21T19:30:41.867' AS DateTime), 209.1600, 3)
INSERT [dbo].[CompeleteOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4029, 1, CAST(N'2024-07-21T19:36:23.913' AS DateTime), 629.0000, 3)
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (1, N'Asim Yasin', N'asim@gmail.com', N'2151626721', N'Egypt-Cairo', N'88c263d7ba087c24932fa63d6364db5dd2ba2f9873d03bf4db37c203338a0d4e')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (1002, N'Ali Maher', N'Ali@gmail.com', N'0118328328', N'Egypt-Cairo', N'b27807a524e3b19040d1076355f4fb3dd752927064ab99742102be81d3b2354c')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (2002, N'Ammar Ali', N'Ammar@gmail.com', N'23982389392', N'Egypt-Alex', N'2580ff95ad9569ad4b0d0c84feed17b5b6542909241fc730b32a1b2b428aa5e2')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (2003, N'Aliaa', N'Aliaa@gmail.com', N'3292389109', N'UK-London', N'500e51d40d21a14f57abb6406010d9896746b48b9d2b3031fb497337a751aa36')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (3012, N'Ammar', N'Ammar@gmail.com', N'3287362701820', N'Egypt-Cairo', N'63bb8c9486c76e0c4f58e03ddf841e5e1d200615576992f3a1d76115a0b2a926')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (4013, N'Assomi', N'Assomi@gmail.com', N'2932981900', N'Egypt', N'bd1e1cc3e4cb8504c2d31e1a1c2c4a5c1c24dd85aac5fc455b734562c1034ba5')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (5015, N'ASIM YASIN OMER AHMED', N'as1549yasas@gmail.com', N'01115346864', N'Kafr El Sheikh', N'92b4335f47010b388432439fdf8c467d0e1e12548cac43180cb4ed5428c8e095')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (5016, N'ASIM YASIN OMER AHMED', N'as1549yasas@gmail.com', N'01115346864', N'Kafr El Sheikh', N'ff1680f007756e3e8f3c869d36670f2906656786b3e5d447072ea964f713f661')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address], [Password]) VALUES (5017, N'ASIM YASIN OMER AHMED', N'as1549yasas@gmail.com', N'01115346864', N'Kafr El Sheikh', N'6cb760e825a8ee0d7ab58e29c70d056a944bc13ad3a528c2779a6b809a8ebad6')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Favourites] ON 

INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (20, 1, 3, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (27, 1, 1, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (1002, 1, 1004, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (2002, 1, 2006, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (4002, 1, 3008, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (5005, 1, 2, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (5007, 1, 3016, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (5009, 5017, 2006, 1)
INSERT [dbo].[Favourites] ([FavouritItemID], [CustomerID], [ProductID], [AddedToFavourite]) VALUES (5010, 5017, 2007, 1)
SET IDENTITY_INSERT [dbo].[Favourites] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1, 1, N'Hi, This test Message.', CAST(N'2024-05-05T04:04:22.757' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (2, 1, N'Hi, this is test2.', CAST(N'2024-05-05T04:16:59.833' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1002, 1, N'Hi, this is Test3.', CAST(N'2024-07-19T19:47:03.243' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1003, 1, N'Test4.', CAST(N'2024-07-19T21:07:40.130' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1004, 1, N'Test5.', CAST(N'2024-07-19T23:01:33.620' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1005, 1, N'Test6.', CAST(N'2024-07-21T19:45:53.773' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1006, 1, N'Test7.', CAST(N'2024-07-22T10:44:04.683' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1007, 1, N'hey', CAST(N'2024-07-26T11:08:34.720' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1008, 1, N'hey', CAST(N'2024-07-26T11:10:30.110' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1009, 1, N'hi', CAST(N'2024-07-26T19:25:42.553' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1010, 1, N'hi', CAST(N'2024-07-27T15:19:14.007' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1011, 1, N'hi', CAST(N'2024-07-27T15:25:01.500' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1012, 1, N'hi', CAST(N'2024-07-27T15:54:15.690' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1013, 1, N'hi', CAST(N'2024-07-27T16:00:42.180' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1014, 1, N'hi', CAST(N'2024-07-27T18:17:35.740' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1015, 1, N'hi', CAST(N'2024-07-28T00:57:57.243' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1016, 1, N'hi', CAST(N'2024-07-28T01:07:34.687' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1017, 1, N'hi', CAST(N'2024-07-28T10:47:07.623' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1018, 1, N'hi', CAST(N'2024-07-28T11:10:04.150' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1019, 1, N'hi', CAST(N'2024-07-28T11:12:23.010' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (1020, 1, N'hi', CAST(N'2024-07-28T11:52:40.930' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (2015, 5017, N'Hi, thank you for your service😊', CAST(N'2024-12-26T12:04:00.387' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [CustomerID], [Message], [DateTime]) VALUES (2016, 5017, N'Hi, How long it will take to receive the order🤔', CAST(N'2024-12-26T12:07:12.097' AS DateTime))
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[NotificationCustomer] ON 

INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (1, 2006, NULL, CAST(N'2024-05-16T12:07:24.237' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2, 2007, NULL, CAST(N'2024-06-07T12:28:00.210' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (1002, 2010, NULL, CAST(N'2024-06-24T12:43:20.297' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2002, 3008, NULL, CAST(N'2024-06-30T23:55:22.617' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2003, 3009, NULL, CAST(N'2024-07-01T00:05:13.337' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2004, 3010, NULL, CAST(N'2024-07-01T19:54:23.810' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2005, 3011, NULL, CAST(N'2024-07-01T20:07:46.060' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2006, 3012, NULL, CAST(N'2024-07-02T00:38:08.503' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2007, 3013, NULL, CAST(N'2024-07-02T00:44:33.383' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2008, NULL, 3002, CAST(N'2024-07-04T00:52:31.500' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (2009, NULL, 3003, CAST(N'2024-07-04T00:53:11.607' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3008, 3014, NULL, CAST(N'2024-07-16T16:05:30.570' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3009, 3015, NULL, CAST(N'2024-07-17T15:42:35.013' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3010, 3016, NULL, CAST(N'2024-07-23T18:24:57.580' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3011, 3017, NULL, CAST(N'2024-07-23T20:08:53.927' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3012, 3018, NULL, CAST(N'2024-07-24T10:22:53.453' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3013, 3019, NULL, CAST(N'2024-07-24T11:05:26.503' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3014, NULL, 4002, CAST(N'2024-07-24T11:21:05.430' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3015, 3020, NULL, CAST(N'2024-07-24T11:32:57.570' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3016, NULL, 4003, CAST(N'2024-07-24T14:45:09.267' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3017, NULL, 4004, CAST(N'2024-07-24T14:47:20.297' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3018, NULL, 4005, CAST(N'2024-07-24T14:48:02.113' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3019, NULL, 4006, CAST(N'2024-07-24T15:12:16.873' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3020, NULL, 4007, CAST(N'2024-07-24T15:12:52.877' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3021, NULL, 4008, CAST(N'2024-07-24T15:14:45.613' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3022, NULL, 4009, CAST(N'2024-07-24T15:28:00.403' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3023, NULL, 4010, CAST(N'2024-07-24T15:35:11.120' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3024, NULL, 4011, CAST(N'2024-07-24T15:44:40.473' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3025, NULL, 4012, CAST(N'2024-07-24T15:58:47.963' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3026, NULL, 4013, CAST(N'2024-07-24T16:01:20.460' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3027, NULL, 4014, CAST(N'2024-07-24T16:04:21.793' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3028, NULL, 4015, CAST(N'2024-07-24T16:06:46.373' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3029, NULL, 4016, CAST(N'2024-07-24T16:10:33.027' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3030, NULL, 4017, CAST(N'2024-07-24T16:22:26.750' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3031, NULL, 4018, CAST(N'2024-07-25T12:34:17.267' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3032, NULL, 4019, CAST(N'2024-07-25T13:11:39.400' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3033, 3021, NULL, CAST(N'2024-07-25T15:04:45.530' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3034, 3022, NULL, CAST(N'2024-07-25T15:11:39.460' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3035, 3023, NULL, CAST(N'2024-07-25T15:25:01.973' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3036, 3024, NULL, CAST(N'2024-07-25T15:37:52.077' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3037, 3025, NULL, CAST(N'2024-07-25T15:44:53.917' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3038, 3026, NULL, CAST(N'2024-07-25T15:55:24.140' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3039, 3027, NULL, CAST(N'2024-07-25T18:21:04.947' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3040, NULL, 4020, CAST(N'2024-07-26T00:56:52.000' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3041, NULL, 4021, CAST(N'2024-07-29T11:11:14.957' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3042, NULL, 4022, CAST(N'2024-07-29T15:44:50.510' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3043, NULL, 4023, CAST(N'2024-07-29T15:46:27.510' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3044, NULL, 4024, CAST(N'2024-07-29T17:46:31.193' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (3045, 3028, NULL, CAST(N'2024-07-29T18:18:53.247' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4041, NULL, 5021, CAST(N'2024-10-16T18:29:15.713' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4042, NULL, 5022, CAST(N'2024-10-17T14:51:43.863' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4043, NULL, 5023, CAST(N'2024-10-17T15:04:16.513' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4044, NULL, 5024, CAST(N'2024-10-17T15:07:17.170' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4045, NULL, 5025, CAST(N'2024-10-17T15:11:08.283' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4046, NULL, 5026, CAST(N'2024-10-17T15:14:27.430' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4047, NULL, 5027, CAST(N'2024-10-17T15:17:14.630' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4048, NULL, 5028, CAST(N'2024-10-17T15:20:50.373' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4049, NULL, 5029, CAST(N'2024-10-17T15:21:36.223' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4050, NULL, 5030, CAST(N'2024-10-17T15:22:00.680' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4051, NULL, 5031, CAST(N'2024-10-17T15:22:34.097' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4052, NULL, 5032, CAST(N'2024-10-18T15:37:27.767' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4053, NULL, 5033, CAST(N'2024-10-18T15:49:25.680' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4054, NULL, 5034, CAST(N'2024-10-18T15:51:07.933' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4055, NULL, 5035, CAST(N'2024-10-18T17:42:37.303' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4056, NULL, 5036, CAST(N'2024-10-18T17:48:53.933' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4057, NULL, 5037, CAST(N'2024-10-18T17:49:35.013' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4058, NULL, 5038, CAST(N'2024-10-18T17:51:10.813' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4059, NULL, 5039, CAST(N'2024-10-18T17:55:43.410' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4060, NULL, 5040, CAST(N'2024-10-19T11:34:11.640' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4061, NULL, 5041, CAST(N'2024-10-22T16:52:05.980' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4062, 3029, NULL, CAST(N'2024-10-25T12:40:47.247' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4063, 3030, NULL, CAST(N'2024-10-25T16:07:04.480' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4064, 3031, NULL, CAST(N'2024-10-25T17:33:48.890' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4065, 3032, NULL, CAST(N'2024-10-25T17:38:46.940' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4066, 3033, NULL, CAST(N'2024-10-25T17:48:00.470' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4067, 3034, NULL, CAST(N'2024-10-25T17:52:03.410' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4068, 3035, NULL, CAST(N'2024-10-25T18:02:06.160' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4069, 3036, NULL, CAST(N'2024-10-25T18:07:29.810' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4070, 3037, NULL, CAST(N'2024-10-25T18:14:08.913' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4071, 3038, NULL, CAST(N'2024-10-26T00:14:19.083' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4072, 3039, NULL, CAST(N'2024-10-26T00:15:58.900' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4073, 3040, NULL, CAST(N'2024-10-26T00:21:37.010' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4074, 3041, NULL, CAST(N'2024-10-26T00:23:45.413' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4075, 3042, NULL, CAST(N'2024-10-26T00:25:49.247' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4076, 3043, NULL, CAST(N'2024-10-26T00:36:50.397' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4077, 3044, NULL, CAST(N'2024-10-26T00:42:22.703' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4078, 3045, NULL, CAST(N'2024-10-26T12:06:39.760' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4079, 3046, NULL, CAST(N'2024-10-26T17:58:37.303' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (4080, 3048, NULL, CAST(N'2024-11-18T17:03:05.003' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (5080, 3049, NULL, CAST(N'2024-11-21T17:09:24.367' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (5081, 3050, NULL, CAST(N'2025-01-02T10:58:46.980' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (5082, 3051, NULL, CAST(N'2025-01-02T11:40:38.067' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (5083, 3052, NULL, CAST(N'2025-01-02T16:35:17.600' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (5084, 3053, NULL, CAST(N'2025-01-02T16:43:38.207' AS DateTime))
INSERT [dbo].[NotificationCustomer] ([NotificationID], [NewProductID], [NewCategoryID], [DateTime]) VALUES (5085, 3054, NULL, CAST(N'2025-01-02T16:57:04.823' AS DateTime))
SET IDENTITY_INSERT [dbo].[NotificationCustomer] OFF
GO
SET IDENTITY_INSERT [dbo].[NotificationOwner] ON 

INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (1, 1002, NULL, CAST(N'2024-05-26T15:42:11.220' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2, NULL, 3002, CAST(N'2024-06-12T12:54:08.947' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (3, NULL, 3003, CAST(N'2024-06-14T11:27:19.010' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (4, NULL, 3004, CAST(N'2024-06-14T11:28:26.347' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (5, NULL, 3005, CAST(N'2024-06-14T11:31:34.483' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (6, NULL, 3006, CAST(N'2024-06-14T11:37:13.437' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (7, NULL, 3007, CAST(N'2024-06-14T11:39:38.677' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (8, NULL, 3008, CAST(N'2024-06-21T17:14:01.527' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (9, NULL, 3009, CAST(N'2024-06-21T17:18:04.160' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (1002, 2002, NULL, CAST(N'2024-07-02T16:45:30.463' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (1003, 2003, NULL, CAST(N'2024-07-03T12:26:50.980' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (1004, 2004, NULL, CAST(N'2024-07-05T17:46:56.760' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2004, NULL, 4002, CAST(N'2024-07-12T17:41:43.713' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2005, NULL, 4003, CAST(N'2024-07-16T17:25:38.433' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2006, NULL, 4004, CAST(N'2024-07-17T16:35:44.653' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2007, NULL, 4005, CAST(N'2024-07-17T16:41:42.470' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2008, NULL, 4006, CAST(N'2024-07-19T15:49:22.247' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2009, NULL, 4007, CAST(N'2024-07-19T16:03:23.117' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2010, NULL, 4008, CAST(N'2024-07-19T16:04:56.640' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2011, NULL, 4009, CAST(N'2024-07-19T16:12:37.893' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2012, NULL, 4010, CAST(N'2024-07-19T17:42:02.167' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2013, NULL, 4011, CAST(N'2024-07-19T17:52:40.153' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2014, NULL, 4012, CAST(N'2024-07-19T19:46:05.253' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2015, NULL, 4013, CAST(N'2024-07-19T19:46:30.380' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2016, NULL, 4014, CAST(N'2024-07-19T21:09:08.280' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2017, NULL, 4015, CAST(N'2024-07-19T21:09:40.580' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2018, NULL, 4016, CAST(N'2024-07-19T23:05:34.877' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2019, NULL, 4017, CAST(N'2024-07-19T23:07:13.013' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2021, 3012, NULL, CAST(N'2024-07-21T18:04:18.887' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2022, NULL, 4018, CAST(N'2024-07-21T18:32:12.303' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2023, NULL, 4019, CAST(N'2024-07-21T18:32:39.190' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2024, NULL, 4020, CAST(N'2024-07-21T19:31:08.807' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2025, NULL, 4021, CAST(N'2024-07-21T19:37:27.503' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2026, NULL, 4022, CAST(N'2024-07-21T19:40:26.970' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2027, NULL, 4023, CAST(N'2024-07-21T19:41:32.033' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2028, NULL, 4024, CAST(N'2024-07-21T19:42:16.517' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2029, NULL, 4025, CAST(N'2024-07-22T10:56:50.970' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2030, NULL, 4026, CAST(N'2024-07-25T18:32:35.700' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2031, NULL, 4027, CAST(N'2024-07-26T00:29:06.377' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2032, NULL, 4028, CAST(N'2024-07-26T19:45:48.367' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2033, NULL, 4029, CAST(N'2024-07-28T01:02:36.460' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2034, NULL, 4030, CAST(N'2024-07-28T01:11:49.017' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2035, NULL, 4031, CAST(N'2024-07-28T17:25:34.397' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2036, NULL, 4032, CAST(N'2024-07-28T17:46:08.790' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2037, NULL, 4033, CAST(N'2024-07-28T17:48:26.747' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2038, NULL, 4034, CAST(N'2024-07-28T18:00:50.887' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2039, NULL, 4035, CAST(N'2024-07-28T18:01:19.740' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2040, NULL, 4036, CAST(N'2024-07-28T19:11:08.837' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2041, NULL, 4037, CAST(N'2024-07-28T19:30:06.313' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2042, NULL, 4038, CAST(N'2024-07-29T00:11:21.113' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (2043, NULL, 4039, CAST(N'2024-07-29T00:15:31.027' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (3033, 4013, NULL, CAST(N'2024-11-06T22:55:13.343' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (4033, 5013, NULL, CAST(N'2024-12-07T16:09:17.273' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (4034, 5014, NULL, CAST(N'2024-12-07T16:30:07.017' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (4035, 5015, NULL, CAST(N'2024-12-08T13:30:47.543' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (4036, 5016, NULL, CAST(N'2024-12-08T13:52:22.230' AS DateTime))
INSERT [dbo].[NotificationOwner] ([NoticficationID], [NewCustomerID], [NewPaymentID], [DateTime]) VALUES (4037, 5017, NULL, CAST(N'2024-12-09T10:07:08.943' AS DateTime))
SET IDENTITY_INSERT [dbo].[NotificationOwner] OFF
GO
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (6, 3, 1, N'M    ', N'Blue', 20000.0000, 20000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (6, 1005, 3, N'M    ', N'Blue', 3000.0000, 9000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (6, 1006, 3, N'M    ', N'Blue', 5000.0000, 15000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (7, 1, 1, N'M    ', N'Blue', 4000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (8, 3, 1, N'M    ', N'Blue', 20000.0000, 20000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (8, 1005, 3, N'M    ', N'Blue', 3000.0000, 9000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (8, 1006, 2, N'M    ', N'Blue', 5000.0000, 10000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1008, 2, 2, N'M    ', N'Blue', 6000.0000, 12000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1008, 1006, 2, N'M    ', N'Blue', 5000.0000, 10000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1009, 3, 1, N'M    ', N'Blue', 20000.0000, 20000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1009, 1006, 3, N'M    ', N'Blue', 5000.0000, 15000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1010, 3, 1, N'M    ', N'Blue', 20000.0000, 20000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1010, 1004, 3, N'M    ', N'Blue', 2000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1011, 1004, 3, N'M    ', N'Blue', 2000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1011, 1005, 2, N'M    ', N'Blue', 3000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1012, 1, 3, N'M    ', N'Blue', 4000.0000, 12000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1012, 3, 2, N'M    ', N'Blue', 20000.0000, 40000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1013, 2, 2, N'M    ', N'Blue', 6000.0000, 12000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1013, 3, 2, N'M    ', N'Blue', 20000.0000, 40000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1014, 2, 2, N'M    ', N'Blue', 6000.0000, 12000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1014, 3, 2, N'M    ', N'Blue', 20000.0000, 40000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1015, 1004, 2, N'M    ', N'Blue', 2000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1015, 1005, 2, N'M    ', N'Blue', 3000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1016, 1004, 2, N'M    ', N'Blue', 2000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1016, 1005, 2, N'M    ', N'Blue', 3000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1017, 3, 1, N'M    ', N'Blue', 20000.0000, 20000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (1018, 1005, 2, N'M    ', N'Blue', 3000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (2008, 2, 2, N'M', N'Blue', 6000.0000, 12000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3008, 2007, 1, N'14.02in', N'black', 5000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3009, 2006, 1, N'13.3inch', N'Gray', 5000.0000, 2500.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3010, 2006, 1, N'13.3inch', N'Gray', 5000.0000, 2500.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3010, 2007, 1, N'14.02in', N'black', 5000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3011, 3, 1, N'M', N'Blue', 20000.0000, 16000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3011, 2006, 1, N'13.3inch', N'Gray', 5000.0000, 2500.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3011, 2007, 1, N'14.02in', N'black', 5000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3012, 3, 1, N'M', N'Blue', 20000.0000, 16000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3012, 1005, 2, N'M', N'Blue', 3000.0000, 5400.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3012, 2006, 1, N'13.3inch', N'Gray', 5000.0000, 2500.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3012, 2007, 1, N'14.02in', N'black', 5000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3013, 2, 2, N'S', N'Blue', 6000.0000, 12000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3014, 3, 1, N'L', N'Blue', 20000.0000, 16000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3014, 2007, 2, N'14.02in', N'Gold', 5000.0000, 8000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (3015, 3, 1, N'M', N'Blue', 20000.0000, 16000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4008, 3010, 1, N'10-Piece', N'Black', 249.0000, 209.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4008, 3012, 1, N'16.89"Dx15', N'Silver', 179.0000, 179.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4009, 3010, 1, N'10-Piece', N'Black', 249.0000, 209.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4009, 3012, 1, N'16.89"Dx15', N'Silver', 179.0000, 179.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4009, 3013, 1, N'20.1"Dx18.', N'Stainless_Steel', 199.0000, 199.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4010, 3013, 1, N'20.1"Dx18.', N'Stainless_Steel', 199.0000, 199.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4010, 3015, 2, N'31.5"Dx76.', N'Pearl_White', 359.0000, 718.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4011, 3013, 1, N'20.1"Dx18.', N'Stainless_Steel', 199.0000, 199.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4011, 3014, 1, N'256GB', N'Titan', 629.0000, 629.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4011, 3015, 2, N'31.5"Dx76.', N'Pearl_White', 359.0000, 718.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4012, 3015, 1, N'31.5"Dx76.', N'Pearl_White', 359.0000, 359.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4013, 3008, 1, N'Meduim', N'Leaf_Colorful', 19.0000, 19.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4014, 3008, 1, N'Meduim', N'Leaf_Colorful', 19.0000, 19.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4014, 3009, 1, N'Medium', N'Black', 39.0000, 39.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4015, 2007, 1, N'14.02in', N'Silver', 5000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4016, 3014, 1, N'256GB', N'Amber_Yellow', 629.0000, 629.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4017, 2010, 1, N'M', N'White', 39.0000, 20.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4017, 3014, 1, N'256GB', N'Amber_Yellow', 629.0000, 629.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4018, 3013, 1, N'20.1"Dx18.', N'Stainless_Steel', 199.0000, 199.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4019, 3012, 1, N'16.89"Dx15', N'Silver', 179.0000, 179.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4019, 3013, 1, N'20.1"Dx18.', N'Stainless_Steel', 199.0000, 199.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4020, 3015, 1, N'31.5"Dx76.', N'Pearl_White', 359.0000, 359.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4021, 3008, 1, N'Meduim', N'Leaf_Colorful', 19.0000, 19.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4021, 3015, 1, N'31.5"Dx76.', N'Pearl_White', 359.0000, 359.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4023, 3010, 1, N'10-Piece', N'Black', 249.0000, 209.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4024, 3010, 1, N'10-Piece', N'Black', 249.0000, 209.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4024, 3015, 1, N'31.5"Dx76.', N'Pearl_White', 359.0000, 359.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4025, 3008, 1, N'Meduim', N'Leaf_Colorful', 19.0000, 19.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4026, 3008, 1, N'Meduim', N'Leaf_Colorful', 19.0000, 19.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4026, 3009, 1, N'Medium', N'Black', 39.0000, 39.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4028, 3010, 1, N'10-Piece', N'Black', 249.0000, 209.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4029, 3014, 1, N'256GB', N'Marble_Gray', 629.0000, 629.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4030, 3012, 1, N'16.89"Dx15', N'Silver', 179.0000, 179.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4030, 3014, 1, N'256GB', N'Marble_Gray', 629.0000, 629.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4031, 3015, 1, N'31.5"Dx76.', N'Pearl_White', 359.0000, 359.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4032, 2007, 1, N'14.02in', N'Gold', 5000.0000, 4000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4033, 3014, 1, N'256GB', N'Titan', 629.0000, 629.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4034, 3017, 1, N'50_Inches', N'Black', 129.0000, 129.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4034, 3021, 1, N'Small', N'Blue Green Orange Purple Red', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4035, 3016, 1, N'71"D x 34"', N'Dark Grey', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4035, 3017, 1, N'50 Inches', N'Black', 129.0000, 129.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4036, 3016, 2, N'71"D x 34"', N'Linen Blue', 329.0000, 401.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4037, 3016, 2, N'71"D x 34"', N'Dark Grey', 329.0000, 401.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4038, 3016, 1, N'71"D x 34"', N'Linen Blue', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4039, 3016, 1, N'71"D x 34"', N'Dark Grey', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4039, 3021, 1, N'Small', N'Green', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4040, 3016, 1, N'71"D x 34"', N'Dark Grey', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4040, 3021, 1, N'Small', N'Green', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4041, 2, 1, N'S', N'Red', 6000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4042, 2, 1, N'S', N'Red', 6000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4043, 2, 1, N'M', N'Red', 6000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4044, 2, 1, N'M', N'Red', 6000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4045, 2010, 1, N'L', N'White', 39.0000, 20.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4046, 2010, 1, N'L', N'White', 39.0000, 20.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4046, 2010, 1, N'S', N'Red Pink', 39.0000, 20.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4051, 3016, 1, N'71"D x 34"', N'Dark Grey', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4047, 2010, 1, N'S', N'Red Pink', 39.0000, 20.0000)
GO
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4047, 3016, 1, N'71"D x 34"', N'Linen Blue', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4047, 3021, 1, N'Small', N'Green', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4047, 3021, 1, N'Small', N'Orange', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4051, 3021, 1, N'Small', N'Green', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 1005, 2, N'Blue', N'M', 3000.0000, 6000.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5049, 3049, 2, N'gray', N'64GB', 352.0000, 704.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5049, 3048, 3, N'black', N'55 Millimeters', 479.0000, 1437.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 2010, 1, N'L', N'White', 39.0000, 20.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4048, 3016, 1, N'71"D x 34"', N'Linen Blue', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4048, 3021, 1, N'Small', N'Green', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 2010, 1, N'S', N'Red Pink', 39.0000, 20.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4048, 3016, 1, N'71"D x 34"', N'Dark Grey', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 3016, 1, N'71"D x 34"', N'Linen Blue', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 3021, 1, N'Small', N'Green', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 3021, 1, N'Small', N'Orange', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 3016, 1, N'71"D x 34"', N'Dark Grey', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4050, 3015, 1, N'31.5"D x 7', N'Dark Gray', 359.0000, 359.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5050, 3049, 2, N'blue', N'256GB', 352.0000, 704.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5050, 3048, 1, N'black', N'55 Millimeters', 479.0000, 479.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4049, 3016, 1, N'71"D x 34"', N'Dark Grey', 329.0000, 201.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (4049, 3021, 1, N'Small', N'Green', 45.0000, 28.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5051, 3015, 1, N'Light Gray', N'31.5"D x 76.4"W x 29.1"H', 359.0000, 359.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5051, 3012, 1, N'Silver', N'16.89"D x 15.51"W x 15.87"H', 179.0000, 179.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5052, 2006, 1, N'Black', N'14 Inches 1 TB SSD 16 GB RAM', 1275.0000, 1275.0000)
INSERT [dbo].[OrderItems] ([OrderID], [ProductID], [Quantity], [Size], [Color], [Price], [TotalItemsPrice]) VALUES (5052, 2007, 1, N'Black', N'15.6 Inches 256 GB SSD 12 GB RAM', 3200.0000, 3200.0000)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1, 1, CAST(N'2024-04-22T11:55:44.390' AS DateTime), 19000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (2, 1, CAST(N'2024-04-22T11:57:07.777' AS DateTime), 19000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3, 1, CAST(N'2024-04-22T15:21:40.077' AS DateTime), 81000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4, 1, CAST(N'2024-04-22T15:22:52.183' AS DateTime), 81000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5, 1, CAST(N'2024-04-22T15:22:52.183' AS DateTime), 81000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (6, 1, CAST(N'2024-04-22T15:27:30.077' AS DateTime), 44000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (7, 1, CAST(N'2024-04-22T22:18:14.620' AS DateTime), 4000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (8, 1, CAST(N'2024-04-25T15:09:12.017' AS DateTime), 39000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1008, 1, CAST(N'2024-04-25T15:20:05.763' AS DateTime), 22000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1009, 1, CAST(N'2024-04-25T15:28:28.510' AS DateTime), 35000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1010, 1, CAST(N'2024-04-25T15:38:02.490' AS DateTime), 26000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1011, 1, CAST(N'2024-04-25T15:42:30.223' AS DateTime), 12000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1012, 1, CAST(N'2024-04-25T18:29:26.970' AS DateTime), 52000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1013, 1, CAST(N'2024-04-25T18:33:11.250' AS DateTime), 52000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1014, 1, CAST(N'2024-04-25T18:35:30.590' AS DateTime), 52000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1015, 1, CAST(N'2024-04-25T20:35:40.990' AS DateTime), 10000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1016, 1, CAST(N'2024-04-25T20:36:40.137' AS DateTime), 16000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1017, 1, CAST(N'2024-04-25T20:38:25.113' AS DateTime), 20000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (1018, 1, CAST(N'2024-04-25T20:39:02.580' AS DateTime), 26000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (2008, 1, CAST(N'2024-04-29T00:15:05.607' AS DateTime), 12000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3008, 1, CAST(N'2024-06-12T12:54:08.843' AS DateTime), 4000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3009, 1, CAST(N'2024-06-14T11:27:18.947' AS DateTime), 2500.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3010, 1, CAST(N'2024-06-14T11:28:26.327' AS DateTime), 4000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3011, 1, CAST(N'2024-06-14T11:31:34.467' AS DateTime), 16000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3012, 1, CAST(N'2024-06-14T11:37:13.420' AS DateTime), 5400.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3013, 1, CAST(N'2024-06-14T11:39:38.617' AS DateTime), 12000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3014, 1, CAST(N'2024-06-21T17:14:01.417' AS DateTime), 16000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (3015, 1, CAST(N'2024-06-21T17:18:04.100' AS DateTime), 16000.0000, 3)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4008, 1, CAST(N'2024-07-12T17:41:43.603' AS DateTime), 388.1600, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4009, 1, CAST(N'2024-07-16T17:25:38.360' AS DateTime), 587.1600, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4010, 1, CAST(N'2024-07-17T16:35:44.440' AS DateTime), 917.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4011, 1, CAST(N'2024-07-17T16:41:42.400' AS DateTime), 629.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4012, 1, CAST(N'2024-07-19T15:49:22.037' AS DateTime), 359.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4013, 1, CAST(N'2024-07-19T16:03:22.903' AS DateTime), 19.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4014, 1, CAST(N'2024-07-19T16:04:56.560' AS DateTime), 39.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4015, 1, CAST(N'2024-07-19T16:12:37.797' AS DateTime), 4000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4016, 1, CAST(N'2024-07-19T17:42:01.957' AS DateTime), 629.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4017, 1, CAST(N'2024-07-19T17:52:40.100' AS DateTime), 19.5000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4018, 1, CAST(N'2024-07-19T19:46:05.053' AS DateTime), 199.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4019, 1, CAST(N'2024-07-19T19:46:30.340' AS DateTime), 179.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4020, 1, CAST(N'2024-07-19T21:09:08.117' AS DateTime), 359.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4021, 1, CAST(N'2024-07-19T21:09:40.517' AS DateTime), 19.0000, 3)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4022, 1, CAST(N'2024-07-19T21:14:10.290' AS DateTime), 72.0000, 6)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4023, 1, CAST(N'2024-07-19T23:05:34.687' AS DateTime), 209.1600, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4024, 1, CAST(N'2024-07-19T23:07:12.947' AS DateTime), 359.0000, 6)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4025, 1, CAST(N'2024-07-21T18:32:12.063' AS DateTime), 19.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4026, 1, CAST(N'2024-07-21T18:32:39.103' AS DateTime), 39.0000, 3)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4027, 1, CAST(N'2024-07-21T18:35:01.433' AS DateTime), 19.5000, 3)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4028, 1, CAST(N'2024-07-21T19:30:41.867' AS DateTime), 209.1600, 3)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4029, 1, CAST(N'2024-07-21T19:36:23.913' AS DateTime), 629.0000, 3)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4030, 1, CAST(N'2024-07-21T19:38:01.743' AS DateTime), 179.0000, 6)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4031, 1, CAST(N'2024-07-21T19:41:15.333' AS DateTime), 359.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4032, 1, CAST(N'2024-07-21T19:42:07.863' AS DateTime), 4000.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4033, 1, CAST(N'2024-07-22T10:56:50.753' AS DateTime), 629.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4034, 1, CAST(N'2024-07-25T18:32:35.563' AS DateTime), 157.3500, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4035, 1, CAST(N'2024-07-26T00:29:06.150' AS DateTime), 329.6900, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4036, 1, CAST(N'2024-07-26T19:45:48.093' AS DateTime), 401.3800, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4037, 1, CAST(N'2024-07-28T01:02:36.230' AS DateTime), 401.3800, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4038, 1, CAST(N'2024-07-28T01:11:48.947' AS DateTime), 200.6900, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4039, 1, CAST(N'2024-07-28T17:25:34.167' AS DateTime), 229.0400, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4040, 1, CAST(N'2024-07-28T17:41:57.840' AS DateTime), 229.0400, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4041, 1, CAST(N'2024-07-28T17:45:49.830' AS DateTime), 6000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4042, 1, CAST(N'2024-07-28T17:46:33.303' AS DateTime), 6000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4043, 1, CAST(N'2024-07-28T17:48:14.003' AS DateTime), 6000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4044, 1, CAST(N'2024-07-28T17:48:57.753' AS DateTime), 6000.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4045, 1, CAST(N'2024-07-28T18:00:41.043' AS DateTime), 19.5000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4046, 1, CAST(N'2024-07-28T18:01:19.723' AS DateTime), 19.5000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4047, 1, CAST(N'2024-07-28T19:11:08.680' AS DateTime), 229.0400, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4048, 1, CAST(N'2024-07-28T19:30:06.203' AS DateTime), 229.0400, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4049, 1, CAST(N'2024-07-28T19:30:06.203' AS DateTime), 229.0400, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4050, 1, CAST(N'2024-07-29T00:11:21.027' AS DateTime), 359.0000, 2)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4051, 1, CAST(N'2024-07-28T19:30:06.203' AS DateTime), 229.0400, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5049, 5017, CAST(N'2024-12-15T10:45:45.180' AS DateTime), 2141.0000, 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5050, 5017, CAST(N'2024-12-15T21:03:39.410' AS DateTime), 1183.0000, 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5051, 5017, CAST(N'2024-12-22T22:44:18.357' AS DateTime), 538.0000, 6)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5052, 5017, CAST(N'2024-12-28T23:10:14.027' AS DateTime), 4475.0000, 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1, 7, 4000.0000, N'Cash On Delivery', CAST(N'2024-04-22' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (2, 8, 39000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1002, 1008, 22000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1003, 1009, 35000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1004, 1010, 26000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1005, 1011, 12000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1006, 1012, 52000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1007, 1013, 52000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1008, 1015, 10000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1009, 1016, 16000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1010, 1017, 20000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (1011, 1018, 26000.0000, N'Cash On Delivery', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (2002, 2008, 12000.0000, N'Cash On Delivery', CAST(N'2024-04-29' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3002, 3008, 4000.0000, N'Cash On Delivery', CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3003, 3009, 2500.0000, N'Cash On Delivery', CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3004, 3010, 4000.0000, N'Cash On Delivery', CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3005, 3011, 16000.0000, N'Visa Card', CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3006, 3012, 5400.0000, N'Cash On Delivery', CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3007, 3013, 12000.0000, N'Cash On Delivery', CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3008, 3014, 16000.0000, N'Cash On Delivery', CAST(N'2024-06-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (3009, 3015, 16000.0000, N'Cash On Delivery', CAST(N'2024-06-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4002, 4008, 388.1600, N'Cash On Delivery', CAST(N'2024-07-12' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4003, 4009, 587.1600, N'Cash On Delivery', CAST(N'2024-07-16' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4004, 4010, 917.0000, N'Bank Transfer', CAST(N'2024-07-17' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4005, 4011, 629.0000, N'Cash On Delivery', CAST(N'2024-07-17' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4006, 4012, 359.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4007, 4013, 19.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4008, 4014, 39.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4009, 4015, 4000.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4010, 4016, 629.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4011, 4017, 19.5000, N'Visa Card', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4012, 4018, 199.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4013, 4019, 179.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4014, 4020, 359.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4015, 4021, 19.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4016, 4023, 209.1600, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4017, 4024, 359.0000, N'Cash On Delivery', CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4018, 4025, 19.0000, N'Cash On Delivery', CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4019, 4026, 39.0000, N'Cash On Delivery', CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4020, 4028, 209.1600, N'Cash On Delivery', CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4021, 4029, 629.0000, N'Cash On Delivery', CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4022, 4030, 179.0000, N'Cash On Delivery', CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4023, 4031, 359.0000, N'Cash On Delivery', CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4024, 4032, 4000.0000, N'Cash On Delivery', CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4025, 4033, 629.0000, N'Cash On Delivery', CAST(N'2024-07-22' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4026, 4034, 157.3500, N'Cash On Delivery', CAST(N'2024-07-25' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4027, 4035, 329.6900, N'Cash On Delivery', CAST(N'2024-07-26' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4028, 4036, 401.3800, N'Cash On Delivery', CAST(N'2024-07-26' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4029, 4037, 401.3800, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4030, 4038, 200.6900, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4031, 4039, 229.0400, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4032, 4041, 6000.0000, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4033, 4043, 6000.0000, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4034, 4045, 19.5000, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4035, 4046, 19.5000, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4036, 4047, 229.0400, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4037, 4048, 229.0400, N'Cash On Delivery', CAST(N'2024-07-28' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4038, 4050, 359.0000, N'Cash On Delivery', CAST(N'2024-07-29' AS Date))
INSERT [dbo].[Payments] ([PaymentID], [OrderID], [Amount], [PaymentMethod], [TransactionDate]) VALUES (4039, 4051, 229.0400, N'Cash On Delivery', CAST(N'2024-07-29' AS Date))
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
INSERT [dbo].[PendingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5049, 5017, CAST(N'2024-12-15T10:45:45.180' AS DateTime), 2141.0000, 1)
INSERT [dbo].[PendingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (5052, 5017, CAST(N'2024-12-28T23:10:14.027' AS DateTime), 4475.0000, 1)
GO
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4034, N'1', CAST(N'2024-07-25T18:32:35.563' AS DateTime), 157.3500, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4008, N'1', CAST(N'2024-07-12T17:41:43.603' AS DateTime), 388.1600, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4010, N'1', CAST(N'2024-07-17T16:35:44.440' AS DateTime), 917.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4011, N'1', CAST(N'2024-07-17T16:41:42.400' AS DateTime), 629.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4015, N'1', CAST(N'2024-07-19T16:12:37.797' AS DateTime), 4000.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4017, N'1', CAST(N'2024-07-19T17:52:40.100' AS DateTime), 19.5000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4023, N'1', CAST(N'2024-07-19T23:05:34.687' AS DateTime), 209.1600, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4037, N'1', CAST(N'2024-07-28T01:02:36.230' AS DateTime), 401.3800, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4040, N'1', CAST(N'2024-07-28T17:41:57.840' AS DateTime), 229.0400, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4045, N'1', CAST(N'2024-07-28T18:00:41.043' AS DateTime), 19.5000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4048, N'1', CAST(N'2024-07-28T19:30:06.203' AS DateTime), 229.0400, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4049, N'1', CAST(N'2024-07-28T19:30:06.203' AS DateTime), 229.0400, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4050, N'1', CAST(N'2024-07-29T00:11:21.027' AS DateTime), 359.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4012, N'1', CAST(N'2024-07-19T15:49:22.037' AS DateTime), 359.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4013, N'1', CAST(N'2024-07-19T16:03:22.903' AS DateTime), 19.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4014, N'1', CAST(N'2024-07-19T16:04:56.560' AS DateTime), 39.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4020, N'1', CAST(N'2024-07-19T21:09:08.117' AS DateTime), 359.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4036, N'1', CAST(N'2024-07-26T19:45:48.093' AS DateTime), 401.3800, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4016, N'1', CAST(N'2024-07-19T17:42:01.957' AS DateTime), 629.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4018, N'1', CAST(N'2024-07-19T19:46:05.053' AS DateTime), 199.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4019, N'1', CAST(N'2024-07-19T19:46:30.340' AS DateTime), 179.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4025, N'1', CAST(N'2024-07-21T18:32:12.063' AS DateTime), 19.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4041, N'1', CAST(N'2024-07-28T17:45:49.830' AS DateTime), 6000.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4042, N'1', CAST(N'2024-07-28T17:46:33.303' AS DateTime), 6000.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4043, N'1', CAST(N'2024-07-28T17:48:14.003' AS DateTime), 6000.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4031, N'1', CAST(N'2024-07-21T19:41:15.333' AS DateTime), 359.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4044, N'1', CAST(N'2024-07-28T17:48:57.753' AS DateTime), 6000.0000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4039, N'1', CAST(N'2024-07-28T17:25:34.167' AS DateTime), 229.0400, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4046, N'1', CAST(N'2024-07-28T18:01:19.723' AS DateTime), 19.5000, 2)
INSERT [dbo].[ProcessingOrders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [Status]) VALUES (4047, N'1', CAST(N'2024-07-28T19:11:08.680' AS DateTime), 229.0400, 2)
GO
SET IDENTITY_INSERT [dbo].[ProductCatalog] ON 

INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (1, N'Computer Desk', N'ODK 40 Inch Small L Shaped Gaming Computer Desk with Power Outlets', N'【Power Outlets & Charging Ports】 ODK L shaped computer desk is equipped with 3 Power outlets & 1 USB charging port & 1 Type-C port for electronic devices, you can easily and conveniently charge your smart phone, gaming gear or Bluetooth devices when you are working or playing games.
【Reversible Corner Desk for Small Space】The l desk fits perfectly any places in a corner, which maximize your limited spaces. This modern minimalist desk will be a beautiful decor in your living room, bedroom, office, dormitory, gaming room, children’s room. You can customize the shelves on your left or right follow your personal habits.
【Super Ample Storage Space】With Two-tier open shelves and PC stand providing maximally ample space for your PC case, books, files, devices for convenience usage, and side storage bag helps you store gaming devices or office stuffs.', 2000.0000, 100, N'c5179a60-1fef-4c8f-9ce3-18695d9bd741.jpg', NULL, 2, 1, NULL, NULL, 50, CAST(N'2024-06-01' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (2, N'Desk Chair with Armrest', N'Padded Mid-Back Office Computer Desk Chair with Armrest', N'Office desk chair for home office, work station, or conference room
Adjustable seat height, adjustable seat angle, and tilt control for customizable comfort
Supports up to 275 pounds; sturdy KD metal base; comply with BIFMA standard, a nonprofit organization that creates voluntary standards to support safe standards for business and institutional working environments
Puresoft PU upholstery in Cream; contoured padded seat, backrest, and armrests for comfort; durable caster wheels for smooth-rolling mobility
Assembly instructions included; components (casters, base, arms, seat mechanism, hardware kit) arrive packed in the back cushion
Product Dimensions: 23.75 x 26 x 38.25 - 42 inches (WxDxH); seat width: 19.5 inches; seat depth: 17.75 inches; arm height: 26.25 - 30 inches', 6000.0000, 195, N'ba084d38-8fd7-43ef-a081-f4a3405d46db.jpg', NULL, 2, 2, NULL, NULL, NULL, CAST(N'2024-06-01' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3, N'Couch', N'Sectional Sofa Couches for Living Room - 78'''' Dark Grey 3 Seat L-Shaped Couch with Storage Ottoman, Modern Linen Convertible Sectionals Sofas with Chaise for Apartment, Office, Small Space', N'【Convertible & Flexible Couch】Create your own customized home living space with the sectional couches for living room. Ottoman can be attached to any seat according to your preference, thanks to its removable storage ottoman. You can decide the position and shape you want on this sectional couch. Snuggle up with your favorite pet on our living room set.
【Comfort & Durability】Sink into comfort with the small couch featuring soft cushions and reinforced backrests that provide long-lasting support. Modern breathable linen fabric, solid wood frame and high-density foam ensure lasting comfortable and stability.
【Space Saving Elegance】On a sectional sofa, lifting the cushion on the ottoman opens up a storage space; a storage pocket on each side of the armrest. Whether it''s a TV remote control, magazines and books, or pillows and blankets, toys. they can be placed in the storage space, which is practical and convenient.
【Chic Space Optimization】Tailored for small interiors such as small lounge, studio, apartments and offices, this sofas for living room compact design fits perfectly. Customize your layout with a movable ottoman, offering versatility and maximizing your living spaces.
【One Package Delivery】Crafted for convenient shipment and easy assembly. All parts are marked with either a letter or a number. You just need to follow the steps install the couches for living room clearance. You can assemble the l shaped couch easily within 30 minutes.
【Note】For the convenience of transportation, all seat cushions and back cushions are vacuum-compressed packaging. After opening the package, it will take 48 hour for the cushion to return to its original shape.', 10240.0000, 300, N'3f3140cf-1091-491b-8ef9-6feb3bf0d35c.jpg', NULL, 1, 5006, NULL, NULL, 20, CAST(N'2024-06-03' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (1004, N'Comfortable-Office Chair with Dynamic-Lumbar Support', N'Marsail Comfortable-Office Chair with Dynamic-Lumbar Support: High Back PU Leather Executive Office Chair with Flip-up Arms Tilt Function, Ergonomic Executive Desk Chair for Home Office Work, Black', N'Unique Dual Lumbar Support: Our executive office chair features an innovative dual lumbar support system. It locks into the backrest to match your preferred angle and dynamically adjusts to your movements. Simply pull the lumbar support control lever upwards to activate the advanced rocking feature. This allows the lumbar support to move effortlessly with you, adjusting forward, backward, and side-to-side to perfectly align with your back’s curves. This exceptional design delivers remarkable relief and comfort, especially for those suffering from lower back pain
Luxurious Seat Comfort: Our big and tall executive office chair features a high-density foam seat that''s 30-50% thicker than other black leather office chair on the market. This not only provides an incredibly soft feel but also offers perfect support, ensuring you enjoy unmatched comfort. Whether you''re working long hours or taking a break, our office chair delivers unparalleled comfort
Versatile Adjustability: This leather executive office chair conforms to your comfort preferences with ease. It offers seat height adjustments from 15.6 inches to 19.5 inches and tilts smoothly between 90° and 120°, allowing you to effortlessly transition from work mode to relaxation mode ﻿
Flip-Up Armrests: The leather office chair features armrests that can flip up 90° to save space when not in use. Whether you need to push your chair under the desk, or simply prefer more unrestricted movement while working, the armrests can be positioned to suit your preference
Certified Quality and Sturdy Design: This office chair leather is BIFMA-certified for reliable quality and features an SGS-certified Class 3 gas lift for dependable performance. With its heavy-duty metal base, it effortlessly supports weights up to 300 pounds. Whether it''s comfort, safety, or durability, this chair excels in all aspects, ensuring a long-lasting and comfortable office experience
Easy To Assemble: We offer installation instructions and videos to help you easily and quickly assemble the executive chair yourself. It usually takes about 10-20 minutes to assemble. If you have any questions, please feel free to contact us
5-Year Customer Assurance: We provide 5 years of after-sales guarantee! If there are problems such as missing parts, product damage, or other unsatisfactory issues, please contact us via the email address provided in the instruction manual- our dedicated team responds within 24 hours during workdays. Thank you for choosing Marsail office chair. We will be responsible for your choice', 2000.0000, 100, N'0b55b234-fa39-44be-8a7b-864152750198.jpg', NULL, 2, 2, NULL, NULL, NULL, CAST(N'2024-06-10' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (1005, N'Chair', N'Hbada E3 Pro Ergonomic Office Chair, Big and Tall Office Chair - with 3-Zone Dynamic Lumbar Support, 4D Adjustable Headrest, 6D Adjustable Armrests, Swivel Computer Chair for Home Office, Grey', N'The Best Ergonomic Chair under $1000: Hbada E3 Pro Ergonomic Office Chair has been certified by international authorities, like IGR, BIFMA, SGS, TUV, LONDON DESIGN AWARDS, and recommended by many online influencers and Authoritative medias like MSN.
3-Zone Dynamic Lumbar Support: The lumbar support of Hbada E3 Pro office chair realizes dynamic support with 8-way adjustment to prevent any discomfort in the waist or back.
4D Biaxial Adjustable Headrest: The headrest of Hbada E3 Pro desk chair can be adjusted in 4 dimensions, to fully support neck and head in any position as you like.
Suitable for multiple scenarios: Hbada E3 Pro computer chair can be applied in different scenarios according to different needs, like office, home, gaming, study and noon break.
What You Get: Hbada E3 Pro Ergonomic Office Chair, welcome guide, worry-free 3-year warranty, 30-day free return, 15-day price match guarantee, and friendly customer service.
Tips when use: *Lumbar support: There are a total of 7 gears for the lumbar support (including the initial gear). Pulling up 6 gears will produce a gear sound, and pulling down 7 gears will unlock the gear. After unlocking, pull to the bottom to readjust the position. *Headrest: The front and rear adjustment is not reset when you use it. You need to pull it to the last unlock. This guide groove can only be fixed in front and back after squeezing and unlocking the inner buckle. *Backrest: The liftable backrest has a nine-position adjustment, allowing for 2.76" of up and down movement, move up to the ninth gear to reset.', 2700.0000, 299, N'41e32c5e-175d-4a33-ae10-ed63a89b5d8e.jpg', NULL, 2, 2, NULL, NULL, 10, CAST(N'2024-06-18' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (1006, N'Office Chair', N'Ergonomic Office Chair - X-Shaped Computer Desk Chair Comfy, Gaming Chair, Office Chair with Lumbar Support, Mesh Office Chairs with Headrests, Desk Chair for Long Hours (Grey Gold)', N'Ergonomic Office Chair: Experience unparalleled support with our ergonomic office chair, designed to provide comprehensive assistance for your head, back, hips, and arms. Tailored lumbar support ensures your comfort and well-being. Suitable for people of about 5''5" to 6''2". Easily adjust seat height, headrest, backrest, and flip-up arms to cater to diverse needs, offering comfortable support during extended periods of sitting
Comfortable Breathable Mesh Seat: This office chair offers a spacious seating area, accommodating various body types. Overall dimensions (including arms): 25.7" W x 17.3" D x 46.9.3"-49.2" H, Seat dimensions: 20" W x 17.3" D x 18.5"-3" H. It can support up to 330 lbs. Its unique recline function allows you to tilt the backrest (90~120°) or sit upright freely, ensuring your comfort and relaxation
330 lbs Load Capacity and Durable Construction: This chair is made of high-quality materials and has a sturdy 5-point bottom metal base to ensure strength and stability. Whether you''re working or playing, enjoy a chair designed to meet your needs
Convenient Mobility: The chair''s 360° swivel base allows for effortless body rotation while seated. Its silent rolling wheels move smoothly in any direction, making it ideal for hard floors. Enjoy quiet and comfortable mobility in your office space. Can be used as student office chairs, computer chairs, ergonomic chairs, desk chairs, and gaming chairs
Super Easy to Assemble: There is a clear assembly manual in the package, you can follow it step by step very easily. And no more extra tools are needed, all the screws and tools are already in the box. Mostly, it can be assembled within 15 minutes.【LIFETIME WARRANTY】This chair comes with a lifetime warranty. If you encounter any quality problems, please feel free to contact us. We will replace the necessary parts for you', 4500.0000, 100, N'c968255c-2aab-4312-85c3-29753bdccc8a.jpg', NULL, 2, 2, NULL, NULL, 10, CAST(N'2024-06-28' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (2006, N'ASUS ZenBook', N'ASUS Zenbook 14 Q425MA-U71TB – Intel Ultra 7 155H – 14" OLED Touch – 16GB Ram – 1TB SSD – Win 11 – Q US English Keyboard – 1 Year Warranty', N'Note: Asus Turkey comes with a 12 month Warranty. Warranty starts from the date of invoice. Note: Q is US English Keyboard. Sticker adhesive keys for letters not visible on the keyboard. Note: European compatible adapter "converter" for cable header included. Warning: All products are sealed box so they are affixed to the converter packaging package. Please note when opening the packaging.', 2550.0000, 99, N'6e454706-0467-40cc-8221-c2cfe636780f.jpg', NULL, 2002, 3002, NULL, NULL, 50, CAST(N'2024-07-05' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (2007, N'Dell Inspiron 3511 Laptop', N'Dell Inspiron 3511 Laptop, 15.6" Full HD Touchscreen, Intel Core i5-1135G7 (Beats Intel i7-1065G7), 12GB DDR4 RAM, 256GB PCIe SSD, SD Card Reader, HDMI, Wi-Fi, Windows 11 Home, Black', N'【High Speed RAM And Enormous Space】12GB high-bandwidth RAM to smoothly run multiple applications and browser tabs all at once; 256GB PCIe NVMe M.2 Solid State Drive allows to fast bootup and data transfer
【Processor】Intel Core i5-1135G7 (4 Cores, 8 Threads, 8MB Cache, 2.40 GHz base frequency, up to 4.20 GHz max turbo frequency) with Intel Iris Xe Graphics
【Display】15.6-inch FHD (1920 x 1080) Anti-glare LED Backlight Narrow Border WVA Touchscreen
【Tech Specs】1 x USB 2.0 Type-A, 2 x USB 3.2 Gen 1 Type-A, 1 x HDMI 1.4, 1 x Headphone/Microphone Combo Jack, 1 x SD Card Reader, 1 x Power Adapter; Wi-Fi and Bluetooth Combo
【Operating System】Windows 11 Home-Beautiful, more consistent new design, Great window layout options, Better multi-monitor functionality, Improved performance features, New videogame selection and capabilities, Compatible with Android Apps', 3200.0000, 99, N'61616b7e-ba0b-40d9-8072-be1f6778f033.jpg', NULL, 2002, 3002, NULL, NULL, 20, CAST(N'2024-07-20' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (2010, N'Men''s Slim Fit Formal Shirt', N'Men Dress Shirt Regular Fit Soild Casual Business Formal Long Sleeve Button Down Shirts with Pocket', N'Machine Wash Cold Inside Out / No chlorine wash and low iron. Please wash it with similar colors
Soft/Breathable Thin Fabric/Good Choice for Spring ,Summer and the early Autumn/Long Sleeve/Design By Korean
Formal Dress Shirt for Men/Various Colors/Fitted/Please note that body builds vary by person, therefore, detailed size information should be reviewed
Casual/Business/Work/Dating/Party/suitable for a variety of occasions/Perfect Gift for families, friends or boyfriend
Color Disclaimer : Due to ', 9.7500, 41, N'33fa9bc5-976e-4ff5-a6a2-866e1526a972.jpg', NULL, 2003, 4002, NULL, NULL, 50, CAST(N'2024-07-29' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3008, N'SheLucki Hawaiian Shirt for Men', N'Unisex Summer Beach Casual Short Sleeve Button Down Shirts, Printed Palmshadow Clothing', N'Mens Hawaiian Shirts Are Made of 95% Polyester, 5% Spandex Fabric. Soft & Coolness Fabric With Quick To Dry Effect, Nice Print.
You May Wear The Shirts In Many Occasions .Including Holiday, Beach Parties, Theme Parties, Fishing, Sailing, Cruise , Days at Office Etc .The Collared Shirt For Men Could Be Easy To Match With Slacks, Hawaiian Shorts, Swim Shorts, Jeans And So On.
Mens Hawaiian & Paisley & Baroque & Funny Cartoon Style Shirts Are Designed for Different Ages. Pineapple,Sunflower,Fruit', 19.0000, 100, N'9dbd9639-2a91-4702-8a5e-7388e2f2cde1.jpg', NULL, 2003, 4002, NULL, NULL, NULL, CAST(N'2024-08-15' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3009, N'Women''s V-Neck Retro Floral Print Elegant Ruffled Hem Dress', N'Material description: 100% polyesterDescription: This is a dress full of summer breath. Its short-', N'Yard description: Check the size information before ordering. Manual tile measurement. There will be an error of 2-3 cm. It is considered normal.
Washing method: do not bleach. Clean with cold water , add a certain amount of detergent, after about 15 minutes, after ordinary washing, just use water.
Suitable places: it is very suitable for dating, parties, holidays, beaches, parties, clubs, offices, schools, outdoor and daily summer wear.', 39.0000, 100, N'e7217d15-f3c9-4442-8ae6-d1385637eec4.jpg', NULL, 2003, 4003, NULL, NULL, NULL, CAST(N'2024-08-20' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3010, N'Calphalon 10-Piece Non-Stick Kitchen Cookware Set', N'Black Pots & Pans with Stay-Cool Stainless Steel Handles, Hard-Anodized Aluminum for Even Heating', N'Includes: 8 Fry Pan, 10 Fry Pan, 1-Qt Sauce Pan with Cover, 2-Qt Saucepan with Cover, 3-Qt Sauté Pan with Cover, 6-Qt Stockpot with Cover
Material: Hard-Anodized Aluminum Cookware, Resists Corrosion and Warping
Interior: Durable, 2-Layer Nonstick Interior for Easy Cleanup
Handles: Long Silicone-Stay Cool Handles for Safety
Oven-Safe: Cookware is Oven-Safe Up to 400 Degrees Fahrenheit
Constituents: Contains PTFE, Aluminum, Stainless Steel (Iron, Chromium, Nickel, Manganese, Copper, Phosphoru', 209.1600, 50, N'625acb67-3ac4-4b4d-9432-544aa1aa520c.jpg', N'C:\Users\lap2p\Downloads\cookware.mp4', 1003, 5002, NULL, NULL, 16, CAST(N'2024-08-21' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3011, N'Hot Plate,Cusimax Double Burner 1800W Cast Iron Heating Plate', N'Electric Stove with Adjustable Temperature Control,Stainless Steel,Suitable for Various Scenarios Up', N'1800W DOUBLE BURNERS & EASY TO CONTROL - Used 2*11 thermostatically controlled heat settings conveniently to cook a variety of foods such as warm sauces, scrambled eggs, grilled cheese, soup, pasta, vegetables and so much more. Also you can use it as extra burner to keep food warm.
ALL TYPES OF COOKWARE - CUSIMAX hot plate is equipped with a powerful 6.1+7.4 inches heating plate, compatible with pots and pans with maximum size of 7.4 inches. CUSIMAX hot plate can be used with any type of cookwa', 58.3200, 80, N'b2c37513-ac07-41c1-bc46-09be2b4c3c4f.jpg', NULL, 1003, 5004, NULL, NULL, 10, CAST(N'2024-08-27' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3012, N'ECOWELL Air Fryer Toaster Oven Combo', N'15-in-1 Airfryer Toaster Ovens Countertop, 26.4 QT Stainless Steel Air Fryers Convection Oven, for 3', N'【Multi-Functional】ECOWELL Air Fryer Toaster Oven features 15 rich cooking options, Airfry, Bake, Roast, Broil, Toast, Slow cook, etc. Explore and create even more dishes
🔥【Easy to Use】The stainless steel air fryer toaster oven allows easy cooking control with knobs and buttons, an LED display that clearly shows the working status of the unit. A simple cooker for every food lover, even if you''re new to cooking
🔥【Perfect for Family Needs】This toaster oven air fryer combo with a capacity of 26.', 179.0000, 49, N'6d677e52-4f8a-4c3d-89ea-9648fefd041d.jpg', NULL, 1003, 5003, NULL, NULL, NULL, CAST(N'2024-08-29' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3013, N'Frigidaire EFR451 2 Door Refrigerator/Freezer', N'4.6 cu ft, Platinum Series, Stainless Steel, Double', N'STORAGE: A large Freezer compartment with an ice cube tray. Also, this refrigerator has a double door design perfect for storing drinks and condiments.Freezer Capacity:0.8 cubic_feet.Fresh Food Capacity: 4.3 cubic_feet.Lock Type:Electronic.Frequency : 60 Hz
EXTRA STORAGE: Adjustable / Removable shelves to expand storage and to easy cleaning.
DESIGN: Unique design that stand out out in your kitchen. Great quality Stainless Steel.
THERMOSTAT: Adjustable thermostat control which is easily access', 199.0000, 20, N'399b8719-4ca8-45bb-a4f7-2beca6f4b348.jpg', NULL, 1003, 5005, NULL, NULL, NULL, CAST(N'2024-09-03' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3014, N'SAMSUNG Galaxy S24 Cell Phone', N'128GB AI Smartphone, Unlocked Android, 50MP Camera, Fastest Processor, Long Battery Life, US Version', N'CIRCLE & SEARCH¹ IN A SNAP: What’s your favorite influencer wearing? Where’d they go on vacation? What’s that word mean? Don’t try to describe it — use Circle to Search1 with Google to get the answer; With S24 Series, circle it on your screen and learn more
REAL EASY, REAL-TIME TRANSLATIONS: Speak foreign languages on the spot with Live Translate²; Unlock the power of convenient communication with near real-time voice translations, right through your Samsung Phone app
NOTE SMARTER, NOT HARDER:', 629.0000, 50, N'03bc4adb-8a17-4fff-b4f2-0b2831432c82.jpg', N'C:\Users\lap2p\Downloads\SamsungS24.mp4', 2002, 3003, NULL, NULL, NULL, CAST(N'2024-09-11' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3015, N'mopio Aaron Couch', N'Small Sofa, Futon, Sofa Bed, Sleeper Sofa, Loveseat, Mid Century Modern Futon Couch, Sofa Cama, Couc', N'Dimensions: 76.4 (W) X 31.5 (D) X 29.1 (H) Inches [Sofa] | 76.4 (W) X 36.2 (D) X 22.8 (H) Inches [Bed]
Spill-resistant & Texture-rich Bouclé Fabric: Effortless upkeep with spill-resistance for worry-free use and stylish design details with its elegant color and nubby textured surface
Versatile Functionality: Sit, lounge or sleep with 3 adjustable splitback fold-down backrest settings. Accommodates seating for 3 and easily transforms into a compact futon bed for 1, suitable for living and guest', 359.0000, 18, N'89083fc8-f62d-496b-9864-f72e2fe669ce.jpg', N'C:\Users\lap2p\Downloads\Couch.mp4', 1, 5006, NULL, NULL, NULL, CAST(N'2024-09-15' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3016, N'Sofa Bed', N'4 in 1 Multi-Function Folding Ottoman Breathable Linen Couch Bed with Adjustable Backrest Modern Con', N'* CONVERTIBLE CHAIR TO BED - 4 IN 1 Folding Sofa Bed is easily converted into a leisure ottoman, sofa/chair, bed, and Lounger to satisfy various needs. It''s absolutely a good idea for placement in a small room, dorms, apartments, studios, office.
* MATERIAL -This 4 IN 1 Folding Sofa Bed is wrapped in premium linen fabric for beauty and comfort. High-density sponge makes the sofa very elastic, suitable for rest and sleep. The adjustable sofa back is stable and durable, allowing you to relax at ev', 200.6900, 2, N'a9d3236c-ac85-464d-896b-36d7dd14db8a.jpg', N'C:\Users\lap2p\Downloads\Sofabed.mp4', 1, 5007, NULL, NULL, 39, CAST(N'2024-09-15' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3017, N'TV with Alexa Voice Remote', N'INSIGNIA 50-inch Class F30 Series LED 4K UHD Smart Fire TV with Alexa Voice Remote', N'4K Ultra HD (2160p resolution) - Enjoy breathtaking 4K movies and TV shows at 4 times the resolution of Full HD, and upscale your current content to Ultra HD-level picture quality.
Alexa voice control - Speak commands into the voice remote with Alexa to control your Fire TV verbally—ask it to watch live TV, search for titles, play music, switch inputs, control smart home devices and more.
Access thousands of shows with Fire TV - Watch over 1 million streaming movies and TV episodes with access t', 129.0000, 18, N'66f21496-4e35-4e6c-900d-6077a8cc0f2f.jpg', NULL, 2002, 5008, NULL, NULL, NULL, CAST(N'2024-09-25' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3018, N'Vase w Poetry Card', N'Unique Hand Made Pottery Vase w Poetry Card - Cute Country Farmhouse Style Mini Flower Pot - Gifts f', N'Introducing the perfect gift for mom, expecting moms and those looking for a unique and special find! So what is a mother pot” Well, they are miniature pottery vases -smaller than a bud vase, intended to hold the tiny road-side flowers picked by children. Children don’t always manage to pluck them with the stem intact, so they don’t fit into a traditional bud vase. If you have ever been the recipient of a dandelion bouquet with tiny stems, this wee flower vase is for you! Children always want th', 18.0000, 30, N'baeb0707-66eb-4f6f-aac6-7e4b9f9ab847.jpg', N'C:\Users\lap2p\Downloads\Vase.mp4', 4, 5009, NULL, NULL, NULL, CAST(N'2024-10-15' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3019, N'Snowflake Glaze White Ceramic Vase', N'8 Inch Handmade Snowflake Glaze White Ceramic Vase,Asymmetric Wave Patterns White Vase for Modern Ho', N'【Elegant Wave Patterns and Enhanced Stability】Beautifully crafted with an elegant asymmetrical wavy pattern, this ceramic white vase boasts an enhanced stability due to its thickened base. With a weight of 2.1 pounds, it is 20% heavier than vases of similar size, ensuring it sits securely on tables or shelves while providing a substantial feel.
【 Handmade High-Temperature Ceramic】 Made from high-quality ceramic , with kaolin clay pure handcrafted and fired at temperatures exceeding 2000 degrees', 18.0000, 30, N'edc1e93d-264d-415a-b3bb-fb80ddec8803.jpg', N'C:\Users\lap2p\Downloads\Vase2.mp4', 4, 5009, NULL, NULL, NULL, CAST(N'2024-10-18' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3020, N'H2OGO! Inflatable Beach Ball', N'Classic Color Panel DesignConstructed from high grade PVC materialInflation Nozzle allows for ea', N'Brand	Bestway Toys Domestic
Material	Plastic
Color	Multi
Age Range (Description)	3+ years
Item Weight	0.05 Kilograms', 4.0000, 50, N'c3ba4216-b490-4acf-99df-282655be4934.jpg', NULL, 4002, 5010, NULL, NULL, NULL, CAST(N'2024-10-19' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3021, N'Upgraded Flying Orb Ball Toy', N'Hand Controlled Boomerang Hover Ball, Cosmic Globe Flying Spinner with Endless Tricks, Cool Toys Gif', N'【Design Concept of The Flying Orb Ball】Spherical appearance, powerful engine, function based on aviation flight principle, which can realize a variety of flight modes. This girl toys not only brings fun to play but also helps to improve children''s hands-on ability, operating skills, intelligence, and creativity.
【Rich Flying Skills】You can control the flying ball to float, glide and climb in the air, or throw it out and fly back like a boomerang, just like you have magic. Control the angle of th', 28.3500, 37, N'4fe0ba66-ba43-48b3-a79b-d18b4d517975.jpg', N'C:\Users\lap2p\Downloads\FlyingBall.mp4', 4002, 5010, NULL, NULL, 37, CAST(N'2024-10-20' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3022, N'Boys T-Shirts', N'Boys T-Shirts Little Big Kids Girls,Game Boys Shirts Short Sleeve T-Shirts,Lightning Graphic Neon T-', N'💨【Breathable Fabric】The neon shirts for boys are made of 100% polyester.With the silky-feeling fabric, the funny shirts for boys and girls make you feel cooler than other shirts in summer. A comfortable rainbow shirt for toddlers and your kids.
💥【Unique Eye-catching Printing Design】Our boys shirts 2024 are made of full body printing design,using the black color as a background and the rainbow smoke graphic, with the popular game characters, suits Hawaiian shirts for boys girls.
🎁【Gift for Kid', 14.0000, 50, N'ec4ef243-1ff5-445b-beef-fc3324f502b6.jpg', NULL, 2003, 4004, NULL, NULL, NULL, CAST(N'2024-10-20' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3023, N'Mother’s Day Fresh Flowers', N'Blue Orchid with Vase For .Gift for Birthday, Anniversary, Get Well, Thank You, Mother’s Day Fresh F', N'BLOOM SELECTIONS : 10 Blue Orchids
FRESH FLOWERS: Revel in the delight of your Bouquet Refreshing to life. Enjoy the freshness, as these handpicked Orchids gracefully.
CRAFT THE PERFECT SURPRISE: To ensure your gift inlcudes your information for the recipient, At checkout, please check off "THIS IS A GIFT" or "ADD A GIFT RECEIPT".
DELIVER AT YOUR CONVENIENCE: Place your orders any day, by 2 PM EST to receive your items the very next day! We deliver Tuesday to Friday. Orders placed on Friday, Sat', 69.0000, 20, N'2a8c1f18-51d4-4f55-8e30-d2e9a5b7e41c.jpg', NULL, 7, 5012, NULL, NULL, NULL, CAST(N'2024-10-26' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3024, N'BGment Blackout Curtains for Bedroom', N'Grommet Thermal Insulated Room Darkening Curtains for Living Room, Set of 2 Panels (42 x 63 Inch, Na', N'Package Includes: Set of 2 pieces navy blue blackout curtains; Each panel measures 42 Inch wide by 63 Inch long. Suggest choose the right size after measuring the windows.
Grommet Construction: Each curtain panel has 6 silver metal grommets on top. Each grommet inner diameter is 1.6 inch, comparable with most rods. Easy to hang, and slide smoothly.
Blackout Functions: Our bedroom curtains can block out sunlight, darker colors work better. Perfect for late sleepers and afternoon naps.
Thermal Ins', 25.0000, 20, N'44929f88-913a-44a0-b697-6653283eadc9.jpg', N'C:\Users\lap2p\Downloads\Curtains.mp4', 1002, 5013, NULL, NULL, NULL, CAST(N'2024-11-01' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3025, N'PlayStation 5', N'PlayStation 5 Digital Edition – Marvel’s Spider-Man 2 Bundle (Slim)', N'Bundle includes Marvel’s Spider-Man 2 full game digital voucher
Includes DualSense Wireless Controller, 1TB SSD, 2 Horizontal Stand Feet, HDMI Cable, AC power cord, USB cable, printed materials, ASTRO’s PLAYROOM (Pre-installed game)
Slim Design - With PS5, players get powerful gaming technology packed inside a sleek and compact console design.
PS5 Vertical Stand sold separately.', 544.0000, 20, N'5416bf56-f714-4d10-bca8-ce167e6659a4.jpg', NULL, 2002, 5015, NULL, NULL, NULL, CAST(N'2024-11-02' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3026, N'MATEIN Travel Laptop Backpack', N'MATEIN Travel Laptop Backpack, Business Anti Theft Slim Sturdy Laptops Backpack with USB Charging Po', N'★LOTS OF STORAGE SPACE&POCKETS: One separate laptop compartment hold 15.6 Inch Laptop as well as 15 Inch,14 Inch and 13 Inch Laptop. One spacious packing compartment roomy for daily necessities,tech electronics accessories. Front compartment with many pockets, pen pockets and key fob hook, makes your item organized and easier to find
★COMFY&STURDY: Comfortable soft padded back design with thick but soft multi-panel ventilated padding, gives you maximum back support. Breathable and adjustable sho', 21.4500, 30, N'51785322-9330-424a-ba25-1d6713ce7d0a.jpg', N'C:\Users\lap2p\Downloads\BackPack.mp4', 2003, 5016, NULL, NULL, 45, CAST(N'2024-11-02' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3027, N'Atomic Habits', N'An Easy & Proven Way to Build Good Habits & Break Bad Ones.', N'No matter your goals, Atomic Habits offers a proven framework for improving--every day. James Clear, one of the world''s leading experts on habit formation, reveals practical strategies that will teach you exactly how to form good habits, break bad ones, and master the tiny behaviors that lead to remarkable results.

If you''re having trouble changing your habits, the problem isn''t you. The problem is your system. Bad habits repeat themselves again and again not because you don''t want to change, b', 13.7700, 20, N'd54b2710-bf8f-4cf6-8da3-9aae2686d093.jpg', NULL, 4019, 5021, NULL, NULL, 49, CAST(N'2024-11-07' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3028, N'Charge Board', N'6Pcs TP5100 Charge Management Power Module 2A Charging Board Voltage Regulator Lithium Battery Charg', N'Double 8.4v / 4.2v lithium rechargeable single. Input voltage: 5-18V DC power supply (actual 5-12V is appropriate); Current: 1A-2A
The TP5100 is a switching step-down dual-cell 8.4V/single-cell 4.2V Li-ion battery charge management module.
The TP5100 has a wide input voltage range of 5V-18V and charges the battery in three stages: trickle pre-charge, constant current, and constant voltage. The trickle pre-charge current and constant current charge current are adjusted by external resistors, and ', 7.0000, 30, N'a13be909-c89c-4e8f-8ec1-cccdb4aa7686.jpg', NULL, 4024, 5023, NULL, NULL, NULL, CAST(N'2024-11-11' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3048, N'Canon EOS Rebel T7 DSLR Camera', N'Canon EOS Rebel T7 DSLR Camera with 18-55mm Lens | Built-in Wi-Fi | 24.1 MP CMOS Sensor | DIGIC 4+ I', N'24.1 Megapixel CMOS (APS-C) sensor with is 100–6400 (H: 12800)
Built-in Wi-Fi and NFC technology
9-Point AF system and AI Servo AF
Optical Viewfinder with approx 95% viewing coverage
Use the EOS Utility Webcam Beta Software (Mac and Windows) to turn your compatible Canon camera into a high-quality webcam. Compatible Lenses- Canon EF Lenses (including EF-S lenses, excluding EF-M lenses)', 479.0000, 26, N'a5d516a3-8ec1-4bb9-bb2b-f235da9b0454.jpg', NULL, 2002, 3003, NULL, NULL, NULL, CAST(N'2024-11-18' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3049, N'Apple iPad', N'Apple iPad (10th Generation): with A14 Bionic chip, 10.9-inch Liquid Retina Display, 64GB, Wi-Fi 6, ', N'WHY IPAD — Colorfully reimagined and more versatile than ever, iPad is great for the things you do every day. With an all-screen design, 10.9-inch Liquid Retina display, powerful A14 Bionic chip, superfast Wi-Fi, and four gorgeous colors, iPad delivers a powerful way to create, stay connected, and get things done.
IPADOS + APPS — iPadOS makes iPad more productive, intuitive, and versatile. With iPadOS, run multiple apps at once, use Apple Pencil to write in any text field with Scribble, and edit', 400.0000, 46, N'f170b513-1536-487f-bb30-91eaf09bd43e.jpg', NULL, 2002, 3003, CAST(20 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), 20, CAST(N'2024-11-21' AS Date), 1)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3050, N'Lenovo Ideapad 1i Laptop', N'Lenovo Ideapad 1i Laptop, 15.6" FHD Touchscreen, Core i3-1215U, 8GB RAM, 256GB SSD, Iris Xe Graphics - Cloud Gray + Cleaning Cloth', N'Standing screen display size	‎15.6 Inches
Screen Resolution	‎1920 x 1080 pixels
Max Screen Resolution	‎1920 x 1080 pixels
RAM	‎8 GB
Hard Drive	‎256GB SSD
Card Description	‎Integrated
Wireless Type	‎802.11n', 349.0000, 10, N'34bfdcb1-1175-4040-830d-b93dd21b6c10.jpg', N'string', 2002, 3002, CAST(10 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), NULL, CAST(N'2025-01-02' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3052, N'Purple Laptop,Ultra-Narrow bezels 2.5K QHD(2560x1600)', N'16" Purple Laptop,Ultra-Narrow bezels 2.5K QHD(2560x1600) IPS,In tel N95 (Up to 3.4Ghz),16G RAM 256G SSD, Color Backlit KB, Fingerprint,Type-C/HDMI/WiFi/HDD Expand, Win 11 PC for Business Study', N'【𝐏𝐮𝐫𝐩𝐥𝐞 𝐏𝐫𝐞𝐬𝐭𝐢𝐠𝐞 𝐋𝐚𝐩𝐭𝐨𝐩: 𝐔𝐧𝐥𝐞𝐚𝐬𝐡 𝐘𝐨𝐮𝐫 𝐔𝐧𝐢𝐪𝐮𝐞 𝐒𝐭𝐲𝐥𝐞 𝐰𝐢𝐭𝐡 𝐋𝐮𝐱𝐮𝐫𝐲 𝐚𝐧𝐝 𝐏𝐨𝐰𝐞𝐫】Step into a world of elegance with our 16-inch purple laptop, designed for those who appreciate the captivating charm of purple. The rich, romantic hue of the exterior adds a touch of luxury, making this laptop a statement piece in any setting. Paired with a vibrant rainbow backlit keyboard, every keystroke becomes an enchanting experience, as colors come alive beneath your fingertips. This laptop seamlessly blends distinctive style with powerful performance, inviting you to explore a digital landscape full of beauty and excitement.
【𝐄𝐧𝐭𝐞𝐫 𝐚 𝐖𝐨𝐫𝐥𝐝 𝐨𝐟 𝐂𝐥𝐚𝐫𝐢𝐭𝐲: 𝐄𝐱𝐩𝐞𝐫𝐢𝐞𝐧𝐜𝐞 𝐒𝐭𝐮𝐧𝐧𝐢𝐧𝐠 𝐕𝐢𝐬𝐮𝐚𝐥𝐬 𝐰𝐢𝐭𝐡 𝟐.𝟓𝐊 𝐁𝐫𝐢𝐥𝐥𝐢𝐚𝐧𝐜𝐞】Experience the enchantment of the 2560x1600 pixel display, which offers superior pixel density compared to 2K screens, delivering images that are not just sharper but exquisitely detailed. Whether you''re watching movies, tackling work tasks, or unleashing your creativity, the DQ160 ensures an exceptional visual experience. With IPS technology, enjoy vibrant colors, wide viewing angles, and intricate details, making sure everyone sees astonishing visuals without distortion, whether collaborating with colleagues or sharing with friends.
【𝐔𝐩𝐠𝐫𝐚𝐝𝐞 𝐭𝐨 𝐍𝐞𝐱𝐭-𝐋𝐞𝐯𝐞𝐥 𝐏𝐨𝐰𝐞𝐫: 𝐔𝐧𝐦𝐚𝐭𝐜𝐡𝐞𝐝 𝐏𝐞𝐫𝐟𝐨𝐫𝐦𝐚𝐧𝐜𝐞 𝐰𝐢𝐭𝐡 𝐭𝐡𝐞 𝐍𝐞𝐰 𝐍𝟗𝟓 𝐏𝐫𝐨𝐜𝐞𝐬𝐬𝐨𝐫】 Step up to next-level computing with the upgraded Intel 12th-Gen Alder Lake N95 processor. Featuring improved quad-core architecture, a 6W power-efficient design, and a refined 1.7GHz base speed, this processor advances multitasking capabilities with boosted speeds up to 3.4GHz, making it perfect for intense workloads and dynamic tasks like video editing, gaming, and seamless multitasking. Enjoy enhanced data handling with a 6MB cache and superior Intel UHD Graphics for an immersive visual experience
【𝐈𝐦𝐦𝐞𝐫𝐬𝐢𝐯𝐞 𝟏𝟔-𝐢𝐧𝐜𝐡 𝐃𝐢𝐬𝐩𝐥𝐚𝐲: 𝐋𝐢𝐦𝐢𝐭𝐥𝐞𝐬𝐬 𝐕𝐢𝐞𝐰𝐬 𝐰𝐢𝐭𝐡 𝐌𝐢𝐧𝐢𝐦𝐚𝐥 𝐁𝐞𝐳𝐞𝐥𝐬! 】Explore the allure of our laptop with a spacious 16-inch anti-blue light eye protection screen. Enjoy the enchanting 92% screen ratio, playful 16:10 aspect ratio, and the flexibility of 180° opening and closing support—perfect for daily tasks and entertainment. Immerse yourself in the magic of 4-side 4mm ultra-narrow bezels, creating a wide-angle view for seamless multitasking across apps, projects, and entertainment. Embrace the cuteness of a wide-angle display, providing an adorable space for video calls, content creation, and immersive gaming.
【 𝐔𝐧𝐥𝐞𝐚𝐬𝐡 𝐔𝐩𝐠𝐫𝐚𝐝𝐞𝐝 𝐏𝐨𝐰𝐞𝐫: 𝐅𝐫𝐨𝐦 𝟏𝟐𝐆𝐁 𝐭𝐨 𝟏𝟔𝐆𝐁 𝐑𝐀𝐌! 】Experience a surge in computing prowess with the DQ160, now featuring an impressive 16GB RAM, a significant upgrade from the previous 12GB.Enjoy smoother multitasking, faster data processing, and an overall improved computing performance, ensuring a seamless and efficient user experience.Tailor your storage to fit your needs with optional configurations of 256GB, 512GB, or 1TB SSD. Expand seamlessly to 2TB with HDD support, providing a limitless storage experience.Further flexibility comes with Micro SD card support of up to 512GB, offering ample room for all your digital aspirations.
【𝐌𝐚𝐱𝐢𝐦𝐢𝐳𝐞 𝐘𝐨𝐮𝐫 𝐏𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐯𝐢𝐭𝐲: 𝐕𝐞𝐫𝐬𝐚𝐭𝐢𝐥𝐢𝐭𝐲 𝐚𝐧𝐝 𝐀𝐛𝐮𝐧𝐝𝐚𝐧𝐭 𝐏𝐨𝐫𝐭𝐬 𝐚𝐭 𝐘𝐨𝐮𝐫 𝐅𝐢𝐧𝐠𝐞𝐫𝐭𝐢𝐩𝐬】Enjoy a versatile design featuring a full-size numeric keyboard with a 7 Colors Backlit keyboard, a spacious touchpad for smooth navigation, and enhanced privacy through fingerprint support. Stay connected with rich connectivity options including Type-C, HDMI, 3.5mm headphone jack, USB 3.0 ports, and a microSD slot. Elevate your connectivity with 2.4G/5G WiFi and Bluetooth 4.2.Experience long-lasting usage with a powerful 5000mAh battery and temperature control through an internal fan, ensuring fast and stable performance.
【𝐑𝐞𝐚𝐝𝐲 𝐭𝐨 𝐆𝐨: 𝐏𝐫𝐞-𝐈𝐧𝐬𝐭𝐚𝐥𝐥𝐞𝐝 𝐖𝐢𝐧𝐝𝐨𝐰𝐬 𝟏𝟏 𝐚𝐧𝐝 𝐎𝐟𝐟𝐢𝐜𝐞 𝟐𝟎𝟏𝟗 𝐟𝐨𝐫 𝐈𝐧𝐬𝐭𝐚𝐧𝐭 𝐏𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐯𝐢𝐭𝐲】The DQ160 laptop comes ready to use right out of the box with Windows 11 Professional and Microsoft Office 2019 already installed. This means you can start working on your projects, creating documents, or managing spreadsheets without any setup delays. Whether you''re writing reports in Word, crunching numbers in Excel, or managing emails, everything is ready and activated for you. This laptop makes it easy to jump straight into your tasks and boost your productivity from the moment you turn it on.', 387.0000, 11, N'a89c3901-ecf3-4746-a034-dbf9655aba52.jpg', NULL, 2002, 3002, CAST(10 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), NULL, CAST(N'2025-01-02' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3053, N'Student Laptop', N'Student Laptop, 1TB M2 PCIe NVMe SSD, 4C4T 1.7-3.4GHz Intel N95 CPU, 15.6" FHD IPS LCD Screen, Privacy Shutter, Backlit Keyboard, Fingerprint Reader, USB-Ax3, USB-C, Win11 Pro (32GB DDR4 RAM)', N'High-Capacity & Lightning-Fast SSD: The best laptop 2024 features a 1TB M.2 PCIe NVMe SSD, offering speeds up to 5 times faster than traditional SATA SSDs for quick boot times and seamless loading. With 1TB, you can install about 200-300 more applications and 20-30 additional games compared to a 512GB SSD. The SSD is upgradeable to 8TB, and with a microSD slot supporting up to 2TB, you can reach a total of 10TB storage, providing ample space for all your essential programs and games
Ample Memory for Multitasking: This light gamer laptop comes with 32GB RAM, enabling you to run about 20-30 more applications simultaneously compared to an 16GB setup. With DDR4 RAM that''s up to 1.5 times faster than DDR3, you’ll experience smoother performance for gaming, streaming, and multitasking. The RAM is also upgradeable to a maximum of 32GB DDR5 (dependent on memory type), offering even greater flexibility for your computing needs with this 2666MHz 32GB RAM laptop
Powerful Processor: This laptop for gaming ranks among the best 2024 laptops with the Intel N95 processor, a 4-core, 4-thread chip that operates at a base frequency of 1.7 GHz and boosts to 3.4 GHz for demanding tasks. With a TDP of just 15W. Compared to the Intel N5095, the N95 delivers a performance boost of 20-30%. The integrated Intel UHD Graphics includes 16 units, a max frequency of 1.2 GHz, supports 4K@60Hz, and can drive 3 displays, effectively handling graphics tasks and light gaming
Vibrant FHD Display: This 15.6 laptop showcases a stunning FHD IPS LCD display with ultra-slim 0.2-inch bezels, delivering crystal-clear visuals and vibrant colors. With a resolution of 1920 x 1080, it ensures sharp detail. The IPS technology provides wide viewing angles, and the screen flips 180 degrees, making it ideal for presentations. This laptop 2024 also includes a privacy camera, while the anti-glare coating reduces reflections for comfortable use in various lighting conditions
Comprehensive Connectivity: This Windows 11 Pro laptop includes a USB-C port for fast data transfer and power delivery, enhancing productivity. It also offers three USB-A ports for connecting multiple devices, an HDMI port for external displays, and a K-slot for added security. With a 3.5mm audio jack, a 3.5mm x 1.35mm charging port, and a microSD slot supporting up to 1TB, this laptop provides versatile connectivity and storage options, making it ideal for both work and entertainment
Protection Plan: Enjoy peace of mind with a comprehensive coverage policy for your student laptop, valid for a full 730 days from the date of purchase', 324.0000, 20, N'46350d8e-a11c-434c-8f4f-3d1a2548fea4.jpg', NULL, 2002, 3002, CAST(10 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), NULL, CAST(N'2025-01-02' AS Date), 2)
INSERT [dbo].[ProductCatalog] ([ProductID], [ProductName], [Description], [LongDescription], [Price], [QuantityInStock], [ImageURL], [VideoURL], [CategoryID], [SubCategoryID], [Taxes], [ADS], [Discount], [InsertionDate], [InsertByUserID]) VALUES (3054, N'Smart Roku TV with Alexa Compatibility', N'Hisense 32-Inch Class A4 Series HD 720p Smart Roku TV with Alexa Compatibility (32A4HNR, 2024 Model) - Dolby Audio, Slim Bezel Design, Google Assistant', N'ROKU TV: Hisense Roku TV makes it easy to watch what you love with built-in streaming. Enjoy endless free, live and trending TV with all the most popular apps and new features added automatically. Available in lots of sizes, there’s a Hisense Roku TV for everyone and every room
GOOGLE ASSISTANT & ALEXA COMPATIBLE: Gain access to all the latest programming and control your TV with the Google Assistant or Alexa that you already own. With the touch of your remote, Roku mobile app or sound of your own voice, turn on and off your TV, change the channels and more
HD RESOLUTION: When a 720p High-Definition LCD screen meets a Full Array LED backlight, it creates an even sharper, brighter picture
DOLBY AUDIO: Dial up the impact of your entertainment with the enhanced sound of Dolby Audio. It delivers crystal clarity, easy-to-hear dialogue, great detail and realistic surround sound to make what you’re watching even better
SLIM BEZEL DESIGN: Take advantage of a more viewable screen area and our slim, gorgeous bezel design
SIMPLE REMOTE: Make changing the channels a breeze. The no-nonsense remote gives you one-touch access to all the top streaming channels
Technical Details: -
Item Weight	‎12.23 pounds
Product Dimensions	‎3.3 x 28.6 x 16.9 inches
Country of Origin	‎Mexico
Item model number	‎32A4HNR
Batteries	‎2 AAA batteries required. (included)
Color Name	‎Black
Special Features	‎Multiple Voice Assistance, Slim Bezel Design, Flat, Non-nosense Remote, Dolby Audio
Speaker Type	‎Built-In
Standing screen display size	‎31.5 Inches
Aspect Ratio	‎16:9
Voltage	‎110 Volts
Wattage	‎50 watts', 119.0000, 10, N'cfbcdd4e-a348-4ddc-a6be-390f692f0c07.jpg', NULL, 2002, 5008, CAST(10 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), NULL, CAST(N'2025-01-02' AS Date), 2)
SET IDENTITY_INSERT [dbo].[ProductCatalog] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (1, N'living room furniture', N'4cd4104f-8c3e-4523-9b94-1206fa0b4068.png', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (2, N'office & Study furniture', N'e2e9ab78-6007-4af2-95ad-34134a5d75f0.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (4, N'home decoration', N'cbce325a-6755-4ff6-8b6e-9df91d64b1fb.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (7, N'Gardening store', N'5bdd8779-2caf-4fb6-a1c2-600103ffdade.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (1002, N'Curtains & Accessories', N'e24b87b5-7343-4367-ac52-deada3c71c06.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (1003, N'kitchen, Cookware & Serveware', N'aa21c0d4-5874-455d-bfe5-8eb47cd4e0d0.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (2002, N'Smart Devices', N'd9e3f1aa-9d5f-4d12-b05a-08c8699e1287.png', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (2003, N'Clothes', N'ff66db14-a2e7-4713-ae94-d8e776375a23.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (4002, N'Toys && Games', N'e93642bf-1a1f-4fed-9fad-e4644d4fe412.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (4019, N'Books', N'126f1646-4e57-45c7-b686-2ea01c6e941e.jpg', 1)
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [CategoryImage], [InsertByUserID]) VALUES (4024, N'Electronics & Automation', N'b0098b71-5c9d-4432-a893-a41b0d8d8e3c.jpg', 1)
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductColor] ON 

INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (1, N'Red
Blue 
Orange', 1)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (2, N'Red
Blue
Orange', 2)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (3, N'Red
Blue 
Orange', 3)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (6008, N'Red
Blue 
Orange', 1)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (7002, N'White 
DarkBlue 
SkyBlue 
Red Pink 
Black 
White Green', 2010)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8002, N'Leaf Green', 3008)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8003, N'Black', 3009)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8004, N'Black', 3010)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8005, N'Matte
Silver', 3011)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8006, N'Silver', 3012)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8007, N'Stainless Steel', 3013)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8008, N'Amber Yellow
Cobalt Violet
Marble Gray 
Onyx Black 
Titanium Black 
Titanium Gray 
Titanium Vi', 3014)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8009, N'Cloud', 3015)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8010, N'Dark Grey 
Linen Blue 
Linen Red 
White 
Yellow', 3016)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8011, N'Black', 3017)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8012, N'Blue', 3018)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8013, N'White 
Black', 3019)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8014, N'Multi', 3020)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8015, N'Blue 
Green 
Orange 
Purple 
Red', 3021)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8016, N'Green Lightning Neon Shirt Rainbow Smoke Starry Sky', 3022)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8017, N'Blue Orchid
Blue &Purple 
Blue & white 
Purple & White 
White Orchid', 3023)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8018, N'Aqua 
Pink', 3024)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8019, N'White', 3025)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8020, N'Black', 3026)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (8021, N'Black & White
Colorful', 3027)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (9035, N'black', 3048)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10035, N'blue', 3049)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10036, N'black', 3049)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10037, N'gray', 3049)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10038, N'yellow', 3049)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10039, N'Beige ', 3024)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10040, N'Black ', 3024)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10041, N'Brown ', 3024)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10042, N'Yellow ', 3024)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10043, N'

Royal Blue', 3024)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10044, N'
Classic Blue', 3024)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10045, N'Gray ', 3026)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10046, N'Green ', 3026)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10047, N'Yellow ', 3026)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10048, N'BlueWhite', 3026)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10049, N'
Leaf Yellow', 3008)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10050, N'
Leaf Colorful', 3008)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10051, N'
Leaf Navy', 3008)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10052, N'
Leaf Gray', 3008)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10053, N'
Leaf White Green', 3008)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10054, N'
Leaf Blue', 3008)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10055, N'Gray', 3015)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10056, N'
Dark Gray', 3015)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10057, N'Light Gray', 3015)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10058, N'
Midnight Black', 3015)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10059, N'
Old Rosa', 3015)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10060, N'
Pearl White', 3015)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10061, N'Black', 1004)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10062, N'Brown', 1004)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10063, N'Grey', 1005)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10064, N'Grey Gold', 1006)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10065, N'Black', 2006)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10066, N'Black', 2007)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10067, N'Gray', 2007)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10068, N'Gray', 3050)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10070, N'Purple', 3052)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10071, N'Silver', 3053)
INSERT [dbo].[ProductColor] ([ColorID], [Color], [ProductID]) VALUES (10072, N'Black', 3054)
SET IDENTITY_INSERT [dbo].[ProductColor] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 

INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1, N'C:\Users\lap2p\Downloads\Samlpe11.jpg', 1, 1005)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (2, N'C:\Users\lap2p\Downloads\Chair1.jpg', 0, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (3, N'C:\Users\lap2p\Downloads\Chair2.jpg', 1, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1002, N'C:\Users\lap2p\Downloads\desk2.jpg', 0, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1003, N'C:\Users\lap2p\Downloads\desk3.jpg', 1, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1004, N'C:\Users\lap2p\Downloads\desk4.jpg', 2, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1006, N'C:\Users\lap2p\Downloads\Sofa1.jpg', 0, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1007, N'C:\Users\lap2p\Downloads\Sofa2.jpg', 1, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1008, N'C:\Users\lap2p\Downloads\Sofa3.jpg', 2, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1009, N'C:\Users\lap2p\Downloads\Sofa4.jpg', 3, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1010, N'C:\Users\lap2p\Downloads\Chair11.jpg', 0, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1011, N'C:\Users\lap2p\Downloads\Chair12.jpg', 1, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1012, N'C:\Users\lap2p\Downloads\Chair13.jpg', 2, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (1013, N'C:\Users\lap2p\Downloads\Chair14.jpg', 3, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (2002, N'C:\Users\lap2p\Downloads\LapTop2.jpg', 0, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (2003, N'C:\Users\lap2p\Downloads\Laptop3.jpg', 1, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (2004, N'C:\Users\lap2p\Downloads\LapTop4.jpg', 2, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (2005, N'C:\Users\lap2p\Downloads\LapTop5.jpg', 3, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (3002, N'C:\Users\lap2p\Downloads\dell2.jpg', 0, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (3003, N'C:\Users\lap2p\Downloads\Dell3.jpg', 1, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (3004, N'C:\Users\lap2p\Downloads\dell4.jpg', 2, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (3005, N'C:\Users\lap2p\Downloads\Dell5.jpg', 3, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (4002, N'C:\Users\lap2p\Downloads\WhiteTShirt2.jpg', 0, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (4003, N'C:\Users\lap2p\Downloads\WhiteTShirt3.jpg', 1, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (4004, N'C:\Users\lap2p\Downloads\WhiteTShirt4.jpg', 2, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (4005, N'C:\Users\lap2p\Downloads\WhiteTShirt5.jpg', 3, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (4006, N'C:\Users\lap2p\Downloads\WhiteTShirt6.jpg', 4, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (4007, N'C:\Users\lap2p\Downloads\WhitTShirtInfo.jpg', 5, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5002, N'C:\Users\lap2p\Downloads\Shirt1.jpg', 0, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5003, N'C:\Users\lap2p\Downloads\Shirt2.jpg', 1, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5004, N'C:\Users\lap2p\Downloads\Shirt3.jpg', 2, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5005, N'C:\Users\lap2p\Downloads\Shirt5.jpg', 3, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5006, N'C:\Users\lap2p\Downloads\Shirt6.jpg', 4, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5007, N'C:\Users\lap2p\Downloads\Dress1.jpg', 0, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5008, N'C:\Users\lap2p\Downloads\Dress2.jpg', 1, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5009, N'C:\Users\lap2p\Downloads\Dress3.jpg', 2, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5010, N'C:\Users\lap2p\Downloads\Dress4.jpg', 3, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5011, N'C:\Users\lap2p\Downloads\Dress5.jpg', 4, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5012, N'C:\Users\lap2p\Downloads\Dress6.jpg', 5, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5013, N'C:\Users\lap2p\Downloads\Dress7.jpg', 6, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5014, N'C:\Users\lap2p\Downloads\CookWare2.jpg', 0, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5015, N'C:\Users\lap2p\Downloads\CookWare3.jpg', 1, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5016, N'C:\Users\lap2p\Downloads\CookWare4.jpg', 2, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5017, N'C:\Users\lap2p\Downloads\CookWare5.jpg', 3, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5018, N'C:\Users\lap2p\Downloads\CookWare6.jpg', 4, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5019, N'C:\Users\lap2p\Downloads\Stove2.jpg', 0, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5020, N'C:\Users\lap2p\Downloads\Stove3.jpg', 1, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5021, N'C:\Users\lap2p\Downloads\Stove4.jpg', 2, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5022, N'C:\Users\lap2p\Downloads\Stove5.jpg', 3, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5023, N'C:\Users\lap2p\Downloads\Stove6.jpg', 4, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5024, N'C:\Users\lap2p\Downloads\Oven2.jpg', 0, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5025, N'C:\Users\lap2p\Downloads\Oven3.jpg', 1, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5026, N'C:\Users\lap2p\Downloads\Oven4.jpg', 2, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5027, N'C:\Users\lap2p\Downloads\Oven5.jpg', 3, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5028, N'C:\Users\lap2p\Downloads\Oven6.jpg', 4, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5029, N'C:\Users\lap2p\Downloads\Refrigrator1.jpg', 0, 3013)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5030, N'C:\Users\lap2p\Downloads\Refrigrator2.jpg', 1, 3013)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5031, N'C:\Users\lap2p\Downloads\Refrigrator3.jpg', 2, 3013)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5038, N'C:\Users\lap2p\Downloads\S241.jpg', 0, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5039, N'C:\Users\lap2p\Downloads\S242.jpg', 1, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5040, N'C:\Users\lap2p\Downloads\S243.jpg', 2, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5041, N'C:\Users\lap2p\Downloads\S244.jpg', 3, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5042, N'C:\Users\lap2p\Downloads\S245.jpg', 4, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5043, N'C:\Users\lap2p\Downloads\S246.jpg', 5, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5044, N'C:\Users\lap2p\Downloads\S247.jpg', 6, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5045, N'C:\Users\lap2p\Downloads\S248.jpg', 7, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5046, N'C:\Users\lap2p\Downloads\Couch1.jpg', 0, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5047, N'C:\Users\lap2p\Downloads\Couch2.jpg', 1, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5048, N'C:\Users\lap2p\Downloads\Couch3.jpg', 2, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5049, N'C:\Users\lap2p\Downloads\Couch4.jpg', 3, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5050, N'C:\Users\lap2p\Downloads\Couch5.jpg', 4, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5051, N'C:\Users\lap2p\Downloads\Couch6.jpg', 5, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5052, N'C:\Users\lap2p\Downloads\Couch7.jpg', 6, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5053, N'C:\Users\lap2p\Downloads\Couch8.jpg', 7, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5054, N'C:\Users\lap2p\Downloads\Sofabed1.jpg', 0, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5055, N'C:\Users\lap2p\Downloads\Sofabed2.jpg', 1, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5056, N'C:\Users\lap2p\Downloads\Sofabed3.jpg', 2, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5057, N'C:\Users\lap2p\Downloads\Sofabed4.jpg', 3, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5058, N'C:\Users\lap2p\Downloads\Sofabed5.jpg', 4, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5059, N'C:\Users\lap2p\Downloads\Sofabed6.jpg', 5, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5060, N'C:\Users\lap2p\Downloads\Sofabed7.jpg', 6, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5061, N'C:\Users\lap2p\Downloads\Sofabed8.jpg', 7, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5062, N'C:\Users\lap2p\Downloads\Sofabed9.jpg', 8, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5063, N'C:\Users\lap2p\Downloads\Tv1.jpg', 0, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5064, N'C:\Users\lap2p\Downloads\Tv2.jpg', 1, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5065, N'C:\Users\lap2p\Downloads\Tv3.jpg', 2, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5066, N'C:\Users\lap2p\Downloads\Tv4.jpg', 3, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5067, N'C:\Users\lap2p\Downloads\Tv5.jpg', 4, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5068, N'C:\Users\lap2p\Downloads\Tv6.jpg', 5, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5069, N'C:\Users\lap2p\Downloads\Tv7.jpg', 6, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5070, N'C:\Users\lap2p\Downloads\Tv8.jpg', 7, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5071, N'C:\Users\lap2p\Downloads\Vase1.jpg', 0, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5072, N'C:\Users\lap2p\Downloads\Vase2.jpg', 1, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5073, N'C:\Users\lap2p\Downloads\Vase3.jpg', 2, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5074, N'C:\Users\lap2p\Downloads\Vase4.jpg', 3, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5075, N'C:\Users\lap2p\Downloads\Vase5.jpg', 4, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5076, N'C:\Users\lap2p\Downloads\Vase6.jpg', 5, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5077, N'C:\Users\lap2p\Downloads\Vase7.jpg', 6, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5078, N'C:\Users\lap2p\Downloads\Vase8.jpg', 7, 3018)
GO
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5079, N'C:\Users\lap2p\Downloads\Vase9.jpg', 8, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5080, N'C:\Users\lap2p\Downloads\Vase11.jpg', 0, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5081, N'C:\Users\lap2p\Downloads\Vase22.jpg', 1, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5082, N'C:\Users\lap2p\Downloads\Vase33.jpg', 2, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5083, N'C:\Users\lap2p\Downloads\Vase44.jpg', 3, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5084, N'C:\Users\lap2p\Downloads\Vase55.jpg', 4, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5085, N'C:\Users\lap2p\Downloads\Vase66.jpg', 5, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5086, N'C:\Users\lap2p\Downloads\Ball1.jpg', 0, 3020)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5087, N'C:\Users\lap2p\Downloads\Ball2.jpg', 1, 3020)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5088, N'C:\Users\lap2p\Downloads\Ball3.jpg', 2, 3020)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5089, N'C:\Users\lap2p\Downloads\FlyingBall1.jpg', 0, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5090, N'C:\Users\lap2p\Downloads\FlyingBall2.jpg', 1, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5091, N'C:\Users\lap2p\Downloads\FlyingBall3.jpg', 2, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5092, N'C:\Users\lap2p\Downloads\FlyingBall4.jpg', 3, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5093, N'C:\Users\lap2p\Downloads\FlyingBall5.jpg', 4, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5094, N'C:\Users\lap2p\Downloads\ChidTShirt1.jpg', 0, 3022)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5095, N'C:\Users\lap2p\Downloads\ChidTShirt2.jpg', 1, 3022)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5096, N'C:\Users\lap2p\Downloads\Flower1.jpg', 0, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5097, N'C:\Users\lap2p\Downloads\Flower2.jpg', 1, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5098, N'C:\Users\lap2p\Downloads\Flower3.jpg', 2, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5099, N'C:\Users\lap2p\Downloads\Flower4.jpg', 3, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5100, N'C:\Users\lap2p\Downloads\Flower5.jpg', 4, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5101, N'C:\Users\lap2p\Downloads\Curtains1.jpg', 0, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5102, N'C:\Users\lap2p\Downloads\Curtains2.jpg', 1, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5103, N'C:\Users\lap2p\Downloads\Curtains3.jpg', 2, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5104, N'C:\Users\lap2p\Downloads\Curtains4.jpg', 3, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5105, N'C:\Users\lap2p\Downloads\Curtains5.jpg', 4, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5106, N'C:\Users\lap2p\Downloads\Curtains6.jpg', 5, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5107, N'C:\Users\lap2p\Downloads\Curtains7.jpg', 6, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5108, N'C:\Users\lap2p\Downloads\Curtains8.jpg', 7, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5109, N'C:\Users\lap2p\Downloads\Ps5.jpg', 0, 3025)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5110, N'C:\Users\lap2p\Downloads\Ps52.jpg', 1, 3025)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5111, N'C:\Users\lap2p\Downloads\Ps53.jpg', 2, 3025)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5112, N'C:\Users\lap2p\Downloads\BackPack1.jpg', 0, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5113, N'C:\Users\lap2p\Downloads\BackPack2.jpg', 1, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5114, N'C:\Users\lap2p\Downloads\BackPack3.jpg', 2, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5115, N'C:\Users\lap2p\Downloads\BackPack4.jpg', 3, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5116, N'C:\Users\lap2p\Downloads\BackPack5.jpg', 4, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5117, N'C:\Users\lap2p\Downloads\Book1.jpg', 0, 3027)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5118, N'C:\Users\lap2p\Downloads\Board1.jpg', 0, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5119, N'C:\Users\lap2p\Downloads\Board2.jpg', 1, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5120, N'C:\Users\lap2p\Downloads\Board3.jpg', 2, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5121, N'C:\Users\lap2p\Downloads\Board4.jpg', 3, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5122, N'C:\Users\lap2p\Downloads\Board5.jpg', 4, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (5123, N'C:\Users\lap2p\Downloads\Board6.jpg', 5, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6143, N'ad6dba7a-3468-4b51-9c0b-c43a2b114e6e.jpg', 2, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6144, N'361cfd73-5ab6-4ebd-bc3d-ef743c6518ed.jpg', 3, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6145, N'd9445a40-2c36-4db2-95b5-de25669bddf8.jpg', 0, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6146, N'a235745f-87a4-47db-878a-89f1cee386b8.jpg', 4, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6147, N'2f9c4f51-af1c-408f-9456-25599d53971a.jpg', 1, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6148, N'54cfe24d-fae6-4f00-abd6-247691798507.jpg', 5, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6149, N'c6e2a99d-e994-4f1b-b6fb-79bb536dc83a.jpg', 7, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6150, N'125054e8-8cd2-45b6-9ffa-21dc7c34029d.jpg', 6, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (6151, N'44978504-a757-4600-9041-7df58e9648b0.jpg', 8, 3048)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7143, N'f8d5ed24-5dab-455d-ad05-7c69d70261d4.jpg', 4, 3049)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7144, N'cd9fc343-d82a-4c3d-a759-9443c88890cd.jpg', 1, 3049)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7145, N'2fc4efdf-af81-4a4e-ba57-64c20ffe6ced.jpg', 0, 3049)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7146, N'd8dcedcc-3765-4e3d-9dfa-4cbb874b3392.jpg', 3, 3049)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7147, N'fdebf75c-3450-4fb5-9aa8-5c7031cc3003.jpg', 2, 3049)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7148, N'307248d5-54b2-41a7-b66c-02abff15a14c.jpg', 0, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7149, N'0a14f0a4-2de8-4f5b-b4a1-3e09bd9148b4.jpg', 1, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7150, N'75fbcd5e-9d36-4e14-bac3-399a51d8340a.jpg', 2, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7151, N'72c1357b-f56f-4872-a0bc-ee840e9d91b0.jpg', 3, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7152, N'0947f32b-945c-4eac-8fcb-3ef75d3ae574.jpg', 4, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7153, N'a83ab64d-1f76-470b-8436-f7b139ef79aa.jpg', 6, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7154, N'2cfc88cd-b776-43d1-aace-740031e68295.jpg', 5, 2010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7155, N'23b8a95b-9330-49c2-a9f5-d89aaf881de4.jpg', 0, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7156, N'1b7e08e9-9caa-4151-8743-8187c5d13284.jpg', 1, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7157, N'f90545c5-6549-4893-8151-af3b91e6652f.jpg', 0, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7158, N'0b0a018d-dadb-463b-8c89-02037acc7b82.jpg', 2, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7159, N'5e44a72c-a783-4fad-ab02-f5a1e2e941ce.jpg', 3, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7160, N'd8afff8d-145a-4440-a876-d420e79fdd2e.jpg', 4, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7161, N'09af6b79-98e4-4b1d-939a-aaf56ec9b59e.jpg', 5, 3008)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7162, N'28dbc356-8bd4-427b-9b7d-0a2c153d7477.jpg', 2, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7163, N'8d4c5cea-4364-42bd-810a-76b6dd4794fc.jpg', 4, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7164, N'9359691f-567e-4a60-9ebf-5ffb19cfc430.jpg', 3, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7165, N'7e817517-eabd-4f60-b1ae-bb15e855e901.jpg', 1, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7166, N'81a9c550-8fd3-4c4c-b7c6-819cb0a677d3.jpg', 5, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7167, N'371037d3-f7de-416e-8726-4bd990963c51.jpg', 6, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7168, N'a8a14ae3-da27-4ad6-ad14-6176a04f9d61.jpg', 0, 3009)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7169, N'fbbd4117-ed94-42b8-a07d-32ae2e2886b8.jpg', 0, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7170, N'0cab92bf-a8c3-4306-aed1-18ec6635b7ee.jpg', 1, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7171, N'3e8f1c5d-6b3a-4138-bf14-35c66b257d4b.jpg', 3, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7172, N'52bd889a-045f-4dc0-b725-93dd46c79ea3.jpg', 2, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7173, N'32fc459a-2edc-4bfa-9165-143013300ce9.jpg', 4, 3010)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7174, N'1add4449-cf7d-40d8-a277-2377a6b17009.jpg', 0, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7175, N'f34a244f-2130-42d9-801c-b6d412eb3fae.jpg', 1, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7176, N'd47b7987-c34f-4173-b813-050a50da6103.jpg', 3, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7177, N'd14570b0-4cc5-4054-a1e2-a3277d1edd00.jpg', 2, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7178, N'1a721fff-08da-402a-89ac-71212542e607.jpg', 4, 3011)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7179, N'7e830d83-3bd5-4331-ba1e-d069d5a6eacb.jpg', 2, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7180, N'2269615b-d004-4270-be4f-51f596ec4961.jpg', 0, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7181, N'719425a7-434f-4c59-89b2-7902d9260703.jpg', 1, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7182, N'01b7daec-8cd4-4c73-95d3-78ddeed25af6.jpg', 3, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7183, N'470bf37a-400b-4d9b-915f-5b6d0ce15abc.jpg', 4, 3012)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7184, N'04a9a6a5-f3f3-42a5-be65-6b263f41f0f0.jpg', 2, 3013)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7185, N'3609f901-8a0e-4acd-9fe4-85d796f1c5da.jpg', 0, 3013)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7186, N'b50d257d-545c-4d1b-9ec4-690468c0810c.jpg', 1, 3013)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7187, N'17d9d29d-4d59-4b5e-9d01-8be77b8dc206.jpg', 0, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7188, N'dce6135c-2bf7-4886-b5c3-50894e4094a6.jpg', 3, 3014)
GO
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7189, N'205cbeb4-9ffc-4934-b46c-c0272761d367.jpg', 2, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7190, N'b0e4535b-59ce-4ab9-95b9-5fbc04e7ac72.jpg', 1, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7191, N'6cc9dcb0-41c6-44ef-a062-a26e9558c579.jpg', 4, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7192, N'570efbe6-1b7f-4964-9f01-9f711c8e1911.jpg', 6, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7193, N'090915ed-880a-4296-8bec-7bc33d8b2666.jpg', 5, 3014)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7194, N'00680d50-87f4-4c5b-8007-0470b1c7a8ac.jpg', 0, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7195, N'6392ce24-fb12-4623-96a9-22d4104b9271.jpg', 1, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7196, N'f8a22933-fa37-4430-bd9d-b0afba8ab18a.jpg', 3, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7197, N'31888899-d463-4bca-b2f2-41b17d42f5e3.jpg', 2, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7198, N'5e446d68-7c5b-40fa-b97e-d66fbc373c37.jpg', 4, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7199, N'78362268-fa00-4aef-9907-c59ab46b3568.jpg', 5, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7200, N'80251fe3-c7c0-4558-92b6-508d311404f5.jpg', 7, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7201, N'437f2f5f-6662-44c7-b088-8d6b9fda937c.jpg', 6, 3017)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7202, N'e1f41c1e-9ff3-4f14-8eb9-2a619a5b9bcd.jpg', 1, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7203, N'aa9afaf2-f8a5-417e-9c6a-ff0aac16ddc5.jpg', 0, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7204, N'de0edc7f-f5b6-467a-9d73-d0b189e5901d.jpg', 3, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7205, N'e0ab1b05-df94-42c1-a2e5-18223d4436b6.jpg', 2, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7206, N'e061707b-0480-4591-80b8-0d1a868764ab.jpg', 7, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7207, N'c5a37066-b12c-419b-b82f-78e5a003c2d0.jpg', 4, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7208, N'06f9161e-64ba-4ae8-bfe5-6707d30e76c0.jpg', 5, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7209, N'2101d865-287a-47d7-90b0-24b3eab64f12.jpg', 6, 3018)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7210, N'a59544ad-3435-4ad4-a945-ae737800742a.jpg', 0, 3020)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7211, N'bfbef9b2-8ed7-4695-8a4d-37429917f984.jpg', 1, 3020)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7212, N'b1b69f84-0a50-47be-b710-e32ba0d32753.jpg', 2, 3020)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7213, N'd4b3cb07-c141-4e3d-bf31-49246b6bfd01.jpg', 0, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7214, N'78e54f33-0e94-4fd7-bf8a-8dc3790494a3.jpg', 2, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7215, N'ba6364f5-2098-46df-9f1e-0e31f1a0699d.jpg', 1, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7216, N'edc357cf-12da-4754-825d-17bf49a5efd3.jpg', 3, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7217, N'acc7119e-b49a-4604-848a-a0ccb6b5b67c.jpg', 4, 3021)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7218, N'66c24322-1067-4e3f-937e-a35fb2779348.jpg', 0, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7219, N'a62e9deb-5b4d-4ba4-8a84-038aeec53bb3.jpg', 1, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7220, N'9054fd18-b4ed-4195-9ce1-58b79e9a8cd7.jpg', 2, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7221, N'3ae72b31-730f-485f-b56c-a52f4e69770c.jpg', 4, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7222, N'c116826c-4ee7-4092-8252-51779f80bbb8.jpg', 3, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7223, N'3936aeec-fc91-492e-87f5-5d834ed9de81.jpg', 5, 3019)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7224, N'fe67bd74-9693-4a3d-90ce-7098f08ed6bf.jpg', 1, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7225, N'b6b037c6-c024-46f3-b5e0-6c2970a4c858.jpg', 0, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7226, N'b1a4d572-93d9-4376-b580-37a49259ccf1.jpg', 4, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7227, N'c58578e6-a79a-42d7-89f1-1751eb1c088a.jpg', 2, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7228, N'64ac91a2-4fe0-458b-9cc0-fb38973c3cc8.jpg', 3, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7229, N'75f26f17-45db-4240-89cd-19df194217cd.jpg', 7, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7230, N'56c15d24-39fd-461c-9a4d-868a32672e72.jpg', 6, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7231, N'ac35ca2f-77fd-4ab2-95e1-7b572f1426f6.jpg', 5, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7232, N'9f8ff1a7-2da5-48ef-a97c-427b1367582c.jpg', 8, 3016)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7233, N'd55dd419-fbe0-4666-83a4-7d5381bd8950.jpg', 0, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7234, N'2ed36734-2ff0-4d06-9666-edcb34549ea0.jpg', 3, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7235, N'f1a77793-29d3-4e99-a07e-5bc216785129.jpg', 1, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7236, N'81d393eb-79a2-4070-9f40-ee5cb3a4c16b.jpg', 5, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7237, N'4bbbd93a-b034-452a-88f3-1ee39cf95810.jpg', 4, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7238, N'b469ed5e-431d-421a-b550-5becca41e74e.jpg', 6, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7239, N'ef173120-ed15-4807-a5fd-64a521a9edd8.jpg', 7, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7240, N'265cc893-4c4a-44f5-ad41-598028c67dbb.jpg', 2, 3015)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7241, N'cc57fd18-8cce-4fc8-b87d-086e05a91daf.jpg', 0, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7242, N'd2da9e9a-d878-4bfe-9da2-460b7ad433b9.jpg', 2, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7243, N'c8e154e9-eac6-4965-b49c-12da53ef5d74.jpg', 4, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7244, N'4a09adec-3a95-42ed-9228-ad5a65e7e84e.jpg', 1, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7245, N'f6e3e996-70e0-4849-8d72-f5607d78a0ea.jpg', 3, 3023)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7246, N'371e1ab3-9057-4243-8be5-0772a8451997.jpg', 0, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7247, N'5d645a35-7c47-4f7f-a433-0b58273ad7a8.jpg', 3, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7248, N'a2bdb80d-c6c5-4185-a964-79cc75ba70a9.jpg', 2, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7249, N'20390f33-d24b-468e-938f-41772b8364b8.jpg', 1, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7250, N'c73299fc-ee3c-4415-a9cb-4c8328d286d5.jpg', 5, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7251, N'4c753b8f-78bf-4ff6-a6fe-835f21089faa.jpg', 6, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7252, N'da0d0bd1-9b8a-41bd-96b0-1e25601d657a.jpg', 4, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7253, N'c3936970-e656-47ae-a300-4777f4032a98.jpg', 7, 3024)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7254, N'e2b61eca-92b4-43cd-bb54-dca92c82e9b6.jpg', 0, 3025)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7255, N'80d9dff7-1a0f-44c6-b452-6593e37753ad.jpg', 1, 3025)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7256, N'ea8e722c-f246-4baa-be41-f4fc78e6446f.jpg', 2, 3025)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7257, N'fd0aabf3-ee30-42ee-a6a5-7827f71e732d.jpg', 2, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7258, N'89ddd3e6-1993-40a1-b9d1-8fa6947be0ef.jpg', 0, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7259, N'6332b74d-a927-406d-8a0e-5c32f61dc1a0.jpg', 1, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7260, N'c3bbab46-c727-410c-a460-67b925f84ef5.jpg', 3, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7261, N'6267e67c-3e33-4f37-a02a-dfa00233383e.jpg', 4, 3026)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7262, N'60f0fe44-6da0-4048-9fc4-7de078c98fb1.jpg', 0, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7263, N'164d8e07-46e2-4cd1-b6a5-3395ab37bee0.jpg', 2, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7264, N'b2e95d09-aa5a-4fb2-88ee-dff9e3434163.jpg', 3, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7265, N'b9ee68de-e003-46e8-8bf7-e12736b27683.jpg', 1, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7266, N'859be003-6f4e-4873-a70d-874b0aa7683a.jpg', 5, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7267, N'12467e83-94e8-4d7e-a1dd-a8fd781d8969.jpg', 4, 3028)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7268, N'48d2ba13-1ba6-4f3e-990d-f60e04803284.jpg', 0, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7269, N'efea5094-25e0-4619-9c03-e43c8682cc19.jpg', 2, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7270, N'26986fe5-6b66-417e-8393-e693af99336b.jpg', 3, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7271, N'c3e6a6ab-efb5-4ec7-86a9-b7afc01e7262.jpg', 1, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7272, N'ae7a138c-4be0-4fa8-b3d3-a6f5f6079100.jpg', 5, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7273, N'754e9e74-acd5-42f8-8ead-03eb24cc4f0c.jpg', 4, 3)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7274, N'd816f5ee-ae78-4fe7-a9bd-20ecaa1db63a.jpg', 0, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7275, N'3b580ed8-e64b-4c4e-b468-ce9bab822769.jpg', 1, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7276, N'8c6084c3-f424-4135-a583-8680f8aa102b.jpg', 3, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7277, N'c2fa12a8-1c09-4d94-b9f5-e0b595766795.jpg', 2, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7278, N'94dbead5-88f1-4515-97e6-3a65ea1d0954.jpg', 4, 1)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7279, N'e9fe8b19-2111-4776-aac3-888bf4dab017.jpg', 2, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7280, N'5a34ab49-2cc5-485e-b521-2f848c0c2eea.jpg', 1, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7281, N'5c9cbfb6-0f42-4e6f-b3a6-9754e980db42.jpg', 3, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7282, N'27081a66-1225-4240-905f-2e1e01261532.jpg', 0, 2)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7283, N'66936ba0-7602-44a6-b39c-ae211457e228.jpg', 0, 1004)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7284, N'83091c8c-d1c4-47e7-9d6b-343747b0899f.jpg', 2, 1004)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7285, N'e75f5721-4fe2-4bb4-a163-9580b0c4bd97.jpg', 1, 1004)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7286, N'5cf6e90d-c341-436a-b369-36afd2e59342.jpg', 4, 1004)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7287, N'9ec705a6-24b6-48b3-81da-d2297d091ad5.jpg', 3, 1004)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7288, N'2abb060d-8f12-4e0d-ac8c-75ed33a87d74.jpg', 2, 1005)
GO
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7289, N'2f9637c3-f8be-419e-a018-08cd35e4722b.jpg', 4, 1005)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7290, N'7c19c865-3f38-4b94-be51-ba21acf22c74.jpg', 3, 1005)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7291, N'0b8c3fc2-96f6-4bd3-a1d6-7a3363495fc7.jpg', 0, 1005)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7292, N'b40e334a-f2a8-46a0-a9d8-fac2277c9deb.jpg', 1, 1005)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7293, N'5419f8e0-f1f9-400f-9d11-52c75991c8a6.jpg', 0, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7294, N'ffa07234-0f62-42ca-a19b-1a196e772d50.jpg', 2, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7295, N'185e5380-765a-4416-b20b-f5371f9e945d.jpg', 3, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7296, N'2ef8631c-493d-456c-a0a8-0be91c55d7dd.jpg', 1, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7297, N'ec1f0f02-c4d3-48aa-9fcc-5274379e0509.jpg', 5, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7298, N'9b24fb87-13ee-4d70-b672-8ada3ad9365d.jpg', 4, 1006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7299, N'b8b267c6-dd48-433c-a9f5-d78394c6c20f.jpg', 0, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7300, N'7b1b2ffd-2eef-49f4-85fe-cfdb07fff03e.jpg', 2, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7301, N'511261d8-7a98-4933-8751-5ec316bcbf3a.jpg', 1, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7302, N'df61275c-a184-41e5-ae05-294c81a9b10f.jpg', 3, 2006)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7303, N'30ab87d3-267a-49c1-b1ca-886f3a52d64f.jpg', 0, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7304, N'6d1cc50c-a45e-41da-ad62-a79c4d732688.jpg', 3, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7305, N'0b98cc33-814d-4765-bfd5-ca23bdb89102.jpg', 1, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7306, N'2e185589-4ee2-402d-9375-2f42bd88b251.jpg', 4, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7307, N'e2f4c72b-e987-4c22-88bd-28ffd7509a0d.jpg', 2, 2007)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7308, N'812d56d0-0f07-412e-a654-b9558038e4e3.jpg', 2, 3050)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7309, N'92b18bfa-8e8e-4ba2-8928-266c20b1a6ac.jpg', 0, 3050)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7310, N'ad092c2c-965f-4cb1-ac64-36e388ca59b7.jpg', 1, 3050)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7311, N'0e82f0f2-053c-4194-8448-8d85e1b2839a.jpg', 4, 3050)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7312, N'f3ed9c4a-27b3-4383-a559-b3e294f2ebde.jpg', 3, 3050)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7313, N'4b0f1272-9c82-4d7d-b5a8-c310c7b1f518.jpg', 0, 3052)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7314, N'a29a56c6-4423-42d8-96c4-b4d9fcca16c2.jpg', 1, 3052)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7315, N'afc4db60-87f3-45c8-a485-8214c6737115.jpg', 2, 3052)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7316, N'e0deccfe-fcb0-4a1c-8d81-e72422680100.jpg', 3, 3052)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7317, N'5b749f96-b5a2-49fe-a5a4-8572a0741162.jpg', 4, 3052)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7318, N'e3a5c60c-3f9f-42ac-ba9e-e3e9fd1c20a9.jpg', 5, 3052)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7319, N'8a7d24e1-d8b3-48ce-9e3a-23a1180db4bd.jpg', 6, 3052)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7320, N'b123b28c-e2b2-4366-8f80-20bcc6140f31.jpg', 1, 3053)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7321, N'e026ac12-03c7-40f1-a6dd-2302fd03ed7b.jpg', 4, 3053)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7322, N'0c4ecb7c-ef6e-4f05-9d4e-d7da426ba9db.jpg', 6, 3053)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7323, N'03ea72f9-2d14-450c-b592-76f1cec15b6b.jpg', 5, 3053)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7324, N'30fea712-1cbc-4d77-bdb8-c106e0f03273.jpg', 2, 3053)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7325, N'14d64bc9-0f68-468e-b1e1-e471e9d95372.jpg', 3, 3053)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7326, N'f775b3fb-5d46-4aaf-8032-1d242870ebcd.jpg', 0, 3053)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7327, N'2fb76c13-19c5-4ed4-a486-3e571b1e45ed.jpg', 4, 3054)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7328, N'd35ea0e0-029d-46ba-b852-f47100d55b59.jpg', 3, 3054)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7329, N'23f2352f-3ff0-4254-a769-179b20974a80.jpg', 1, 3054)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7330, N'e7cd3998-30a3-4997-92c4-1cfb32368752.jpg', 2, 3054)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7331, N'b84ee423-1141-4325-a99c-a083f7841941.jpg', 0, 3054)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7332, N'd6dd7533-bc76-460f-add3-202f2f318680.jpg', 5, 3054)
INSERT [dbo].[ProductImages] ([ID], [ImageURL], [ImageOrder], [ProductID]) VALUES (7333, N'dfbc9537-af4c-4a87-8da0-7e7090b96f26.jpg', 6, 3054)
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductSize] ON 

INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (1, N'S 
M 
L', 1)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (2, N'S
M
L', 2)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (3, N'S 
M 
L', 3)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (4009, N'S 
M 
L', 1)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (5007, N'S 
M 
L 
XL
XXL', 2010)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6007, N'Small 
Meduim 
Large 
X Large 
XX Large', 3008)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6008, N'Small 
Medium 
Large', 3009)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6009, N'10-Piece', 3010)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6010, N'Tow Heating Elements', 3011)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6011, N'16.89"D x 15.51"W x 15.87"H', 3012)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6012, N'20.1"D x 18.9"W x 43"H', 3013)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6013, N'128GB 
256GB 
512GB', 3014)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6014, N'31.5"D x 76.4"W x 29.1"H', 3015)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6015, N'71"D x 34"W x 16"H', 3016)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6016, N'50 Inches', 3017)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6017, N'Small', 3018)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6018, N'Medium', 3019)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6019, N'Big', 3020)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6020, N'Small', 3021)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6021, N'5-6 Years', 3022)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6022, N'20', 3023)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6023, N'45"L x 38"W 
42"L x 63"W 
52"L x 72"W', 3024)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6024, N'None', 3025)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6025, N'15.6 Inch', 3026)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6026, N'Big
Small', 3027)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (6027, N'Input Voltage 18 Volts', 3028)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (7038, N'55 Millimeters', 3048)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8038, N'256GB', 3049)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8039, N'64GB', 3049)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8040, N'27.6"D x 22.5"W x 42.7"H', 1004)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8041, N'27.56"D x 27.56"W x 47.64"H', 1005)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8042, N'27.6"D x 27.6"W x 49.2"H', 1006)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8043, N'14 Inches 1 TB SSD 16 GB RAM', 2006)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8044, N'15.6 Inches 256 GB SSD 12 GB RAM', 2007)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8045, N'‎256GB SSD', 3050)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8047, N'16GB+256GB SSD', 3052)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8048, N'32 GB 15.6 Inches', 3053)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8049, N'43-inch', 3054)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8050, N'40-inch', 3054)
INSERT [dbo].[ProductSize] ([SizeID], [Size], [ProductID]) VALUES (8051, N'32-inch', 3054)
SET IDENTITY_INSERT [dbo].[ProductSize] OFF
GO
SET IDENTITY_INSERT [dbo].[Responses] ON 

INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (1, 2, N'Asim', N'Hi, this is Owner.', 1, CAST(N'2024-05-05T04:27:22.480' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2, 2, N'Asim', N'Hi Asim', 1, CAST(N'2024-06-06T17:40:01.110' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (1002, 2, N'Asim', N'Hey, How can I help you?', 1, CAST(N'2024-07-05T16:55:48.373' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2002, 2004, N'Tom', N'Test5 response.', 1004, CAST(N'2024-07-19T23:02:33.893' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2003, 2004, N'Tom', N'Test6', 1005, CAST(N'2024-07-21T19:46:35.527' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2004, 2004, N'Tom', N'Test6.', 1005, CAST(N'2024-07-21T23:09:28.183' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2005, 2004, N'Tom', N'Test6', 1005, CAST(N'2024-07-21T23:20:50.883' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2006, 2004, N'Tom', N'Test6.', 1005, CAST(N'2024-07-21T23:27:01.983' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2007, 2004, N'Tom', N'Test6.', 1005, CAST(N'2024-07-22T10:43:19.477' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2008, 2004, N'Tom', N'hey', 1008, CAST(N'2024-07-26T11:11:11.157' AS DateTime), 1)
INSERT [dbo].[Responses] ([ResponseID], [OwnerID], [Name], [Response], [MessageID], [DateTime], [CustomerID]) VALUES (2011, 2004, N'Tom', N'hi', 2, CAST(N'2024-07-29T18:34:12.560' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Responses] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (2, 3, 1, N'Good Quality Furniture.', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-05-09T15:25:13.740' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (1002, 1006, 1, N'Nice Chair', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-05-12T14:45:20.663' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (2002, 2010, 1, N'Nice Shirt', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-06-26T19:28:14.110' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3002, 1, 1, N'', CAST(3.0 AS Decimal(2, 1)), CAST(N'2024-07-02T16:19:48.133' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3003, 3010, 1, N'Nice Cookware Collection', CAST(5.0 AS Decimal(2, 1)), CAST(N'2024-07-10T10:11:21.977' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3004, 3011, 1, N'Nice Stove', CAST(5.0 AS Decimal(2, 1)), CAST(N'2024-07-10T10:15:41.257' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3005, 1005, 1, N'Nice Chair', CAST(5.0 AS Decimal(2, 1)), CAST(N'2024-07-10T10:20:51.667' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3006, 2006, 1, N'Nice Laptop', CAST(5.0 AS Decimal(2, 1)), CAST(N'2024-07-10T10:22:47.520' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3007, 2007, 1, N'High Performance Laptop :)', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-10T12:16:24.793' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3008, 3016, 1, N'jok', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-26T19:03:08.697' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3009, 3016, 1, N'dfdcx', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-26T19:22:50.320' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3010, 3016, 1, N'ccx', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-26T19:34:14.973' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3011, 3016, 1, N'jiio', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-26T19:40:49.287' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3012, 3016, 1, N'nice', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-27T15:30:10.397' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3013, 3016, 1, N'nice', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-28T01:01:19.163' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3014, 3016, 1, N'nice', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-28T01:10:10.983' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (3027, 3016, 1, N'cx', CAST(6.0 AS Decimal(2, 1)), CAST(N'2024-07-28T19:27:59.990' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4015, 2, 5017, N'Nice', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T10:43:24.663' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4016, 2, 5017, N'Nice2', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T10:45:34.670' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4017, 2, 5017, N'Nice', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T10:47:34.797' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4018, 2, 5017, N'Nice', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T10:48:26.357' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4019, 1004, 5017, N'Nice', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T10:50:30.603' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4020, 1004, 5017, N'Good', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T11:04:18.963' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4021, 1004, 5017, N'Good2', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T12:24:09.973' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4022, 1004, 5017, N'Wonderful', CAST(5.0 AS Decimal(2, 1)), CAST(N'2024-12-09T12:29:55.707' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4024, 1004, 5017, N'Awesome', CAST(4.0 AS Decimal(2, 1)), CAST(N'2024-12-09T14:43:52.007' AS DateTime))
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [CustomerID], [ReviewText], [Rating], [ReviewDate]) VALUES (4025, 1004, 5017, N'I Like it', CAST(3.0 AS Decimal(2, 1)), CAST(N'2024-12-09T14:47:35.970' AS DateTime))
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[SalesReport] ON 

INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (2, N'January', 2021, 10, CAST(5000.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (3, N'February', 2021, 15, CAST(5500.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (4, N'March', 2021, 18, CAST(5600.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (5, N'April', 2021, 12, CAST(5800.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (6, N'May', 2021, 11, CAST(5000.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (7, N'June', 2021, 19, CAST(3900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (8, N'July', 2021, 25, CAST(6300.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (9, N'August', 2021, 19, CAST(5600.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (10, N'September', 2021, 29, CAST(6900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (11, N'October', 2021, 26, CAST(6500.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (12, N'November', 2021, 22, CAST(6200.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (13, N'December', 2021, 31, CAST(7100.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (14, N'January', 2022, 19, CAST(5200.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (15, N'February', 2022, 13, CAST(5300.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (16, N'March', 2022, 21, CAST(5900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (17, N'April', 2022, 25, CAST(6000.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (18, N'May', 2022, 30, CAST(6900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (19, N'June', 2022, 33, CAST(7500.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (20, N'July', 2022, 39, CAST(7900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (21, N'August', 2022, 42, CAST(8100.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (22, N'September', 2022, 50, CAST(8800.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (23, N'October', 2022, 49, CAST(8600.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (24, N'November', 2022, 52, CAST(8900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (25, N'December', 2022, 60, CAST(9800.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (26, N'January', 2023, 56, CAST(9200.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (27, N'February', 2023, 62, CAST(10100.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (28, N'March', 2023, 69, CAST(10900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (29, N'April', 2023, 76, CAST(12100.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (30, N'May', 2023, 72, CAST(11200.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (31, N'June', 2023, 78, CAST(12500.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (32, N'July', 2023, 81, CAST(13000.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (33, N'August', 2023, 77, CAST(12300.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (34, N'September', 2023, 85, CAST(13500.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (35, N'October', 2023, 90, CAST(13900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (36, N'November', 2023, 93, CAST(14100.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (37, N'December', 2023, 90, CAST(15000.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (38, N'January', 2024, 93, CAST(16200.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (39, N'February', 2024, 94, CAST(17700.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (40, N'March', 2024, 92, CAST(18200.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (41, N'April', 2024, 97, CAST(20600.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (42, N'May', 2024, 99, CAST(21800.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (43, N'June', 2024, 101, CAST(22900.0000 AS Decimal(19, 4)))
INSERT [dbo].[SalesReport] ([SalesID], [Month], [Year], [TotalSales], [TotalRevenue]) VALUES (44, N'July', 2024, 149, CAST(32978.7900 AS Decimal(19, 4)))
SET IDENTITY_INSERT [dbo].[SalesReport] OFF
GO
SET IDENTITY_INSERT [dbo].[Shippers] ON 

INSERT [dbo].[Shippers] ([CarrierID], [CarrierName], [Phone], [Email], [UserName], [Password], [InsertByUserID]) VALUES (1, N'John', N'0112328932', N'John@gmail.com', N'John123', N'f8986fd1570d78028f9b036f47f1207f8cd9f0a6ec673daa29bacf3435dfde3e', 1)
INSERT [dbo].[Shippers] ([CarrierID], [CarrierName], [Phone], [Email], [UserName], [Password], [InsertByUserID]) VALUES (2, N'Mike', N'323781789823', N'Mike@gamil.com', N'Mike123', N'18aa2698ce26db3479297111b7022f2e9c285428533a9c738854e7eaf6a9eed8', 1)
INSERT [dbo].[Shippers] ([CarrierID], [CarrierName], [Phone], [Email], [UserName], [Password], [InsertByUserID]) VALUES (3, N'ASIM YASIN OMER AHMED', N'01115346864', N'as1549yasas@gmail.com', N'as123', N'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', 1)
INSERT [dbo].[Shippers] ([CarrierID], [CarrierName], [Phone], [Email], [UserName], [Password], [InsertByUserID]) VALUES (1003, N'Asim Yasin', N'01115346864', N'as1549yasas@gmail.com', N'Asim123', N'fbf6352882eaa5fcb7912ed13a11e5cea2f06647055281cc9288240f60f3889a', 2)
SET IDENTITY_INSERT [dbo].[Shippers] OFF
GO
SET IDENTITY_INSERT [dbo].[Shippings] ON 

INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (1, 2008, 1, N'BR8111797', 5, CAST(N'2024-06-05T00:00:00.000' AS DateTime), CAST(N'2024-06-11T17:35:28.227' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (2, 3008, 1, N'WY4968004', 5, CAST(N'2024-06-14T00:00:00.000' AS DateTime), CAST(N'2024-06-12T12:58:05.333' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (3, 3013, 1, N'JV3248195', 5, CAST(N'2024-07-14T00:00:00.000' AS DateTime), CAST(N'2024-07-11T17:11:46.820' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (4, 4009, 1, N'ZT6725757', 5, CAST(N'2024-07-19T00:00:00.000' AS DateTime), CAST(N'2024-07-16T17:30:59.573' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (5, 4022, 1, N'JQ2143386', 6, CAST(N'2024-07-22T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (8, 4033, 1, N'XV6871255', 5, CAST(N'2024-07-25T00:00:00.000' AS DateTime), CAST(N'2024-07-22T11:07:11.320' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (9, 4032, 2, N'XJ1492829', 5, CAST(N'2024-07-25T00:00:00.000' AS DateTime), CAST(N'2024-07-22T12:07:01.220' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (11, 4035, 1, N'MJ0636998', 5, CAST(N'2024-07-29T00:00:00.000' AS DateTime), CAST(N'2024-07-26T00:34:46.803' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (12, 4038, 1, N'YJ7969472', 5, CAST(N'2024-07-31T00:00:00.000' AS DateTime), CAST(N'2024-07-28T01:16:20.830' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (13, 4051, 1, N'XQ3413526', 5, CAST(N'2024-08-01T00:00:00.000' AS DateTime), CAST(N'2024-07-29T11:06:43.963' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (1012, 5050, 1, N'XI4058120', 5, CAST(N'2024-12-20T00:00:00.000' AS DateTime), CAST(N'2024-12-18T22:58:06.423' AS DateTime))
INSERT [dbo].[Shippings] ([ShippingID], [OrderID], [CarrierID], [TrackingNumber], [ShippingStatus], [EstimatedDeliveryDate], [ActualDeliveryDate]) VALUES (1013, 5051, 1, N'HA4559918', 6, CAST(N'2024-12-26T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Shippings] OFF
GO
SET IDENTITY_INSERT [dbo].[SubCategory] ON 

INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (1, N'Tables', 2)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (2, N'Chairs', 2)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (2003, N'Desks', 2)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (3002, N'Laptops', 2002)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (3003, N'Smart Phones', 2002)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (4002, N'Men Clothes', 2003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (4003, N'Women Clothes', 2003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (4004, N'Children Clothes', 2003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5002, N'Cookware', 1003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5003, N'Ovens', 1003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5004, N'Stoves', 1003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5005, N'Refrigerators', 1003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5006, N'Couch', 1)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5007, N'Sofa', 1)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5008, N'TV', 2002)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5009, N'Home made products', 4)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5010, N'Toys', 4002)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5012, N'Flowers', 7)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5013, N'Curtains', 1002)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5014, N'Accessories', 1002)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5015, N'PlayStation', 2002)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5016, N'BackPack', 2003)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5018, N'Science', 4019)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5019, N'Entertainment', 4019)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5021, N'Self Improvement', 4019)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (5023, N'Electric Board', 4024)
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName], [CategoryID]) VALUES (6023, N'Vase', 7)
SET IDENTITY_INSERT [dbo].[SubCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (1, N'Asim', N'382994829', N'as@gmail.com', N'Dubai', N'O123', N'4e9036ea221b6acee54c7bf8b9a12f704ce4dad814ea5e998ff2921aaf86bae6', NULL, 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (2, N'Tom', N'3921029107012', N'Tom@gmail.com', N'United States', N'Tom123', N'f8986fd1570d78028f9b036f47f1207f8cd9f0a6ec673daa29bacf3435dfde3e', NULL, 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (3, N'Ramy', N'329723089198', N'Ramy@gmail.com', N'Egypt-Cairo', N'Ramy123', N'63033a593a3f731d82ad0e24e6a89d8f81fe9931e489cfe375d218f6f079ff1f', N'', 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (4, N'Basil', N'329364322893', N'Basil@gmail.com', N'USA-Virgina', N'Basil123', N'a935c2b6223434aad8b1d3f9b58ee36ae2e93c51d923a145d6d5e6d98cf0b14e', NULL, 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (5, N'ASIM YASIN OMER AHMED', N'01115346864', N'as1549yasas@gmail.com', N'Dubai', N'as123', N'as93im', N'669d92c2-260e-439c-a262-e39574cc441f.png', 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (6, N'Asim Yasin Omer', N'01115346864', N'as1549yasas@gmail.com', N'Kafr El Sheikh', N'as1234', N'as93im', N'4c4f971b-9ac3-4773-8144-18624df609d4.jpg', 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (13, N'Basil Yasin', N'372381717393', N'Ba@gmail.com', N'US', N'Ba123', N'8b01ce91c0a81b37645619ff98e8ddaf71e201c9e2e84707e48a41db8794adb4', N'', 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (14, N'Ali', N'7347823289', N'Ali@gmail.com', N'Egypt', N'Ali123', N'0d2193f235b10710ca689bfee35f088230a39161f5608614c82e5bb06776f019', NULL, 1)
INSERT [dbo].[Users] ([UserID], [Name], [Phone], [Email], [Address], [UserName], [Password], [ImageURL], [Permissions]) VALUES (15, N'Ammar', N'3873873228', N'Ammar@gmail.com', N'Egypt', N'Ammar123', N'63bb8c9486c76e0c4f58e03ddf841e5e1d200615576992f3a1d76115a0b2a926', NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[WeeklySales] ON 

INSERT [dbo].[WeeklySales] ([WeeklySalesID], [Month], [Week1Sales], [Week2Sales], [Week3Sales], [Week4Sales]) VALUES (1, N'July', 8, 6, 10, 14)
INSERT [dbo].[WeeklySales] ([WeeklySalesID], [Month], [Week1Sales], [Week2Sales], [Week3Sales], [Week4Sales]) VALUES (3, N'July', 4, 6, 11, 15)
INSERT [dbo].[WeeklySales] ([WeeklySalesID], [Month], [Week1Sales], [Week2Sales], [Week3Sales], [Week4Sales]) VALUES (4, N'July', 10, 7, 18, 5)
SET IDENTITY_INSERT [dbo].[WeeklySales] OFF
GO
ALTER TABLE [dbo].[Favourites] ADD  CONSTRAINT [DF_Table_1_AddedToFavourit]  DEFAULT ((0)) FOR [AddedToFavourite]
GO
ALTER TABLE [dbo].[ProductImages] ADD  CONSTRAINT [DF_ProductImages_ImageOrder]  DEFAULT ((0)) FOR [ImageOrder]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_ProductCatalog] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductCatalog] ([ProductID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_ProductCatalog]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Order_Payment] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Order_Payment]
GO
ALTER TABLE [dbo].[ProductCatalog]  WITH CHECK ADD  CONSTRAINT [FK_Category_Product] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProductCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductCatalog] CHECK CONSTRAINT [FK_Category_Product]
GO
ALTER TABLE [dbo].[ProductCatalog]  WITH CHECK ADD  CONSTRAINT [FK_ProductCatalog_Users] FOREIGN KEY([InsertByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ProductCatalog] CHECK CONSTRAINT [FK_ProductCatalog_Users]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Users] FOREIGN KEY([InsertByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Users]
GO
ALTER TABLE [dbo].[ProductColor]  WITH CHECK ADD  CONSTRAINT [FK_ProductColor_ProductCatalog] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductCatalog] ([ProductID])
GO
ALTER TABLE [dbo].[ProductColor] CHECK CONSTRAINT [FK_ProductColor_ProductCatalog]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_ProductCatalog] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductCatalog] ([ProductID])
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_ProductCatalog]
GO
ALTER TABLE [dbo].[ProductSize]  WITH CHECK ADD  CONSTRAINT [FK_ProductSize_ProductCatalog] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductCatalog] ([ProductID])
GO
ALTER TABLE [dbo].[ProductSize] CHECK CONSTRAINT [FK_ProductSize_ProductCatalog]
GO
ALTER TABLE [dbo].[Responses]  WITH CHECK ADD  CONSTRAINT [FK_Responses_Messages1] FOREIGN KEY([MessageID])
REFERENCES [dbo].[Messages] ([MessageID])
GO
ALTER TABLE [dbo].[Responses] CHECK CONSTRAINT [FK_Responses_Messages1]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Review] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Customer_Review]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Product_Review] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductCatalog] ([ProductID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Product_Review]
GO
ALTER TABLE [dbo].[Shippers]  WITH CHECK ADD  CONSTRAINT [FK_Shippers_Users] FOREIGN KEY([InsertByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [FK_Shippers_Users]
GO
ALTER TABLE [dbo].[Shippings]  WITH CHECK ADD  CONSTRAINT [FK_Order_Shipping] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Shippings] CHECK CONSTRAINT [FK_Order_Shipping]
GO
ALTER TABLE [dbo].[Shippings]  WITH CHECK ADD  CONSTRAINT [FK_Shippings_Shippers] FOREIGN KEY([CarrierID])
REFERENCES [dbo].[Shippers] ([CarrierID])
GO
ALTER TABLE [dbo].[Shippings] CHECK CONSTRAINT [FK_Shippings_Shippers]
GO
ALTER TABLE [dbo].[SubCategory]  WITH CHECK ADD  CONSTRAINT [FK_SubCategory_ProductCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProductCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[SubCategory] CHECK CONSTRAINT [FK_SubCategory_ProductCategory]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewCategory]
    @CategoryName nvarchar(100),
	@CategoryImage nvarchar(500),
	@InsertByUserID int,
    @NewCategoryID INT OUTPUT
AS
BEGIN
    INSERT INTO ProductCategory(CategoryName,CategoryImage,InsertByUserID)
    VALUES   (@CategoryName,@CategoryImage,@InsertByUserID);

    SET @NewCategoryID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewChartData]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewChartData]
 --   @Month nvarchar(50),
	--@TotalOrders int,
	--@TotalVisitors int,
	--@TotalRevenue float,
AS
BEGIN
    INSERT INTO ChartData(Month,TotalOrders,TotalVisitors,TotalMonthSales)
    VALUES  ((SELECT DATENAME(month, GETDATE())),(Select Count(*)from Orders where Month(OrderDate)=Month(SYSDATETIME())),
	(select Count(NewCustomerID)from NotificationOwner where Month(DateTime)= Month(SYSDATETIME())),
	(select Count(*) from Payments where Month(TransactionDate)= Month(SYSDATETIME())));
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewCustomer]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_AddNewCustomer]
    @Name nvarchar(100),
	@Email nvarchar(100),
	@Phone nvarchar(20),
	@Address nvarchar(200),
	@Password nvarchar (100),
    @NewCustomerID INT OUTPUT
AS
BEGIN
    INSERT INTO Customers(Name ,Email,Phone,Address,Password)
    VALUES   (@Name,@Email,@Phone,@Address,@Password);

    SET @NewCustomerID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewMessage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewMessage]
	@CustomerID int,
	@Message nvarchar(500),
	@DateTime datetime,
	@NewMessageID int output
AS
BEGIN
    INSERT INTO Messages(CustomerID ,Message,DateTime)
    VALUES   (@CustomerID,@Message,GETDATE());
	set @NewMessageID =  SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewOrder]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewOrder]
@CustomerID int,
@OrderDate datetime,
@TotalAmount smallmoney,
@Status smallint,
    @NewOrderID INT OUTPUT
AS
BEGIN
    INSERT INTO Orders(CustomerID,OrderDate,TotalAmount,Status)
    VALUES   (@CustomerID,GETDATE(),@TotalAmount,@Status);

    SET @NewOrderID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewOrderItem]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AddNewOrderItem]
@OrderID int,
@ProductID int,
@Quantity int,
@Size nvarchar(10),
@Color nvarchar(50),
@Price decimal,
@TotalItemsPrice decimal
As BEGIN
    INSERT INTO OrderItems(OrderID,ProductID,Quantity,Size,Color,Price,TotalItemsPrice)
    VALUES   (@OrderID,@ProductID,@Quantity,@Size,@Color,@Price,@TotalItemsPrice);

END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewPayment]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_AddNewPayment]
@OrderID int,
@Amount smallmoney,
@PaymentMethod nvarchar(50),
@TransactionDate DateTime,
   @NewPaymentID INT OUTPUT
AS
BEGIN
    INSERT INTO Payments(OrderID,Amount,PaymentMethod,TransactionDate)
    VALUES   (@OrderID,@Amount,@PaymentMethod,@TransactionDate);

    SET @NewPaymentID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewProductCatalog]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewProductCatalog]
@ProductName nvarchar(100),
@Description nvarchar(Max),
@LongDescription nvarchar(Max),
@Price smallmoney,
@QuantityInStock int,
@CategoryID int,
@SubCategoryID int,
@ImageURL nvarchar(200),
@VideoURL nvarchar(200),
@Taxes decimal,
@ADS decimal,
@Discount int,
@InsertByUserID int,
    @NewProductID INT OUTPUT
AS
BEGIN
    INSERT INTO ProductCatalog(ProductName,Description,LongDescription,Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertionDate,InsertByUserID)
    VALUES   (@ProductName,@Description,@LongDescription,@Price,@QuantityInStock,@ImageURL,@VideoURL,@CategoryID,@SubCategoryID,@Taxes,@ADS,@Discount,GETDATE(),@InsertByUserID);

    SET @NewProductID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewProductColor]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewProductColor]
    @Color nvarchar(100),
	@ProductID int,
    @NewColorID INT OUTPUT
AS
BEGIN
    INSERT INTO ProductColor(Color,ProductID)
    VALUES   (@Color,@ProductID);

    SET @NewColorID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewProductImage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewProductImage]
    @ImageUrl nvarchar(200),
	@ImageOrder smallint,
	@ProductID int,
    @NewImageID INT OUTPUT
AS
BEGIN
    INSERT INTO ProductImages(ImageURL,ImageOrder,ProductID)
    VALUES   (@ImageUrl,@ImageOrder,@ProductID);

    SET @NewImageID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewProductSize]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewProductSize]
    @Size nvarchar(100),
	@ProductID int,
    @NewSizeID INT OUTPUT
AS
BEGIN
    INSERT INTO ProductSize(Size,ProductID)
    VALUES   (@Size,@ProductID);

    SET @NewSizeID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewResponse]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewResponse]
	@OwnerID int,
	@Name nvarchar(100),
	@Response nvarchar(500),
	@MessageID int,
	@Datetime datetime,
	@CustomerID int,
    @NewResponseID INT OUTPUT
AS
BEGIN
    INSERT INTO Responses(OwnerID ,Name,Response,MessageID,DateTime,CustomerID)
    VALUES   (@OwnerID,@Name,@Response,@MessageID,@Datetime,@CustomerID);

    SET @NewResponseID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewReview]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewReview]
    @ProductID int,
	@CustomerID int,
	@ReviewText nvarchar(500),
	@Rating decimal(2,1),
    @NewReviewID INT OUTPUT
AS
BEGIN
    INSERT INTO Reviews(ProductID,CustomerID,ReviewText,Rating,ReviewDate)
    VALUES   (@ProductID,@CustomerID,@ReviewText,@Rating,GETDATE());

    SET @NewReviewID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewShipper]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewShipper]
    @CarrierName nvarchar(100),
	@Email nvarchar(100),
	@Phone nvarchar(20),
	@UserName nvarchar (100),
	@Password nvarchar (100),
	@InsertByUserID int,
    @NewCarrierID INT OUTPUT
AS
BEGIN
    INSERT INTO Shippers(CarrierName ,Email,Phone,UserName,Password,InsertByUserID)
    VALUES   (@CarrierName,@Email,@Phone,@UserName,@Password,@InsertByUserID);

    SET @NewCarrierID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewShipping]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewShipping]
    @OrderID int,
	@CarrierID int,
	@TrackingNumber nvarchar(100),
	@ShippingStatus smallint,
	@EstimatedDeliveryDate Date,
	@ActualDeliveryDate Date =null,
    @NewShippingID INT OUTPUT
AS
BEGIN
    INSERT INTO Shippings(OrderID ,CarrierID,TrackingNumber,ShippingStatus,EstimatedDeliveryDate,ActualDeliveryDate)
    VALUES   (@OrderID,@CarrierID,@TrackingNumber,@ShippingStatus,@EstimatedDeliveryDate,@ActualDeliveryDate);

    SET @NewShippingID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewSubCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AddNewSubCategory]
    @SubCategoryName nvarchar(100),
	@CategoryID int,
    @NewSubCategoryID INT OUTPUT
AS
BEGIN
    INSERT INTO SubCategory(SubCategoryName,CategoryID)
    VALUES   (@SubCategoryName,@CategoryID);

    SET @NewSubCategoryID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewUser]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewUser]
    @Name nvarchar(100),
	@Email nvarchar(100),
	@Phone nvarchar(20),
	@Address nvarchar(200),
	@UserName nvarchar (100),
	@Password nvarchar (100),
	@ImageURL nvarchar(200),
	@Permissions int,
    @NewUserID INT OUTPUT
AS
BEGIN
    INSERT INTO Users(Name,Phone,Email,Address,UserName,Password,ImageURL,Permissions)
    VALUES   (@Name,@Phone,@Email,@Address,@UserName,@Password,@ImageURL,@Permissions);

    SET @NewUserID = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewWeeklySales]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewWeeklySales]
 --   @Month nvarchar(50),
	--@TotalOrders int,
	--@TotalVisitors int,
	--@TotalRevenue float,
AS
BEGIN
    INSERT INTO WeeklySales(Month,Week1Sales,Week2Sales,Week3Sales,Week4Sales)
    VALUES  ((SELECT DATENAME(month, GETDATE())),(SELECT 
    COUNT(*) FROM Payments WHERE
    MONTH(TransactionDate) = MONTH(GETDATE()) and DAY(TransactionDate) <=7) ,
	(SELECT 
    COUNT(*) FROM Payments WHERE
    MONTH(TransactionDate) = MONTH(GETDATE()) and DAY(TransactionDate) <=14 ),
	(SELECT 
    COUNT(*) FROM Payments WHERE
    MONTH(TransactionDate) = MONTH(GETDATE()) and DAY(TransactionDate) <=21 ),
	(SELECT 
    COUNT(*) FROM Payments WHERE
    MONTH(TransactionDate) = MONTH(GETDATE()) and DAY(TransactionDate) > 21 ));
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddToFavourit]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddToFavourit]
@ProductID int,
@CustomerID int
AS
BEGIN
   INSERT INTO Favourites (CustomerID, ProductID, AddedToFavourite)
SELECT @CustomerID, @ProductID, 1
WHERE NOT EXISTS (
    SELECT * FROM Favourites WHERE ProductID = @ProductID and CustomerID = @CustomerID
);
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckCategoryExist]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckCategoryExist]
    @CategoryName nvarchar(100)
AS
BEGIN
    IF EXISTS(SELECT Found=1 FROM ProductCategory WHERE CategoryName = @CategoryName)
        RETURN 1;  
    ELSE
        RETURN 0;  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckCustomerExist]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_CheckCustomerExist]
    @Email nvarchar(100)
AS
BEGIN
    IF EXISTS(SELECT Found=1 FROM Customers WHERE Email = @Email)
        RETURN 1;  
    ELSE
        RETURN 0;  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckShipperExist]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckShipperExist]
    @UserName nvarchar(100)
AS
BEGIN
    IF EXISTS(SELECT Found=1 FROM Shippers WHERE Username = @UserName)
        RETURN 1;  
    ELSE
        RETURN 0;  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckSubCategoryExist]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckSubCategoryExist]
    @SubCategoryName nvarchar(100)
AS
BEGIN
    IF EXISTS(SELECT Found=1 FROM SubCategory WHERE SubCategoryName = @SubCategoryName)
        RETURN 1;  
    ELSE
        RETURN 0;  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckUserExist]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckUserExist]
    @UserName nvarchar(100)
AS
BEGIN
    IF EXISTS(SELECT Found=1 FROM Users WHERE Username = @UserName)
        RETURN 1;  
    ELSE
        RETURN 0;  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CompleteAllOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_CompleteAllOrders]
AS
BEGIN
	Update ProcessingOrders
	set Status = 2;
  insert into CompeleteOrders(OrderID,CustomerID,OrderDate,TotalAmount,Status)
  select OrderID,CustomerID,OrderDate,TotalAmount,Status from ProcessingOrders;
  truncate table ProcessingOrders;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteCategory]
@CategoryID int
AS
BEGIN
  Delete SubCategory where CategoryID = @CategoryID;
  Delete ProductCategory where CategoryID = @CategoryID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteColor]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_DeleteColor]
@ID int
AS
BEGIN
  Delete from ProductColor where ColorID = @ID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteCompleteOrder]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_DeleteCompleteOrder]
@OrderID int
AS
BEGIN
  Delete CompeleteOrders where OrderID = @OrderID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteCustomer]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_DeleteCustomer]
@CustomerID int
AS
BEGIN
  Delete Customers where CustomerID = @CustomerID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteMessage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteMessage]
@MessageID int
AS
BEGIN
  Delete Messages where MessageID = @MessageID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteOrder]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteOrder]
@OrderID int
AS
BEGIN
  Delete Orders where OrderID = @OrderID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteOrderItem]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteOrderItem]
@ProductID int
AS
BEGIN
  Delete OrderItems where ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePayment]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeletePayment]
@PaymentID int
AS
BEGIN
  Delete Payments where PaymentID = @PaymentID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePendingOrder]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_DeletePendingOrder]
@OrderID int
AS
BEGIN
  Delete PendingOrders where OrderID = @OrderID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProcessingOrder]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_DeleteProcessingOrder]
@OrderID int
AS
BEGIN
  Delete ProcessingOrders where OrderID = @OrderID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProductCatalog]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteProductCatalog]
@ProductID int
AS
BEGIN
  Delete ProductColor where ProductID = @ProductID;
  Delete ProductSize where ProductID = @ProductID;
  Delete ProductImages where ProductID = @ProductID;
  Delete ProductCatalog where ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProductImage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteProductImage]
@ID int
AS
BEGIN
  Delete ProductImages where ID = @ID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteResponse]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DeleteResponse]
@ResponseID int
AS
BEGIN
  Delete Responses where ResponseID = @ResponseID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteShipper]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteShipper]
@CarrierID int
AS
BEGIN
  Delete Shippers where CarrierID = @CarrierID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteShipping]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteShipping]
@ShippingID int
AS
BEGIN
  Delete Shippings where ShippingID = @ShippingID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteSize]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_DeleteSize]
@ID int
AS
BEGIN
  Delete from ProductSize where SizeID = @ID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteSubCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteSubCategory]
@SubCategoryID int
AS
BEGIN
  Delete SubCategory where SubCategoryID = @SubCategoryID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteUser]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteUser]
@UserID int
AS
BEGIN
  Delete Users where UserID = @UserID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindCategoryByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindCategoryByID]
	@CategoryID int
AS
BEGIN
    select * from ProductCategory where CategoryID = @CategoryID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindCategoryByName]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindCategoryByName]
	@CategoryName nvarchar(100)
AS
BEGIN
    select * from ProductCategory where CategoryName = @CategoryName;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindCustomerByEmail]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_FindCustomerByEmail]
	@Email nvarchar(100)
AS
BEGIN
    select * from Customers where Email like '%'+ @Email+'%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindCustomerByEmailPassword]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_FindCustomerByEmailPassword]
	@Email nvarchar (100),
	@Password nvarchar (100)
AS
BEGIN
    select * from Customers where Email = @Email and Password = @Password;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindCustomerByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_FindCustomerByID]
	@CustomerID int
AS
BEGIN
    select * from Customers where CustomerID = @CustomerID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindCustomerNotificationByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindCustomerNotificationByID]
@NotificationID int
AS
BEGIN
    select * from NotificationCustomer where NotificationID = @NotificationID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindMessageByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindMessageByID]
	@MessageID int
AS
BEGIN
    select * from Messages where MessageID = @MessageID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindOrderByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindOrderByID]
@OrderID int
AS
BEGIN
    select OrderID,Name,Email,Phone,OrderDate,Address as DeliveryAddress,TotalAmount
	, CASE WHEN Status = 1 THEN 'Pending'
         WHEN Status = 2 THEN 'Processing'
         WHEN Status = 3 THEN 'Compelete'
         WHEN Status = 4 THEN 'Shipped'
         WHEN Status = 5 THEN 'Delivered'
         WHEN Status = 6 THEN 'Canceled'
         ELSE 'Not Provided' END as Status from Orders inner join Customers on Customers.CustomerID=Orders.CustomerID
		 where OrderID = @OrderID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindOrderItemByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FindOrderItemByID]
@OrderID int,
@ProductID int
AS
BEGIN
    select * from OrderItems where OrderID = @OrderID and ProductID =@ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindOwnerNotificationByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindOwnerNotificationByID]
@NotificationID int
AS
BEGIN
    select * from NotificationOwner where NoticficationID = @NotificationID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindPaymentByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindPaymentByID]
@PaymentID int
AS
BEGIN
    select * from Payments where PaymentID = @PaymentID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindProductCatalogByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindProductCatalogByID]
@ProductID int
AS
BEGIN
    select ProductID,ProductName,Description,LongDescription,Price,
	QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,
	ADS,Discount,InsertByUserID from ProductCatalog where ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindProductCatalogByName]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindProductCatalogByName]
@ProductName nvarchar(100)
AS
BEGIN
    SELECT  ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
   from ProductCatalog where ProductName Like '%'+@ProductName+'%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindProductCatalogByNameView]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_FindProductCatalogByNameView]
@ProductName nvarchar(100)
AS
BEGIN
    select ProductID,ProductName,Description,LongDescription,Price,QuantityInStock,
   CategoryName as Category,SubCategoryName as SubCategory,ImageURL,VideoURL,Discount
   from ProductCatalog inner join ProductCategory
   on ProductCatalog.CategoryID=ProductCategory.CategoryID
   inner join SubCategory on ProductCatalog.SubCategoryID = SubCategory.SubCategoryID where ProductName Like '%'+@ProductName+'%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindProductColorByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindProductColorByID]
	@ProductID int
AS
BEGIN
    select * from ProductColor where ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindProductImageByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FindProductImageByID]
	@ID int
AS
BEGIN
    select * from ProductImages where ID = @ID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindProductSizeByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FindProductSizeByID]
	@ProductID int
AS
BEGIN
    select * from ProductSize where ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindResponseByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindResponseByID]
	@ResponseID int
AS
BEGIN
    select * from Responses where ResponseID = @ResponseID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindReviewByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindReviewByID]
	@ReviewID int
AS
BEGIN
    select * from Reviews where ReviewID = @ReviewID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindShipperByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindShipperByID]
	@CarrierID int
AS
BEGIN
    select * from Shippers where CarrierID = @CarrierID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindShipperByName]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindShipperByName]
	@CarrierName nvarchar(100)
AS
BEGIN
    select * from Shippers where CarrierName like '%'+ @CarrierName+'%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindShipperByUserName]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindShipperByUserName]
	@UserName nvarchar(100)
AS
BEGIN
    select * from Shippers where UserName LIKE '%'+ @UserName+'%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindShipperByUserNamePassword]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindShipperByUserNamePassword]
	@UserName nvarchar (100),
	@Password nvarchar (100)
AS
BEGIN
    select * from Shippers where UserName = @UserName and Password = @Password;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindShippingByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindShippingByID]
	@ShippingID int
AS
BEGIN
    select * from Shippings where ShippingID = @ShippingID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindShippingByTrackingNumber]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FindShippingByTrackingNumber]
	@TrackingNumber nvarchar(100)
AS
BEGIN
    select * from Shippings where TrackingNumber = @TrackingNumber;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindSubCategoryByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindSubCategoryByID]
	@SubCategoryID int
AS
BEGIN
    select * from SubCategory where SubCategoryID = @SubCategoryID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindSubCategoryByName]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindSubCategoryByName]
	@SubCategoryName nvarchar(100)
AS
BEGIN
    select * from SubCategory where SubCategoryName = @SubCategoryName;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindUserByID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindUserByID]
	@UserID int
AS
BEGIN
    select * from Users where UserID = @UserID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindUserByUserName]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindUserByUserName]
	@UserName nvarchar(100)
AS
BEGIN
    select * from Users where Username like '%'+ @UserName+'%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FindUserByUserNamePassword]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FindUserByUserNamePassword]
	@UserName nvarchar (100),
	@Password nvarchar (100)
AS
BEGIN
    select * from Users where UserName = @UserName and Password = @Password;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllCategories]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllCategories]
AS
BEGIN
   select * from ProductCategory
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllCompeleteOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllCompeleteOrders]
AS
BEGIN
     select OrderID,Name,Email,Phone,Address,OrderDate,TotalAmount,
   Case
   when Status =1 then 'Pending'
   when Status =2 then 'Processing'
   when Status =3 then 'Compelete'
   when Status =4 then 'Shipped'
   when Status =5 then 'Deliverd'
   when Status = 6 then 'Canceled'
   else 'UNKNOWN'
   end as OrderStatus from CompeleteOrders
   inner join Customers on Customers.CustomerID = CompeleteOrders.CustomerID order by OrderDate desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllCustomerNotifications]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllCustomerNotifications]
AS
BEGIN
   select * from NotificationCustomer order by NotificationID desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllCustomers]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetAllCustomers]
AS
BEGIN
   select CustomerID,Name,Email,Phone,Address from Customers;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllDeliveredShippingsForCarrierID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllDeliveredShippingsForCarrierID]
@CarrierID int
AS
BEGIN
      select ShippingID,Name as Customer,Shippings.OrderID,CarrierName,TrackingNumber,
   CASE
WHEN ShippingStatus =5 THEN 'Delivered'
WHEN ShippingStatus = 6 THEN 'Canceled'
ELSE 'Pending'
END AS ShippingStatus, EstimatedDeliveryDate,ActualDeliveryDate from Shippings 
   inner join Orders on Shippings.OrderID = Orders.OrderID
   inner join Customers on Orders.CustomerID=Customers.CustomerID
   inner join Shippers on Shippings.CarrierID=Shippers.CarrierID
   where Shippings.CarrierID = @CarrierID and ShippingStatus = 5;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllFavouritesForCustomerID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllFavouritesForCustomerID]
@CustomerID int
AS
BEGIN
   select FavouritItemID,CustomerID,Favourites.ProductID,ProductName,Description,Price,
   ImageURL,Taxes,ADS,Discount,AddedToFavourite from Favourites inner join ProductCatalog on 
   Favourites.ProductID = ProductCatalog.ProductID where AddedToFavourite =1 and CustomerID = @CustomerID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllMessages]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllMessages]
AS
BEGIN
   select MessageID,Name,Message,DateTime from Messages inner join Customers on Messages.CustomerID = Customers.CustomerID order by DateTime desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllMessagesForCustomerID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetAllMessagesForCustomerID]
@CustomerID int
AS
BEGIN
   select * from Messages where CustomerID=@CustomerID order by DateTime desc;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllOrderItemsByOrderID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllOrderItemsByOrderID]
@OrderID int
AS
BEGIN
   select OrderID,ProductName,Quantity,ProductCatalog.Price,TotalItemsPrice from OrderItems
   inner join ProductCatalog on ProductCatalog.ProductID = OrderItems.ProductID 
   where OrderID =@OrderID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllOrders]
AS
BEGIN
   select OrderID,Name,Email,Phone,Address,OrderDate,TotalAmount,
   Case
   when Status =1 then 'Pending'
   when Status =2 then 'Processing'
   when Status =3 then 'Compelete'
   when Status =4 then 'Shipped'
   when Status =5 then 'Deliverd'
   when Status = 6 then 'Canceled'
   else 'UNKNOWN'
   end as OrderStatus from Orders
   inner join Customers on Customers.CustomerID =Orders.CustomerID order by OrderDate desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllOrdersForCustomerID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetAllOrdersForCustomerID]
@CustomerID int
AS
BEGIN
   select * from Orders where CustomerID = @CustomerID order by OrderDate desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllOwnerNotifications]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllOwnerNotifications]
AS
BEGIN
   select * from NotificationOwner order by NoticficationID desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllPendingOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllPendingOrders]
AS
BEGIN
    select OrderID,Name,Email,Phone,Address,OrderDate,TotalAmount,
   Case
   when Status =1 then 'Pending'
   when Status =2 then 'Processing'
   when Status =3 then 'Compelete'
   when Status =4 then 'Shipped'
   when Status =5 then 'Deliverd'
   when Status = 6 then 'Canceled'
   else 'UNKNOWN'
   end as OrderStatus from PendingOrders
   inner join Customers on Customers.CustomerID = PendingOrders.CustomerID order by OrderDate desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllProcessingOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllProcessingOrders]
AS
BEGIN
     select OrderID,Name,Email,Phone,Address,OrderDate,TotalAmount,
   Case
   when Status =1 then 'Pending'
   when Status =2 then 'Processing'
   when Status =3 then 'Compelete'
   when Status =4 then 'Shipped'
   when Status =5 then 'Deliverd'
   when Status = 6 then 'Canceled'
   else 'UNKNOWN'
   end as OrderStatus from ProcessingOrders
   inner join Customers on Customers.CustomerID = ProcessingOrders.CustomerID order by OrderDate desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllProductColors]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllProductColors]
@ProductID int
AS
BEGIN
   select * from ProductColor where ProductID = @ProductID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllProducts]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllProducts]
AS
BEGIN
    SELECT  ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
   from ProductCatalog
   order by newID();
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllProductSizes]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllProductSizes]
@ProductID int
AS
BEGIN
   select * from ProductSize where ProductID = @ProductID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllReviews]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllReviews]
AS
BEGIN
   select * from Reviews order by ReviewDate desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllReviewsForCustomerID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllReviewsForCustomerID]
@CustomerID int
AS
BEGIN
   select * from Reviews where CustomerID=@CustomerID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllReviewsForProductID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllReviewsForProductID]
@ProductID int
AS
BEGIN
   select ReviewID,ProductID,Customers.CustomerID,Customers.Name,ReviewText,Rating,
   CASE 
   WHEN DATEDIFF(SECOND, ReviewDate, GETDATE()) < 60
   THEN CAST(DATEDIFF(SECOND, ReviewDate, GETDATE()) AS VARCHAR(10)) + ' Seconds ago' 
   WHEN DATEDIFF(MINUTE, ReviewDate, GETDATE()) < 60
   THEN CAST(DATEDIFF(MINUTE, ReviewDate, GETDATE()) AS VARCHAR(10)) + ' Minutes ago' 
   WHEN DATEDIFF(HOUR, ReviewDate, GETDATE()) < 24
   THEN CAST(DATEDIFF(HOUR, ReviewDate, GETDATE()) AS VARCHAR(10)) + ' hours ago' 
   WHEN DATEDIFF(DAY, ReviewDate, GETDATE()) < 7 
   THEN CAST(DATEDIFF(DAY, ReviewDate, GETDATE()) AS VARCHAR(10)) + ' days ago' 
   WHEN DATEDIFF(WEEK, ReviewDate, GETDATE()) < 4 
   THEN CAST(DATEDIFF(WEEK, ReviewDate, GETDATE()) AS VARCHAR(10)) + ' weeks ago' 
   WHEN DATEDIFF(MONTH, ReviewDate, GETDATE()) < 12 
   THEN CAST(DATEDIFF(MONTH, ReviewDate, GETDATE()) AS VARCHAR(10)) + ' months ago' 
   ELSE 'Over a year ago' END AS TimeAgo from Reviews
   inner join Customers on Customers.CustomerID = Reviews.CustomerID where ProductID = @ProductID order by ReviewDate desc;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllShippersData]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllShippersData]
AS
BEGIN
   select CarrierID,CarrierName,Phone,Email,UserName from Shippers;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllShippersName]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllShippersName]
AS
BEGIN
   select CarrierName from Shippers
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllShippings]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllShippings]
AS
BEGIN
   select ShippingID,Shippings.OrderID,Name as Customer , CarrierName as Carrier,TrackingNumber,
   Case
   when ShippingStatus = 4 then 'Shipped'
   when ShippingStatus = 5 then 'Deliverd'
      when ShippingStatus = 6 then 'Canceled'
   else 'UNKNOWN'
   end as ShippingStatus, EstimatedDeliveryDate,ActualDeliveryDate from Shippings 
   inner join Orders on Shippings.OrderID = Orders.OrderID
   inner join Customers on Orders.CustomerID = Customers.CustomerID 
   inner join Shippers on Shippings.CarrierID = Shippers.CarrierID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllShippingsForCarrierID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllShippingsForCarrierID]
@CarrierID int
AS
BEGIN
   select ShippingID,Shippings.OrderID,Name as Customer,CarrierName,TrackingNumber,
   CASE
WHEN ShippingStatus =5 THEN 'Delivered'
WHEN ShippingStatus = 6 THEN 'Canceled'
ELSE 'Pending'
END AS ShippingStatus, EstimatedDeliveryDate,ActualDeliveryDate from Shippings 
   inner join Orders on Shippings.OrderID = Orders.OrderID 
   inner join Customers on Orders.CustomerID=Customers.CustomerID
   inner join Shippers on Shippings.CarrierID=Shippers.CarrierID
   where Shippings.CarrierID = @CarrierID and ShippingStatus = 4;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSubCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllSubCategory]
@CategoryID int
AS
BEGIN
   select * from SubCategory where CategoryID = @CategoryID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllUsers]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllUsers]
AS
BEGIN
   select UserID,Name,Email,Phone,Address,Username from Users;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAvrageRatingForProductID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetAvrageRatingForProductID]
@ProductID int
AS
BEGIN
 select AVG(Rating) from Reviews where ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetChartData]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetChartData]
AS
BEGIN
   select * from ChartData;
   --where Month = (Select DATENAME(month, GETDATE()));
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCurrentYearTotalRevenue]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCurrentYearTotalRevenue]
AS
BEGIN
    select Sum(TotalRevenue) as TotalRevenue from SalesReport where Year = YEAR(GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCurrentYearTotalSales]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCurrentYearTotalSales]
AS
BEGIN
    select Sum(TotalSales) as TotalSales from SalesReport where Year = YEAR(GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomersCount]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCustomersCount]
AS
BEGIN
   select Count(*) from Customers;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMostSoldProduct]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetMostSoldProduct]
@From nvarchar(30),
@To nvarchar(30)
AS
BEGIN
  Select Top 3 ProductCatalog.ProductID,ProductName, COUNT(*) AS Frequency 
  from Payments inner join Orders On Payments.OrderID = Orders.OrderID 
  inner join OrderItems On Orders.OrderID = OrderItems.OrderID 
  inner join ProductCatalog On OrderItems.ProductID = ProductCatalog.ProductID
  Where TransactionDate Between @From AND @To
  GROUP BY ProductName,ProductCatalog.ProductID
  ORDER BY Frequency DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetNewArrivalProducts]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetNewArrivalProducts]
@PageNumber int
AS
BEGIN
DECLARE @RowsPerPage AS INT;
SET @RowsPerPage = 8;
  SELECT  ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
FROM ProductCatalog WHERE InsertionDate >= DATEADD(DAY, -14, GETDATE()) order by ProductID OFFSET (@PageNumber - 1) * @RowsPerPage ROWS
    FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetNewArrivalTotalPage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetNewArrivalTotalPage]
AS
BEGIN
    select Ceiling(Cast(Count(*) as float)/8) from ProductCatalog 
	WHERE InsertionDate >= DATEADD(DAY, -14, GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductImagesByProductID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProductImagesByProductID]
	@ProductID int
AS
BEGIN
    select * from ProductImages where ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductPerPage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProductPerPage]
@PageNumber int
AS
BEGIN
	DECLARE @RowsPerPage AS INT;
SET @RowsPerPage = 8;
    SELECT  ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
   from ProductCatalog Order by ProductID OFFSET (@PageNumber - 1) * @RowsPerPage ROWS
    FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductPerPageForCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProductPerPageForCategory]
@PageNumber int,
@CategoryID int
AS
BEGIN
	DECLARE @RowsPerPage AS INT;
SET @RowsPerPage = 8;
  SELECT  ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
   from ProductCatalog where ProductCatalog.CategoryID = @CategoryID Order by ProductID OFFSET (@PageNumber - 1) * @RowsPerPage ROWS
    FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductPerPageForSubCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProductPerPageForSubCategory]
@PageNumber int,
@SubCategoryID int
AS
BEGIN
	DECLARE @RowsPerPage AS INT;
SET @RowsPerPage = 8;
  SELECT  ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
   from ProductCatalog where ProductCatalog.SubCategoryID = @SubCategoryID Order by ProductID OFFSET (@PageNumber - 1) * @RowsPerPage ROWS
    FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductPerPageView]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetProductPerPageView]
@PageNumber int
AS
BEGIN
	DECLARE @RowsPerPage AS INT;
SET @RowsPerPage = 8;
    select ProductID,ProductName,Description,LongDescription,Price,QuantityInStock,
   CategoryName as Category,SubCategoryName as SubCategory,ImageURL,VideoURL,Discount
   from ProductCatalog inner join ProductCategory
   on ProductCatalog.CategoryID=ProductCategory.CategoryID
   inner join SubCategory on ProductCatalog.SubCategoryID = SubCategory.SubCategoryID Order by ProductID OFFSET (@PageNumber - 1) * @RowsPerPage ROWS
    FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductsForCategoryID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProductsForCategoryID]
@CategoryID int
AS
BEGIN
   select ProductID,ProductName,Description,LongDescription,Price,QuantityInStock,
   CategoryName as Category,SubCategoryName as SubCategory,ImageURL,VideoURL,Discount
   from ProductCatalog inner join ProductCategory
   on ProductCatalog.CategoryID=ProductCategory.CategoryID
   inner join SubCategory on ProductCatalog.SubCategoryID = SubCategory.SubCategoryID where ProductCatalog.CategoryID=@CategoryID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductsForSubCategoryID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProductsForSubCategoryID]
@SubCategoryID int
AS
BEGIN
  SELECT  ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
   from ProductCatalog where ProductCatalog.SubCategoryID=@SubCategoryID;
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetResponseForCustomerID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_GetResponseForCustomerID]
	@CustomerID int
AS
BEGIN
    select * from Responses where CustomerID = @CustomerID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSalesReportData]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetSalesReportData]
AS
BEGIN
  SELECT 
      [Month]
      ,[Year]
      ,[TotalSales]
      ,[TotalRevenue]
  FROM [Online_Store].[dbo].[SalesReport];
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetStarRatingPersentage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetStarRatingPersentage]
@ProductID int
AS
BEGIN
 
SELECT Rating,
COUNT(*) AS RatingCount, Round((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Reviews where ProductID = @ProductID)),2) 
AS RatingPercentage FROM Reviews where ProductID = @ProductID GROUP BY Rating


END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTopSellingProduct]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetTopSellingProduct]
AS
BEGIN
  Select Top 4   ProductCatalog.ProductID,ProductName,Description,LongDescription,
  ProductCatalog.Price,QuantityInStock,ImageURL,VideoURL,CategoryID,SubCategoryID,Taxes,ADS,Discount,InsertByUserID
  from Payments inner join Orders On Payments.OrderID = Orders.OrderID 
  inner join OrderItems On Orders.OrderID = OrderItems.OrderID 
  inner join ProductCatalog On OrderItems.ProductID = ProductCatalog.ProductID
  GROUP BY ProductName,ProductCatalog.ProductID,ProductCatalog.Description,ProductCatalog.LongDescription,
  ProductCatalog.Price,ProductCatalog.QuantityInStock,ProductCatalog.ImageURL,ProductCatalog.VideoURL,ProductCatalog.CategoryID,
  ProductCatalog.SubCategoryID,ProductCatalog.Taxes,ProductCatalog.ADS,ProductCatalog.Discount,ProductCatalog.InsertByUserID
  ORDER BY count(*) DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTotalPage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetTotalPage]
AS
BEGIN
    select Ceiling(Cast(Count(*) as float)/8) from ProductCatalog;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTotalPageForCategoryID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetTotalPageForCategoryID]
@CategoryID int
AS
BEGIN
    select Ceiling(Cast(Count(*) as float)/8) from ProductCatalog Where CategoryID =@CategoryID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTotalPageForSubCategoryID]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetTotalPageForSubCategoryID]
@SubCategoryID int
AS
BEGIN
    select Ceiling(Cast(Count(*) as float)/8) from ProductCatalog Where SubCategoryID =@SubCategoryID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTotalRevenue]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetTotalRevenue]
AS
BEGIN
    select Sum(Amount) from Payments;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUsersCount]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetUsersCount]
AS
BEGIN
   select Count(*) from Users;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetWeeklySales]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetWeeklySales]
AS
BEGIN
   select Top 1* from WeeklySales order By WeeklySalesID Desc;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_IsProductAddedToFavourite]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_IsProductAddedToFavourite]
@ProductID int,
@CustomerID int
AS
BEGIN
   select AddedToFavourite from Favourites where CustomerID =@CustomerID and ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ProcessAllOrders]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ProcessAllOrders]
AS
BEGIN
	Update PendingOrders
	set Status = 2;
  insert into ProcessingOrders(OrderID,CustomerID,OrderDate,TotalAmount,Status)
  select OrderID,CustomerID,OrderDate,TotalAmount,Status from PendingOrders;
  truncate table PendingOrders;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_RemoveFromFavourit]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RemoveFromFavourit]
@ProductID int,
@CustomerID int
AS
BEGIN
     delete from Favourites where CustomerID = @CustomerID and ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateCategory]
@CategoryID int,
@CategoryName nvarchar(100),
@CategoryImage nvarchar(500),
@InsertByUserID int
AS
BEGIN
    UPDATE ProductCategory
     SET CategoryName = @CategoryName
	    ,CategoryImage = @CategoryImage
		,InsertByUserID = @InsertByUserID
        WHERE CategoryID = @CategoryID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCustomer]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_UpdateCustomer]
    @CustomerID int,
	@Name nvarchar(100),
	@Email nvarchar(100),
	@Phone nvarchar(20),
	@Address nvarchar(200),
	@Password nvarchar (100)
AS
BEGIN
    UPDATE Customers
     SET Name = @Name
	    ,Email = @Email
		,Phone = @Phone
		,Address = @Address
		,Password = @Password
        WHERE CustomerID = @CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateMesaage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UpdateMesaage]
@MessageID int,
@Message nvarchar(500)
AS
BEGIN
    UPDATE Messages
     SET Message = @Message
        WHERE MessageID = @MessageID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateOrder]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateOrder]
@OrderID int,
@CustomerID int,
@OrderDate datetime,
@TotalAmount smallmoney,
@Status smallint

AS
BEGIN
    UPDATE Orders
     SET CustomerID = @CustomerID
	    ,OrderDate = @OrderDate
		,TotalAmount = @TotalAmount
		,Status = @Status
        WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateOrderItem]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UpdateOrderItem]
@OrderID int,
@ProductID int,
@Quantity int,
@Size nvarchar(10),
@Color nvarchar(50),
@Price decimal,
@TotalItemsPrice decimal

AS
BEGIN
    UPDATE OrderItems
     SET Quantity = @Quantity
	    ,Size = @Size
		,Color = @Color
		,Price = @Price
		,TotalItemsPrice = @TotalItemsPrice
        WHERE OrderID = @OrderID and ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateOrderStatus]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateOrderStatus]
@OrderID int,
@Status smallint

AS
BEGIN
    UPDATE Orders
     SET Status = @Status
        WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePayment]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdatePayment]
@PaymentID int,
@OrderID int,
@Amount smallmoney,
@PaymentMethod nvarchar(50),
@TransactionDate DateTime
AS
BEGIN
    UPDATE Payments
     SET OrderID = @OrderID
	    ,Amount = @Amount
		,PaymentMethod = @PaymentMethod
		,TransactionDate = @TransactionDate
        WHERE PaymentID = @PaymentID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePendingOrderStatus]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UpdatePendingOrderStatus]
@OrderID int,
@Status smallint

AS
BEGIN
    UPDATE PendingOrders
     SET Status = @Status
        WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProcessingOrderStatus]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateProcessingOrderStatus]
@OrderID int,
@Status smallint

AS
BEGIN
    UPDATE ProcessingOrders
     SET Status = @Status
        WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProductCatalog]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateProductCatalog]
@ProductID int,
@ProductName nvarchar(100),
@Description NVARCHAR(MAX),
@LongDescription NVARCHAR(MAX),
@Price smallmoney,
@QuantityInStock int,
@CategoryID int,
@SubCategoryID int,
@ImageURL nvarchar(200),
@VideoURL nvarchar(200),
@Taxes decimal,
@ADS decimal,
@Discount int,
@InsertByUserID int
AS
BEGIN
    UPDATE ProductCatalog
     SET ProductName = @ProductName
	    ,Description = @Description
		,LongDescription = @LongDescription
		,Price = @Price
		,QuantityInStock = @QuantityInStock
		,ImageURL = @ImageURL
		,VideoURL = @VideoURL
		,CategoryID = @CategoryID
		,SubCategoryID = @SubCategoryID
		,Taxes = @Taxes
		,ADS = @ADS
		,Discount = @Discount
		,InsertByUserID = @InsertByUserID
        WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProductColor]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateProductColor]
@Color nvarchar(100),
@ProductID int
AS
BEGIN
    UPDATE ProductColor
     SET Color = @Color
        WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProductImage]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateProductImage]
    @ID int,
    @ImageUrl nvarchar(200),
	@ImageOrder smallint,
	@ProductID int
AS
BEGIN
    UPDATE ProductImages
     SET ImageURL = @ImageUrl
	    ,ImageOrder = @ImageOrder
		,ProductID = @ProductID
        WHERE ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProductSize]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UpdateProductSize]
@Size nvarchar(100),
@ProductID int
AS
BEGIN
    UPDATE ProductSize
     SET Size = @Size
        WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateResponse]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UpdateResponse]
@ResponseID int,
@Response nvarchar(500)
AS
BEGIN
    UPDATE Responses
     SET Response = @Response
        WHERE ResponseID = @ResponseID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateShipper]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateShipper]
    @CarrierID int,
	@CarrierName nvarchar(100),
	@Email nvarchar(100),
	@Phone nvarchar(20),
	@UserName nvarchar (100),
	@Password nvarchar (100),
	@InsertByUserID int
AS
BEGIN
    UPDATE Shippers
     SET CarrierName = @CarrierName
	    ,Email = @Email
		,Phone = @Phone
		,UserName = @UserName
		,Password = @Password
		,InsertByUserID = @InsertByUserID
        WHERE CarrierID = @CarrierID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateShipping]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateShipping]
    @ShippingID int,
    @OrderID int,
	@CarrierID int,
	@TrackingNumber nvarchar(100),
	@ShippingStatus smallint,
	@EstimatedDeliveryDate DateTime,
	@ActualDeliveryDate DateTime =null
AS
BEGIN
    UPDATE Shippings
     SET OrderID = @OrderID
	    ,CarrierID = @CarrierID
		,TrackingNumber = @TrackingNumber
		,ShippingStatus = @ShippingStatus
		,EstimatedDeliveryDate = @EstimatedDeliveryDate
		,ActualDeliveryDate = @ActualDeliveryDate
        WHERE ShippingID = @ShippingID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateSubCategory]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateSubCategory]
@SubCategoryID int,
@SubCategoryName int,
@CategoryID nvarchar(500)
AS
BEGIN
    UPDATE SubCategory
     SET SubCategoryName = @SubCategoryName
	    ,CategoryID = @CategoryID
        WHERE SubCategoryID = @SubCategoryID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUser]    Script Date: 1/3/2025 3:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateUser]
    @UserID int,
	@Name nvarchar(100),
	@Email nvarchar(100),
	@Phone nvarchar(20),
	@Address nvarchar(200),
	@UserName nvarchar (100),
	@Password nvarchar (100),
	@ImageURL nvarchar(200),
	@Permissions int
AS
BEGIN
    UPDATE Users
     SET Name = @Name
	    ,Email = @Email
		,Phone = @Phone
		,Address = @Address
		,UserName = @UserName
		,Password = @Password
		,ImageURL = @ImageURL
		,Permissions = @Permissions
        WHERE UserID = @UserID
END
GO
USE [master]
GO
ALTER DATABASE [Online_Store] SET  READ_WRITE 
GO
