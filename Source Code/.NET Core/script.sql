USE [master]
GO

DROP DATABASE IF EXISTS RealEstateSystem;
GO

/****** Object:  Database [RealEstateSystem]    Script Date: 5/8/2019 12:51:08 AM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'RealEstateSystem')
BEGIN
CREATE DATABASE [RealEstateSystem]
END
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RealEstateSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RealEstateSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RealEstateSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RealEstateSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RealEstateSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RealEstateSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [RealEstateSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RealEstateSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RealEstateSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RealEstateSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RealEstateSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RealEstateSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RealEstateSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RealEstateSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RealEstateSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RealEstateSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RealEstateSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RealEstateSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RealEstateSystem] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [RealEstateSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RealEstateSystem] SET  MULTI_USER 
GO
ALTER DATABASE [RealEstateSystem] SET DB_CHAINING OFF 
GO
USE [RealEstateSystem]
GO
/****** Object:  Schema [Account]    Script Date: 5/8/2019 12:51:08 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Account')
EXEC sys.sp_executesql N'CREATE SCHEMA [Account]'
GO
/****** Object:  Schema [Customer]    Script Date: 5/8/2019 12:51:08 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Customer')
EXEC sys.sp_executesql N'CREATE SCHEMA [Customer]'
GO
/****** Object:  Schema [Employee]    Script Date: 5/8/2019 12:51:08 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Employee')
EXEC sys.sp_executesql N'CREATE SCHEMA [Employee]'
GO
/****** Object:  Schema [Post]    Script Date: 5/8/2019 12:51:08 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Post')
EXEC sys.sp_executesql N'CREATE SCHEMA [Post]'
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_diagramobjects]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N''dbo''
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N''dbo.sp_upgraddiagrams''),
			@id_sysdiagrams = object_id(N''dbo.sysdiagrams''),
			@id_helpdiagrams = object_id(N''dbo.sp_helpdiagrams''),
			@id_helpdiagramdefinition = object_id(N''dbo.sp_helpdiagramdefinition''),
			@id_creatediagram = object_id(N''dbo.sp_creatediagram''),
			@id_renamediagram = object_id(N''dbo.sp_renamediagram''),
			@id_alterdiagram = object_id(N''dbo.sp_alterdiagram''), 
			@id_dropdiagram = object_id(N''dbo.sp_dropdiagram'')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	' 
END
GO
/****** Object:  Table [Customer].[Block]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Customer].[Block]') AND type in (N'U'))
BEGIN
CREATE TABLE [Customer].[Block](
	[Cus_ID] [int] NOT NULL,
	[Block_ID] [int] IDENTITY(1,1) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[BlockDate] [datetime] NULL,
	[UnBlockDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Block_2] PRIMARY KEY CLUSTERED 
(
	[Block_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Customer].[Customer]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Customer].[Customer]') AND type in (N'U'))
BEGIN
CREATE TABLE [Customer].[Customer](
	[Customer_ID] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
	[Account_ID] [nvarchar](450) NOT NULL,
	[Avatar_URL] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Customer].[Interested_Post]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Customer].[Interested_Post]') AND type in (N'U'))
BEGIN
CREATE TABLE [Customer].[Interested_Post](
	[Customer_ID] [int] NOT NULL,
	[Post_ID] [varchar](300) NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Interested_Post] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC,
	[Post_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[__EFMigrationsHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Admin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Admin](
	[Admin_Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](200) NULL,
	[PasswordHash] [nvarchar](200) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[Admin_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoleClaims]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserTokens]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Dashboard]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dashboard]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dashboard](
	[Id] [varchar](10) NOT NULL,
	[TotalGuest] [int] NULL,
	[TotalFBClick] [int] NULL,
	[TotalInsClick] [int] NULL,
	[TotalTwiClick] [int] NULL,
	[TotalLinClick] [int] NULL,
	[TotalPinClick] [int] NULL,
 CONSTRAINT [PK_Dashboard] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Information]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Information]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Information](
	[Info_Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](300) NULL,
	[Address] [nvarchar](300) NULL,
	[PhoneNumber] [nvarchar](30) NULL,
	[WorkingTime] [nvarchar](100) NULL,
	[Facebook] [varchar](100) NULL,
	[Twitter] [varchar](100) NULL,
	[Instagram] [varchar](100) NULL,
	[Pinterest] [varchar](100) NULL,
	[Linkedin] [varchar](100) NULL,
 CONSTRAINT [PK_Information] PRIMARY KEY CLUSTERED 
(
	[Info_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Menu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Menu](
	[Menu_Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](20) NULL,
	[Action] [varchar](20) NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Menu_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SubMenu]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubMenu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SubMenu](
	[Sub_Id] [int] IDENTITY(1,1) NOT NULL,
	[Menu_Id] [int] NULL,
	[Title] [nvarchar](20) NULL,
	[Action] [nvarchar](20) NULL,
 CONSTRAINT [PK_SubMenu] PRIMARY KEY CLUSTERED 
(
	[Sub_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sysdiagrams]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Detail]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Detail]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Detail](
	[Detail_ID] [int] IDENTITY(1,1) NOT NULL,
	[Floor] [int] NULL,
	[Bedroom] [int] NULL,
	[Bathroom] [int] NULL,
	[Direction_ID] [int] NULL,
	[Alley] [bit] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Detail] PRIMARY KEY CLUSTERED 
(
	[Detail_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Direction]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Direction]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Direction](
	[Direction_ID] [int] IDENTITY(1,1) NOT NULL,
	[Direction_Name] [nvarchar](30) NULL,
 CONSTRAINT [PK_Direction] PRIMARY KEY CLUSTERED 
(
	[Direction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Post]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Post]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Post](
	[Post_ID] [varchar](300) NOT NULL,
	[PostType] [int] NOT NULL,
	[PostTime] [datetime] NULL,
	[Tittle] [nvarchar](200) NOT NULL,
	[Price] [bigint] NOT NULL,
	[Location] [nvarchar](100) NOT NULL,
	[Area] [decimal](18, 2) NOT NULL,
	[Project] [int] NULL,
	[Description] [nvarchar](max) NOT NULL,
	[RealEstaleType] [int] NOT NULL,
	[Detail] [int] NULL,
	[Author_ID] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[Post_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Post_Image]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Post_Image]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Post_Image](
	[Image_ID] [int] IDENTITY(1,1) NOT NULL,
	[Post_ID] [varchar](300) NULL,
	[url] [varchar](100) NULL,
	[AddedDate] [datetime] NULL,
 CONSTRAINT [PK_Post_Image] PRIMARY KEY CLUSTERED 
(
	[Image_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Post_Report]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Post_Report]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Post_Report](
	[Post_Report_ID] [int] IDENTITY(1,1) NOT NULL,
	[Post_ID] [varchar](300) NOT NULL,
	[Reason] [nvarchar](200) NOT NULL,
	[Report_Time] [datetime] NULL,
	[Reporter] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Post_Report] PRIMARY KEY CLUSTERED 
(
	[Post_Report_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Post_Status]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Post_Status]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Post_Status](
	[Post_Status_ID] [int] IDENTITY(1,1) NOT NULL,
	[Post_ID] [varchar](300) NOT NULL,
	[Status] [int] NOT NULL,
	[CensorshipTime] [datetime] NULL,
	[Reason] [nvarchar](500) NULL,
 CONSTRAINT [PK_Post_Status] PRIMARY KEY CLUSTERED 
(
	[Post_Status_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Project]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Project]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Project](
	[Project_ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](100) NOT NULL,
	[Protential] [nvarchar](max) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Project_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Project_Image]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Project_Image]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Project_Image](
	[Img_ID] [int] IDENTITY(1,1) NOT NULL,
	[Project_ID] [int] NULL,
	[url] [nvarchar](50) NULL,
 CONSTRAINT [PK_Project_Image] PRIMARY KEY CLUSTERED 
(
	[Img_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[RealEstateType]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[RealEstateType]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[RealEstateType](
	[RealEstateType_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_RealEstaleType] PRIMARY KEY CLUSTERED 
(
	[RealEstateType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Status]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Status]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Status](
	[Status_ID] [int] IDENTITY(1,1) NOT NULL,
	[Status_Type] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Status_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Post].[Type]    Script Date: 5/8/2019 12:51:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Post].[Type]') AND type in (N'U'))
BEGIN
CREATE TABLE [Post].[Type](
	[PostType_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PostType] PRIMARY KEY CLUSTERED 
(
	[PostType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [Customer].[Block] ON 

INSERT [Customer].[Block] ([Cus_ID], [Block_ID], [Reason], [BlockDate], [UnBlockDate], [ModifiedDate]) VALUES (1, 20, N'Employee 1 was blocked', CAST(N'2019-03-21T15:51:42.543' AS DateTime), CAST(N'2018-12-10T00:51:41.680' AS DateTime), CAST(N'2019-03-21T15:51:42.543' AS DateTime))
INSERT [Customer].[Block] ([Cus_ID], [Block_ID], [Reason], [BlockDate], [UnBlockDate], [ModifiedDate]) VALUES (3, 22, N'I like it', CAST(N'2019-03-21T15:51:42.560' AS DateTime), NULL, CAST(N'2019-05-07T22:38:08.553' AS DateTime))
INSERT [Customer].[Block] ([Cus_ID], [Block_ID], [Reason], [BlockDate], [UnBlockDate], [ModifiedDate]) VALUES (14, 29, N'Blocked by Admin', CAST(N'2019-05-07T13:28:18.600' AS DateTime), CAST(N'2019-05-07T13:29:45.753' AS DateTime), CAST(N'2019-05-07T13:28:25.493' AS DateTime))
INSERT [Customer].[Block] ([Cus_ID], [Block_ID], [Reason], [BlockDate], [UnBlockDate], [ModifiedDate]) VALUES (14, 30, N'Blocked by Admin', CAST(N'2019-05-07T13:30:01.677' AS DateTime), CAST(N'2019-05-07T13:31:48.687' AS DateTime), CAST(N'2019-05-07T13:30:28.443' AS DateTime))
SET IDENTITY_INSERT [Customer].[Block] OFF
SET IDENTITY_INSERT [Customer].[Customer] ON 

INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (1, N'Thủy', N'Đào Xuân', N'thuydx.9598@gmail.com', N'101, Lê Đại Hành, Phường 11, Quận 5, TP. Hồ Chí Minh', N'0979 31 9598', N'd84a55ca-bdd1-45c3-bbd8-742b509ed896', N'xuanthuy-572019103651PM.jpg', CAST(N'2019-05-07T22:35:31.210' AS DateTime), CAST(N'2019-05-02T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (2, N'Minh', N'Ngô Công', N'MinhNC@gmail.com', N'54, Nguyễn Công Trứ, Quận 2, Hồ Chí Minh', N'0123123123', N'eaebb98f-81a7-45b9-801f-2194a5de5a31', N'c_2.jpg', CAST(N'2019-05-07T18:20:44.260' AS DateTime), CAST(N'2019-05-03T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (3, N'An', N'Đinh Thị', N'AnDT@gmail.com', N'11, Lê Lợi, Phường 8, Quận 7, Hồ Chí Minh', N'0234234023', N'781214f2-d165-4dd6-abcf-82b42beff763', N'c_3.jpg', CAST(N'2019-05-07T18:20:17.270' AS DateTime), CAST(N'2019-05-02T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (4, N'Quốc', N'Nguyễn Thiên', N'QuocNT@gmail.com', N'4, Thôn 2, Thanh Xuân, Hà Nội', N'0234523455', N'b0f3907d-878c-47c8-83e2-ed12eb33e6f6', N'c_4.jpg', CAST(N'2019-05-07T18:20:24.403' AS DateTime), CAST(N'2019-05-04T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (5, N'Ngân', N'Huỳnh Thị', N'NganHT@gmail.com', N'8, Xuân Thủy, Cầu Giấy, Hà Nội', N'0345634634', N'f7b7a178-1124-45fb-ac84-40b3889dc47d', N'c_5.jpg', CAST(N'2019-05-07T18:20:35.150' AS DateTime), CAST(N'2019-05-07T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (6, N'Thanh', N'Lê Thị Kim', N'lekiimthanh@gmail.com', N'Bình Long, Bình Phước', N'0123414555', N'31e3364d-e2e3-4d19-9ca3-1365682cb3c9', N'$2a$10$NqzKmty21Y7iCVAjkuRV4eBlXBQR1u4s2KgLOCl5uUjxrhDkmq0Gq.jpg', CAST(N'2019-05-07T18:20:56.847' AS DateTime), CAST(N'2019-05-08T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (7, N'Hòa', N'Nguyễn Tiến', N'hoaNT@gmail.com', N'Quận 7, Hồ Chí Minh', N'0345555555', N'6198f423-6a80-481f-8031-aceaa97152ad', N'98a66f7d11b86941598146b5604e41147ae608ff14884dd07eab428d2444f863.jpg', CAST(N'2019-05-07T18:21:01.790' AS DateTime), CAST(N'2019-05-01T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (8, N'Liễu', N'Lá Thị Út', N'lieunuCongThuong@gmail.com', N'Quận Thủ Đức, Hồ Chí Minh', N'0235234555', N'54dea537-5155-47fe-98c8-1f3e3b287082', N'noAvatar.png', CAST(N'2019-05-07T18:21:09.057' AS DateTime), CAST(N'2019-04-28T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (9, N'Minh', N'Đinh Công', N'dinhcongminh@gmail.com', N'Quận 9, Hồ Chí Minh', N'0565656655', N'82c805eb-8608-45de-ab02-3a5c09edea0a', N'noAvatar.png', CAST(N'2019-05-07T18:21:21.883' AS DateTime), CAST(N'2019-05-09T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (10, N'Minh', N'Nguyễn Hoàng', N'MinhNH@gmail.com', N'Quận 7, Hồ Chí Minh', N'0234444232', N'6917496a-2f16-4323-b42c-44e38a46bbb2', N'f62d58d668f3df547dafba55cfd7127b086b78457d09d6fef6e4f3c3ac2a0811.jpg', CAST(N'2019-05-07T18:21:29.300' AS DateTime), CAST(N'2019-04-10T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (13, N'Kha', N'Phạm Hồng', N'KhaPH@gmail.com', N'Quận 7, Hồ Chí Minh', N'0454433444', N'152a5029-a84b-4046-b04e-f8c29e3875d5', N'5ce191d798477bbb9711f26c52394a585fccb3714e23e266f448efa1ebcccff5.jpg', CAST(N'2019-05-07T18:21:37.750' AS DateTime), CAST(N'2019-05-03T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (14, N'Huy', N'Bùi Quốc', N'huyBQ@gmail.com', N'Quận 7, Hồ Chí Minh', N'0235553453', N'2f250ae3-6852-43e1-880e-b2c6b4cc3194', N'dc427e099d5d4a737a4e2416004605e1dbfad3be95b7cecee7355f45c2e9e7ff.jpg', CAST(N'2019-05-07T18:21:43.743' AS DateTime), CAST(N'2019-05-10T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (15, N'Hoàng', N'Đào Xuân', N'hoangDX@gmail.com', N'101 Thôn 9, Hòa Ninh, Di Linh', N'0129312391', N'28497695-f331-40df-ae54-a9ea3b10b2cf', N'noAvatar.png', CAST(N'2019-04-30T14:43:05.587' AS DateTime), CAST(N'2019-05-17T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (16, N'Dat', N'Dao Xuan Thanh', N'datdxt@gmail.com', N'101 Thôn 9, Hòa Ninh, Di Linh', N'0299393939', N'a6de1c9b-b8b2-459b-9a6a-2b2d704217bb', N'noAvatar.png', CAST(N'2019-05-07T18:21:51.330' AS DateTime), CAST(N'2019-05-09T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (17, N'Hoàng', N'Dao Xuan Thanh', N'test@gmail.com', N'101 Thôn 9, Hòa Ninh, Di Linh', N'0129312391', N'edd8187a-4bf5-4534-b778-91cac33a957c', N'noAvatar.png', CAST(N'2019-05-07T18:21:56.493' AS DateTime), CAST(N'2019-05-09T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (18, N'Hoàng', N'Đào Xuân', N'email123@gmail.com', N'101 Thôn 9, Hòa Ninh, Di Linh', N'0299393939', N'f0ca5e71-50c0-4c27-a21e-5bc3983d7a56', N'noAvatar.png', CAST(N'2019-05-07T18:22:01.880' AS DateTime), CAST(N'2019-05-13T00:00:00.000' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (19, N'Thụy', N'Đinh Hoàng Diễm', N'thuy@uteshare.com', N'79, Nguyễn Văn Trỗi, Phường 1, TP. Bảo Lộc, Lâm Đồng', N'0929384844', N'8de8510e-bc53-4a92-995d-d6eae23fa973', N'56589757_2331139670453617_7470188943795814400_o-57201994016PM.jpg', CAST(N'2019-05-07T21:38:56.300' AS DateTime), CAST(N'2019-05-07T21:40:16.840' AS DateTime))
INSERT [Customer].[Customer] ([Customer_ID], [Firstname], [LastName], [Email], [Address], [PhoneNumber], [Account_ID], [Avatar_URL], [ModifiedDate], [CreatedDate]) VALUES (21, N'Thanh', N'Hoàng Thị', N'thanh@uteshare.com', N'72 Thôn 2, Bình Long, Bình Phước', N'0352456377', N'aaf77851-1b83-4c6d-ac73-0fee8db195aa', N'52472046_2287707958222458_7656251191961059328_n-572019103258PM.jpg', CAST(N'2019-05-07T22:31:38.107' AS DateTime), CAST(N'2019-05-07T22:31:54.207' AS DateTime))
SET IDENTITY_INSERT [Customer].[Customer] OFF
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'00000000000000_CreateIdentitySchema', N'2.2.4-servicing-10062')
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([Admin_Id], [UserName], [PasswordHash]) VALUES (1, N'admin@gmail.com', N'$2a$10$AzIBs68xPZnjD8PF9oAyy.mEUA5tFfqOvLgI88yi.p6G1zg1Oib/q')
SET IDENTITY_INSERT [dbo].[Admin] OFF
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'152a5029-a84b-4046-b04e-f8c29e3875d5', N'KhaPH@gmail.com', N'KHAPH@GMAIL.COM', N'KhaPH@gmail.com', N'KHAPH@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOCxVfVLmpLlkCZXaOQKnPNhGbjtWR9uON3nuN6BCMnv1Pc4h8P9CSkl4xP3tcFHIQ==', N'VBTXZLUBYCUNUDGPXCKC3C5CHK2CBKQA', N'3b727eba-d4e0-415c-b8db-2a9dfb846101', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'28497695-f331-40df-ae54-a9ea3b10b2cf', N'hoangDX@gmail.com', N'HOANGDX@GMAIL.COM', N'hoangDX@gmail.com', N'HOANGDX@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEDzxBHBq/cwcTyirbsSiC+k2n5JUmEewZBi3Z1kOaliaZMnjSQUCplh9NlYd4NVHKA==', N'MGXIF33PM3ESZLQEEIMUNHFJDZE47BC4', N'3d2780f9-eaf2-4da0-9d0d-e79749cad0c1', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'2f250ae3-6852-43e1-880e-b2c6b4cc3194', N'huyBQ@gmail.com', N'HUYBQ@GMAIL.COM', N'huyBQ@gmail.com', N'HUYBQ@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEHjwyRFqwxR+H3iwwjnyZmRa+tgate0X+m6J5gkhXSKhAETDTFBqDliCDNwxKYeoBg==', N'SDZTASHLADQDCN5YJOV6FWGLIZJVR27M', N'c434c151-2e0c-423a-b663-2c5111f02883', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'31e3364d-e2e3-4d19-9ca3-1365682cb3c9', N'lekiimthanh@gmail.com', N'LEKIIMTHANH@GMAIL.COM', N'lekiimthanh@gmail.com', N'LEKIIMTHANH@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEJ7MiM9dkWFQqnMXZ6YUc1WNXcC426IJY8MsRlTLNLwPVeYpvmtalWC7wBz83RkPQg==', N'NLXRP5PN2H3QF6KM252D7TRPAQMHPRKV', N'0d028974-20a4-41b9-b021-6fde5242e797', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'54dea537-5155-47fe-98c8-1f3e3b287082', N'lieunuCongThuong@gmail.com', N'LIEUNUCONGTHUONG@GMAIL.COM', N'lieunuCongThuong@gmail.com', N'LIEUNUCONGTHUONG@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEFtOqetKLtiyKIoaxW1Cxr+GYfTvEUdBjaoVj1I1hLZasLzxDTiR0bBART4zo0ndTA==', N'Q4USEP6DKATT5WMMOMU3C7MBTWP37MAG', N'53f0e389-e5b1-4768-8126-109e54affdb0', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'6198f423-6a80-481f-8031-aceaa97152ad', N'hoaNT@gmail.com', N'HOANT@GMAIL.COM', N'hoaNT@gmail.com', N'HOANT@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEP2pjj5QEItWxA8I99tbSCade9n8HZx1Ol0vzo6b9TFU+E7FmEa+tE2zZpQhkKLOeg==', N'PJJREQ2YJC6FKCXRSEXBGS3H7I7TOWSX', N'867477ac-285e-4dd3-9767-28240052bcb8', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'6917496a-2f16-4323-b42c-44e38a46bbb2', N'MinhNH@gmail.com', N'MINHNH@GMAIL.COM', N'MinhNH@gmail.com', N'MINHNH@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEANFUF1FuzpYmbXnze6IKU/OcMuJCkEZLdToq1Z+hhYpSGDcUqB+XbDyML8c4vEEwg==', N'5J36IWPANWRRU7Z6VQVB2NOUVIWD7437', N'67476649-e422-476c-93be-a277927fb871', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'781214f2-d165-4dd6-abcf-82b42beff763', N'AnDT@gmail.com', N'ANDT@GMAIL.COM', N'AnDT@gmail.com', N'ANDT@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEByaBxAPNGea5Jnq5CqdcU1W1fxlWqI9gJIsIW+eI0UFEkfW2U530mnZInEjBTJ5zQ==', N'GQRUJMXF5XGD6XFIAQPMS25YZWUUJQXW', N'680a71f4-0b36-4a9e-8823-f3c600b8affe', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'82c805eb-8608-45de-ab02-3a5c09edea0a', N'dinhcongminh@gmail.com', N'DINHCONGMINH@GMAIL.COM', N'dinhcongminh@gmail.com', N'DINHCONGMINH@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEObT9GrhBDDo2iaCkhnwTGieBwRN4/wgKL08aNU8nA5vJMAFK6KNPW7NctXW215fZw==', N'3QMMZ5ZIUUVEVUUQZF6RI4Y3HLVQO6B5', N'b8f09144-7ede-44c5-8fe9-ef49dc155ce1', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'8de8510e-bc53-4a92-995d-d6eae23fa973', N'thuy@uteshare.com', N'THUY@UTESHARE.COM', N'thuy@uteshare.com', N'THUY@UTESHARE.COM', 0, N'AQAAAAEAACcQAAAAEIVPl7H96r/xsnB5rTrqQEqEYK2pfzddnJ+0RQmErZVhN3IJGA2k2vahVVb6j1l0Qw==', N'4NDBIPJKFUD4ROWDZYBIRVT6NT5RF5KD', N'f0106df1-0705-4a03-a4c1-358a5ebd968e', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'a6de1c9b-b8b2-459b-9a6a-2b2d704217bb', N'datdxt@gmail.com', N'DATDXT@GMAIL.COM', N'datdxt@gmail.com', N'DATDXT@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKF3O1D4MbcPGeosQKeVa84XcMrRJYpQNWWffTkl74goXzCKjeejCfn/hGY6sjSjWQ==', N'AXZYQVD452UD6VOYZ63JTG7VXETNNORL', N'c03ff56d-030f-4fe6-bef5-de1a540a38a0', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'aaf77851-1b83-4c6d-ac73-0fee8db195aa', N'thanh@uteshare.com', N'THANH@UTESHARE.COM', N'thanh@uteshare.com', N'THANH@UTESHARE.COM', 0, N'AQAAAAEAACcQAAAAEIsfkyQ15ssheybRKb/AyLMT7xbytTmt6qdiqUn9pqmPu0kT/oXP9Fg/GcQId1zaNA==', N'ISCO72D3J6FRKFW4RLGEEG3VKGVCX72K', N'be59d07f-437c-48ef-8b7d-2c4e34e2da96', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b0f3907d-878c-47c8-83e2-ed12eb33e6f6', N'QuocNT@gmail.com', N'QUOCNT@GMAIL.COM', N'QuocNT@gmail.com', N'QUOCNT@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEAOv70jJ+AE36JxlJWAGmm5/cF4GXYIc/Bga4mk0ox5n2UgHX5LIpHzOXVIx/Qih1w==', N'ZLBCU5PERYDOURPYG432JTQSHRKOMRXV', N'e856cf9a-4cd5-45f9-b18e-6d0ae67ead29', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'cec3058d-dc19-423b-9f27-7fda6cfdaa2f', N'email@gmail.com', N'EMAIL@GMAIL.COM', N'email@gmail.com', N'EMAIL@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAELzEUaFhWPlXEe4DBTT11PFZKsLhZvc4kdjrZi86QKJ6MS/yKNMljcT/tk41MrQewg==', N'MZLFI2RLB7OEDZ4C5NHUQ4AOX6SD7N5E', N'981047b1-d2be-4bba-81f1-d137217a666c', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'd84a55ca-bdd1-45c3-bbd8-742b509ed896', N'thuydx.9598@gmail.com', N'THUYDX.9598@GMAIL.COM', N'thuydx.9598@gmail.com', N'THUYDX.9598@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEDVkt5wID/QiBr0NEm2G28hQ8jf0axJtwrIHFT3P/LHePu1HeffMdJ+FB5Fp1YJNPQ==', N'VW5WP3LIRX5OUMEVCB3OR6MOIBEOOHMN', N'd271315d-e630-46ee-9c53-c6de2b2043c9', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'eaebb98f-81a7-45b9-801f-2194a5de5a31', N'MinhNC@gmail.com', N'MINHNC@GMAIL.COM', N'MinhNC@gmail.com', N'MINHNC@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAELARxAbWQr85FcTJE74tfq+bGaW6AfXsFXulME2rKNke456syQW3+SAGsUL4TTQrLg==', N'6KDAC4P4YYEA3TXY2W6QM7DV4DP65K5S', N'91c1f7b2-80e0-463f-b816-fb7cb76aef3c', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'edd8187a-4bf5-4534-b778-91cac33a957c', N'test@gmail.com', N'TEST@GMAIL.COM', N'test@gmail.com', N'TEST@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEE6UvTmSJZv948mwPf7+O/pY4yfRPCCj4ZntQEitwLUMs3g/lZ6yiqou3ikbCn0x/g==', N'3LYC7HQ4QZEN2ZWJ6YKHN3WJ64N66NJD', N'3a72046b-7bb3-4993-bf9c-591d75fdb901', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'f0ca5e71-50c0-4c27-a21e-5bc3983d7a56', N'email123@gmail.com', N'EMAIL123@GMAIL.COM', N'email123@gmail.com', N'EMAIL123@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEPbHdJ3WvxzyqN7pk+SrenTPy+SuAreIfcHL0zsWfPj0K7iIhFSu930W1nzNy+UBNQ==', N'D6XVYOGZOCHA6JTKJFGWEP74T7UAOZZ5', N'07ca3481-ac99-490a-ba92-b169d71dde71', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'f7b7a178-1124-45fb-ac84-40b3889dc47d', N'NganHT@gmail.com', N'NGANHT@GMAIL.COM', N'NganHT@gmail.com', N'NGANHT@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKTlssKh4FZgh6QS808MoaAlHPtufbDRqn5L2ftD7z2NTs7OFY3ZeAexS8ai+hCAhg==', N'KCCABAVQ3WY4CYXLFQ5UCF6HGAEYX2RD', N'7aca6f87-1ad0-4548-932a-1edc382c5019', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUserTokens] ([UserId], [LoginProvider], [Name], [Value]) VALUES (N'a6de1c9b-b8b2-459b-9a6a-2b2d704217bb', N'[AspNetUserStore]', N'AuthenticatorKey', N'PEGSTEOBRLIHDNKMHHPHH7MVSE5Y3WPI')
INSERT [dbo].[Dashboard] ([Id], [TotalGuest], [TotalFBClick], [TotalInsClick], [TotalTwiClick], [TotalLinClick], [TotalPinClick]) VALUES (N'ute-res-xt', 12364, 844, 234, 829, 235, 120)
SET IDENTITY_INSERT [dbo].[Information] ON 

INSERT [dbo].[Information] ([Info_Id], [Email], [Address], [PhoneNumber], [WorkingTime], [Facebook], [Twitter], [Instagram], [Pinterest], [Linkedin]) VALUES (1, N'hau36631@donga.edu.vn', N'01 Võ Văn Ngân, Hòa Bình, Đà Nẵng', N'(+84) 327 648 380', N'Thứ 2 - Thứ 6, 8 AM - 5 PM', N'https://www.facebook.com/vanhau.bui.100', N'https://twitter.com/', N'https://www.instagram.com/', N'https://www.pinterest.com/', N'https://www.linkedin.com')
INSERT [dbo].[Information] ([Info_Id], [Email], [Address], [PhoneNumber], [WorkingTime], [Facebook], [Twitter], [Instagram], [Pinterest], [Linkedin]) VALUES (2, N'hau36631@donga.edu.vn', N'01 Võ Văn Ngân, Hòa Bình, Đà Nẵng', N'ád', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Information] ([Info_Id], [Email], [Address], [PhoneNumber], [WorkingTime], [Facebook], [Twitter], [Instagram], [Pinterest], [Linkedin]) VALUES (3, N'hau36631@donga.edu.vn', N'01 Võ Văn Ngân, Hòa Bình, Đà Nẵng', N'(+84) 327 648 380', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Information] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([Menu_Id], [Title], [Action]) VALUES (1, N'TRANG CHỦ', N'/')
INSERT [dbo].[Menu] ([Menu_Id], [Title], [Action]) VALUES (2, N'GIỚI THIỆU', N'/gioithieu')
INSERT [dbo].[Menu] ([Menu_Id], [Title], [Action]) VALUES (3, N'CẦN MUA', N'/canmua')
INSERT [dbo].[Menu] ([Menu_Id], [Title], [Action]) VALUES (4, N'CẦN THUÊ', N'/canthue')
INSERT [dbo].[Menu] ([Menu_Id], [Title], [Action]) VALUES (5, N'LIÊN HỆ', N'/lienhe')
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[SubMenu] ON 

INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (1, 3, N'Nhà', N'?id=1')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (2, 3, N'Đất', N'?id=2')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (3, 3, N'Căn hộ', N'?id=3')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (4, 3, N'Mặt bằng', N'?id=4')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (5, 3, N'Kho xưởng', N'?id=5')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (6, 3, N'Khác', N'?id=10')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (7, 4, N'Nhà', N'?id=1')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (8, 4, N'Đất', N'?id=2')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (9, 4, N'Căn hộ', N'?id=3')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (10, 4, N'Mặt bằng', N'?id=4')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (11, 4, N'Kho xưởng', N'?id=5')
INSERT [dbo].[SubMenu] ([Sub_Id], [Menu_Id], [Title], [Action]) VALUES (12, 4, N'Khác', N'?id=10')
SET IDENTITY_INSERT [dbo].[SubMenu] OFF
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'dgrRES', 1, 1, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000003D00000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF3F000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000FEFFFFFF1100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F000000300000003100000032000000330000003400000035000000360000003700000038000000390000003A0000003B0000003C000000FEFFFFFFFEFFFFFF64000000FEFFFFFF4100000042000000430000004400000045000000460000004700000048000000490000004A0000004B0000004C0000004D0000004E0000004F000000500000005100000052000000530000005400000055000000560000005700000058000000590000005A0000005B0000005C0000005D0000005E0000005F00000060000000610000006200000063000000FEFFFFFF650000006600000067000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000C016618FFEFED4013E000000C0080000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000002000000E21B0000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000100000005259000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000005F00000000000000000434000A1E500C05000080610000000F00FFFF4600000061000000007D0000DA7C0000A0440000021E0100CC2E0100D2D6FFFF0EE9FFFFDE805B10F195D011B0A000AA00BDCB5C000008003000000000020000030000003C006B0000000900000000000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002800430000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002800430000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C52000000EC1A000000D2010000003C00A50900000700008002000000A802000000800000110000805363684772696400AA370000E02E00004163636F756E7420284163636F756E742900000000003C00A50900000700008003000000AE02000000800000140000805363684772696400E4570000383100004163636F756E744C6F6720284163636F756E742900009000A50900000700008004000000520000000180000065000080436F6E74726F6C00064D00001336000052656C6174696F6E736869702027464B5F4163636F756E744C6F675F4163636F756E7420284163636F756E742927206265747765656E20274163636F756E7420284163636F756E74292720616E6420274163636F756E744C6F6720284163636F756E74292700000000002800B50100000700008005000000310000005D00000002800000436F6E74726F6C00244C00005938000000003800A50900000700008006000000A60200000080000010000080536368477269640036F7FFFFA46A0000426C6F636B2028437573746F6D65722900003C00A50900000700008008000000AC0200000080000013000080536368477269640042270000B0040000437573746F6D65722028437573746F6D6572290000008800A50900000700008009000000620000000180000060000080436F6E74726F6C00DD000000F31C000052656C6174696F6E736869702027464B5F426C6F636B5F437573746F6D65722028437573746F6D65722927206265747765656E2027437573746F6D65722028437573746F6D6572292720616E642027426C6F636B2028437573746F6D6572292700002800B5010000070000800A000000310000005500000002800000436F6E74726F6C0007030000C72D000000008C00A5090000070000800B000000620000000180000063000080436F6E74726F6C00272F0000EF1C000052656C6174696F6E736869702027464B5F437573746F6D65725F4163636F756E742028437573746F6D65722927206265747765656E20274163636F756E7420284163636F756E74292720616E642027437573746F6D65722028437573746F6D657229270000002800B5010000070000800C000000310000005900000002800000436F6E74726F6C0051310000322A000000003800A50900000700008012000000A0020000008000000D0000805363684772696400269EFFFF220B000044657461696C2028506F73742909000000003800A50900000700008013000000A602000000800000100000805363684772696400DCBAFFFF100E0000446972656374696F6E2028506F73742900008000A50900000700008014000000520000000180000058000080436F6E74726F6C0082B3FFFF0F0D000052656C6174696F6E736869702027464B5F44657461696C5F446972656374696F6E2028506F73742927206265747765656E2027446972656374696F6E2028506F7374292720616E64202744657461696C2028506F7374292700002800B50100000700008015000000310000005900000002800000436F6E74726F6C007DB2FFFF9F0C000000003C00A50900000700008016000000AC020000008000001300008053636847726964007017000020670000456D706C6F7965652028456D706C6F796565290000008800A50900000700008017000000520000000180000060000080436F6E74726F6C00920C00002F74000052656C6174696F6E736869702027464B5F426C6F636B5F456D706C6F7965652028437573746F6D65722927206265747765656E2027456D706C6F7965652028456D706C6F796565292720616E642027426C6F636B2028437573746F6D6572292700002800B50100000700008018000000310000005500000002800000436F6E74726F6C00560D0000BF73000000008C00A5090000070000801D000000620000000180000063000080436F6E74726F6C00AD210000373D000052656C6174696F6E736869702027464B5F456D706C6F7965655F4163636F756E742028456D706C6F7965652927206265747765656E20274163636F756E7420284163636F756E74292720616E642027456D706C6F7965652028456D706C6F79656529270000002800B5010000070000801E000000310000005900000002800000436F6E74726F6C00432500004253000000009000A5090000070000801F0000006A0000000180000066000080436F6E74726F6C005C1200000C62000052656C6174696F6E736869702027464B5F456D706C6F7965655F456D706C6F7965652028456D706C6F7965652927206265747765656E2027456D706C6F7965652028456D706C6F796565292720616E642027456D706C6F7965652028456D706C6F7965652927000000002800B50100000700008020000000310000005B00000002800000436F6E74726F6C009C100000E763000000003800A50900000700008021000000A2020000008000000E00008053636847726964001E97FFFFD2C4FFFF4572726F724C6F67202864626F29000000004400A50900000700008022000000BA020000008000001A00008053636847726964004227000098EFFFFF496E74657265737465645F506F73742028437573746F6D657229000000009C00A50900000700008023000000520000000180000074000080436F6E74726F6C00CD300000F5F8FFFF52656C6174696F6E736869702027464B5F496E74657265737465645F506F73745F437573746F6D65722028437573746F6D65722927206265747765656E2027437573746F6D65722028437573746F6D6572292720616E642027496E74657265737465645F506F73742028437573746F6D6572292700002800B50100000700008024000000310000006900000002800000436F6E74726F6C001333000084FFFFFF00003C00A50900000700008025000000AE0200000080000014000080536368477269640036F7FFFF945C00005065726D697373696F6E20284163636F756E742900004400A50900000700008026000000B802000000800000190000805363684772696400A0F6FFFFE64600005065726D697373696F6E5F526F6C6520284163636F756E74290000000000A000A50900000700008027000000520000000180000075000080436F6E74726F6C00C10000004350000052656C6174696F6E736869702027464B5F5065726D697373696F6E5F526F6C655F5065726D697373696F6E20284163636F756E742927206265747765656E20275065726D697373696F6E20284163636F756E74292720616E6420275065726D697373696F6E5F526F6C6520284163636F756E74292700000000002800B50100000700008028000000310000006D00000002800000436F6E74726F6C00070300009356000000004000A50900000700008029000000B2020000008000001600008053636847726964007C4700004E0C000050686F6E654E756D6265722028437573746F6D657229000000009400A5090000070000802A00000052000000018000006C000080436F6E74726F6C009E3C00009310000052656C6174696F6E736869702027464B5F50686F6E654E756D6265725F437573746F6D65722028437573746F6D65722927206265747765656E2027437573746F6D65722028437573746F6D6572292720616E64202750686F6E654E756D6265722028437573746F6D6572292700002800B5010000070000802B000000310000006100000002800000436F6E74726F6C00EB3A0000D912000000003400A5090000070000802C0000009C020000008000000B0000805363684772696400C2B6FFFFF03C0000506F73742028506F7374295000009000A5090000070000802D000000620000000180000068000080436F6E74726F6C001ECCFFFFF9F3FFFF52656C6174696F6E736869702027464B5F496E74657265737465645F506F73745F506F73742028437573746F6D65722927206265747765656E2027506F73742028506F7374292720616E642027496E74657265737465645F506F73742028437573746F6D6572292700002800B5010000070000802E000000310000006100000002800000436F6E74726F6C0000E5FFFF23F6FFFF00003C00A5090000070000802F000000A802000000800000110000805363684772696400C2B6FFFFEA240000506F73745F496D6167652028506F73742900000000008000A50900000700008030000000520000000180000056000080436F6E74726F6C004DC0FFFFC230000052656C6174696F6E736869702027464B5F506F73745F496D6167655F506F73742028506F73742927206265747765656E2027506F73742028506F7374292720616E642027506F73745F496D6167652028506F73742927292700002800B50100000700008031000000310000005700000002800000436F6E74726F6C0093C2FFFF8A37000000003C00A50900000700008032000000AA02000000800000120000805363684772696400FCD6FFFFF03C0000506F73745F5265706F72742028506F737429000000008C00A50900000700008033000000620000000180000064000080436F6E74726F6C00A3E0FFFF3950000052656C6174696F6E736869702027464B5F506F73745F5265706F72745F456D706C6F7965652028506F73742927206265747765656E2027456D706C6F7965652028456D706C6F796565292720616E642027506F73745F5265706F72742028506F7374292700002800B50100000700008034000000310000006100000002800000436F6E74726F6C00320A00004253000000008000A50900000700008035000000620000000180000058000080436F6E74726F6C001ECCFFFF9746000052656C6174696F6E736869702027464B5F506F73745F5265706F72745F506F73742028506F73742927206265747765656E2027506F73742028506F7374292720616E642027506F73745F5265706F72742028506F7374292700002800B50100000700008036000000310000005900000002800000436F6E74726F6C00E3C7FFFFFE4C000000003C00A50900000700008037000000AA020000008000001200008053636847726964001E97FFFF72510000506F73745F5374617475732028506F737429000000008000A50900000700008038000000620000000180000058000080436F6E74726F6C007AACFFFF454F000052656C6174696F6E736869702027464B5F506F73745F5374617475735F506F73742028506F73742927206265747765656E2027506F73742028506F7374292720616E642027506F73745F5374617475732028506F7374292700002800B50100000700008039000000310000005900000002800000436F6E74726F6C00A9A2FFFFD950000000003800A5090000070000803A000000A2020000008000000E0000805363684772696400C2B6FFFF80BB000050726F6A6563742028506F737429742900007800A5090000070000803B000000620000000180000050000080436F6E74726F6C003DBFFFFF9661000052656C6174696F6E736869702027464B5F506F73745F50726F6A6563742028506F73742927206265747765656E202750726F6A6563742028506F7374292720616E642027506F73742028506F7374292700002800B5010000070000803C000000310000005100000002800000436F6E74726F6C0067C1FFFF708F000000003C00A5090000070000803D000000AE020000008000001400008053636847726964001E97FFFFD8BD000050726F6A6563745F496D6167652028506F73742900008C00A5090000070000803E000000520000000180000062000080436F6E74726F6C007AACFFFF1DC2000052656C6174696F6E736869702027464B5F50726F6A6563745F496D6167655F50726F6A6563742028506F73742927206265747765656E202750726F6A6563742028506F7374292720616E64202750726F6A6563745F496D6167652028506F73742927270000002800B5010000070000803F000000310000006300000002800000436F6E74726F6C004CABFFFFADC1000000003C00A50900000700008040000000AE02000000800000140000805363684772696400DC050000D4FEFFFF50726F6D6F74696F6E2028437573746F6D65722900009000A50900000700008041000000620000000180000068000080436F6E74726F6C00381B00002306000052656C6174696F6E736869702027464B5F50726F6D6F74696F6E5F437573746F6D65722028437573746F6D65722927206265747765656E2027437573746F6D65722028437573746F6D6572292720616E64202750726F6D6F74696F6E2028437573746F6D6572292700002800B50100000700008042000000310000005D00000002800000436F6E74726F6C0079110000F40F000000004400A50900000700008043000000BC020000008000001B00008053636847726964001A040000C819000050726F6D6F74696F6E5F44657461696C2028437573746F6D6572290000009400A5090000070000804400000062000000018000006A000080436F6E74726F6C001ECCFFFF291E000052656C6174696F6E736869702027464B5F50726F6D6F74696F6E5F44657461696C5F506F73742028437573746F6D65722927206265747765656E2027506F73742028506F7374292720616E64202750726F6D6F74696F6E5F44657461696C2028437573746F6D65722927000000002800B50100000700008045000000310000006300000002800000436F6E74726F6C0061D4FFFF592300000000A000A50900000700008046000000520000000180000078000080436F6E74726F6C00670F00002B0D000052656C6174696F6E736869702027464B5F50726F6D6F74696F6E5F44657461696C5F50726F6D6F74696F6E2028437573746F6D65722927206265747765656E202750726F6D6F74696F6E2028437573746F6D6572292720616E64202750726F6D6F74696F6E5F44657461696C2028437573746F6D6572292700002800B50100000700008047000000310000006D00000002800000436F6E74726F6C0013FFFFFFB914000000004000A5090000070000804B000000B002000000800000150000805363684772696400FCD6FFFF80BB00005265616C457374617465547970652028506F7374290A000000008800A5090000070000804C00000062000000018000005E000080436F6E74726F6C00FFC0FFFF9661000052656C6174696F6E736869702027464B5F506F73745F5265616C457374616C65547970652028506F73742927206265747765656E20275265616C457374617465547970652028506F7374292720616E642027506F73742028506F73742927000000002800B5010000070000804D000000310000005F00000002800000436F6E74726F6C0029C3FFFF4C9E000000003800A5090000070000804E000000A2020000008000000E0000805363684772696400CCF7FFFF38310000526F6C6520284163636F756E7429000000009400A5090000070000804F000000520000000180000069000080436F6E74726F6C0057010000993A000052656C6174696F6E736869702027464B5F5065726D697373696F6E5F526F6C655F526F6C6520284163636F756E742927206265747765656E2027526F6C6520284163636F756E74292720616E6420275065726D697373696F6E5F526F6C6520284163636F756E74292700000000002800B50100000700008050000000310000006100000002800000436F6E74726F6C0081F4FFFFA441000000004000A50900000700008051000000B2020000008000001600008053636847726964000618000038310000526F6C655F4163636F756E7420284163636F756E7429000000009400A50900000700008052000000520000000180000069000080436F6E74726F6C00622D00001336000052656C6174696F6E736869702027464B5F526F6C655F4163636F756E745F4163636F756E7420284163636F756E742927206265747765656E20274163636F756E7420284163636F756E74292720616E642027526F6C655F4163636F756E7420284163636F756E74292700000000002800B50100000700008053000000310000006100000002800000436F6E74726F6C00E82B0000A335000000008C00A50900000700008054000000520000000180000063000080436F6E74726F6C00280D00007D35000052656C6174696F6E736869702027464B5F526F6C655F4163636F756E745F526F6C6520284163636F756E742927206265747765656E2027526F6C6520284163636F756E74292720616E642027526F6C655F4163636F756E7420284163636F756E7429270000002800B50100000700008055000000310000005B00000002800000436F6E74726F6C00C80C0000C337000000003800A50900000700008056000000A0020000008000000D00008053636847726964001E97FFFF5A3C00005374617475732028506F73742909000000008400A5090000070000805700000052000000018000005C000080436F6E74726F6C00A9A0FFFFBB45000052656C6174696F6E736869702027464B5F506F73745F5374617475735F5374617475732028506F73742927206265747765656E20275374617475732028506F7374292720616E642027506F73745F5374617475732028506F7374292700002800B50100000700008058000000310000005D00000002800000436F6E74726F6C00D694FFFF874C000000003800A50900000700008059000000A4020000008000000F000080536368477269640088770000E02E0000547970652028437573746F6D6572292900008800A5090000070000805A00000062000000018000005E000080436F6E74726F6C006D340000EF1C000052656C6174696F6E736869702027464B5F437573746F6D65725F547970652028437573746F6D65722927206265747765656E2027547970652028437573746F6D6572292720616E642027437573746F6D65722028437573746F6D65722927000000002800B5010000070000805B000000310000005300000002800000436F6E74726F6C00CE5900006828000000003400A5090000070000805C0000009C020000008000000B0000805363684772696400FCD6FFFF2AA80000547970652028506F7374296D00007800A5090000070000805D00000062000000018000004E000080436F6E74726F6C001ECCFFFFB951000052656C6174696F6E736869702027464B5F506F73745F506F7374547970652028506F73742927206265747765656E2027547970652028506F7374292720616E642027506F73742028506F73742927292700002800B5010000070000805E000000310000005300000002800000436F6E74726F6C0015D5FFFFBD7B000000007800A5090000070000806000000062000000018000004E000080436F6E74726F6C003DB2FFFF6F1E000052656C6174696F6E736869702027464B5F506F73745F44657461696C2028506F73742927206265747765656E202744657461696C2028506F7374292720616E642027506F73742028506F73742927081300002800B50100000700008061000000310000004F00000002800000436F6E74726F6C00DDADFFFFBA2F00000000000000000000000000000000000000000000000000000000000000002143341208000000881600000E1100007856341207000000140100004100630063006F0075006E007400200028004100630063006F0075006E0074002900000000000000000014400000000000C070400000000000001440000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000F03F0000000000000000000000000000000000000000000000000000000000000000C4AB50670000000000000000846C51671C585167709FC107709FC107020000000200000000000000000000004084481300000000020000000000204100002041000020410000A040000070410000204100000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000E11000000000000050000000500000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A000000080000004100630063006F0075006E0074000000080000004100630063006F0075006E0074000000214334120800000088160000180C00007856341207000000140100004100630063006F0075006E0074004C006F006700200028004100630063006F0075006E007400290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000737859A300020080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A000000080000004100630063006F0075006E00740000000B0000004100630063006F0075006E0074004C006F006700000002000B00324E0000AA370000E4570000AA3700000000000002000000F0F0F00000000000000000000000000000000000010000000500000000000000244C000059380000680D00005801000037000000010000020000680D000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61150046004B005F004100630063006F0075006E0074004C006F0067005F004100630063006F0075006E0074002143341208000000881600000416000078563412070000001401000042006C006F0063006B002000280043007500730074006F006D006500720029000000FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEAE7BF4A300070080FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000416000000000000070000000700000002000000020000001C010000C80A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000000600000042006C006F0063006B000000214334120800000088160000FA1A000078563412070000001401000043007500730074006F006D00650072002000280043007500730074006F006D00650072002900000010000000220000001100000010000000270000001600000002000000300000002A00000002000000370000003100000010000000430000003900000010000000480000003E000000020000004F0000005000000002000000550000005C000000100000005B00000061000000020000006100000069000000020000006800000070000000100000006D00000075000000020000006D000000FDFFFFFF02000000710000007600000002000000770000007F000000020000008100000086000000100000008600000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000FA1A000000000000090000000900000002000000020000001C01000060090000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000000900000043007500730074006F006D0065007200000004000B00E02E0000AA1F0000E02E00008B2C0000580200008B2C000058020000A46A00000000000002000000F0F0F00000000000000000000000000000000000010000000A0000000000000007030000C72D0000960A00005801000031000000010000020000960A000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61110046004B005F0042006C006F0063006B005F0043007500730074006F006D006500720004000B00CC420000E02E0000CC4200008B2C0000A23000008B2C0000A2300000AA1F00000000000002000000F0F0F00000000000000000000000000000000000010000000C0000000000000051310000322A0000470C0000580100003F000000010000020000470C000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F0043007500730074006F006D00650072005F004100630063006F0075006E00740021433412080000008816000004160000785634120700000014010000440065007400610069006C002000280050006F007300740029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000416000000000000070000000700000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F0073007400000007000000440065007400610069006C0000002143341208000000881600009D09000078563412070000001401000044006900720065006300740069006F006E002000280050006F007300740029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000AA0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000A00000044006900720065006300740069006F006E00000002000B00DCBAFFFFA60E0000AEB4FFFFA60E00000000000002000000F0F0F000000000000000000000000000000000000100000015000000000000007DB2FFFF9F0C00007A0A000058010000310000000100000200007A0A000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F00440065007400610069006C005F0044006900720065006300740069006F006E00214334120800000088160000751D000078563412070000001401000045006D0070006C006F007900650065002000280045006D0070006C006F0079006500650029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000C3200000000000002D0100000C0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000751D0000000000000A0000000A00000002000000020000001C010000AA0A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000045006D0070006C006F0079006500650000000900000045006D0070006C006F00790065006500000002000B0070170000C6750000BE0D0000C67500000000000002000000F0F0F00000000000000000000000000000000000010000001800000000000000560D0000BF730000960A00005801000037000000010000020000960A000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61110046004B005F0042006C006F0063006B005F0045006D0070006C006F0079006500650004000B00CC420000EE3F0000CC42000049550000282300004955000028230000206700000000000002000000F0F0F00000000000000000000000000000000000010000001E000000000000004325000042530000470C00005801000036000000010000020000470C000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F0045006D0070006C006F007900650065005F004100630063006F0075006E00740005000B00701700004C680000881300004C68000088130000386300009C180000386300009C180000206700000000000002000000F0F0F000000000000000000000000000000000000100000020000000000000009C100000E7630000110D0000580100003D000000010000020000110D000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61140046004B005F0045006D0070006C006F007900650065005F0045006D0070006C006F00790065006500214334120800000088160000FA1A00007856341207000000140100004500720072006F0072004C006F00670020002800640062006F002900000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000FA1A000000000000090000000900000002000000020000001C010000600900000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000090000004500720072006F0072004C006F00670000002143341208000000FB170000180C000078563412070000001401000049006E00740065007200650073007400650064005F0050006F00730074002000280043007500730074006F006D00650072002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000FB170000180C000000000000030000000300000002000000020000001C0100008B0B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000001000000049006E00740065007200650073007400650064005F0050006F0073007400000002000B0064320000B004000064320000B0FBFFFF0000000002000000F0F0F000000000000000000000000000000000000100000024000000000000001333000084FFFFFFAC1000005801000032000000010000020000AC10000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611B0046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0043007500730074006F006D0065007200214334120800000088160000180C00007856341207000000140100005000650072006D0069007300730069006F006E00200028004100630063006F0075006E0074002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A000000080000004100630063006F0075006E00740000000B0000005000650072006D0069007300730069006F006E0000002143341208000000C6170000180C00007856341207000000140100005000650072006D0069007300730069006F006E005F0052006F006C006500200028004100630063006F0075006E00740029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000EC3B59A300010080F93D0D1F14BC6F009400201F00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000C6170000180C000000000000030000000300000002000000020000001C0100006D0B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A000000080000004100630063006F0075006E0074000000100000005000650072006D0069007300730069006F006E005F0052006F006C006500000002000B0058020000945C000058020000FE5200000000000002000000F0F0F0000000000000000000000000000000000001000000280000000000000007030000935600000211000058010000390000000100000200000211000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611D0046004B005F005000650072006D0069007300730069006F006E005F0052006F006C0065005F005000650072006D0069007300730069006F006E00214334120800000077170000180C0000785634120700000014010000500068006F006E0065004E0075006D006200650072002000280043007500730074006F006D006500720029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000077170000180C000000000000030000000300000002000000020000001C010000400B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000000C000000500068006F006E0065004E0075006D00620065007200000002000B00CA3D00002A1200007C4700002A1200000000000002000000F0F0F00000000000000000000000000000000000010000002B00000000000000EB3A0000D91200006F0F000058010000320000000100000200006F0F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61170046004B005F00500068006F006E0065004E0075006D006200650072005F0043007500730074006F006D00650072002143341208000000881600006127000078563412070000001401000050006F00730074002000280050006F00730074002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000009230000000000002D0100000D0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C003000000000000010000008816000061270000000000000E0000000C00000002000000020000001C010000600900000000000001000000391300004D0C000000000000040000000400000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000500000050006F0073007400000004000B004ACDFFFFEE4D0000FED2FFFFEE4D0000FED2FFFF74F5FFFF4227000074F5FFFF0000000002000000F0F0F00000000000000000000000000000000000010000002E0000000000000000E5FFFF23F6FFFFDA0D00005801000041000000010000020000DA0D000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61170046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0050006F0073007400214334120800000088160000930E000078563412070000001401000050006F00730074005F0049006D006100670065002000280050006F00730074002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000B00000050006F00730074005F0049006D00610067006500000002000B00E4C1FFFFF03C0000E4C1FFFF7D3300000000000002000000F0F0F0000000000000000000000000000000000001000000310000000000000093C2FFFF8A3700007D0B000058010000320000000100000200007D0B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61120046004B005F0050006F00730074005F0049006D006100670065005F0050006F00730074002143341208000000881600000416000078563412070000001401000050006F00730074005F005200650070006F00720074002000280050006F0073007400290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000416000000000000070000000700000002000000020000001C010000C80A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000C00000050006F00730074005F005200650070006F0072007400000004000B00662100002067000066210000495500001EE2FFFF495500001EE2FFFFF45200000000000002000000F0F0F00000000000000000000000000000000000010000003400000000000000320A000042530000A50E00005801000032000000010000020000A50E000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61170046004B005F0050006F00730074005F005200650070006F00720074005F0045006D0070006C006F0079006500650004000B004ACDFFFF7251000066D4FFFF7251000066D4FFFF12480000FCD6FFFF124800000000000002000000F0F0F00000000000000000000000000000000000010000003600000000000000E3C7FFFFFE4C0000D40B00005801000032000000010000020000D40B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F0050006F00730074005F005200650070006F00720074005F0050006F00730074002143341208000000881600008913000078563412070000001401000050006F00730074005F005300740061007400750073002000280050006F007300740029000000000005000000C4FFFFFF00000000A7000000D4000000010000000000000007000000C4FFFFFF000000008D0000001E010000020000000300000005000000C8FFFFFF000000006900000024010000040000000300000005000000C0FFFFFF000000006001000069010000040000000300000005000000C0FFFFFF000000001C0000008D010000000000000300000005000000CCFFFFFF0000000022000000C2010000050000000300000005000000BCFFFFFF000000001C000000C501000006000000030000000500000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000AB170000000000002D010000080000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600008913000000000000060000000600000002000000020000001C010000AA0A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000C00000050006F00730074005F00530074006100740075007300000004000B00C2B6FFFFDC500000F2AEFFFFDC500000F2AEFFFF685B0000A6ADFFFF685B00000000000002000000F0F0F00000000000000000000000000000000000010000003900000000000000A9A2FFFFD95000009A0B000058010000320000000100000200009A0B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F0050006F00730074005F005300740061007400750073005F0050006F00730074002143341208000000881600000E110000785634120700000014010000500072006F006A006500630074002000280050006F007300740029000000693F0000803F0000803FD7D6563FDCDB5B3FEAE9693F0000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004A010000A40100002C010000EC0400007602000077010000760200001B0300001C0200000000000001000000881600000E11000000000000050000000500000002000000020000001C0100005F0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F0073007400000008000000500072006F006A00650063007400000004000B00E4C1FFFF80BB0000E4C1FFFF0BB90000B8C0FFFF0BB90000B8C0FFFF516400000000000002000000F0F0F00000000000000000000000000000000000010000003C0000000000000067C1FFFF708F0000E60800005801000032000000010000020000E608000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D610F0046004B005F0050006F00730074005F00500072006F006A00650063007400214334120800000088160000180C0000785634120700000014010000500072006F006A006500630074005F0049006D006100670065002000280050006F007300740029000000008020436F72706F726174696F6E31153013060355040B130C4D6963726F736F6674204954311E301C060355040313154D697314C6A36F1F0080495420544C532043412034301E170D3138303132333233323934365A170D3230303132333233323934365A30383136300C14FDA304200080736F7574686561737461736961312D612E636F6E74726F6C2E64617461626173652E77696E646F77732E6E65743082010514F4A30921008086F70D01010105000382010F003082010A0282010100D51BA79A000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004A010000A40100002C010000EC0400007602000077010000760200001B0300001C020000000000000100000088160000180C000000000000030000000300000002000000020000001C0100005F0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000E000000500072006F006A006500630074005F0049006D00610067006500000002000B00C2B6FFFFB4C30000A6ADFFFFB4C300000000000002000000F0F0F00000000000000000000000000000000000010000003F000000000000004CABFFFFADC100006B0E000058010000380000000100000200006B0E000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61180046004B005F00500072006F006A006500630074005F0049006D006100670065005F00500072006F006A006500630074002143341208000000881600000E110000785634120700000014010000500072006F006D006F00740069006F006E002000280043007500730074006F006D006500720029000000D646101419A2BA2400804B96F8C15D89770F43CB786576CFADC7D4959F66CC4CAFB69D3B6728AC0DBBD662C2175B20A04C2CFFF35AC4404FB1C6291410A22D25008032DFFEF0136FEA83987EAEFAD4A38B84DF0A228CA3676DBB89E968ED144FD7DB2F1B41CFE542B1B4BAA7C349D5D3A11D221417A2BA2600802434FE650834FE65F833FE650000000000000000000000000000000000000000000000000000000000000000000000003B140EA2072700801D0603551D0E04160414239D843EFC973502000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000E11000000000000050000000500000002000000020000001C010000AA0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000000A000000500072006F006D006F00740069006F006E00000004000B00422700002A120000721F00002A120000721F00009E070000641C00009E0700000000000002000000F0F0F0000000000000000000000000000000000001000000420000000000000079110000F40F00004A0D000058010000320000000100000200004A0D000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61150046004B005F00500072006F006D006F00740069006F006E005F0043007500730074006F006D00650072002143341208000000D7190000180C0000785634120700000014010000500072006F006D006F00740069006F006E005F00440065007400610069006C002000280043007500730074006F006D006500720029000000EE777E5FDFB0CCFA47A3003881167C3F308FFC04CE48FA14139F0D1A5D14ACA33019008031C7B2A5DBDCAEF8C6B57C07B199803BFEC7061051ECBC1D8C415F53AFBAB11201A351FE0AC9033E1D69D2FF772CFC3C5614A3A34D030080DDADE34E23FBEE41AE19E0ECFEAD03B117A0D1C16A452EC338727A177A66A99AF59D49091F4AA35C9FED9F21E00000006F14DAA3001B008000000000000000000000000000000000000000000000000004000000F00D0000EC0D000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000D7190000180C000000000000030000000300000002000000020000001C010000990C0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D0065007200000011000000500072006F006D006F00740069006F006E005F00440065007400610069006C00000004000B004ACDFFFFB04F0000B2D3FFFFB04F0000B2D3FFFFA41F00001A040000A41F00000000000002000000F0F0F0000000000000000000000000000000000001000000450000000000000061D4FFFF59230000320E00005801000032000000010000020000320E000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61180046004B005F00500072006F006D006F00740069006F006E005F00440065007400610069006C005F0050006F007300740002000B00FE100000E20F0000FE100000C81900000000000002000000F0F0F0000000000000000000000000000000000001000000470000000000000013FFFFFFB91400003C11000058010000390000000100000200003C11000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611D0046004B005F00500072006F006D006F00740069006F006E005F00440065007400610069006C005F00500072006F006D006F00740069006F006E00214334120800000088160000180C00007856341207000000140100005200650061006C0045007300740061007400650054007900700065002000280050006F007300740029000000DCDB5B3FEAE9693F0000803F463044304206092B06010401921767A23036008006082B060105050702011627687474703A2F2F7777772E6D6963726F736F66742E636F6D2F706B692F6D73636F72702FAB179EA227370080060104018237150A041A3018300A06082B06010505070302300A06082B06010505070301300D06092A864886F70D0101A41795A2823800802A18DFF4B7E657C7D53D987FF2B9F967379C1BC52F2C4856A76F853FA4494B3E3BDA20A8CC5419C76EBB2A0FAC3E3288BD17000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004A010000A40100002C010000EC0400007602000077010000760200001B0300001C020000000000000100000088160000180C000000000000030000000300000002000000020000001C0100005F0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000F0000005200650061006C004500730074006100740065005400790070006500000004000B001EE2FFFF80BB00001EE2FFFF57B800007AC2FFFF57B800007AC2FFFF516400000000000002000000F0F0F00000000000000000000000000000000000010000004D0000000000000029C3FFFF4C9E0000680D00005801000032000000010000020000680D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61160046004B005F0050006F00730074005F005200650061006C0045007300740061006C0065005400790070006500214334120800000088160000180C000078563412070000001401000052006F006C006500200028004100630063006F0075006E0074002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A000000080000004100630063006F0075006E00740000000500000052006F006C006500000002000B00EE020000503D0000EE020000E64600000000000002000000F0F0F0000000000000000000000000000000000001000000500000000000000081F4FFFFA4410000BE0D00005801000035000000010000020000BE0D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61170046004B005F005000650072006D0069007300730069006F006E005F0052006F006C0065005F0052006F006C006500214334120800000088160000180C000078563412070000001401000052006F006C0065005F004100630063006F0075006E007400200028004100630063006F0075006E007400290000005B3FEAE9693F0000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000AA0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A000000080000004100630063006F0075006E00740000000D00000052006F006C0065005F004100630063006F0075006E007400000002000B00AA370000AA3700008E2E0000AA3700000000000002000000F0F0F00000000000000000000000000000000000010000005300000000000000E82B0000A3350000880E00005801000033000000010000020000880E000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61170046004B005F0052006F006C0065005F004100630063006F0075006E0074005F004100630063006F0075006E00740002000B00540E00001437000006180000143700000000000002000000F0F0F00000000000000000000000000000000000010000005500000000000000C80C0000C3370000810C00005801000037000000010000020000810C000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61140046004B005F0052006F006C0065005F004100630063006F0075006E0074005F0052006F006C006500214334120800000088160000180C00007856341207000000140100005300740061007400750073002000280050006F007300740029000000EAE9693F0000803F0000803FD7D6563FDCDB5B3FEAE9693F0000803FA00302010202100B6AB3B03EB1A9F6C460926AA8CDFEB3300D06092A7E17CBA20D4200800500305A310B300906035504061302494531123010060355040A130942616C74696D6F726531133011060355040B130A7717C2A2724300807374312230200603550403131942616C74696D6F7265204379626572547275737420526F6F74301E170D3136303532307017F9A2334400800D3234303532303132353233385A30818B310B300906035504061302555331133011000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000AA0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F0073007400000007000000530074006100740075007300000002000B0040A2FFFF7248000040A2FFFF725100000000000002000000F0F0F00000000000000000000000000000000000010000005800000000000000D694FFFF874C0000BB0C00005801000035000000010000020000BB0C000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61150046004B005F0050006F00730074005F005300740061007400750073005F00530074006100740075007300214334120800000088160000180C000078563412070000001401000054007900700065002000280043007500730074006F006D006500720029000000F887391398323513582A3513182D3513F833351398273513F82835133831351358F05B13F8F95B13E831351348283513F01F7013701A7013201B701350217013301D7013682B7113182C711308357113C82C7113B82A7113782D7113282E711398317113B8523013C8813913B0AE651320B2651310A56513F0B66513A0B7651370A66513E075360B2073360B701F3413601D341318F35B1398ED5B13C8C7A0006057250BC058250B5055250B50BD420BD0B26513C0B06513A0AC651310B0651340B66513B0B9651328AF131328F5000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000AA0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D00650072000000050000005400790070006500000004000B00AA820000E02E0000AA8200006F2A0000E83500006F2A0000E8350000AA1F00000000000002000000F0F0F00000000000000000000000000000000000010000005B00000000000000CE59000068280000960A00005801000032000000010000020000960A000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61100046004B005F0043007500730074006F006D00650072005F0054007900700065002143341208000000881600009D09000078563412070000001401000054007900700065002000280050006F00730074002900000048E7741328E37413F887391398323513582A3513182D3513F833351398273513F82835133831351358F05B13F8F95B13E831351348283513F01F7013701A7013201B701350217013301D7013682B7113182C711308357113C82C7113B82A7113782D7113282E711398317113B8523013C8813913B0AE651320B2651310A56513F0B66513A0B7651370A66513E075360B2073360B701F3413601D341318F35B1398ED5B13C8C7A0006057250BC058250B5055250B50BD420BD0B26513C0B06513A0AC651310B0651340B66513B0B9651328AF131328F5000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004A010000A40100002C010000EC0400007602000077010000760200001B0300001C0200000000000001000000881600009D09000000000000020000000200000002000000020000001C0100005F0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F00730074000000050000005400790070006500000004000B00FCD6FFFFDAAC000066D4FFFFDAAC000066D4FFFF345300004ACDFFFF345300000000000002000000F0F0F00000000000000000000000000000000000010000005E0000000000000015D5FFFFBD7B0000230A00005801000032000000010000020000230A000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61100046004B005F0050006F00730074005F0050006F0073007400540079007000650004000B00D4B3FFFF26210000D4B3FFFF0B2F000058B7FFFF0B2F000058B7FFFFF03C00000000000002000000F0F0F00000000000000000000000000000000000010000006100000000000000DDADFFFFBA2F00001C08000058010000350000000100000200001C08000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D610E0046004B005F0050006F00730074005F00440065007400610069006C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000FEFFFFFFFEFFFFFF0400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F0000002000000021000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F573900000200E089468FFEFED401020200001048450000000000000000000000000000000000220200004400610074006100200053006F0075007200630065003D00750074006500730068006100720065002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074003B0049006E0069007400690061006C00200043006100740061006C006F0067003D005200650061006C00450073007400610074006500530079007300740065006D003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D007800750061006E0074006800750079003B004D0075006C007400690070006C006500410063007400690076000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000040000000064700000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000020000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000003000000840700000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000002200000012000000000000000C000000D2D6FFFF0EE9FFFF0100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000400000004000000000000004400000001FFFFFF010000004100630063006F0075006E007400000046004B005F004100630063006F0075006E0074004C006F0067005F004100630063006F0075006E00740000000000000000000000C40200000000050000000500000004000000080000000137C8129037C8120000000000000000AD070000000000060000000600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000080000000800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400300030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000900000009000000000000003E000000014F3B670100000043007500730074006F006D0065007200000046004B005F0042006C006F0063006B005F0043007500730074006F006D006500720000000000000000000000C402000000000A0000000A00000009000000080000000136C812D036C8120000000000000000AD0700000000000B0000000B000000000000004200000001FFFFFF0100000043007500730074006F006D0065007200000046004B005F0043007500730074006F006D00650072005F004100630063006F0075006E00740000000000000000000000C402000000000C0000000C0000000B00000008000000013CC812D03CC8120000000000000000AD070000000000120000001200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000130000001300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001400000014000000000000003A000000014F3B670100000050006F0073007400000046004B005F00440065007400610069006C005F0044006900720065006300740069006F006E0000000000000000000000C402000000001500000015000000140000000800000001161523581615230000000000000000AD070000000000160000001600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001700000017000000000000003E000000014F3B670100000043007500730074006F006D0065007200000046004B005F0042006C006F0063006B005F0045006D0070006C006F0079006500650000000000000000000000C402000000001800000018000000170000000800000001111523D81115230000000000000000AD0700000000001D0000001D000000000000004200000001FFFFFF0100000045006D0070006C006F00790065006500000046004B005F0045006D0070006C006F007900650065005F004100630063006F0075006E00740000000000000000000000C402000000001E0000001E0000001D0000000800000001121523981215230000000000000000AD0700000000001F0000001F000000000000004400000001FFFFFF0100000045006D0070006C006F00790065006500000046004B005F0045006D0070006C006F007900650065005F0045006D0070006C006F0079006500650000000000000000000000C4020000000020000000200000001F00000008000000010C1523580C15230000000000000000AD070000000000210000002100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400300030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000220000002200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003900350035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000023000000230000000000000052000000014E2F230100000043007500730074006F006D0065007200000046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0043007500730074006F006D006500720000000000000000000000C4020000000024000000240000002300000008000000010B1523180B15230000000000000000AD070000000000250000002500000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000260000002600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003900320035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002700000027000000000000005400000001000000010000004100630063006F0075006E007400000046004B005F005000650072006D0069007300730069006F006E005F0052006F006C0065005F005000650072006D0069007300730069006F006E0000000000000000000000C4020000000028000000280000002700000008000000010A1523580A15230000000000000000AD070000000000290000002900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800380030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002A0000002A000000000000004A00000001332E670100000043007500730074006F006D0065007200000046004B005F00500068006F006E0065004E0075006D006200650072005F0043007500730074006F006D006500720000000000000000000000C402000000002B0000002B0000002A00000008000000010A1523180A15230000000000000000AD0700000000002C0000002C00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400300030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002D0000002D000000000000004A00000001332E670100000043007500730074006F006D0065007200000046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0050006F007300740000000000000000000000C402000000002E0000002E0000002D00000008000000010C1523180C15230000000000000000AD0700000000002F0000002F00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000030000000300000000000000038000000010000000100000050006F0073007400000046004B005F0050006F00730074005F0049006D006100670065005F0050006F007300740000000000000000000000C402000000003100000031000000300000000800000001091523D80915230000000000000000AD070000000000320000003200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003300000033000000000000004200000001FFFFFF0100000050006F0073007400000046004B005F0050006F00730074005F005200650070006F00720074005F0045006D0070006C006F0079006500650000000000000000000000C402000000003400000034000000330000000800000001091523180915230000000000000000AD0700000000003500000035000000000000003A000000014F3B670100000050006F0073007400000046004B005F0050006F00730074005F005200650070006F00720074005F0050006F007300740000000000000000000000C4020000000036000000360000003500000008000000010E1523580E15230000000000000000AD070000000000370000003700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003800000038000000000000003A000000014F3B670100000050006F0073007400000046004B005F0050006F00730074005F005300740061007400750073005F0050006F007300740000000000000000000000C402000000003900000039000000380000000800000001081523D80815230000000000000000AD0700000000003A0000003A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003600350035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003B0000003B0000000000000032000000019EBE120100000050006F0073007400000046004B005F0050006F00730074005F00500072006F006A0065006300740000000000000000000000C402000000003C0000003C0000003B00000008000000010A1523D80A15230000000000000000AD0700000000003D0000003D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003600350035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003E0000003E000000000000004400000001FFFFFF0100000050006F0073007400000046004B005F00500072006F006A006500630074005F0049006D006100670065005F00500072006F006A0065006300740000000000000000000000C402000000003F0000003F0000003E0000000800000001081523580815230000000000000000AD070000000000400000004000000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000004100000041000000000000004600000001FFFFFF0100000043007500730074006F006D0065007200000046004B005F00500072006F006D006F00740069006F006E005F0043007500730074006F006D006500720000000000000000000000C4020000000042000000420000004100000008000000010E1523180E15230000000000000000AD070000000000430000004300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003200320035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000004400000044000000000000004C00000001332E670100000043007500730074006F006D0065007200000046004B005F00500072006F006D006F00740069006F006E005F00440065007400610069006C005F0050006F007300740000000000000000000000C402000000004500000045000000440000000800000001091523580915230000000000000000AD0700000000004600000046000000000000005600000001FFFFFF0100000043007500730074006F006D0065007200000046004B005F00500072006F006D006F00740069006F006E005F00440065007400610069006C005F00500072006F006D006F00740069006F006E0000000000000000000000C402000000004700000047000000460000000800000001081523180815230000000000000000AD0700000000004B0000004B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003600350035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000004C0000004C00000000000000400000000100000C0100000050006F0073007400000046004B005F0050006F00730074005F005200650061006C0045007300740061006C006500540079007000650000000000000000000000C402000000004D0000004D0000004C00000008000000010C1523D80C15230000000000000000AD0700000000004E0000004E00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000004F0000004F000000000000004800000001FFFFFF010000004100630063006F0075006E007400000046004B005F005000650072006D0069007300730069006F006E005F0052006F006C0065005F0052006F006C00650000000000000000000000C4020000000050000000500000004F0000000800000001081523980815230000000000000000AD070000000000510000005100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000005200000052000000000000004800000001FFFFFF010000004100630063006F0075006E007400000046004B005F0052006F006C0065005F004100630063006F0075006E0074005F004100630063006F0075006E00740000000000000000000000C4020000000053000000530000005200000008000000010C1523980C15230000000000000000AD0700000000005400000054000000000000004200000001FFFFFF010000004100630063006F0075006E007400000046004B005F0052006F006C0065005F004100630063006F0075006E0074005F0052006F006C00650000000000000000000000C4020000000055000000550000005400000008000000010D1523D80D15230000000000000000AD070000000000560000005600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000005700000057000000000000003E000000014F3B670100000050006F0073007400000046004B005F0050006F00730074005F005300740061007400750073005F0053007400610074007500730000000000000000000000C4020000000058000000580000005700000008000000010B1523580B15230000000000000000AD070000000000590000005900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000005A0000005A000000000000003C000000010074000100000043007500730074006F006D0065007200000046004B005F0043007500730074006F006D00650072005F00540079007000650000000000000000000000C402000000005B0000005B0000005A0000000800000001071523D80715230000000000000000AD0700000000005C0000005C00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003600350035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000005D0000005D0000000000000034000000010000000100000050006F0073007400000046004B005F0050006F00730074005F0050006F0073007400540079007000650000000000000000000000C402000000005E0000005E0000005D00000008000000010D1523580D15230000000000000000AD07000000000060000000600000000000000030000000010069000100000050006F0073007400000046004B005F0050006F00730074005F00440065007400610069006C0000000000000000000000C402000000006100000061000000600000000800000001191523581915230000000000000000AD0F00000100008C000000040000000200000003000000670000005E0000000B0000000200000008000000240000001F0000001D00000002000000160000002500000026000000520000000200000051000000660000005F000000090000000800000006000000190000002400000023000000080000002200000024000000250000002A00000008000000290000007700000060000000410000000800000040000000760000006700000060000000120000002C00000049000000000000001400000013000000120000004A000000550000001700000016000000060000007A0000006F0000001F00000016000000160000004C00000002000000330000001600000032000000200000002500000027000000250000002600000024000000270000002D0000002C000000220000008300000062000000300000002C0000002F0000002400000025000000350000002C000000320000008F0000006E000000380000002C000000370000008C0000006B000000440000002C0000004300000089000000680000003B0000003A0000002C00000024000000210000003E0000003A0000003D000000640000005D000000460000004000000043000000250000002A0000004C0000004B0000002C00000024000000270000004F0000004E000000260000002500000028000000540000004E000000510000005D0000005C00000057000000560000003700000025000000240000005A000000590000000800000024000000310000005D0000005C0000002C000000580000009500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F0022000000008005000E0000006400670072005200450053000000000226000A000000540079007000650000000A00000050006F00730074000000000226000A000000540079007000650000001200000043007500730074006F006D00650072000000000226000E00000053007400610074007500730000000A00000050006F00730074000000000226001A00000052006F006C0065005F004100630063006F0075006E0074000000100000004100630063006F0075006E0074000000000226000A00000052006F006C0065000000100000004100630063006F0075006E0074000000000226001E0000005200650061006C00450073007400610074006500540079007000650000000A00000050006F007300740000000002260022000000500072006F006D006F00740069006F006E005F00440065007400610069006C0000001200000043007500730074006F006D006500720000000002260014000000500072006F006D006F00740069006F006E0000001200000043007500730074006F006D00650072000000000226001C000000500072006F006A006500630074005F0049006D0061006700650000000A00000050006F007300740000000002260010000000500072006F006A0065006300740000000A00000050006F00730074000000000226001800000050006F00730074005F0053007400610074007500730000000A00000050006F00730074000000000226001800000050006F00730074005F005200650070006F007200740000000A00000050006F00730074000000000226001600000050006F00730074005F0049006D0061006700650000000A00000050006F00730074000000000226000A00000050006F007300740000000A00000050006F007300740000000002260018000000500068006F006E0065004E0075006D0062006500720000001200000043007500730074006F006D0065007200000000022600200000005000650072006D0069007300730069006F006E005F0052006F006C0065000000100000004100630063006F0075006E007400000000022600160000005000650072006D0069007300730069006F006E000000100000004100630063006F0075006E0074000000000226002000000049006E00740065007200650073007400650064005F0050006F007300740000001200000043007500730074006F006D0065007200000000022600120000004500720072006F0072004C006F006700000008000000640062006F000000000226001200000045006D0070006C006F0079006500650000001200000045006D0070006C006F007900650065000000000226001400000044006900720065006300740069006F006E0000000A00000050006F00730074000000000226000E000000440065007400610069006C0000000A00000050006F00730074000000000226001200000043007500730074006F006D006500720000001200000043007500730074006F006D00650072000000000226000C00000042006C006F0063006B0000001200000043007500730074006F006D0065007200000000022600160000004100630063006F0075006E0074004C006F0067000000100000004100630063006F0075006E007400000000022400100000004100630063006F0075006E0074000000100000004100630063006F0075006E007400000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_0', 1, 2, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF19000000FEFFFFFF0400000005000000060000000700000027000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000FEFFFFFFFEFFFFFF1B0000001C0000001D0000001E0000001F00000020000000210000002200000023000000240000002500000026000000FEFFFFFF2800000029000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000C0253D9FFEFED40103000000400F0000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000001E090000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000080000009320000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000250000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F0000002000000021000000220000002300000024000000FEFFFFFF26000000FEFFFFFFFEFFFFFF290000002A0000002B0000002C0000002D0000002E0000002F000000300000003100000032000000330000003400000035000000360000003700000038000000390000003A0000003B000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000430000A1E100C05000080180000000F00FFFF18000000007D0000DA7C0000A04400001A9D00002784000000000000F3110000DE805B10F195D011B0A000AA00BDCB5C0000080030000000000200000300000038002B00000009000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002C0043200000000000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002C0043200000000000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C18000000280800000098010000004400A50900000700008001000000BC020000008000001B0000805363684772696400C0120000AE1500005F5F45464D6967726174696F6E73486973746F7279202864626F290000004000A50900000700008002000000B20200000080000016000080536368477269640000000000004B00004173704E6574526F6C65436C61696D73202864626F29000000003C00A50900000700008003000000A80200000080000011000080536368477269640000000000FA3200004173704E6574526F6C6573202864626F2900000000009C00A50900000700008004000000520000000180000074000080436F6E74726F6C008B090000D63E000052656C6174696F6E736869702027464B5F4173704E6574526F6C65436C61696D735F4173704E6574526F6C65735F526F6C654964202864626F2927206265747765656E20274173704E6574526F6C6573202864626F292720616E6420274173704E6574526F6C65436C61696D73202864626F292700002800B50100000700008005000000310000007F00000002800000436F6E74726F6C00D10B00007645000000004000A50900000700008006000000B202000000800000160000805363684772696400DE3F0000326400004173704E657455736572436C61696D73202864626F29000000004000A50900000700008007000000B202000000800000160000805363684772696400825F0000B23E00004173704E6574557365724C6F67696E73202864626F29000000004000A50900000700008008000000B002000000800000150000805363684772696400A41F0000523500004173704E657455736572526F6C6573202864626F290A000000009C00A50900000700008009000000520000000180000072000080436F6E74726F6C005C1500006B38000052656C6174696F6E736869702027464B5F4173704E657455736572526F6C65735F4173704E6574526F6C65735F526F6C654964202864626F2927206265747765656E20274173704E6574526F6C6573202864626F292720616E6420274173704E657455736572526F6C6573202864626F2927000000002800B5010000070000800A000000310000007D00000002800000436F6E74726F6C00140E0000B13A000000003C00A5090000070000800B000000A802000000800000110000805363684772696413DE3F0000383100004173704E65745573657273202864626F2964626F00009C00A5090000070000800C000000520000000180000074000080436F6E74726F6C00694900005D58000052656C6174696F6E736869702027464B5F4173704E657455736572436C61696D735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E657455736572436C61696D73202864626F292700002800B5010000070000800D000000310000007F00000002800000436F6E74726F6C008C320000C65F000000009C00A5090000070000800E000000520000000180000074000080436F6E74726F6C003A550000B944000052656C6174696F6E736869702027464B5F4173704E6574557365724C6F67696E735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E6574557365724C6F67696E73202864626F292700002800B5010000070000800F000000310000007F00000002800000436F6E74726F6C005E4F00004944000000009C00A50900000700008010000000620000000180000072000080436F6E74726F6C00003500008738000052656C6174696F6E736869702027464B5F4173704E657455736572526F6C65735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E657455736572526F6C6573202864626F2927000000002800B50100000700008011000000310000007D00000002800000436F6E74726F6C000E200000D143000000004000A50900000700008012000000B202000000800000160000805363684772696400DE3F0000321900004173704E657455736572546F6B656E73202864626F29000000009C00A50900000700008013000000520000000180000074000080436F6E74726F6C00694900000A25000052656C6174696F6E736869702027464B5F4173704E657455736572546F6B656E735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E657455736572546F6B656E73202864626F292700002800B50100000700008014000000310000007F00000002800000436F6E74726F6C00AF4B0000D22B000000003C00A50900000700008015000000AC020000008000001300008053636847726964000618000028230000437573746F6D65722028437573746F6D6572290000003C00A50900000700008016000000AC02000000800000130000805363684772696400565E00008A1B0000456D706C6F7965652028456D706C6F796565296200009000A509000007000080170000006A0000000180000066000080436F6E74726F6C13425900007616000052656C6174696F6E736869702027464B5F456D706C6F7965655F456D706C6F7965652028456D706C6F7965652927206265747765656E2027456D706C6F7965652028456D706C6F796565292720616E642027456D706C6F7965652028456D706C6F7965652927000000002800B50100000700008018000000310000005B00000002800000436F6E74726F6C009257000051180000000000000000000000000000000000000000000000000000000000000000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC000000000000000000000000000000000000000000000000000000000000000000000000000000000000002143341208000000E91800009D0900007856341207000000140100005F005F00450046004D006900670072006100740069006F006E00730048006900730074006F007200790020002800640062006F002900000000003440000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270789B0513789B0513020000000200000000000000000000007841031300000000020000000000803F0000803F0000803F0000A841000098C10000803F00000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000E91800009D09000000000000020000000200000002000000020000001C0100004E0C00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000160000005F005F00450046004D006900670072006100740069006F006E00730048006900730074006F00720079000000214334120800000088160000930E00007856341207000000140100004100730070004E006500740052006F006C00650043006C00610069006D00730020002800640062006F00290000000000B06BC508B06BC508306AC508306AC5083C6AC5083C6AC508486AC508486AC508546AC508546AC508606AC508606AC5086C6AC5086C6AC508786AC508786AC508846AC508846AC508906AC508906AC5089C6AC5089C6AC508A86AC508A86AC508B46AC508B46AC508C06AC508C06AC508CC6AC508CC6AC508D86AC508D86AC508E46AC508E46AC508F06AC508F06AC508FC6AC508FC6AC508086BC508086BC508146BC508146BC508206BC508206BC5082C6BC5082C6BC508386BC508386B000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E006500740052006F006C00650043006C00610069006D0073000000214334120800000088160000930E00007856341207000000140100004100730070004E006500740052006F006C006500730020002800640062006F00290000000000803FD0CF4F3FD7D6563FE6E5653F0000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C0000004100730070004E006500740052006F006C0065007300000002000B00220B00008D410000220B0000004B00000000000002000000F0F0F00000000000000000000000000000000000010000000500000000000000D10B0000764500006E17000058010000300000000100000200006E17000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E006500740052006F006C00650043006C00610069006D0073005F004100730070004E006500740052006F006C00650073005F0052006F006C00650049006400214334120800000088160000930E00007856341207000000140100004100730070004E0065007400550073006500720043006C00610069006D00730020002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E0065007400550073006500720043006C00610069006D0073000000214334120800000088160000930E00007856341207000000140100004100730070004E006500740055007300650072004C006F00670069006E00730020002800640062006F0029000000743FC0BF3F3F0000803F0000803FFEFD7D3FF5F4743FC0BF3F3F0000803F0000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A27090A9051390A90513020000000200000000000000000000007841031300000000020000000000803F0000803F0000803F0000A841000098C10000803F00000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E006500740055007300650072004C006F00670069006E00730000002143341208000000881600009D0900007856341207000000140100004100730070004E0065007400550073006500720052006F006C006500730020002800640062006F00290000000000000080004700000000000000000001010100060000000000000000000000000000018000060000000000000000000101010047000000000000000000000000000001800047000000000000000000010101004700000000000000000000000000000280004700000000000000000001010100060000000000000000000000000000058000060000000000000000000101010006000000000000000000000000000007800006000000000000000000010101000600000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000100000004100730070004E0065007400550073006500720052006F006C0065007300000002000B0088160000023A0000A41F0000023A00000000000002000000F0F0F00000000000000000000000000000000000010000000A00000000000000140E0000B13A000018170000580100003C0000000100000200001817000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61250046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E006500740052006F006C00650073005F0052006F006C00650049006400214334120800000088160000DC2900007856341207000000140100004100730070004E00650074005500730065007200730020002800640062006F00290000000300000005000000F0FFFFFF0000000010010000A5010000040000000000000007000000F0FFFFFF00000000A9010000AC020000030000000300000005000000F0FFFFFF0000000022020000BE020000050000000000000007000000F0FFFFFF0000000016000000CD020000000000000000000006000000F0FFFFFF00000000C1020000CD020000030000000300000005000000F0FFFFFF00000000E6020000F3020000010000000000000006000000F0FFFFFF00000000F0000000F502000006000000030000000500000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000009230000000000002D0100000D0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000DC290000000000000F0000000C00000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C0000004100730070004E006500740055007300650072007300000002000B00004B0000145B0000004B0000326400000000000002000000F0F0F00000000000000000000000000000000000010000000D000000000000008C320000C65F0000C5170000580100003C000000010000020000C517000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E0065007400550073006500720043006C00610069006D0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640002000B006656000050460000825F0000504600000000000002000000F0F0F00000000000000000000000000000000000010000000F000000000000005E4F000049440000C51700005801000030000000010000020000C517000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E006500740055007300650072004C006F00670069006E0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640004000B00DE3F0000504600000E380000504600000E380000023A00002C360000023A00000000000002000000F0F0F000000000000000000000000000000000000100000011000000000000000E200000D14300005117000058010000320000000100000200005117000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61250046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E0065007400550073006500720073005F00550073006500720049006400214334120800000088160000930E00007856341207000000140100004100730070004E0065007400550073006500720054006F006B0065006E00730020002800640062006F00290000005B3FEAE9693F0000803F00003440000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270D8AA0513D8AA0513020000000200000000000000000000007841031300000000020000000000803F0000803F0000803F0000A841000098C10000803F00000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E0065007400550073006500720054006F006B0065006E007300000002000B00004B000038310000004B0000C52700000000000002000000F0F0F00000000000000000000000000000000000010000001400000000000000AF4B0000D22B00003918000058010000320000000100000200003918000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E0065007400550073006500720054006F006B0065006E0073005F004100730070004E0065007400550073006500720073005F00550073006500720049006400214334120800000088160000FA1A000078563412070000001401000043007500730074006F006D00650072002000280043007500730074006F006D006500720029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000FA1A000000000000090000000900000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000000900000043007500730074006F006D00650072000000214334120800000088160000751D000078563412070000001401000045006D0070006C006F007900650065002000280045006D0070006C006F0079006500650029000000004070400000000000C070400000000000001440000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A27028A3051328A3051302000000020000000000000000000000A007DA120000000002000000000020410000824300002041008084430000A0400000824300000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000C3200000000000002D0100000C0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000751D0000000000000A0000000A00000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000045006D0070006C006F0079006500650000000900000045006D0070006C006F00790065006500000005000B00565E0000B61C00006E5A0000B61C00006E5A0000A2170000825F0000A2170000825F00008A1B00000000000002000000F0F0F000000000000000000000000000000000000100000018000000000000009257000051180000110D0000580100003D000000010000020000110D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61140046004B005F0045006D0070006C006F007900650065005F0045006D0070006C006F0079006500650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001A000000F51900000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000270000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000028000000E20400000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000003C00000012000000000000000C00000000000000F31100000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003100350030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000400000004000000000000005E0000000101516801000000640062006F00000046004B005F004100730070004E006500740052006F006C00650043006C00610069006D0073005F004100730070004E006500740052006F006C00650073005F0052006F006C0065004900640000000000000000000000C402000000000500000005000000040000000800000001940113F89401130000000000000000AD0F0000010000060000000600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000070000000700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000080000000800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000900000009000000000000005C00000001FFFFFF01000000640062006F00000046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E006500740052006F006C00650073005F0052006F006C0065004900640000000000000000000000C402000000000A0000000A0000000900000008000000016ED912286ED9120000000000000000AD0F00000100000B0000000B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000C0000000C000000000000005E000000014F3B6701000000640062006F00000046004B005F004100730070004E0065007400550073006500720043006C00610069006D0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C402000000000D0000000D0000000C0000000800000001980113789801130000000000000000AD0F00000100000E0000000E000000000000005E00000001FFFFFF01000000640062006F00000046004B005F004100730070004E006500740055007300650072004C006F00670069006E0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C402000000000F0000000F0000000E0000000800000001990113F89901130000000000000000AD0F00000100001000000010000000000000005C0000000100000001000000640062006F00000046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C4020000000011000000110000001000000008000000019B0113F89B01130000000000000000AD0F0000010000120000001200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001300000013000000000000005E000000014F3B6701000000640062006F00000046004B005F004100730070004E0065007400550073006500720054006F006B0065006E0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C402000000001400000014000000130000000800000001A2011338A201130000000000000000AD0F0000010000150000001500000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000160000001600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000017000000170000000000000044000000011013710100000045006D0070006C006F00790065006500000046004B005F0045006D0070006C006F007900650065005F0045006D0070006C006F0079006500650000000000000000000000C402000000001800000018000000170000000800000001F0AB1218F0AB120000000000000000AD0F00000100002300000009000000030000000800000061000000580000000400000003000000020000002500000024000000130000000B000000120000002400000025000000100000000B0000000800000090000000590000000E0000000B0000000700000091000000620000000C0000000B0000000600000025000000240000001700000016000000160000004C000000020000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F573900000200B03A339FFEFED401020200001048450000000000000000000000000000000000220200004400610074006100200053006F0075007200630065003D00750074006500730068006100720065002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074003B0049006E0069007400690061006C00200043006100740061006C006F0067003D005200650061006C00450073007400610074006500530079007300740065006D003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D007800750061006E0074006800750079003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500140000004400690061006700720061006D005F0030000000000226002C0000005F005F00450046004D006900670072006100740069006F006E00730048006900730074006F0072007900000008000000640062006F00000000022600220000004100730070004E006500740052006F006C00650043006C00610069006D007300000008000000640062006F00000000022600180000004100730070004E006500740052006F006C0065007300000008000000640062006F00000000022600220000004100730070004E0065007400550073006500720043006C00610069006D007300000008000000640062006F00000000022600220000004100730070004E006500740055007300650072004C006F00670069006E007300000008000000640062006F00000000022600200000004100730070004E0065007400550073006500720052006F006C0065007300000008000000640062006F00000000022600180000004100730070004E006500740055007300650072007300000008000000640062006F00000000022600220000004100730070004E0065007400550073006500720054006F006B0065006E007300000008000000640062006F000000000226001200000043007500730074006F006D006500720000001200000043007500730074006F006D00650072000000000224001200000045006D0070006C006F0079006500650000001200000045006D0070006C006F00790065006500000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_1', 1, 3, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000003A00000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF3C000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D000000FEFFFFFF0F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F00000030000000310000003200000033000000340000003500000036000000370000003800000039000000FEFFFFFFFEFFFFFF60000000FEFFFFFF3E0000003F000000400000004100000042000000430000004400000045000000460000004700000048000000490000004A0000004B0000004C0000004D0000004E0000004F000000500000005100000052000000530000005400000055000000560000005700000058000000590000005A0000005B0000005C0000005D0000005E0000005F000000FEFFFFFF610000006200000063000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF020000000000000000000000000000000000000000000000000000000000000040EFA00FB304D5013B000000C0080000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000002000000AA170000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000E000000D657000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000005F00000000000000000434000A1E500C05000080720000000F00FFFF8200000072000000007D0000DA7C0000A04400007E1A010008F80000C96B0000232D0000DE805B10F195D011B0A000AA00BDCB5C000008003000000000020000030000003C006B0000000900000000000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002800430000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002800430000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C47000000B416000000C7016900004400A50900000700008001000000BC020000008000001B000080536368477269640000000000000000005F5F45464D6967726174696F6E73486973746F7279202864626F290000004000A50900000700008006000000B20200000080000016000080536368477269640000000000004B00004173704E6574526F6C65436C61696D73202864626F29000000003C00A50900000700008007000000A80200000080000011000080536368477269640000000000FA3200004173704E6574526F6C6573202864626F2928646200009C00A50900000700008008000000520000000180000074000080436F6E74726F6C008B090000D63E000052656C6174696F6E736869702027464B5F4173704E6574526F6C65436C61696D735F4173704E6574526F6C65735F526F6C654964202864626F2927206265747765656E20274173704E6574526F6C6573202864626F292720616E6420274173704E6574526F6C65436C61696D73202864626F292700002800B50100000700008009000000310000007F00000002800000436F6E74726F6C00D10B00007845000000004000A5090000070000800A000000B202000000800000160000805363684772696400DE3F0000321900004173704E657455736572436C61696D73202864626F29000000004000A5090000070000800B000000B202000000800000160000805363684772696400825F0000B23E00004173704E6574557365724C6F67696E73202864626F29000000004000A5090000070000800C000000B002000000800000150000805363684772696400A41F0000523500004173704E657455736572526F6C6573202864626F2929000000009C00A5090000070000800D000000520000000180000072000080436F6E74726F6C005C1500006B38000052656C6174696F6E736869702027464B5F4173704E657455736572526F6C65735F4173704E6574526F6C65735F526F6C654964202864626F2927206265747765656E20274173704E6574526F6C6573202864626F292720616E6420274173704E657455736572526F6C6573202864626F2927000000002800B5010000070000800E000000310000007D00000002800000436F6E74726F6C00140E0000B13A000000003C00A5090000070000800F000000A802000000800000110000805363684772696400DE3F0000383100004173704E65745573657273202864626F2964626F00009C00A50900000700008010000000520000000180000074000080436F6E74726F6C00694900000A25000052656C6174696F6E736869702027464B5F4173704E657455736572436C61696D735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E657455736572436C61696D73202864626F292700002800B50100000700008011000000310000007F00000002800000436F6E74726F6C00AF4B0000F92A000000009C00A50900000700008012000000520000000180000074000080436F6E74726F6C003A550000B13D000052656C6174696F6E736869702027464B5F4173704E6574557365724C6F67696E735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E6574557365724C6F67696E73202864626F292700002800B50100000700008013000000310000007F00000002800000436F6E74726F6C005E4F0000413D000000009C00A50900000700008014000000620000000180000072000080436F6E74726F6C00003500008738000052656C6174696F6E736869702027464B5F4173704E657455736572526F6C65735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E657455736572526F6C6573202864626F2927000000002800B50100000700008015000000310000007D00000002800000436F6E74726F6C000E200000D143000000004000A50900000700008016000000B20200000080000016000080536368477269640004290000E26800004173704E657455736572546F6B656E73202864626F29000000009C00A50900000700008017000000620000000180000074000080436F6E74726F6C00373D00001D60000052656C6174696F6E736869702027464B5F4173704E657455736572546F6B656E735F4173704E657455736572735F557365724964202864626F2927206265747765656E20274173704E65745573657273202864626F292720616E6420274173704E657455736572546F6B656E73202864626F292700002800B50100000700008018000000310000007F00000002800000436F6E74726F6C00AB260000D463000000003800A50900000700008019000000A60200000080000010000080536368477269640092B8000042270000426C6F636B2028437573746F6D65722900003C00A5090000070000801A000000AC02000000800000130000805363684772696400D6830000E8350000437573746F6D65722028437573746F6D6572290000008800A5090000070000801B000000520000000180000060000080436F6E74726F6C0059AC0000E734000052656C6174696F6E736869702027464B5F426C6F636B5F437573746F6D65722028437573746F6D65722927206265747765656E2027437573746F6D65722028437573746F6D6572292720616E642027426C6F636B2028437573746F6D6572292700002800B5010000070000801C000000310000005500000002800000436F6E74726F6C00BFAD00002D37000000003800A5090000070000801D000000A0020000008000000D000080536368477269640042BD0000907E000044657461696C2028506F73742908000000003800A5090000070000801E000000A602000000800000100000805363684772696400E6DC0000907E0000446972656374696F6E2028506F73742900008000A5090000070000801F000000520000000180000058000080436F6E74726F6C009ED20000BB7E000052656C6174696F6E736869702027464B5F44657461696C5F446972656374696F6E2028506F73742927206265747765656E2027446972656374696F6E2028506F7374292720616E64202744657461696C2028506F7374292700002800B50100000700008020000000310000005900000002800000436F6E74726F6C0018D300004B7E000000004400A50900000700008028000000BA020000008000001A00008053636847726964008E8F0000C8640000496E74657265737465645F506F73742028437573746F6D657229000000009C00A50900000700008029000000520000000180000074000080436F6E74726F6C00AF9900002150000052656C6174696F6E736869702027464B5F496E74657265737465645F506F73745F437573746F6D65722028437573746F6D65722927206265747765656E2027437573746F6D65722028437573746F6D6572292720616E642027496E74657265737465645F506F73742028437573746F6D6572292700002800B5010000070000802A000000310000006900000002800000436F6E74726F6C00EB8900004563000000003400A509000007000080320000009C020000008000000B0000805363684772696400EE9800004A790000506F73742028506F7374290000009000A50900000700008033000000720000000180000068000080436F6E74726F6C00719B0000256E000052656C6174696F6E736869702027464B5F496E74657265737465645F506F73745F506F73742028437573746F6D65722927206265747765656E2027506F73742028506F7374292720616E642027496E74657265737465645F506F73742028437573746F6D6572292700002800B50100000700008034000000310000006100000002800000436F6E74726F6C007F8E00005A73000000007800A5090000070000803500000052000000018000004E000080436F6E74726F6C004AAE00008F7D000052656C6174696F6E736869702027464B5F506F73745F44657461696C2028506F73742927206265747765656E202744657461696C2028506F7374292720616E642027506F73742028506F73742927562100002800B50100000700008036000000310000004F00000002800000436F6E74726F6C0031B200001F7D000000003C00A50900000700008037000000A802000000800000110000805363684772696400FEA60000C8AF0000506F73745F496D6167652028506F73742972290000003C00A5090000070000803A000000AA0200000080000012000080536368477269640016BC0000685B0000506F73745F5265706F72742028506F737429646200008000A5090000070000803B0000005A0000000180000058000080436F6E74726F6C0043AB00000F65000052656C6174696F6E736869702027464B5F506F73745F5265706F72745F506F73742028506F73742927206265747765656E2027506F73742028506F7374292720616E642027506F73745F5265706F72742028506F7374292700002800B5010000070000803C000000310000005900000002800000436F6E74726F6C0089AD0000CA68000000003C00A5090000070000803F000000AA02000000800000120000805363684772696400868800009CAE0000506F73745F5374617475732028506F737429646200003800A50900000700008042000000A2020000008000000E00008053636847726964001E780000EE98000050726F6A6563742028506F737429000000007800A50900000700008043000000620000000180000050000080436F6E74726F6C007A8D0000BB8B000052656C6174696F6E736869702027464B5F506F73745F50726F6A6563742028506F73742927206265747765656E202750726F6A6563742028506F7374292720616E642027506F73742028506F7374292700002800B50100000700008044000000310000005100000002800000436F6E74726F6C00CD9100007A95000000003C00A50900000700008045000000AE02000000800000140000805363684772696400E45700009696000050726F6A6563745F496D6167652028506F73742900008C00A50900000700008046000000520000000180000062000080436F6E74726F6C00406D0000ED97000052656C6174696F6E736869702027464B5F50726F6A6563745F496D6167655F50726F6A6563742028506F73742927206265747765656E202750726F6A6563742028506F7374292720616E64202750726F6A6563745F496D6167652028506F73742927000000002800B50100000700008047000000310000006300000002800000436F6E74726F6C00546C00007D97000000004000A50900000700008050000000B0020000008000001500008053636847726964009ABF00007AA300005265616C457374617465547970652028506F73742929000000008800A5090000070000805100000062000000018000005E000080436F6E74726F6C004AAE00008D9B000052656C6174696F6E736869702027464B5F506F73745F5265616C457374616C65547970652028506F73742927206265747765656E20275265616C457374617465547970652028506F7374292720616E642027506F73742028506F73742927000000002800B50100000700008052000000310000005F00000002800000436F6E74726F6C0071A900003BA1000000003800A5090000070000805B000000A0020000008000000D00008053636847726964008A6600003AB600005374617475732028506F73742908000000008400A5090000070000805C00000052000000018000005C000080436F6E74726F6C00E67B000039B5000052656C6174696F6E736869702027464B5F506F73745F5374617475735F5374617475732028506F73742927206265747765656E20275374617475732028506F7374292720616E642027506F73745F5374617475732028506F7374292700002800B5010000070000805D000000310000005D00000002800000436F6E74726F6C00617C00007FB7000000003400A509000007000080610000009C020000008000000B00008053636847726964006E730000647D0000547970652028506F7374290000007800A5090000070000806200000052000000018000004E000080436F6E74726F6C00CA880000637C000052656C6174696F6E736869702027464B5F506F73745F506F7374547970652028506F73742927206265747765656E2027547970652028506F7374292720616E642027506F73742028506F73742927000000002800B50100000700008063000000310000005300000002800000436F6E74726F6C00608C0000A97E000000009000A50900000700008064000000520000000180000067000080436F6E74726F6C003A550000E734000052656C6174696F6E736869702027464B5F437573746F6D65725F4173704E657455736572732028437573746F6D65722927206265747765656E20274173704E65745573657273202864626F292720616E642027437573746F6D65722028437573746F6D657229270000002800B50100000700008065000000310000006100000002800000436F6E74726F6C00AE6500002D37000000003400A509000007000080660000009C020000008000000B00008053636847726964004CB30000FE10000041646D696E202864626F290000003400A509000007000080670000009A020000008000000A0000805363684772696400685B0000681000004D656E75202864626F29000000003800A50900000700008068000000A0020000008000000D0000805363684772696400DE8A0000D20F00005375624D656E75202864626F2905000000007800A5090000070000806900000052000000018000004D000080436F6E74726F6C00B4800000670F000052656C6174696F6E736869702027464B5F5375624D656E755F4D656E75202864626F2927206265747765656E20274D656E75202864626F292720616E6420275375624D656E75202864626F292700000000002800B5010000070000806A000000310000005100000002800000436F6E74726F6C0014810000AD11000000003C00A5090000070000806B000000A8020000008000001100008053636847726964003C5A000080250000496E666F726D6174696F6E202864626F296F737400008000A5090000070000806C0000005A0000000180000056000080436F6E74726F6C00478900002150000052656C6174696F6E736869702027464B5F506F73745F437573746F6D65722028506F73742927206265747765656E2027437573746F6D65722028437573746F6D6572292720616E642027506F73742028506F73742927292700002800B5010000070000806D000000310000005300000002800000436F6E74726F6C00EF7F0000DB6D000000008000A5090000070000806E000000520000000180000056000080436F6E74726F6C00FDA50000DD9A000052656C6174696F6E736869702027464B5F506F73745F496D6167655F506F73742028506F73742927206265747765656E2027506F73742028506F7374292720616E642027506F73745F496D6167652028506F73742927292700002800B5010000070000806F000000310000005700000002800000436F6E74726F6C00689B000002A6000000008000A50900000700008070000000520000000180000058000080436F6E74726F6C00ED970000DD9A000052656C6174696F6E736869702027464B5F506F73745F5374617475735F506F73742028506F73742927206265747765656E2027506F73742028506F7374292720616E642027506F73745F5374617475732028506F7374292700002800B50100000700008071000000310000005900000002800000436F6E74726F6C003B8D00006CA5000000003800A50900000700008072000000A4020000008000000F0000805363684772696400945C00005AF1FFFF44617368626F617264202864626F290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002143341208000000E91800009D0900007856341207000000140100005F005F00450046004D006900670072006100740069006F006E00730048006900730074006F007200790020002800640062006F00290000000000803F0000803FF3F2723F9E9D1D3F0000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE0400000000000001000000E91800009D09000000000000020000000200000002000000020000001C010000300C00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000160000005F005F00450046004D006900670072006100740069006F006E00730048006900730074006F00720079000000214334120800000088160000930E00007856341207000000140100004100730070004E006500740052006F006C00650043006C00610069006D00730020002800640062006F00290000005B3FEAE9693F0000803F00708540000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270A8372123A8372123020000000200000000000000000000001029CA12000000000200000000000000000000000000000000802B4400802BC40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE040000000000000100000088160000930E000000000000040000000400000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E006500740052006F006C00650043006C00610069006D0073000000214334120800000088160000930E00007856341207000000140100004100730070004E006500740052006F006C006500730020002800640062006F00290000000000803FD7D6563FDCDB5B3FEAE9693F0000803F00A06640000000000000F03F0000000000000000000000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F00000000000000000000000000000000C4ABA1700000000000000000846CA2701C58A270B02E2123B02E212302000000020000000000000000000000784103130000000006000000000057430000204100005C4300002041000057430000704100000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE040000000000000100000088160000930E000000000000040000000400000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C0000004100730070004E006500740052006F006C0065007300000002000B00220B00008D410000220B0000004B00000000000002000000F0F0F00000000000000000000000000000000000010000000900000000000000D10B0000784500006E17000058010000300000000100000200006E17000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E006500740052006F006C00650043006C00610069006D0073005F004100730070004E006500740052006F006C00650073005F0052006F006C00650049006400214334120800000088160000930E00007856341207000000140100004100730070004E0065007400550073006500720043006C00610069006D00730020002800640062006F00290000005B3FEAE9693F0000803F00003340000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270A0172123A017212302000000020000000000000000000000A86FD91200000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA060000000000000100000088160000930E000000000000040000000400000002000000020000001C010000040B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E0065007400550073006500720043006C00610069006D0073000000214334120800000088160000930E00007856341207000000140100004100730070004E006500740055007300650072004C006F00670069006E00730020002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA060000000000000100000088160000930E000000000000040000000400000002000000020000001C010000040B0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E006500740055007300650072004C006F00670069006E00730000002143341208000000881600009D0900007856341207000000140100004100730070004E0065007400550073006500720052006F006C006500730020002800640062006F0029000000DCDB5B3FEAE9693F0000803F00308640000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270702421237024212302000000020000000000000000000000A8F3DE12000000000200000000000000000000000000000000803144008031C40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA0600000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000100000004100730070004E0065007400550073006500720052006F006C0065007300000002000B0088160000023A0000A41F0000023A00000000000002000000F0F0F00000000000000000000000000000000000010000000E00000000000000140E0000B13A000018170000580100003C0000000100000200001817000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61250046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E006500740052006F006C00650073005F0052006F006C006500490064002143341208000000881600009C3100007856341207000000140100004100730070004E00650074005500730065007200730020002800640062006F00290000000000803FD7D6563FDCDB5B3FEAE9693F0000803F0000803FA5A4243EE5E4643EABAAAA3E0000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900004B370000000000002D0100000D0000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA0600000000000001000000881600009C310000000000000F0000000C00000002000000020000001C010000040B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C0000004100730070004E006500740055007300650072007300000002000B00004B000038310000004B0000C52700000000000002000000F0F0F00000000000000000000000000000000000010000001100000000000000AF4B0000F92A0000C5170000580100003C000000010000020000C517000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E0065007400550073006500720043006C00610069006D0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640002000B0066560000483F0000825F0000483F00000000000002000000F0F0F000000000000000000000000000000000000100000013000000000000005E4F0000413D0000C51700005801000030000000010000020000C517000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E006500740055007300650072004C006F00670069006E0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640004000B00DE3F0000504600000E380000504600000E380000023A00002C360000023A00000000000002000000F0F0F000000000000000000000000000000000000100000015000000000000000E200000D14300005117000058010000320000000100000200005117000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61250046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E0065007400550073006500720073005F00550073006500720049006400214334120800000088160000930E00007856341207000000140100004100730070004E0065007400550073006500720054006F006B0065006E00730020002800640062006F00290000005B3FEAE9693F0000803F00003C40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270C8132123C813212302000000020000000000000000000000C03CA81200000000020000000000000000000000000000000000E0410000E0C10000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA060000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000110000004100730070004E0065007400550073006500720054006F006B0065006E007300000004000B0074400000D462000074400000DB650000B23E0000DB650000B23E0000E26800000000000002000000F0F0F00000000000000000000000000000000000010000001800000000000000AB260000D46300003918000058010000320000000100000200003918000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61260046004B005F004100730070004E0065007400550073006500720054006F006B0065006E0073005F004100730070004E0065007400550073006500720073005F00550073006500720049006400214334120800000022290000DD1F000078563412070000001401000042006C006F0063006B002000280043007500730074006F006D006500720029000000803F0000803FD7D6563FDCDB5B3FEAE9693F0000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C00000034000000000000000000000022290000DD1F0000000000002D010000090000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA0600000000000001000000881600000416000000000000070000000700000002000000020000001C01000024090000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000000600000042006C006F0063006B0000002143341208000000AF290000F01C000078563412070000001401000043007500730074006F006D00650072002000280043007500730074006F006D006500720029000000D7D6563FDCDB5B3FEAE9693F0000803F4F004D0020007300790073002E0065007800740065006E006400650064005F00700072006F0070006500720074006900650073002000570048004500520045002000280063006C0061007300730020003D00200031002900200041004E004400200028006D0069006E006F0072005F006900640020003D00200030002900200041004E004400200028006D0061006A006F0072005F006900640020003D0020004F0042004A004500430054005F004900440028004E00000000000000000000000000000005000000540000002C0000002C0000002C000000340000000000000000000000AF290000F01C0000000000002D0100000C0000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA0600000000000001000000911600008C250000000000000A0000000A00000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000000900000043007500730074006F006D0065007200000002000B0085AD00007E36000092B800007E3600000000000002000000F0F0F00000000000000000000000000000000000010000001C00000000000000BFAD00002D370000960A00005801000031000000010000020000960A000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61110046004B005F0042006C006F0063006B005F0043007500730074006F006D006500720021433412080000008816000004160000785634120700000014010000440065007400610069006C002000280050006F007300740029000000D5D4D43E0000803F9A99193FD5D4543E9392923ED5D4D43E0000803F0000803FA5A4243EE5E4643EABAAAA3E0000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE0400000000000001000000881600000416000000000000070000000700000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F0073007400000007000000440065007400610069006C0000002143341208000000881600009D09000078563412070000001401000044006900720065006300740069006F006E002000280050006F007300740029000000803F0000803FD7D6563FDCDB5B3FEAE9693F0000803F00A06640000000000000F03F0000000000000000000000000100000001000000000000000000000000000000000000000000F03F00000000000000000000000000000000000000000000000000000000000000000000000000000000C4ABA1700000000000000000846CA2701C58A270D0332123D03321230200000002000000000000000000000058F2AB12000000000600000000002041000020410000A04000002041000020410000A04000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE0400000000000001000000881600009D09000000000000020000000200000002000000020000001C010000D70A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000A00000044006900720065006300740069006F006E00000002000B00E6DC000052800000CAD30000528000000000000002000000F0F0F0000000000000000000000000000000000001000000200000000000000018D300004B7E00007A0A000058010000310000000100000200007A0A000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F00440065007400610069006C005F0044006900720065006300740069006F006E002143341208000000FB170000180C000078563412070000001401000049006E00740065007200650073007400650064005F0050006F00730074002000280043007500730074006F006D006500720029000000803F0000E0400000A0400000E0400000804000008040000040400000C040000010410000C040000040400000C0400000C040000080400000C0400000C0400000804000004040000030410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA0600000000000001000000FB170000180C000000000000030000000300000002000000020000001C010000C70B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000900000043007500730074006F006D006500720000001000000049006E00740065007200650073007400650064005F0050006F0073007400000002000B00469B0000D8520000469B0000C86400000000000002000000F0F0F00000000000000000000000000000000000010000002A00000000000000EB89000045630000AC1000005801000063000000010000020000AC10000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611B0046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0043007500730074006F006D00650072002143341208000000881600004A24000078563412070000001401000050006F00730074002000280050006F0073007400290000000000264007000000000000000100000026004B00480046004E0003002600000000410000E0400000C0400000C0400000C04000004040000000410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000070000005C0900002A00000060000000390000005C09000070BFC30B0000000010000000000030420000404100004041000000000000464000000000000014400000000000001C4000000000000020400100000000000000010000005200000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000E2280000000000002D0100000D0000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE0400000000000001000000881600004A240000000000000E0000000C00000002000000020000001C010000D70A0000000000000100000039130000930E000000000000050000000500000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000500000050006F0073007400000006000B00089D00004A790000089D000000720000BF9C000000720000BF9C000070720000089D000070720000089D0000E07000000000000002000000F0F0F000000000000000000000000000000000000100000034000000000000007F8E00005A730000DA0D00005801000041000000010000020000DA0D000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61170046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0050006F007300740002000B0042BD0000267F000076AF0000267F00000000000002000000F0F0F0000000000000000000000000000000000001000000360000000000000031B200001F7D00001C08000058010000340000000100000200001C08000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D610E0046004B005F0050006F00730074005F00440065007400610069006C00214334120800000088160000930E000078563412070000001401000050006F00730074005F0049006D006100670065002000280050006F007300740029000000000000000000264001000000000000000100000053000000E040000000000000000000001000000007000000910900002A00000030010000390000009109000070BFC30B00000000100000000000504100004041000040410000000000002A40000000000000004000000000004052400000000000002640100000000000000001000000440057004C0044004F0003002C005100470048005B00480056001100110011000000C04000008040000040400000C0400000404000004040000040400000E0400000E0400000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE040000000000000100000088160000930E000000000000040000000400000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000B00000050006F00730074005F0049006D00610067006500000021433412080000005C150000F01C000078563412070000001401000050006F00730074005F005200650070006F00720074002000280050006F00730074002900000000001C0000001B0000005E0900000000000000C06B40000000000000104024000000270000005E09000002000000020000000000000000004842000000000000704110000000070000005F0900002B00000028000000180000005F0900001800000010000000520000000000000000002840080000005500000010000000220000005E0900005F09000014000000260000004C0900005E0900000400000014000000260000004B0900004C090000000000001400000026000000040800004B090000110000001000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C01000006090000620700004704000055050000C0030000EC04000007080000CE04000007080000230A0000EA06000000000000010000005C150000F01C000000000000070000000700000002000000020000001C010000410A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000C00000050006F00730074005F005200650070006F0072007400000003000B00DAAC00004A790000DAAC00008A66000016BC00008A6600000000000002000000F0F0F00000000000000000000000000000000000010000003C0000000000000089AD0000CA680000D40B00005801000032000000010000020000D40B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F0050006F00730074005F005200650070006F00720074005F0050006F00730074002143341208000000881600008913000078563412070000001401000050006F00730074005F005300740061007400750073002000280050006F0073007400290000000000390000004809000070BFC30B00000000100000000000E04000004041000040410000000000001C400000000000000040000000000000514000000000000026400D000000000000000100000030002F0003002C005100470048005B0048005600110011001100000030410000C04000004040000040400000E0400000E0400000C0400000A0400000C0400000A0400000404000004040000040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000AB170000000000002D010000080000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE0400000000000001000000881600008913000000000000060000000600000002000000020000001C010000D70A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000C00000050006F00730074005F0053007400610074007500730000002143341208000000881600000E110000785634120700000014010000500072006F006A006500630074002000280050006F007300740029000000000030000000300000003F00000000000000000000000000000000000000000000000030724000000000000036401400000000000000100000002200000061090000620900001000000007000000630900002700000024000000270000006309000002000000020000000000000000809143000000000000B0411000000007000000640900002B00000050000000180000006409000040000000400000004100000000000000000000000000000000000000000000000030724000000000000036400000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE0400000000000001000000881600000E11000000000000050000000500000002000000020000001C010000D70A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F0073007400000008000000500072006F006A00650063007400000004000B00A68E0000B8A100001E910000B8A100001E910000368D0000EE980000368D00000000000002000000F0F0F00000000000000000000000000000000000010000004400000000000000CD9100007A950000E60800005801000032000000010000020000E608000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D610F0046004B005F0050006F00730074005F00500072006F006A00650063007400214334120800000088160000180C0000785634120700000014010000500072006F006A006500630074005F0049006D006100670065002000280050006F0073007400290000000000500900000100000010000000070000005509000027000000140000002000000055090000000000000000000010000000070000005609000027000000140000002600000055090000560900000000000014000000260000004C0900005509000002000000100000000700000057090000270000001C0000001B00000057090000000000000000414000000000000010401000000007000000580900002700000010000000070000005909000027000000240000002700000059090000020000000200000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE040000000000000100000088160000180C000000000000030000000300000002000000020000001C010000E60A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000E000000500072006F006A006500630074005F0049006D00610067006500000002000B001E780000849900006C6E0000849900000000000002000000F0F0F00000000000000000000000000000000000010000004700000000000000546C00007D9700006B0E000058010000380000000100000200006B0E000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61180046004B005F00500072006F006A006500630074005F0049006D006100670065005F00500072006F006A00650063007400214334120800000088160000180C00007856341207000000140100005200650061006C0045007300740061007400650054007900700065002000280050006F0073007400290000006C00750065002000460052004F004D0020007300790073002E0065007800740065006E006400650064005F00700072006F0070006500720074006900650073002000570048004500520045002000280063006C0061007300730020003D00200031002900200041004E004400200028006D0069006E006F0072005F006900640020003D00200030002900200041004E004400200028006D0061006A006F0072005F006900640020003D0020004F0042004A004500430054005F004900440028004E00000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE040000000000000100000088160000180C000000000000030000000300000002000000020000001C010000E60A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F007300740000000F0000005200650061006C004500730074006100740065005400790070006500000004000B009ABF000010A4000088B7000010A4000088B70000089D000076AF0000089D00000000000002000000F0F0F0000000000000000000000000000000000001000000520000000000000071A900003BA10000680D00005801000032000000010000020000680D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61160046004B005F0050006F00730074005F005200650061006C0045007300740061006C0065005400790070006500214334120800000088160000180C00007856341207000000140100005300740061007400750073002000280050006F00730074002900000048006900730074006F007200790020002800640062006F002900000000003440000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270789B0513789B0513020000000200000000000000000000007841031300000000020000000000803F0000803F0000803F0000A841000098C10000803F00000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE040000000000000100000088160000180C000000000000030000000300000002000000020000001C010000D70A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F0073007400000007000000530074006100740075007300000002000B00127D0000D0B6000086880000D0B600000000000002000000F0F0F00000000000000000000000000000000000010000005D00000000000000617C00007FB70000BB0C00005801000036000000010000020000BB0C000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61150046004B005F0050006F00730074005F005300740061007400750073005F005300740061007400750073002143341208000000881600009D09000078563412070000001401000054007900700065002000280050006F00730074002900000065006500290000000000803F0000803FD7D6563FDCDB5B3FEAE9693F0000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000EE020000B103000094020000EC04000091050000570300009105000008070000CE0400000000000001000000881600009D09000000000000020000000200000002000000020000001C010000D70A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000500000050006F00730074000000050000005400790070006500000002000B00F6890000FA7D0000EE980000FA7D00000000000002000000F0F0F00000000000000000000000000000000000010000006300000000000000608C0000A97E0000230A00005801000032000000010000020000230A000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61100046004B005F0050006F00730074005F0050006F0073007400540079007000650002000B00665600007E360000D68300007E3600000000000002000000F0F0F00000000000000000000000000000000000010000006500000000000000AE6500002D370000DF0E00005801000032000000010000020000DF0E000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61170046004B005F0043007500730074006F006D00650072005F004100730070004E00650074005500730065007200730021433412080000006A1A000031100000785634120700000014010000410064006D0069006E0020002800640062006F002900000000000000000000000000244000000000004070400000000000C070400000000000001440000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A27098A0051398A00513020000000200000000000000000000001029CA120000000002000000000020410000824300002041008084430000A0400000824300000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C0000003400000000000000000000006A1A000031100000000000002D0100000D0000000C000000070000001C01000064050000740400004704000055050000C0030000EE02000007080000CE04000007080000230A0000EA0600000000000001000000060D00004F03000000000000000000000000000002000000020000001C010000640500000000000001000000060D00004F03000000000000000000000000000002000000020000001C010000640500000100000000000000060D00004F03000000000000000000000000000002000000020000001C010000640500000000000000000000861F00001224000000000000000000000D00000004000000040000001C0100006405000063060000ED03000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000006000000410064006D0069006E000000214334120800000078260000131000007856341207000000140100004D0065006E00750020002800640062006F0029000000563FDCDB5B3FEAE9693F0000803F0000803FD7D6563FDCDB5B3FEAE9693F0000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C0000003400000000000000000000007826000013100000000000002D0100000D0000000C000000070000001C010000250800009F0600004704000055050000C00300007404000007080000CE04000007080000230A0000EA0600000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000100000000000000AC1100003403000000000000000000000000000002000000020000001C0100002508000000000000000000005F2D00003E23000000000000000000000D00000004000000040000001C010000250800009C090000EB05000078563412040000005200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000050000004D0065006E007500000021433412080000003E260000251200007856341207000000140100005300750062004D0065006E00750020002800640062006F0029000000000000000000244000000000004070400000000000C070400000000000001440000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABA1700000000000000000846CA2701C58A270202C2123202C212302000000020000000000000000000000D023CA120000000002000000000020410000824300002041008084430000A0400000824300000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C0000003400000000000000000000003E26000025120000000000002D0100000D0000000C000000070000001C010000250800009F0600004704000055050000C00300007404000007080000CE04000007080000230A0000EA0600000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000100000000000000AC1100003403000000000000000000000000000002000000020000001C0100002508000000000000000000005F2D00003E23000000000000000000000D00000004000000040000001C010000250800009C090000EB05000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000080000005300750062004D0065006E007500000002000B00E0810000FE100000DE8A0000FE1000000000000002000000F0F0F00000000000000000000000000000000000010000006A0000000000000014810000AD110000960A00005801000032000000010000020000960A000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D610F0046004B005F005300750062004D0065006E0075005F004D0065006E007500214334120800000028270000B30E000078563412070000001401000049006E0066006F0072006D006100740069006F006E0020002800640062006F00290000000000803FD7D6563FDCDB5B3FEAE9693F0000803F00407840000000000000F03F0000000000000000000000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F00000000000000000000000000000000C4ABA1700000000000000000846CA2701C58A270E8182123E81821230200000002000000000000000000000038410313000000000200000000809443000020410000974300002041008094430000704100000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C00000034000000000000000000000028270000B30E0000000000002D0100000D0000000C000000070000001C010000250800009F0600004704000055050000C00300007404000007080000CE04000007080000230A0000EA0600000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000100000000000000AC1100003403000000000000000000000000000002000000020000001C0100002508000000000000000000005F2D00003E23000000000000000000000D00000004000000040000001C010000250800009C090000EB05000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C00000049006E0066006F0072006D006100740069006F006E00000003000B00DE8A0000D8520000DE8A0000E0790000EE980000E07900000000000002000000F0F0F00000000000000000000000000000000000010000006D00000000000000EF7F0000DB6D0000400A00005801000032000000010000020000400A000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61100046004B005F0050006F00730074005F0043007500730074006F006D006500720002000B0094A70000949D000094A70000C8AF00000000000002000000F0F0F00000000000000000000000000000000000010000006F00000000000000689B000002A600007D0B000058010000320000000100000200007D0B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61120046004B005F0050006F00730074005F0049006D006100670065005F0050006F007300740002000B0084990000949D0000849900009CAE00000000000002000000F0F0F000000000000000000000000000000000000100000071000000000000003B8D00006CA500009A0B000058010000320000000100000200009A0B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61130046004B005F0050006F00730074005F005300740061007400750073005F0050006F0073007400214334120800000087250000F5130000785634120700000014010000440061007300680062006F0061007200640020002800640062006F002900000000000000000000000000004000000000004070400000000000003340000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4AB9F710000000000000000846CA0711C58A07148AE081348AE0813020000000200000000000000000000006831F71200000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C00000034000000000000000000000087250000F5130000000000002D0100000D0000000C000000070000001C010000250800009F0600004704000055050000C00300007404000007080000CE04000007080000230A0000EA0600000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000000000001000000AC1100003403000000000000000000000000000002000000020000001C010000250800000100000000000000AC1100003403000000000000000000000000000002000000020000001C0100002508000000000000000000005F2D00003E23000000000000000000000D00000004000000040000001C010000250800009C090000EB05000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A000000440061007300680062006F00610072006400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000FEFFFFFFFEFFFFFF0400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F0000002000000021000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F5739000002003093940FB304D501020200001048450000000000000000000000000000000000220200004400610074006100200053006F0075007200630065003D00750074006500730068006100720065002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074003B0049006E0069007400690061006C00200043006100740061006C006F0067003D005200650061006C00450073007400610074006500530079007300740065006D003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D007800750061006E0074006800750079003B004D0075006C007400690070006C006500410063007400690076000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000003D000000BC4500000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000020000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000003000000960700000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000002200000012000000000000000C000000C96B0000232D00000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003100320030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000060000000600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000070000000700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000800000008000000000000005E000000014FB56801000000640062006F00000046004B005F004100730070004E006500740052006F006C00650043006C00610069006D0073005F004100730070004E006500740052006F006C00650073005F0052006F006C0065004900640000000000000000000000C402000000000900000009000000080000000800000001072713200727130000000000000000AD0700000000000A0000000A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800320030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000B0000000B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800320030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000C0000000C00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000D0000000D000000000000005C000000014FB56801000000640062006F00000046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E006500740052006F006C00650073005F0052006F006C0065004900640000000000000000000000C402000000000E0000000E0000000D0000000800000001062713600627130000000000000000AD0700000000000F0000000F00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800320030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001000000010000000000000005E000000014FB56801000000640062006F00000046004B005F004100730070004E0065007400550073006500720043006C00610069006D0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C402000000001100000011000000100000000800000001072713A00727130000000000000000AD0700000000001200000012000000000000005E000000014FB56801000000640062006F00000046004B005F004100730070004E006500740055007300650072004C006F00670069006E0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C402000000001300000013000000120000000800000001062713A00627130000000000000000AD0700000000001400000014000000000000005C000000014FB56801000000640062006F00000046004B005F004100730070004E0065007400550073006500720052006F006C00650073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C402000000001500000015000000140000000800000001092713200927130000000000000000AD070000000000160000001600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001700000017000000000000005E000000014FB56801000000640062006F00000046004B005F004100730070004E0065007400550073006500720054006F006B0065006E0073005F004100730070004E0065007400550073006500720073005F0055007300650072004900640000000000000000000000C402000000001800000018000000170000000800000001062713E00627130000000000000000AD070000000000190000001900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300340030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001A0000001A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001B0000001B000000000000003E000000014FB5680100000043007500730074006F006D0065007200000046004B005F0042006C006F0063006B005F0043007500730074006F006D006500720000000000000000000000C402000000001C0000001C0000001B00000008000000010B2713600B27130000000000000000AD0700000000001D0000001D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001E0000001E00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001F0000001F000000000000003A000000014FB5680100000050006F0073007400000046004B005F00440065007400610069006C005F0044006900720065006300740069006F006E0000000000000000000000C4020000000020000000200000001F0000000800000001082713200827130000000000000000AD070000000000280000002800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003000310035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000029000000290000000000000052000000011D18130100000043007500730074006F006D0065007200000046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0043007500730074006F006D006500720000000000000000000000C402000000002A0000002A000000290000000800000001072713E00727130000000000000000AD070000000000320000003200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003300000033000000000000004A000000014FB5680100000043007500730074006F006D0065007200000046004B005F0049006E00740065007200650073007400650064005F0050006F00730074005F0050006F007300740000000000000000000000C402000000003400000034000000330000000800000001062713200627130000000000000000AD07000000000035000000350000000000000030000000014FB5680100000050006F0073007400000046004B005F0050006F00730074005F00440065007400610069006C0000000000000000000000C402000000003600000036000000350000000800000001042713E00427130000000000000000AD070000000000370000003700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003A0000003A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003600320035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003B0000003B000000000000003A000000014FB5680100000050006F0073007400000046004B005F0050006F00730074005F005200650070006F00720074005F0050006F007300740000000000000000000000C402000000003C0000003C0000003B0000000800000001082713600827130000000000000000AD0700000000003F0000003F00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000420000004200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000043000000430000000000000032000000010000000100000050006F0073007400000046004B005F0050006F00730074005F00500072006F006A0065006300740000000000000000000000C402000000004400000044000000430000000800000001052713E00527130000000000000000AD070000000000450000004500000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700390030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000046000000460000000000000044000000010000000100000050006F0073007400000046004B005F00500072006F006A006500630074005F0049006D006100670065005F00500072006F006A0065006300740000000000000000000000C40200000000470000004700000046000000080000000102D812B802D8120000000000000000AD070000000000500000005000000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700390030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000051000000510000000000000040000000014FB5680100000050006F0073007400000046004B005F0050006F00730074005F005200650061006C0045007300740061006C006500540079007000650000000000000000000000C402000000005200000052000000510000000800000001EFD712B8EFD7120000000000000000AD0700000000005B0000005B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000005C0000005C000000000000003E000000010000000100000050006F0073007400000046004B005F0050006F00730074005F005300740061007400750073005F0053007400610074007500730000000000000000000000C402000000005D0000005D0000005C0000000800000001EED712B8EED7120000000000000000AD070000000000610000006100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000062000000620000000000000034000000010000000100000050006F0073007400000046004B005F0050006F00730074005F0050006F0073007400540079007000650000000000000000000000C402000000006300000063000000620000000800000001EED71278EED7120000000000000000AD0700000000006400000064000000000000004A0000000101D2690100000043007500730074006F006D0065007200000046004B005F0043007500730074006F006D00650072005F004100730070004E00650074005500730065007200730000000000000000000000C402000000006500000065000000640000000800000001EDD712F8EDD7120000000000000000AD070000000000660000006600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003800000034002C0030002C003200380034002C0030002C0031003300380030002C0031002C0031003100340030002C0035002C003700350030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0031003300380030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0031003300380030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0031003300380030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0031003300380030002C00310032002C0031003600330035002C00310031002C0031003000300035000000670000006700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003000380035002C0031002C0031003600390035002C0035002C0031003100340030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003000380035002C00310032002C0032003400360030002C00310031002C0031003500310035000000680000006800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003000380035002C0031002C0031003600390035002C0035002C0031003100340030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003000380035002C00310032002C0032003400360030002C00310031002C0031003500310035000000690000006900000000000000300000000100000001000000640062006F00000046004B005F005300750062004D0065006E0075005F004D0065006E00750000000000000000000000C402000000006A0000006A000000690000000800000001F4D712B8F4D7120000000000000000AD0700000000006B0000006B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003000380035002C0031002C0031003600390035002C0035002C0031003100340030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003000380035002C00310032002C0032003400360030002C00310031002C00310035003100350000006C0000006C0000000000000034000000010000000100000050006F0073007400000046004B005F0050006F00730074005F0043007500730074006F006D006500720000000000000000000000C402000000006D0000006D0000006C0000000800000001ECD712F8ECD7120000000000000000AD0700000000006E0000006E0000000000000038000000010000000100000050006F0073007400000046004B005F0050006F00730074005F0049006D006100670065005F0050006F007300740000000000000000000000C402000000006F0000006F0000006E0000000800000001EDD712B8EDD7120000000000000000AD0700000000007000000070000000000000003A000000014FB5680100000050006F0073007400000046004B005F0050006F00730074005F005300740061007400750073005F0050006F007300740000000000000000000000C402000000007100000071000000700000000800000001EDD71238EDD7120000000000000000AD070000000000720000007200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003000380035002C0031002C0031003600390035002C0035002C0031003100340030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000380035000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003000380035002C00310032002C0032003400360030002C00310031002C00310035003100350000006E00000008000000070000000600000025000000240000000D000000070000000C0000006100000058000000100000000F0000000A0000002400000025000000120000000F0000000B000000790000004A000000140000000F0000000C0000009000000059000000170000000F000000160000000100000048000000640000000F0000001A0000005B0000008C0000006C0000001A00000032000000170000004A0000001B0000001A000000190000008D000000BC000000290000001A000000280000004F00000026000000350000001D000000320000004A0000005D0000001F0000001E0000001D0000004E0000004F00000070000000320000003F00000001000000380000006E000000320000003700000031000000000000003300000032000000280000000C0000002D0000003B000000320000003A000000420000006A000000430000004200000032000000670000008C0000004600000042000000450000004A000000530000005100000050000000320000004A000000C30000005C0000005B0000003F0000004B000000640000006200000061000000320000004B0000005800000069000000670000006800000081000000820000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500140000004400690061006700720061006D005F0031000000000226001800000049006E0066006F0072006D006100740069006F006E00000008000000640062006F00000000022600100000005300750062004D0065006E007500000008000000640062006F000000000226000A0000004D0065006E007500000008000000640062006F000000000226000C000000410064006D0069006E00000008000000640062006F000000000226000A000000540079007000650000000A00000050006F00730074000000000226000E00000053007400610074007500730000000A00000050006F00730074000000000226001E0000005200650061006C00450073007400610074006500540079007000650000000A00000050006F00730074000000000226001C000000500072006F006A006500630074005F0049006D0061006700650000000A00000050006F007300740000000002260010000000500072006F006A0065006300740000000A00000050006F00730074000000000226001800000050006F00730074005F0053007400610074007500730000000A00000050006F00730074000000000226001800000050006F00730074005F005200650070006F007200740000000A00000050006F00730074000000000226001600000050006F00730074005F0049006D0061006700650000000A00000050006F00730074000000000226000A00000050006F007300740000000A00000050006F00730074000000000226002000000049006E00740065007200650073007400650064005F0050006F007300740000001200000043007500730074006F006D00650072000000000226001400000044006900720065006300740069006F006E0000000A00000050006F00730074000000000226000E000000440065007400610069006C0000000A00000050006F00730074000000000226001200000043007500730074006F006D006500720000001200000043007500730074006F006D00650072000000000226000C00000042006C006F0063006B0000001200000043007500730074006F006D0065007200000000022600220000004100730070004E0065007400550073006500720054006F006B0065006E007300000008000000640062006F00000000022600180000004100730070004E006500740055007300650072007300000008000000640062006F00000000022600200000004100730070004E0065007400550073006500720052006F006C0065007300000008000000640062006F00000000022600220000004100730070004E006500740055007300650072004C006F00670069006E007300000008000000640062006F00000000022600220000004100730070004E0065007400550073006500720043006C00610069006D007300000008000000640062006F00000000022600180000004100730070004E006500740052006F006C0065007300000008000000640062006F00000000022600220000004100730070004E006500740052006F006C00650043006C00610069006D007300000008000000640062006F000000000226002C0000005F005F00450046004D006900670072006100740069006F006E00730048006900730074006F0072007900000008000000640062006F0000000002240014000000440061007300680062006F00610072006400000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
SET IDENTITY_INSERT [Post].[Detail] ON 

INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (1, 2, 4, 3, 1, 1, CAST(N'2019-03-21T15:50:22.717' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (2, 3, 6, 4, 2, 1, CAST(N'2019-03-21T15:50:22.717' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (3, 4, 4, 3, 2, 0, CAST(N'2019-03-21T15:50:22.730' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (4, 1, 2, 3, 4, NULL, CAST(N'2019-03-21T15:50:22.730' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (5, 6, 9, 10, 5, 0, CAST(N'2019-03-21T15:50:22.730' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (6, 3, 2, 2, 2, 1, CAST(N'2019-04-30T18:33:07.310' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (9, 2, 2, 1, 5, 1, CAST(N'2019-05-02T18:15:06.190' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (11, 4, 7, 3, 6, 0, CAST(N'2019-05-05T16:28:32.387' AS DateTime))
INSERT [Post].[Detail] ([Detail_ID], [Floor], [Bedroom], [Bathroom], [Direction_ID], [Alley], [ModifiedDate]) VALUES (13, 2, 1, 1, 2, 1, CAST(N'2019-05-06T04:34:06.300' AS DateTime))
SET IDENTITY_INSERT [Post].[Detail] OFF
SET IDENTITY_INSERT [Post].[Direction] ON 

INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (1, N'Đông')
INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (2, N'Tây')
INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (3, N'Nam')
INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (4, N'Bắc')
INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (5, N'Đông Nam')
INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (6, N'Đông Bắc')
INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (7, N'Tây Bắc')
INSERT [Post].[Direction] ([Direction_ID], [Direction_Name]) VALUES (8, N'Tây Nam')
SET IDENTITY_INSERT [Post].[Direction] OFF
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'ban-dat-da-nang-20181117161238447', 1, CAST(N'2018-11-17T16:12:38.447' AS DateTime), N'Bán đất Đà Nẵng', 350000000, N'89 Đinh Thanh Bình, Long Thành, Hưng Hòa, Hưng Yên', CAST(100.00 AS Decimal(18, 2)), 4, N'Mô tả', 2, NULL, 2, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'ban-dat-tho-cu-20181117161625450', 1, CAST(N'2018-11-17T16:16:25.450' AS DateTime), N'Bán đất thổ cư', 310000000, N'111 Hòa Trung, Hòa Trung, Khánh Hóa', CAST(150.00 AS Decimal(18, 2)), NULL, N'Mô tả', 2, NULL, 4, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'ban-nha-ha-huy-giap-20181213160019800', 2, CAST(N'2018-12-13T16:00:19.800' AS DateTime), N'Cho thuê nhà Hà Huy Giáp', 10000000, N'111 Huỳnh Thúc Kháng, Quang Trung, Nghệ An', CAST(60.00 AS Decimal(18, 2)), 2, N'Mô tả', 1, 1, 3, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'ban-nha-sieu-dep-20181117160557010', 1, CAST(N'2018-11-17T16:05:57.010' AS DateTime), N'Bán nhà siêu đẹp', 3100000000, N'43 Hòa Hữu, Tây Hòa, Hà Tĩnh', CAST(56.00 AS Decimal(18, 2)), 3, N'Mô tả', 1, 1, 2, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'can-ban-nha-ban-toi-20181214135544330', 1, CAST(N'2018-12-14T13:55:44.330' AS DateTime), N'Cần bán nhà bạn tôi', 1000000000, N'98 Đinh Văn Minh, Linh Trung, Ninh Hòa, Khánh Hòa', CAST(10000.00 AS Decimal(18, 2)), 1, N'Mô tả ngôi nhà của tôi', 1, 5, 1, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'can-ban-nha-chinh-chu-552019112952pm', 1, CAST(N'2019-05-05T16:28:32.487' AS DateTime), N'Cần bán nhà chính chủ', 4500000000, N'122 Bình Hưng Hòa, Quận Tân Phú, Huế', CAST(120.00 AS Decimal(18, 2)), NULL, N'Nhà siêu đẹp, nhìn là mê', 1, 11, 17, 1)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'can-ban-nha-linh-hoa-53201911625am', 1, CAST(N'2019-05-02T18:15:06.350' AS DateTime), N'Cần bán nhà Linh Hòa', 123, N'21 Lê Văn Sỹ, Linh Hòa, Đà Nẵng', CAST(12.22 AS Decimal(18, 2)), NULL, N'Cần bán nhà', 1, 9, 1, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'can-ban-nha-linh-hoa-552019103849pm', 1, CAST(N'2019-05-05T15:37:30.797' AS DateTime), N'Cần bán nhà Linh Hòa', 123, N'21 Lê Văn Sỹ, Linh Hòa, Đà Nẵng', CAST(12.10 AS Decimal(18, 2)), 1, N'mô tả', 2, NULL, 18, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'can-lua-ban-nha-20181209222020107', 1, CAST(N'2018-12-09T22:20:20.107' AS DateTime), N'Cần lúa bán nhà', 1200000000, N'55 Trương Văn Khương, Ninh Hòa, Khánh Hóa', CAST(100.00 AS Decimal(18, 2)), NULL, N'Mô tả', 1, 3, 2, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'can-tien-ban-dat-20181129090536047', 1, CAST(N'2018-11-29T09:05:36.047' AS DateTime), N'Cần tiền bán đất', 210000000, N'34 Phú Mỹ Hưng, Hưng Hòa, Bình Định', CAST(145.00 AS Decimal(18, 2)), NULL, N'Mô tả', 2, NULL, 4, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'dat-nen-hue-20181117161442010', 1, CAST(N'2018-11-17T16:14:42.010' AS DateTime), N'Đất nền Huế', 2100000000, N'123 Phạm Ngũ Lào, Hòa Bắc, Quảng Nam', CAST(250.00 AS Decimal(18, 2)), NULL, N'Mô tả', 10, NULL, 5, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'dat-xay-dung-khong-quy-hoach-20181213154623873', 1, CAST(N'2018-12-13T15:46:23.873' AS DateTime), N'Đất xây dựng không quy hoạch', 620000000, N'212 Tân Hưng Hòa, Hội An, Đà Nẵng', CAST(360.00 AS Decimal(18, 2)), 1, N'Mô tả', 2, NULL, 1, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'nha-moi-xay-100-chua-o-20181209225325693', 1, CAST(N'2018-12-09T22:53:25.693' AS DateTime), N'Nhà mới xây 100% chưa ở', 2300000000, N'131 Long Trường, Thạnh Xuân, Hòa Bình, Đà Nẵng', CAST(100.00 AS Decimal(18, 2)), NULL, N'Mô tả', 1, 1, 1, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'thua-no-ban-nha-gap-20181213084537630', 2, CAST(N'2018-12-13T08:45:37.630' AS DateTime), N'Thua nợ bán nhà gấp', 12000000, N'123 Lê Lợi, Hòa Bình, Hóa Phát, Huế', CAST(123.00 AS Decimal(18, 2)), 5, N'nha dep can cho thue', 1, 4, 1, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'tieu-de-20190430183308043', 1, CAST(N'2019-04-30T18:33:08.043' AS DateTime), N'tiêu đề', 12, N'vi trí', CAST(12.22 AS Decimal(18, 2)), NULL, N'mô tả', 1, 6, 1, 2)
INSERT [Post].[Post] ([Post_ID], [PostType], [PostTime], [Tittle], [Price], [Location], [Area], [Project], [Description], [RealEstaleType], [Detail], [Author_ID], [Status]) VALUES (N'tieu-de-562019113526am', 1, CAST(N'2019-05-06T11:35:26.300' AS DateTime), N'tiêu đề', 123, N'21 Lê Văn Sỹ, Linh Hòa, Đà Nẵng', CAST(123.00 AS Decimal(18, 2)), NULL, N'1', 1, 13, 1, 1)
SET IDENTITY_INSERT [Post].[Post_Image] ON 

INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (1, N'dat-xay-dung-khong-quy-hoach-20181213154623873', N'1.2.jpg', CAST(N'2019-05-02T17:08:42.713' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (2, N'dat-xay-dung-khong-quy-hoach-20181213154623873', N'1.2.jpg', CAST(N'2018-11-24T13:49:03.750' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (3, N'dat-xay-dung-khong-quy-hoach-20181213154623873', N'1.3.jpg', CAST(N'2018-11-24T13:49:06.793' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (4, N'ban-nha-ha-huy-giap-20181213160019800', N'2.1.jpg', CAST(N'2019-05-02T17:19:44.540' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (5, N'ban-nha-ha-huy-giap-20181213160019800', N'2.2.jpg', CAST(N'2018-11-24T13:49:11.813' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (6, N'ban-nha-ha-huy-giap-20181213160019800', N'2.3.jpg', CAST(N'2018-11-24T13:49:14.787' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (7, N'ban-nha-ha-huy-giap-20181213160019800', N'2.4.jpg', CAST(N'2018-11-24T13:49:17.730' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (8, N'ban-nha-sieu-dep-20181117160557010', N'3.1.jpg', CAST(N'2019-05-02T17:32:28.940' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (9, N'ban-nha-sieu-dep-20181117160557010', N'3.2.jpg', CAST(N'2019-05-02T17:32:34.690' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (10, N'ban-nha-sieu-dep-20181117160557010', N'3.3.jpg', CAST(N'2019-05-02T17:32:37.700' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (11, N'ban-nha-sieu-dep-20181117160557010', N'3.4.jpg', CAST(N'2019-05-02T17:32:40.713' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (12, N'ban-nha-sieu-dep-20181117160557010', N'3.5.jpg', CAST(N'2019-05-02T17:32:43.630' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (13, N'ban-dat-da-nang-20181117161238447', N'4.1.jpg', CAST(N'2019-05-02T17:21:21.073' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (14, N'ban-dat-da-nang-20181117161238447', N'4.2.jpg', CAST(N'2018-11-24T13:49:38.003' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (15, N'dat-nen-hue-20181117161442010', N'5.1.jpg', CAST(N'2019-05-02T17:22:13.100' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (16, N'dat-nen-hue-20181117161442010', N'5.2.jpg', CAST(N'2018-11-24T13:49:42.950' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (17, N'ban-dat-tho-cu-20181117161625450', N'6.1.jpg', CAST(N'2019-05-02T17:13:43.360' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (18, N'ban-dat-tho-cu-20181117161625450', N'6.2.jpg', CAST(N'2018-11-24T13:49:48.677' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (19, N'ban-dat-tho-cu-20181117161625450', N'6.3.jpg', CAST(N'2018-11-24T13:49:50.877' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (20, N'ban-dat-tho-cu-20181117161625450', N'6.4.jpg', CAST(N'2018-11-24T13:49:54.623' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (22, N'can-tien-ban-dat-20181129090536047', N'6.4.jpg', CAST(N'2019-05-02T17:14:35.320' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (23, N'can-lua-ban-nha-20181209222020107', N'0a0bd80d945d4dc5ae72b5a8bf0159b82e63309eacb34005cd380107f38e87ab.jpg', CAST(N'2019-05-02T17:15:18.807' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (24, N'can-lua-ban-nha-20181209222020107', N'215eb5dbe4b87c144bc0d25bac49e892612c7a6bed8307a16767e8bf634f7af8.jpg', CAST(N'2018-12-09T22:20:20.153' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (25, N'can-lua-ban-nha-20181209222020107', N'65be37b5eea1e1fb36f2f28c9438e670e45e7ff0405851f8442a148c0b103fcc.jpg', CAST(N'2018-12-09T22:20:20.177' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (26, N'nha-moi-xay-100-chua-o-20181209225325693', N'afc56352878e6d186698e06e8d98c3d4e66fd609e3fed1b30eaabe32ac06db2c.jpg', CAST(N'2019-05-02T17:16:22.610' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (27, N'nha-moi-xay-100-chua-o-20181209225325693', N'9fd7199823a2349a69aed47173a6a987cb05b072b8ace44bc95482e0c7f67149.jpg', CAST(N'2018-12-09T22:53:25.743' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (28, N'nha-moi-xay-100-chua-o-20181209225325693', N'9d726e2725dcf565923d1782309ef916e04af35db3efaca2ad3285eef72032c7.jpg', CAST(N'2018-12-09T22:53:25.763' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (29, N'thua-no-ban-nha-gap-20181213084537630', N'40598946_303314163813193_2811185601380876288_n.jpg', CAST(N'2019-05-02T17:17:11.600' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (30, N'can-ban-nha-ban-toi-20181214135544330', N'bfa7086233f70aace667cbd04626473e72666b6418448298be2e972633e0c4df.jpg', CAST(N'2019-05-02T17:18:01.757' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (31, N'tieu-de-20190430183308043', N'56df573f-google-cloud-platform-51201913201AM.png', CAST(N'2019-05-02T17:18:50.370' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (32, N'tieu-de-20190430183308043', N'56498637_1284562728374644_7031252434424954880_n-51201913340AM.jpg', CAST(N'2019-05-01T01:33:50.380' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (33, N'tieu-de-20190430183308043', N'20150605093116-29d9-51201913423AM.jpg', CAST(N'2019-05-01T01:34:23.527' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (34, N'tieu-de-20190430183308043', N'20151105204835-33f7-51201913423AM.jpg', CAST(N'2019-05-01T01:34:23.737' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (35, N'tieu-de-20190430183308043', N'Conan-1005-00-51201913423AM.jpg', CAST(N'2019-05-01T01:34:23.787' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (36, N'can-ban-nha-linh-hoa-53201911625am', N'5-yeu-to-phong-thuy-khi-mua-nha-53201911625AM.jpg', CAST(N'2019-05-02T18:15:06.497' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (37, N'can-ban-nha-linh-hoa-53201911625am', N'images-53201911625AM.jpg', CAST(N'2019-05-03T01:16:25.380' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (38, N'can-ban-nha-linh-hoa-53201911625am', N'photo1530245378366-15302453783671548891050-53201911625AM.jpg', CAST(N'2019-05-03T01:16:25.397' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (39, N'can-ban-nha-linh-hoa-53201911625am', N'tuoi-nao-hop-huong-nha-tay-bac-3-53201911625AM.jpg', CAST(N'2019-05-03T01:16:25.413' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (40, N'can-ban-nha-linh-hoa-552019103849pm', N'56498637_1284562728374644_7031252434424954880_n-552019103849PM.jpg', CAST(N'2019-05-05T15:37:31.240' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (41, N'can-ban-nha-linh-hoa-552019103849pm', N'20151105204835-33f7-552019103849PM.jpg', CAST(N'2019-05-05T15:37:31.723' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (42, N'can-ban-nha-linh-hoa-552019103849pm', N'images-552019103849PM.jpg', CAST(N'2019-05-05T15:37:32.970' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (43, N'can-ban-nha-chinh-chu-552019112952pm', N'mau-nha-pho-dep-2015-2-552019112952PM.jpg', CAST(N'2019-05-05T16:28:32.570' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (44, N'can-ban-nha-chinh-chu-552019112952pm', N'mau-thiet-ke-nha-biet-thu-dep-3-tang-BT1651-1-552019112952PM.jpg', CAST(N'2019-05-05T23:29:52.263' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (45, N'can-ban-nha-chinh-chu-552019112952pm', N'nha-cap-4-dep-hien-dai-552019112952PM.png', CAST(N'2019-05-05T23:29:52.327' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (46, N'can-ban-nha-chinh-chu-552019112952pm', N'photo1530245378366-15302453783671548891050-552019112952PM.jpg', CAST(N'2019-05-05T23:29:52.357' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (47, N'can-ban-nha-chinh-chu-552019112952pm', N'tuoi-nao-hop-huong-nha-tay-bac-3-552019112952PM.jpg', CAST(N'2019-05-05T23:29:52.373' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (48, N'can-ban-nha-chinh-chu-552019112952pm', N'vlxd_org_nha1-552019112952PM.jpg', CAST(N'2019-05-05T23:29:52.390' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (49, N'tieu-de-562019113526am', N'mau-nha-pho-dep-2015-2-562019113526AM.jpg', CAST(N'2019-05-06T04:34:06.540' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (50, N'tieu-de-562019113526am', N'mau-thiet-ke-nha-biet-thu-dep-3-tang-BT1651-1-562019113526AM.jpg', CAST(N'2019-05-06T11:35:26.367' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (51, N'tieu-de-562019113526am', N'nha-cap-4-dep-hien-dai-562019113526AM.png', CAST(N'2019-05-06T11:35:26.387' AS DateTime))
INSERT [Post].[Post_Image] ([Image_ID], [Post_ID], [url], [AddedDate]) VALUES (52, N'tieu-de-562019113526am', N'photo1530245378366-15302453783671548891050-562019113526AM.jpg', CAST(N'2019-05-06T11:35:26.407' AS DateTime))
SET IDENTITY_INSERT [Post].[Post_Image] OFF
SET IDENTITY_INSERT [Post].[Post_Status] ON 

INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1, N'dat-xay-dung-khong-quy-hoach-20181213154623873', 1, CAST(N'2019-05-02T17:12:41.713' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (2, N'ban-nha-ha-huy-giap-20181213160019800', 1, CAST(N'2019-05-02T17:19:44.557' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (3, N'ban-nha-sieu-dep-20181117160557010', 1, CAST(N'2019-05-02T17:20:34.597' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (4, N'ban-dat-da-nang-20181117161238447', 1, CAST(N'2019-05-02T17:21:21.080' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (5, N'dat-nen-hue-20181117161442010', 1, CAST(N'2019-05-02T17:22:13.103' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (6, N'ban-dat-tho-cu-20181117161625450', 1, CAST(N'2019-05-02T17:13:43.363' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (7, N'dat-xay-dung-khong-quy-hoach-20181213154623873', 2, CAST(N'2018-11-17T16:27:47.503' AS DateTime), NULL)
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (8, N'ban-nha-ha-huy-giap-20181213160019800', 2, CAST(N'2018-11-17T16:29:13.737' AS DateTime), NULL)
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (9, N'ban-nha-sieu-dep-20181117160557010', 2, CAST(N'2018-11-17T16:28:12.400' AS DateTime), NULL)
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (10, N'ban-dat-da-nang-20181117161238447', 4, CAST(N'2018-11-17T16:33:12.157' AS DateTime), N'I like that')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (11, N'dat-nen-hue-20181117161442010', 2, CAST(N'2018-11-17T16:33:29.127' AS DateTime), NULL)
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (23, N'can-tien-ban-dat-20181129090536047', 1, CAST(N'2019-05-02T17:14:35.327' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1024, N'can-lua-ban-nha-20181209222020107', 1, CAST(N'2019-05-02T17:15:18.813' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1025, N'nha-moi-xay-100-chua-o-20181209225325693', 1, CAST(N'2019-05-02T17:16:22.617' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1026, N'nha-moi-xay-100-chua-o-20181209225325693', 2, CAST(N'2018-12-09T22:53:46.947' AS DateTime), N'This post was created by Employee ID: 1')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1027, N'can-lua-ban-nha-20181209222020107', 4, CAST(N'2018-12-09T23:15:15.120' AS DateTime), N'Blocked Post')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1028, N'thua-no-ban-nha-gap-20181213084537630', 1, CAST(N'2019-05-02T17:17:11.603' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1029, N'thua-no-ban-nha-gap-20181213084537630', 2, CAST(N'2018-12-13T08:49:48.677' AS DateTime), N'Approved Post')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1030, N'can-ban-nha-ban-toi-20181214135544330', 1, CAST(N'2019-05-02T17:18:01.760' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1031, N'can-ban-nha-ban-toi-20181214135544330', 2, CAST(N'2018-12-14T13:55:44.547' AS DateTime), N'This post was created by Employee ID: 1')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1032, N'ban-dat-tho-cu-20181117161625450', 2, CAST(N'2018-12-14T13:57:00.703' AS DateTime), N'Approved Post')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1033, N'tieu-de-20190430183308043', 1, CAST(N'2019-05-02T17:18:50.373' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1034, N'can-ban-nha-linh-hoa-53201911625am', 1, CAST(N'2019-05-02T18:15:06.353' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1038, N'can-ban-nha-linh-hoa-53201911625am', 2, CAST(N'2019-05-05T15:21:36.417' AS DateTime), N'This post was approved by admin')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1039, N'thua-no-ban-nha-gap-20181213084537630', 2, CAST(N'2019-05-05T15:21:42.390' AS DateTime), N'This post was approved by admin')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1040, N'can-ban-nha-linh-hoa-552019103849pm', 1, CAST(N'2019-05-05T15:37:30.797' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1041, N'can-ban-nha-linh-hoa-552019103849pm', 4, CAST(N'2019-05-05T15:38:52.810' AS DateTime), N'This post was approved by admin')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1042, N'can-ban-nha-chinh-chu-552019112952pm', 1, CAST(N'2019-05-05T16:28:32.487' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1043, N'tieu-de-562019113526am', 1, CAST(N'2019-05-06T04:34:06.380' AS DateTime), N'new POST')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1071, N'can-ban-nha-chinh-chu-552019112952pm', 2, CAST(N'2019-05-06T10:22:14.417' AS DateTime), N'This post was approved by admin')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1072, N'tieu-de-562019113526am', 4, CAST(N'2019-05-06T10:22:18.093' AS DateTime), N'This post was hided')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1073, N'thua-no-ban-nha-gap-20181213084537630', 4, CAST(N'2019-05-06T10:22:33.517' AS DateTime), N'This post was hided')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1074, N'ban-dat-da-nang-20181117161238447', 4, CAST(N'2019-05-06T10:22:41.833' AS DateTime), N'This post was hided')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1075, N'ban-nha-sieu-dep-20181117160557010', 4, CAST(N'2019-05-06T10:24:43.393' AS DateTime), N'This post was hided')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1076, N'tieu-de-562019113526am', 4, CAST(N'2019-05-07T06:36:29.793' AS DateTime), N'This post was hided')
INSERT [Post].[Post_Status] ([Post_Status_ID], [Post_ID], [Status], [CensorshipTime], [Reason]) VALUES (1077, N'can-ban-nha-chinh-chu-552019112952pm', 4, CAST(N'2019-05-07T06:36:46.933' AS DateTime), N'This post was hided')
SET IDENTITY_INSERT [Post].[Post_Status] OFF
SET IDENTITY_INSERT [Post].[Project] ON 

INSERT [Post].[Project] ([Project_ID], [ProjectName], [Location], [Protential], [ModifiedDate]) VALUES (1, N'VinCity', N'District 9, TP Hồ Chí Minh', N'VinCity is a modern, civilized city modeled on the metropolis of Singapore and beyond. Not only have the facilities to provide the ideal life for the people in Singapore, VinCity also creates unique facilities such as an outdoor sports park with hundreds of exercise machines and BBQ park. hundreds of baking points. With a flexible financial solution, VinCity promises to be a breakthrough solution for Vietnamese residents and opens up opportunities for investment thanks to its potential location and future growth. ', CAST(N'2018-12-11T13:51:07.220' AS DateTime))
INSERT [Post].[Project] ([Project_ID], [ProjectName], [Location], [Protential], [ModifiedDate]) VALUES (2, N'Bien Hoa New City', N'Bien Hoa, Dong Nai', N'New City Hotel is located in the southern key economic development zone and is the focal point of the potential quadrangle of Ho Chi Minh City, which is oriented to become the major economic center of the whole. country.

A new urban area on the river. Bien Hoa (Dong Nai), Bien Hoa New City is highly appreciated when adjacent to Vung Tau crossroads. From here, residents will inherit the system of synchronous and modern transport infrastructure, including land, water and air.

In addition, the location is at the heart of the economic zone so residents of Bien Hoa New City can connect smoothly with the center of Ho Chi Minh City and the surrounding areas through the key roads: Hanoi Highway, National Highway Highway 51, Ho Chi Minh City - Long Thanh - Dau Giay expressway and the 60 m wide riverside boulevard are under construction.

Also from Bien Hoa New City, residents can quickly move to Long Thanh International Airport - the largest airport gateway in Vietnam with only 10 minutes. In addition, the bridge across the Dong Nai River in the future will connect the project area to District 9 (HCMC) easily.', CAST(N'2018-12-11T13:51:18.353' AS DateTime))
INSERT [Post].[Project] ([Project_ID], [ProjectName], [Location], [Protential], [ModifiedDate]) VALUES (3, N'Phu Hong Khang 12', N'Di An, Binh Duong', N'Continuing success of Phu Hong Thinh residential area project 6,8,9,10. Phu Hong Thinh Real Estate Company Limited continues to introduce to customers super products named PHU HONG KHANG - PHU HONG DAT.

The project of Phu Hong Dat and Phu Hong Khang commercial housing area is nearly 65,000m2, of which residential land occupies nearly 40,000m2, the remaining area for infrastructure, roads, green parks, schools ... Two projects with more than 600 backgrounds, estimated to satisfy more than 2,500 people.', CAST(N'2018-12-11T13:51:26.413' AS DateTime))
INSERT [Post].[Project] ([Project_ID], [ProjectName], [Location], [Protential], [ModifiedDate]) VALUES (4, N'FIVE STAR ECO CITY', N'Can Giuoc, Long An', N'Khu Đô Thị Sinh Thái Năm Sao – Five Star Eco City tọa lạc vị trí đắc địa, ngay 2 mặt tiền đường Đinh Đức Thiện (Bình Chánh) và Tỉnh Lộ 835B đi TP.HCM. Nằm ở vị trí liền kề, khu vực sầm uất bậc nhất khu Nam Thành Phố Hồ Chí Minh. Từ Khu Đô Thị Sinh Thái Năm Sao – Five Star Eco City các cư dân chỉ mất khoảng 15 phút di chuyển để tới Khu đô thị Phú Mỹ Hưng, từ 25 – 35 phút để đến chợ Bến Thành và sân bay Quốc Tế Tân Sơn Nhất, từ 45 – 55 phút để đến sân bay Quốc Tế Long Thành… qua các tuyến đường như Đại Lộ Võ Văn Kiệt, Đại Lộ Nguyễn Văn Linh qua Quốc Lộ 1A, tuyến đường Cao tốc Bến Lức – Long Thành…Five Star Eco City đồng thời là đầu mối giao thông cực kỳ quan trọng của các tuyến đường về các Tỉnh miền Tây Nam Bộ, miền Đông và miền Đông Nam Bộ.

', CAST(N'2018-12-11T13:50:41.637' AS DateTime))
INSERT [Post].[Project] ([Project_ID], [ProjectName], [Location], [Protential], [ModifiedDate]) VALUES (5, N'San bay', N'ho chi minh', N'dep', CAST(N'2018-12-13T08:45:37.597' AS DateTime))
SET IDENTITY_INSERT [Post].[Project] OFF
SET IDENTITY_INSERT [Post].[Project_Image] ON 

INSERT [Post].[Project_Image] ([Img_ID], [Project_ID], [url]) VALUES (1, 1, N'4.1.jpg')
INSERT [Post].[Project_Image] ([Img_ID], [Project_ID], [url]) VALUES (2, 2, N'4.2.jpg')
INSERT [Post].[Project_Image] ([Img_ID], [Project_ID], [url]) VALUES (3, 3, N'5.2.jpg')
INSERT [Post].[Project_Image] ([Img_ID], [Project_ID], [url]) VALUES (4, 4, N'6.4.jpg')
INSERT [Post].[Project_Image] ([Img_ID], [Project_ID], [url]) VALUES (6, 5, N'40598946_303314163813193_2811185601380876288_n.jpg')
SET IDENTITY_INSERT [Post].[Project_Image] OFF
SET IDENTITY_INSERT [Post].[RealEstateType] ON 

INSERT [Post].[RealEstateType] ([RealEstateType_ID], [Name], [ModifiedDate]) VALUES (1, N'Nhà', CAST(N'2018-11-17T15:10:51.377' AS DateTime))
INSERT [Post].[RealEstateType] ([RealEstateType_ID], [Name], [ModifiedDate]) VALUES (2, N'Đất', CAST(N'2018-11-17T15:10:54.273' AS DateTime))
INSERT [Post].[RealEstateType] ([RealEstateType_ID], [Name], [ModifiedDate]) VALUES (3, N'Căn hộ', CAST(N'2018-11-17T15:10:58.167' AS DateTime))
INSERT [Post].[RealEstateType] ([RealEstateType_ID], [Name], [ModifiedDate]) VALUES (4, N'Mặt bằng', CAST(N'2018-11-17T15:11:08.273' AS DateTime))
INSERT [Post].[RealEstateType] ([RealEstateType_ID], [Name], [ModifiedDate]) VALUES (5, N'Kho xưởng', CAST(N'2018-11-17T15:11:13.660' AS DateTime))
INSERT [Post].[RealEstateType] ([RealEstateType_ID], [Name], [ModifiedDate]) VALUES (10, N'Khác', CAST(N'2018-11-17T16:13:21.127' AS DateTime))
SET IDENTITY_INSERT [Post].[RealEstateType] OFF
SET IDENTITY_INSERT [Post].[Status] ON 

INSERT [Post].[Status] ([Status_ID], [Status_Type], [ModifiedDate]) VALUES (1, N'Chờ duyệt', CAST(N'2019-05-06T04:21:41.317' AS DateTime))
INSERT [Post].[Status] ([Status_ID], [Status_Type], [ModifiedDate]) VALUES (2, N'Đã duyệt', CAST(N'2019-05-06T04:21:46.703' AS DateTime))
INSERT [Post].[Status] ([Status_ID], [Status_Type], [ModifiedDate]) VALUES (3, N'Đã ẩn', CAST(N'2019-05-06T08:20:52.087' AS DateTime))
INSERT [Post].[Status] ([Status_ID], [Status_Type], [ModifiedDate]) VALUES (4, N'Đã ẩn', CAST(N'2019-05-06T08:20:46.037' AS DateTime))
INSERT [Post].[Status] ([Status_ID], [Status_Type], [ModifiedDate]) VALUES (5, N'Unblock', CAST(N'2018-11-17T15:13:34.690' AS DateTime))
SET IDENTITY_INSERT [Post].[Status] OFF
SET IDENTITY_INSERT [Post].[Type] ON 

INSERT [Post].[Type] ([PostType_ID], [Name]) VALUES (1, N'Cần bán')
INSERT [Post].[Type] ([PostType_ID], [Name]) VALUES (2, N'Cho thuê')
SET IDENTITY_INSERT [Post].[Type] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoleClaims]') AND name = N'IX_AspNetRoleClaims_RoleId')
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND name = N'RoleNameIndex')
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND name = N'IX_AspNetUserClaims_UserId')
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND name = N'IX_AspNetUserLogins_UserId')
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND name = N'IX_AspNetUserRoles_RoleId')
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND name = N'EmailIndex')
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND name = N'UserNameIndex')
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 5/8/2019 12:51:10 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sysdiagrams]') AND name = N'UK_principal_name')
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Block_Customer]') AND parent_object_id = OBJECT_ID(N'[Customer].[Block]'))
ALTER TABLE [Customer].[Block]  WITH CHECK ADD  CONSTRAINT [FK_Block_Customer] FOREIGN KEY([Cus_ID])
REFERENCES [Customer].[Customer] ([Customer_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Block_Customer]') AND parent_object_id = OBJECT_ID(N'[Customer].[Block]'))
ALTER TABLE [Customer].[Block] CHECK CONSTRAINT [FK_Block_Customer]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Customer_AspNetUsers]') AND parent_object_id = OBJECT_ID(N'[Customer].[Customer]'))
ALTER TABLE [Customer].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_AspNetUsers] FOREIGN KEY([Account_ID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Customer_AspNetUsers]') AND parent_object_id = OBJECT_ID(N'[Customer].[Customer]'))
ALTER TABLE [Customer].[Customer] CHECK CONSTRAINT [FK_Customer_AspNetUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Interested_Post_Customer]') AND parent_object_id = OBJECT_ID(N'[Customer].[Interested_Post]'))
ALTER TABLE [Customer].[Interested_Post]  WITH CHECK ADD  CONSTRAINT [FK_Interested_Post_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [Customer].[Customer] ([Customer_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Interested_Post_Customer]') AND parent_object_id = OBJECT_ID(N'[Customer].[Interested_Post]'))
ALTER TABLE [Customer].[Interested_Post] CHECK CONSTRAINT [FK_Interested_Post_Customer]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Interested_Post_Post]') AND parent_object_id = OBJECT_ID(N'[Customer].[Interested_Post]'))
ALTER TABLE [Customer].[Interested_Post]  WITH CHECK ADD  CONSTRAINT [FK_Interested_Post_Post] FOREIGN KEY([Post_ID])
REFERENCES [Post].[Post] ([Post_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Customer].[FK_Interested_Post_Post]') AND parent_object_id = OBJECT_ID(N'[Customer].[Interested_Post]'))
ALTER TABLE [Customer].[Interested_Post] CHECK CONSTRAINT [FK_Interested_Post_Post]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetRoleClaims_AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetRoleClaims]'))
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetRoleClaims_AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetRoleClaims]'))
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserClaims_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserClaims_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserLogins_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserLogins_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserRoles_AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserRoles_AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserRoles_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserRoles_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserTokens_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserTokens]'))
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AspNetUserTokens_AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserTokens]'))
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SubMenu_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubMenu]'))
ALTER TABLE [dbo].[SubMenu]  WITH CHECK ADD  CONSTRAINT [FK_SubMenu_Menu] FOREIGN KEY([Menu_Id])
REFERENCES [dbo].[Menu] ([Menu_Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SubMenu_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubMenu]'))
ALTER TABLE [dbo].[SubMenu] CHECK CONSTRAINT [FK_SubMenu_Menu]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Detail_Direction]') AND parent_object_id = OBJECT_ID(N'[Post].[Detail]'))
ALTER TABLE [Post].[Detail]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Direction] FOREIGN KEY([Direction_ID])
REFERENCES [Post].[Direction] ([Direction_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Detail_Direction]') AND parent_object_id = OBJECT_ID(N'[Post].[Detail]'))
ALTER TABLE [Post].[Detail] CHECK CONSTRAINT [FK_Detail_Direction]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Customer]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Customer] FOREIGN KEY([Author_ID])
REFERENCES [Customer].[Customer] ([Customer_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Customer]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_Customer]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Detail]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Detail] FOREIGN KEY([Detail])
REFERENCES [Post].[Detail] ([Detail_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Detail]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_Detail]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_PostType]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_PostType] FOREIGN KEY([PostType])
REFERENCES [Post].[Type] ([PostType_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_PostType]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_PostType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Project]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Project] FOREIGN KEY([Project])
REFERENCES [Post].[Project] ([Project_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Project]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_Project]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_RealEstaleType]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_RealEstaleType] FOREIGN KEY([RealEstaleType])
REFERENCES [Post].[RealEstateType] ([RealEstateType_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_RealEstaleType]') AND parent_object_id = OBJECT_ID(N'[Post].[Post]'))
ALTER TABLE [Post].[Post] CHECK CONSTRAINT [FK_Post_RealEstaleType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Image_Post]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Image]'))
ALTER TABLE [Post].[Post_Image]  WITH CHECK ADD  CONSTRAINT [FK_Post_Image_Post] FOREIGN KEY([Post_ID])
REFERENCES [Post].[Post] ([Post_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Image_Post]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Image]'))
ALTER TABLE [Post].[Post_Image] CHECK CONSTRAINT [FK_Post_Image_Post]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Report_Post]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Report]'))
ALTER TABLE [Post].[Post_Report]  WITH CHECK ADD  CONSTRAINT [FK_Post_Report_Post] FOREIGN KEY([Post_ID])
REFERENCES [Post].[Post] ([Post_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Report_Post]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Report]'))
ALTER TABLE [Post].[Post_Report] CHECK CONSTRAINT [FK_Post_Report_Post]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Status_Post]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Status]'))
ALTER TABLE [Post].[Post_Status]  WITH CHECK ADD  CONSTRAINT [FK_Post_Status_Post] FOREIGN KEY([Post_ID])
REFERENCES [Post].[Post] ([Post_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Status_Post]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Status]'))
ALTER TABLE [Post].[Post_Status] CHECK CONSTRAINT [FK_Post_Status_Post]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Status_Status]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Status]'))
ALTER TABLE [Post].[Post_Status]  WITH CHECK ADD  CONSTRAINT [FK_Post_Status_Status] FOREIGN KEY([Status])
REFERENCES [Post].[Status] ([Status_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Post_Status_Status]') AND parent_object_id = OBJECT_ID(N'[Post].[Post_Status]'))
ALTER TABLE [Post].[Post_Status] CHECK CONSTRAINT [FK_Post_Status_Status]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Project_Image_Project]') AND parent_object_id = OBJECT_ID(N'[Post].[Project_Image]'))
ALTER TABLE [Post].[Project_Image]  WITH CHECK ADD  CONSTRAINT [FK_Project_Image_Project] FOREIGN KEY([Project_ID])
REFERENCES [Post].[Project] ([Project_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Post].[FK_Project_Image_Project]') AND parent_object_id = OBJECT_ID(N'[Post].[Project_Image]'))
ALTER TABLE [Post].[Project_Image] CHECK CONSTRAINT [FK_Project_Image_Project]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_alterdiagram]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_alterdiagram] AS' 
END
GO

	ALTER PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_creatediagram]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_creatediagram] AS' 
END
GO

	ALTER PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_dropdiagram]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_dropdiagram] AS' 
END
GO

	ALTER PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_helpdiagramdefinition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition] AS' 
END
GO

	ALTER PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_helpdiagrams]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_helpdiagrams] AS' 
END
GO

	ALTER PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_renamediagram]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_renamediagram] AS' 
END
GO

	ALTER PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_upgraddiagrams]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_upgraddiagrams] AS' 
END
GO

	ALTER PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
/****** Object:  Trigger [Customer].[tgr_Customer.Block_InsertUpdate]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Customer].[tgr_Customer.Block_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Xuan Thuy
-- Create date: 17/11/2018
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [Customer].[tgr_Customer.Block_InsertUpdate] ON  [Customer].[Block]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @block_id int;
	DECLARE @cus_id int;

	SELECT @block_id = i.Block_ID FROM inserted i;
	SELECT @cus_id = i.Cus_ID FROM inserted i;

	IF NOT EXISTS(SELECT * FROM DELETED)
    BEGIN  -- Insert
        UPDATE Customer.Block
		SET ModifiedDate = DATEADD(HOUR, 7, GETDATE()), BlockDate = DATEADD(HOUR, 7, GETDATE())
		WHERE Block_ID = @block_id
    END
	ELSE  -- Update
	BEGIN
		UPDATE Customer.Block
		SET ModifiedDate = DATEADD(HOUR, 7, GETDATE())
		WHERE Block_ID = @block_id
	END

END
' 
GO
ALTER TABLE [Customer].[Block] ENABLE TRIGGER [tgr_Customer.Block_InsertUpdate]
GO
/****** Object:  Trigger [Customer].[tgr_Customer.Customer_InsertUpdate]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Customer].[tgr_Customer.Customer_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Xuan Thuy
-- Create date: 17/11/2018
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [Customer].[tgr_Customer.Customer_InsertUpdate] ON  [Customer].[Customer]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @cus_id int;

	SELECT @cus_id = i.Customer_ID FROM inserted i;

        UPDATE Customer.Customer
		SET ModifiedDate = DATEADD(HOUR, 7, GETDATE())
		WHERE Customer_ID = @cus_id

END
' 
GO
ALTER TABLE [Customer].[Customer] ENABLE TRIGGER [tgr_Customer.Customer_InsertUpdate]
GO
/****** Object:  Trigger [Customer].[tgr_Customer.Interested_Post_InsertUpdate]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Customer].[tgr_Customer.Interested_Post_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
CREATE TRIGGER [Customer].[tgr_Customer.Interested_Post_InsertUpdate] ON  [Customer].[Interested_Post]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @cus_id int;
	DECLARE @post_id int;

	SELECT @cus_id = i.Customer_ID FROM inserted i;
	SELECT @post_id = i.Post_ID FROM inserted i;


        UPDATE Customer.Interested_Post
		SET ModifiedDate = GETDATE()
		WHERE Customer_ID = @cus_id AND Post_ID = @post_id

END
' 
GO
ALTER TABLE [Customer].[Interested_Post] ENABLE TRIGGER [tgr_Customer.Interested_Post_InsertUpdate]
GO
/****** Object:  Trigger [Post].[tgr_Post.Detail_InsertUpdate]    Script Date: 5/8/2019 12:51:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[tgr_Post.Detail_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Xuan Thuy
-- Create date: 17/11/2018
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [Post].[tgr_Post.Detail_InsertUpdate] ON  [Post].[Detail]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @det_id int;

	SELECT @det_id = i.Detail_ID FROM inserted i;

			UPDATE Post.Detail
			SET ModifiedDate = GETDATE()
			WHERE Detail_ID = @det_id


END
' 
GO
ALTER TABLE [Post].[Detail] ENABLE TRIGGER [tgr_Post.Detail_InsertUpdate]
GO
/****** Object:  Trigger [Post].[setPostTime_Status]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[setPostTime_Status]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [Post].[setPostTime_Status] ON  [Post].[Post]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @post_id varchar(300);

	SELECT @post_id = i.Post_ID FROM inserted i;

	UPDATE Post.Post 
	SET Status = 1
	WHERE Post_ID = @post_id

	IF NOT EXISTS(SELECT * FROM DELETED)
		BEGIN -- insert
			INSERT INTO Post.Post_Status (Post_ID, Status, CensorshipTime, Reason)
			VALUES (@post_id, 1, GETDATE(), ''new POST'')
		END

END
' 
GO
ALTER TABLE [Post].[Post] ENABLE TRIGGER [setPostTime_Status]
GO
/****** Object:  Trigger [Post].[tgr_Post.Post_Image_InsertUpdate]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[tgr_Post.Post_Image_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [Post].[tgr_Post.Post_Image_InsertUpdate] ON  [Post].[Post_Image]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @img_id int;
	--DECLARE @post_id int

	SELECT @img_id = i.Image_ID FROM inserted i;
	--SELECT @post_id = i.Post_ID FROM inserted i;


        UPDATE Post.Post_Image
		SET AddedDate = GETDATE()
		WHERE Image_ID = @img_id --AND Post_ID = @post_id
END
' 
GO
ALTER TABLE [Post].[Post_Image] ENABLE TRIGGER [tgr_Post.Post_Image_InsertUpdate]
GO
/****** Object:  Trigger [Post].[tgr_Post.Post_Report_InsertUpdate]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[tgr_Post.Post_Report_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [Post].[tgr_Post.Post_Report_InsertUpdate] ON  [Post].[Post_Report]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @rep_id int;
	--DECLARE @post_id int

	SELECT @rep_id = i.Post_Report_ID FROM inserted i;


        UPDATE Post.Post_Report
		SET Report_Time = GETDATE(), Status = 0
		WHERE Post_Report_ID = @rep_id
END
' 
GO
ALTER TABLE [Post].[Post_Report] ENABLE TRIGGER [tgr_Post.Post_Report_InsertUpdate]
GO
/****** Object:  Trigger [Post].[tgr_Post.Post_Status_InsertUpdate]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[tgr_Post.Post_Status_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [Post].[tgr_Post.Post_Status_InsertUpdate] ON  [Post].[Post_Status]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @sta_id int;

	SELECT @sta_id = i.Post_Status_ID FROM inserted i;


    UPDATE Post.Post_Status
	SET CensorshipTime = GETDATE()
	WHERE Post_Status_ID = @sta_id

	DECLARE @post_id varchar(300)
	DECLARE @stt int

	SELECT @post_id = i.Post_ID, @stt = i.Status FROM inserted i;

	UPDATE Post.Post
	SET Status = @stt
	WHERE Post_ID = @post_id
END
' 
GO
ALTER TABLE [Post].[Post_Status] ENABLE TRIGGER [tgr_Post.Post_Status_InsertUpdate]
GO
/****** Object:  Trigger [Post].[tgr_Post.Project_InsertUpdate]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[tgr_Post.Project_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
CREATE TRIGGER [Post].[tgr_Post.Project_InsertUpdate] ON  [Post].[Project]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @id int;

	SELECT @id = i.Project_ID FROM inserted i;


        UPDATE Post.Project
		SET ModifiedDate = GETDATE()
		WHERE Project_ID = @id

END
' 
GO
ALTER TABLE [Post].[Project] ENABLE TRIGGER [tgr_Post.Project_InsertUpdate]
GO
/****** Object:  Trigger [Post].[tgr_Post.RealEstateType_InsertUpdate]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[tgr_Post.RealEstateType_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
CREATE TRIGGER [Post].[tgr_Post.RealEstateType_InsertUpdate] ON  [Post].[RealEstateType]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @id int;

	SELECT @id = i.RealEstateType_ID FROM inserted i;


        UPDATE Post.RealEstateType
		SET ModifiedDate = GETDATE()
		WHERE RealEstateType_ID = @id

END
' 
GO
ALTER TABLE [Post].[RealEstateType] ENABLE TRIGGER [tgr_Post.RealEstateType_InsertUpdate]
GO
/****** Object:  Trigger [Post].[tgr_Post.Status_InsertUpdate]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Post].[tgr_Post.Status_InsertUpdate]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
CREATE TRIGGER [Post].[tgr_Post.Status_InsertUpdate] ON  [Post].[Status]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @stt_id int;

	SELECT @stt_id = i.Status_ID FROM inserted i;


        UPDATE Post.Status
		SET ModifiedDate = GETDATE()
		WHERE Status_ID = @stt_id

END
' 
GO
ALTER TABLE [Post].[Status] ENABLE TRIGGER [tgr_Post.Status_InsertUpdate]
GO
/****** Object:  DdlTrigger [ddlDatabaseTriggerLog]    Script Date: 5/8/2019 12:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE parent_class_desc = 'DATABASE' AND name = N'ddlDatabaseTriggerLog')
EXECUTE dbo.sp_executesql N'
CREATE TRIGGER [ddlDatabaseTriggerLog] ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @data XML;
    DECLARE @schema sysname;
    DECLARE @object sysname;
    DECLARE @eventType sysname;

    SET @data = EVENTDATA();
    SET @eventType = @data.value(''(/EVENT_INSTANCE/EventType)[1]'', ''sysname'');
    SET @schema = @data.value(''(/EVENT_INSTANCE/SchemaName)[1]'', ''sysname'');
    SET @object = @data.value(''(/EVENT_INSTANCE/ObjectName)[1]'', ''sysname'') 

    IF @object IS NOT NULL
        PRINT ''  '' + @eventType + '' - '' + @schema + ''.'' + @object;
    ELSE
        PRINT ''  '' + @eventType + '' - '' + @schema;

    IF @eventType IS NULL
        PRINT CONVERT(nvarchar(max), @data);

    
END;
'
GO
ENABLE TRIGGER [ddlDatabaseTriggerLog] ON DATABASE
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'microsoft_database_tools_support' , N'SCHEMA',N'dbo', N'TABLE',N'sysdiagrams', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
USE [master]
GO
ALTER DATABASE [RealEstateSystem] SET  READ_WRITE 
GO
