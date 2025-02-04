USE [master]
GO
/****** Object:  Database [RealEstaleWebsite]    Script Date: 10/10/2018 11:41:15 PM ******/
CREATE DATABASE [RealEstaleWebsite]
GO
ALTER DATABASE [RealEstaleWebsite] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RealEstaleWebsite].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RealEstaleWebsite] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET ARITHABORT OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RealEstaleWebsite] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RealEstaleWebsite] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RealEstaleWebsite] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RealEstaleWebsite] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET RECOVERY FULL 
GO
ALTER DATABASE [RealEstaleWebsite] SET  MULTI_USER 
GO
ALTER DATABASE [RealEstaleWebsite] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RealEstaleWebsite] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RealEstaleWebsite] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RealEstaleWebsite] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RealEstaleWebsite] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RealEstaleWebsite', N'ON'
GO
ALTER DATABASE [RealEstaleWebsite] SET QUERY_STORE = OFF
GO
USE [RealEstaleWebsite]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [RealEstaleWebsite]
GO
/****** Object:  Schema [Post]    Script Date: 10/10/2018 11:41:15 PM ******/
CREATE SCHEMA [Post]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 10/10/2018 11:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Account_ID] [int] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[AccountType] [varchar](20) NOT NULL,
	[Emp_ID] [int] NULL,
	[Cus_ID] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Account_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/10/2018 11:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Customer_ID] [int] NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Cus_Type] [varchar](10) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 10/10/2018 11:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Employee_ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[IDNumber] [varchar](20) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Email] [varchar](50) NULL,
	[Address] [nvarchar](200) NULL,
	[Manager_ID] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhoneNumber]    Script Date: 10/10/2018 11:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneNumber](
	[Customer_ID] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
 CONSTRAINT [PK_PhoneNumber] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC,
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Post].[Post]    Script Date: 10/10/2018 11:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Post].[Post](
	[Post_ID] [int] NOT NULL,
	[PostType] [int] NOT NULL,
	[PostTime] [datetime] NULL,
	[Price] [money] NOT NULL,
	[Location] [nvarchar](100) NOT NULL,
	[Area] [decimal](18, 2) NOT NULL,
	[Sale] [nvarchar](100) NULL,
	[Form] [nvarchar](50) NULL,
	[Project] [int] NULL,
	[Description] [nvarchar](500) NOT NULL,
	[RealEstaleType] [int] NOT NULL,
	[Status] [bit] NULL,
	[Censor] [int] NULL,
	[CensorshipTime] [datetime] NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[Post_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Post].[Project]    Script Date: 10/10/2018 11:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Post].[Project](
	[Project_ID] [int] NOT NULL,
	[ProjectName] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](100) NOT NULL,
	[Protential] [nvarchar](500) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Project_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Post].[RealEstaleType]    Script Date: 10/10/2018 11:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Post].[RealEstaleType](
	[RealEstaleType_ID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_RealEstaleType] PRIMARY KEY CLUSTERED 
(
	[RealEstaleType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Post].[Type]    Script Date: 10/10/2018 11:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Post].[Type](
	[PostType_ID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PostType] PRIMARY KEY CLUSTERED 
(
	[PostType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Customer] FOREIGN KEY([Cus_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Customer]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Employee] FOREIGN KEY([Emp_ID])
REFERENCES [dbo].[Employee] ([Employee_ID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Employee]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Employee] FOREIGN KEY([Manager_ID])
REFERENCES [dbo].[Employee] ([Employee_ID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Employee]
GO
ALTER TABLE [dbo].[PhoneNumber]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumber_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO
ALTER TABLE [dbo].[PhoneNumber] CHECK CONSTRAINT [FK_PhoneNumber_Customer]
GO
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Employee] FOREIGN KEY([Censor])
REFERENCES [dbo].[Employee] ([Employee_ID])
GO
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_Employee]
GO
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_PostType] FOREIGN KEY([PostType])
REFERENCES [Post].[Type] ([PostType_ID])
GO
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_PostType]
GO
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Project] FOREIGN KEY([Project])
REFERENCES [Post].[Project] ([Project_ID])
GO
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_Project]
GO
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_RealEstaleType] FOREIGN KEY([RealEstaleType])
REFERENCES [Post].[RealEstaleType] ([RealEstaleType_ID])
GO
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_RealEstaleType]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CK_Customer_CusType] CHECK  (([Cus_Type]='Normal' OR [Cus_Type]='Vip'))
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_Customer_CusType]
GO
USE [master]
GO
ALTER DATABASE [RealEstaleWebsite] SET  READ_WRITE 
GO
