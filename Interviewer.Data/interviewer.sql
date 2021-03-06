USE [Interviewer]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateQuestion]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_UpdateQuestion]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdatePlatform]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_UpdatePlatform]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateKnowledgeArea]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_UpdateKnowledgeArea]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateArea]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_UpdateArea]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetInterviewerData]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_GetInterviewerData]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteQuestion]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_DeleteQuestion]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeletePlatform]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_DeletePlatform]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteKnowledgeArea]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_DeleteKnowledgeArea]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteArea]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_DeleteArea]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddQuestion]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_AddQuestion]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddPlatform]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_AddPlatform]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddKnowledgeArea]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_AddKnowledgeArea]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddArea]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP PROCEDURE [dbo].[usp_AddArea]
GO
ALTER TABLE [dbo].[Questions] DROP CONSTRAINT [FK_Questions_Areas]
GO
ALTER TABLE [dbo].[ProfileItem] DROP CONSTRAINT [FK_ProfileItem_Profiles]
GO
ALTER TABLE [dbo].[ProfileItem] DROP CONSTRAINT [FK_ProfileItem_Platforms]
GO
ALTER TABLE [dbo].[ProfileItem] DROP CONSTRAINT [FK_ProfileItem_KnowledgeAreas]
GO
ALTER TABLE [dbo].[ProfileItem] DROP CONSTRAINT [FK_ProfileItem_Areas]
GO
ALTER TABLE [dbo].[KnowledgeAreas] DROP CONSTRAINT [FK_KnowledgeAreas_Platforms]
GO
ALTER TABLE [dbo].[Areas] DROP CONSTRAINT [FK_Areas_KnowledgeAreas]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP TABLE [dbo].[Questions]
GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP TABLE [dbo].[Profiles]
GO
/****** Object:  Table [dbo].[ProfileItem]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP TABLE [dbo].[ProfileItem]
GO
/****** Object:  Table [dbo].[Platforms]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP TABLE [dbo].[Platforms]
GO
/****** Object:  Table [dbo].[KnowledgeAreas]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP TABLE [dbo].[KnowledgeAreas]
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP TABLE [dbo].[Areas]
GO
USE [master]
GO
/****** Object:  Database [Interviewer]    Script Date: 3/12/2016 5:42:43 PM ******/
DROP DATABASE [Interviewer]
GO
/****** Object:  Database [Interviewer]    Script Date: 3/12/2016 5:42:43 PM ******/
CREATE DATABASE [Interviewer]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Interviewer', FILENAME = N'C:\Code\Data\Interviewer.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Interviewer_log', FILENAME = N'C:\Code\Data\Interviewer_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Interviewer] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Interviewer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Interviewer] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Interviewer] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Interviewer] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Interviewer] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Interviewer] SET ARITHABORT OFF 
GO
ALTER DATABASE [Interviewer] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Interviewer] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Interviewer] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Interviewer] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Interviewer] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Interviewer] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Interviewer] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Interviewer] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Interviewer] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Interviewer] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Interviewer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Interviewer] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Interviewer] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Interviewer] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Interviewer] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Interviewer] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Interviewer] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Interviewer] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Interviewer] SET  MULTI_USER 
GO
ALTER DATABASE [Interviewer] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Interviewer] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Interviewer] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Interviewer] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Interviewer] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Interviewer]
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[KnowledgeAreaId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_Areas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KnowledgeAreas]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KnowledgeAreas](
	[PlatformId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_KnowledgeAreas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Platforms]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Platforms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_dbo.Platforms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProfileItem]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileItem](
	[ProfileId] [int] NOT NULL,
	[PlatformId] [int] NULL,
	[KnowledgeAreaId] [int] NULL,
	[AreaId] [int] NULL,
	[IsRequired] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_Profiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Questions]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[AreaId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Weight] [int] NOT NULL DEFAULT ((1)),
	[Level] [int] NOT NULL DEFAULT ((1)),
	[Value] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](150) NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[AreaId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Areas] ON 

INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 1, N'Managed vs non managed', N'Questions about Managed vs non managed')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 2, N'Object''s life cycle', N'Questions about Object''s life cycle')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 3, N'Garbage collection', N'Questions about Garbage collection')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 4, N'Base objects/root object', N'Questions about Base objects/root object')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 5, N'Base object methods', N'Questions about Base object methods')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 6, N'Main namespaces', N'Questions about Main namespaces')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 7, N'Reflection', N'Questions about Reflection')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (1, 8, N'Localization', N'Questions about Localization')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 9, N'Variable declarations', N'Questions about Variable declarations')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 10, N'Regular Expressions', N'Questions about Regular Expressions')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 11, N'Exceptions', N'Questions about Exceptions')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 12, N'Keywords', N'Questions about Keywords')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 13, N'Static classes/methods', N'Questions about Static classes/methods')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 14, N'Value and reference types', N'Questions about Value and reference types')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 15, N'Data types', N'Questions about Data types')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 16, N'String vs StringBuilder', N'Questions about String vs StringBuilder')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 17, N'Collections', N'Questions about Collections')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 18, N'Generics', N'Questions about Generics')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (2, 19, N'LinQ', N'Questions about LinQ')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (3, 20, N'Encapsulation', N'Questions about Encapsulation')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (3, 21, N'Inheritance', N'Questions about Inheritance')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (3, 22, N'Polymorphism', N'Questions about Polymorphism')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (3, 23, N'Interfaces', N'Questions about Interfaces')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (4, 24, N'Concepts', N'Questions about Concepts')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (4, 25, N'Factory method', N'Questions about Factory method')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (4, 26, N'Singleton', N'Questions about Singleton')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (4, 27, N'Builder', N'Questions about Builder')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (5, 28, N'SOLID', N'Questions about SOLID')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (5, 29, N'Performance/Caching', N'Questions about Performance/Caching')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (5, 30, N'Messaging', N'Questions about Messaging')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (5, 31, N'Scheduling', N'Questions about Scheduling')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (6, 32, N'Web Concepts', N'Questions about Web Concepts')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (6, 33, N'Web API', N'Questions about Web API')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (6, 34, N'MVC Development', N'Questions about MVC Development')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (6, 35, N'WCF', N'Questions about WCF')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (6, 36, N'HTML 5', N'Questions about HTML 5')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (6, 37, N'AngularJS', N'Questions about AngularJS')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (7, 38, N'Concepts', N'Questions about Concepts')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (8, 39, N'Array declarations', N'Questions about Array declarations')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (8, 40, N'Word/char counting', N'Questions about Word/char counting')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (8, 41, N'String splitting', N'Questions about String splitting')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (8, 42, N'Word reversing', N'Questions about Word reversing')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (9, 43, N'Concepts and Frameworks', N'Questions about Concepts and Frameworks')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (10, 44, N'Agile Concepts', N'Questions about agile development')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (11, 50, N'Advanced Reflection', N'Questions about Advanced Reflection')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (11, 51, N'Advanced Reflection Methods', N'Questions about Advanced Reflection Methods')
INSERT [dbo].[Areas] ([KnowledgeAreaId], [Id], [Name], [Description]) VALUES (11, 52, N'Code Emit', N'Questions about Code Emit')
SET IDENTITY_INSERT [dbo].[Areas] OFF
SET IDENTITY_INSERT [dbo].[KnowledgeAreas] ON 

INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (1, 1, N'Framework Fundamentals', N'Funtamental concepts about the Framework')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (1, 2, N'C# knowledge', N'Basic C# knowledge')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (2, 3, N'Object Oriented Programming', N'Object Oriented Programming concepts')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (2, 4, N'Patterns', N'All about Development Patterns')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (2, 5, N'Application Design', N'Application Design and its concerns')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (3, 6, N'Web Applications', N'Web Applications and its Roles')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (4, 7, N'SQL Development', N'SQL Development concepts and practices')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (5, 8, N'Basic Algorithms', N'Basic Development Algorithms')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (6, 9, N'Unit Testing', N'Unit Testing implementation')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (7, 10, N'Agile Development', N'Agile Development terminolog')
INSERT [dbo].[KnowledgeAreas] ([PlatformId], [Id], [Name], [Description]) VALUES (1, 11, N'Advanced CSharp', N'Advanced CSharp terms')
SET IDENTITY_INSERT [dbo].[KnowledgeAreas] OFF
SET IDENTITY_INSERT [dbo].[Platforms] ON 

INSERT [dbo].[Platforms] ([Id], [Name], [Description]) VALUES (1, N'Net Framework', N'Knowledge about Net Framework')
INSERT [dbo].[Platforms] ([Id], [Name], [Description]) VALUES (2, N'Applications Development', N'Applications Development Best Practices')
INSERT [dbo].[Platforms] ([Id], [Name], [Description]) VALUES (3, N'Web Development', N'Web Development and its stack')
INSERT [dbo].[Platforms] ([Id], [Name], [Description]) VALUES (4, N'Database Development', N'Database Development and its Tools')
INSERT [dbo].[Platforms] ([Id], [Name], [Description]) VALUES (5, N'Algorithms Solution', N'Simple algorithms solution')
INSERT [dbo].[Platforms] ([Id], [Name], [Description]) VALUES (6, N'Testing', N'Testing frameworks and Concepts')
INSERT [dbo].[Platforms] ([Id], [Name], [Description]) VALUES (7, N'Agile', N'Agile development and its terms')
SET IDENTITY_INSERT [dbo].[Platforms] OFF
INSERT [dbo].[ProfileItem] ([ProfileId], [PlatformId], [KnowledgeAreaId], [AreaId], [IsRequired]) VALUES (1, 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Profiles] ON 

INSERT [dbo].[Profiles] ([Id], [Name], [Description]) VALUES (1, N'DEV III', N'Software Engineer')
INSERT [dbo].[Profiles] ([Id], [Name], [Description]) VALUES (2, N'DEV IV', N'Senior Software Engineer')
INSERT [dbo].[Profiles] ([Id], [Name], [Description]) VALUES (3, N'SEL', N'Software Engineer Leader')
SET IDENTITY_INSERT [dbo].[Profiles] OFF
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 1, 1, 1, N'Please describe what is the .net framework and its characteristics?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 2, 1, 1, N'What is a managed framework and what is a non-managed framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 3, 1, 1, N'What’s the principal characteristic of a managed framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 4, 1, 1, N'What are the advantages and disadvantages of a managed framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 5, 1, 1, N'How is memory allocated and accessed in a non-managed framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 6, 1, 1, N'Is the .net framework a managed framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 7, 1, 1, N'Does C++ run in a managed environment?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 8, 1, 1, N'What is the common language runtime (CLR) in .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 9, 1, 1, N'Please describe up to 3 languages you can use to develop applications in .net framework', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 10, 1, 1, N'Why is possible you can develop a library in F# and you can use it in a C# project?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 11, 1, 1, N'How code is built in the .net framework and how is executed?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 12, 1, 1, N'Does the .net framework binary code generated at compilation is native code? ', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 13, 1, 1, N'In Java, code is generated in byte code and then interpreted by the JVM, what is the name of the intermediate code generated in the .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 14, 1, 1, N'If speed is critical for one application or service, would you consider its implementation in the .net framework or you better go the native way?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 15, 1, 1, N'If security is critical for one application or service, would you consider its implementation in the .net framework or you better go the native way or choose another platform?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 16, 1, 1, N'Please enumerate up to four types of visual studio projects you can create targeting the .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 17, 1, 1, N'Do you consider the .net framework as a successful development platform and what could be the reason of its success?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 18, 1, 1, N'Does the .net framework run in embedded systems?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (1, 19, 1, 1, N'How do you think applications/services development will be done in 30 years?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (2, 20, 1, 1, N'What’s the life cycle of an object in the .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (3, 21, 1, 1, N'What’s the function of the garbage collection in the .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (3, 22, 1, 1, N'Does the garbage collection process run automatically, what are the conditions that trigger this process?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (3, 23, 1, 1, N'Can I force the execution of the garbage collection process?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (3, 24, 1, 1, N'If my class uses resources that need to be disposed when my instance is no longer needed, what interface does it need to implement?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (4, 25, 1, 1, N'What class is the root class of all the .net classes?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (4, 26, 1, 1, N'What is boxing/unboxing/casting in .net?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 27, 1, 1, N'Please enumerate up to 3 public methods of the Object class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 28, 1, 1, N'What methods can I override from the Object class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 29, 1, 1, N'What is the meaning of overriding a method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 30, 1, 1, N'What is the meaning of overloading a method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 31, 1, 1, N'How do you define optional parameters in a method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 32, 1, 1, N'If you have multiple optional parameters in a method, how can you call them in any order you wish?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 33, 1, 1, N'Once you have defined an optional parameter in some specific method of your class, can you define another non-optional parameter to the right of the optional one?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 34, 1, 1, N'What should be the signature of a class method which supports receiving any number of parameters of the same type (string.Format() for example)?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (5, 35, 1, 1, N'How can you compare that two objects are from the same type?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 36, 1, 1, N'Please enumerate most common used (up to 4) name spaces available in .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 37, 1, 1, N'Can I load or unload dynamically a namespace/library?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 38, 1, 1, N'What is an App Domain?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 39, 1, 1, N'In your class definition what keyword you use to import a specific namespace/library?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 40, 1, 1, N'In a console if you want to write a text line into output, what instruction should you use?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 41, 1, 1, N'What is a nuget package?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 42, 1, 1, N'In which namespace resides the DateTime class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 43, 1, 1, N'In which namespace resides the Int32 class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 44, 1, 1, N'In which namespace resides the StringBuilder class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 45, 1, 1, N'In which namespace resides the Stream class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 46, 1, 1, N'Is the Stream class abstract?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 47, 1, 1, N'Please tell me one class which implements the Stream class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (6, 48, 1, 1, N'What is the use of those classes inheriting from Stream class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (7, 49, 1, 1, N'Do you think is possible to generate code in any language or an html page from a .net assembly you have built?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (7, 50, 1, 1, N'What is reflection in .net framework and why is so powerful?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (7, 51, 1, 1, N'Is reflection technology available only in .net framework or is also available in other platforms like Java?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (7, 52, 1, 1, N'What is the main method exposed by the .net framework for start reflecting an object?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (7, 53, 1, 1, N'What are the main methods you can use when discovering/describing an object?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (7, 54, 1, 1, N'What is code obfuscation of an assembly and how can be implemented?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (7, 55, 1, 1, N'When should you create classes inheriting from System.Attribute class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (8, 56, 1, 1, N'What is needed in a visual studio solution to support more than one speaking language (English and Spanish for example) when displaying text to end users?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (8, 57, 1, 1, N'How do you handle dates so they display properly in different speaking languages (British and American English for example)?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (9, 58, 1, 1, N'What is the use of the var keyword in C#?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (9, 59, 1, 1, N'Can you give me one reason you may declare a variable using var instead of specifying the type?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (10, 60, 1, 1, N'What is a regular expression and what is their usage?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (10, 61, 1, 1, N'What is a regular expression pattern?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (10, 62, 1, 1, N'How do you define a regular expression pattern to only accept alphabetic characters in lower and upper case?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (10, 63, 1, 1, N'How do you define a regular expression pattern to only accept from 2 to 8 digits (numbers)?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (11, 64, 1, 1, N'What is the base class of all .net framework exceptions?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (11, 65, 1, 1, N'How do you throw an exception in the .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (11, 66, 1, 1, N'How do you handle exceptions in your code?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (11, 67, 1, 1, N'What is the usage of the finally statement in an exception handling block?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (11, 68, 1, 1, N'What common action(s) you may take when you handle an exception?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 69, 1, 1, N'Could you enumerate at least 5 C# keywords and its uses?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 70, 1, 1, N'What are the main uses of the using keyword/statement?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 71, 1, 1, N'Over what kind of objects works the foreach statement?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 72, 1, 1, N'How is a typical foreach statement definition?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 73, 1, 1, N'What happens when you use the break and/or continue keywords inside a for/foreach statement?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 74, 1, 1, N'Where can you initialize a private variable you’ve prefixed with the readonly keyword in your class definition?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 75, 1, 1, N'What the keyword async is used for and which other keyword needs to be set when you use it?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 76, 1, 1, N'What is the use of the static keyword in C# when applied to a class, method and field?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (12, 77, 1, 1, N'When should you prefix a class as sealed?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (13, 78, 1, 1, N'Why you may need to use static classes in C#?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (13, 79, 1, 1, N'What is the lifecycle of a static instance of your class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (13, 80, 1, 1, N'Can also a class methods or properties be prefixed as static?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (13, 81, 1, 1, N'If you define a class method as static can you use the “this” keyword to refer to the current instance?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (14, 82, 1, 1, N'What are value types and reference types?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (14, 83, 1, 1, N'The .net framework primitive types are value types or reference types?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (15, 84, 1, 1, N'Please enumerate at least 5 primitive types of the .net framework.', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (15, 85, 1, 1, N'To what type maps the int type in the .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (15, 86, 1, 1, N'To what type maps the long type in the .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (15, 87, 1, 1, N'How do you handle date time types when you have several clients working on different world time zones?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (15, 88, 1, 1, N'What date should return DateTime.MinDate?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (16, 89, 1, 1, N'What are immutable values in .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (16, 90, 1, 1, N'String type is immutable or mutable?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (16, 91, 1, 1, N'When should I use String class and when the StringBuilder class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (16, 92, 1, 1, N'What are the most common used methods of the StringBuilder class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (16, 93, 1, 1, N'What method of the string class you use to split a string sentence separated by spaces?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (16, 94, 1, 1, N'What method should you use to join that split string back again?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (17, 95, 1, 1, N'What is the main difference between a string array and a list of strings, i.e. between arrays and collections?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (17, 96, 1, 1, N'Please enumerate at least 4 most used .net framework collection classes.', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (17, 97, 1, 1, N'What is the difference between a list and a dictionary?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (18, 98, 1, 1, N'What are the generic classes and where does make sense to use them?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (18, 99, 1, 1, N'Do generic class implementations improve code maintenance and readability?', N'')
GO
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (18, 100, 1, 1, N'What is the main advantage of using generics?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (18, 101, 1, 1, N'If you want to implement a stack class of items where they can be integers, strings or custom classes, how do you implement it using generics? ', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (18, 102, 1, 1, N'What should be the header signature of a stack class of any type of items implemented using generics?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 103, 1, 1, N'What is LinQ used for?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 104, 1, 1, N'What are anonymous variables and how you define them in a LinQ select clause?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 105, 1, 1, N'When you use the let keyword in a linq expression?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 106, 1, 1, N'What namespace you need to import to use a standard array of integers with linq expressions?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 107, 1, 1, N'What linq instruction should you use to get the maximum value from an array of integers?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 108, 1, 1, N'What linq instruction should you use to get the sum of all values from an array of integers?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 109, 1, 1, N'If you have a dictionary of string keys and its values as integers, can you summarize the values grouped by keys?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (19, 110, 1, 1, N'When you should use the First() and when you should use FirstOrDefault() methods within LinQ?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 111, 1, 1, N'In OOP what is encapsulation and why is one of the pillars of OOP?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 112, 1, 1, N'In .net framework what is the visibility of a private var?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 113, 1, 1, N'In .net framework what is the usage of a protected var?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 114, 1, 1, N'What is shadowing of a class property in .net framework?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 115, 1, 1, N'In .net framework, what is the standard definition of a public property getter, setter (int property for example)?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 116, 1, 1, N'What is a constructor and a destructor of a class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 117, 1, 1, N'Can constructors be declared as private in C#?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (20, 118, 1, 1, N'Can multiple constructors be declared in C# for some given class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 119, 1, 1, N'What is the meaning of the inheritance term in OOP?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 120, 1, 1, N'What is a base class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 121, 1, 1, N'What is a root class of a hierarchy of classes?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 122, 1, 1, N'Why you may need to implement a hierarchy of classes?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 123, 1, 1, N'What (items) should be defined in a base class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 124, 1, 1, N'What (methods) should be implemented in a base class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 125, 1, 1, N'In .net framework what C# keyword you use to define your class can not be instantiated?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 126, 1, 1, N'In .net framework what C# keyword you use to define your class can not be inherited anymore?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (21, 127, 1, 1, N'In .net framework what C# keyword you use to define your derived classes must implement a specific method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (22, 128, 1, 1, N'What is the meaning of the polymorphism term in OOP?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (22, 129, 1, 1, N'How the polymorphism is implemented in a derived class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (22, 130, 1, 1, N'In a base class, how do you define that “A” method has a default implementation and how you define that “B” method has no default implementation so, once that class is derived you have to provide the non-default implementation?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (22, 131, 1, 1, N'Does C# support your class inherit from multiple classes?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (22, 132, 1, 1, N'In C# how do you implement multiple inheritance?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (23, 133, 1, 1, N'What is an interface?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (23, 134, 1, 1, N'What C# keyword is used to define an interface?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (23, 135, 1, 1, N'What items can be defined in an interface?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (23, 136, 1, 1, N'In the .net framework, can properties be declared in an interface?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (23, 137, 1, 1, N'Can interface methods be declared as private or protected?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (23, 138, 1, 1, N'When you may use an interface instead of an abstract class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (23, 139, 1, 1, N'What are the main differences between an interface and an abstract class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (24, 140, 1, 1, N'What is the meaning of software patterns, what are their benefits?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (25, 141, 1, 1, N'Please describe in what cases is recommended to implement the factory method pattern', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (25, 142, 1, 1, N'Please enumerate at least 2 classes in .net framework or third party components which implement the factory method pattern', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (26, 143, 1, 1, N'Please describe what is the singleton pattern and when should be used?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (26, 144, 1, 1, N'Please describe the standard implementation of the singleton pattern', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (27, 145, 1, 1, N'Please describe in what cases is recommended to implement the builder pattern', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (27, 146, 1, 1, N'Please enumerate at least 2 classes/frameworks/platforms you know implement the builder pattern', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (28, 147, 1, 1, N'What is a loosely coupled design of classes and what are its main benefits?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (28, 148, 1, 1, N'In software development SOLID what the S stands for?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (28, 149, 1, 1, N'In software development SOLID what the O stands for?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (28, 150, 1, 1, N'In software development SOLID what the L stands for?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (28, 151, 1, 1, N'In software development SOLID what the I stands for?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (28, 152, 1, 1, N'In software development SOLID what the D stands for?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (29, 153, 1, 1, N'What should be an acceptable time duration for a web page to be rendered in a web site?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (29, 154, 1, 1, N'What is the caching technology and how it may be implemented in a C# project?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (29, 155, 1, 1, N'What items should be cached in an application?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (29, 156, 1, 1, N'Please enumerate at least 2 ways in .net framework to implement caching.', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (29, 157, 1, 1, N'What may be the difference between a Session/Application (web development) and a cache store?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (29, 158, 1, 1, N'How values are saved/retrieved commonly from a cache store?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (29, 159, 1, 1, N'What conditions you may set on your cache items to set its expiration?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (30, 160, 1, 1, N'What is the main usage of the messaging technology?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (30, 161, 1, 1, N'What event model does messaging commonly uses?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (30, 162, 1, 1, N'In what cases you should incorporate the messaging stack within your application?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (30, 163, 1, 1, N'Please enumerate at least 2 technologies/platforms for messaging.', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (31, 164, 1, 1, N'Why scheduling technology should be used in complex systems/services?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (31, 165, 1, 1, N'Please enumerate at least 2 technologies/platforms for scheduling.', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (31, 166, 1, 1, N'What is a standard way to implement in .net framework a scheduled service and what kind of visual studio project can be used?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 167, 1, 1, N'What is a Request object?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 168, 1, 1, N'What is a Response object?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 169, 1, 1, N'In a web communication, who creates the request object and who creates the response object?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 170, 1, 1, N'What are the Header attributes of a request or response and what is its use?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 171, 1, 1, N'What is the lifecycle of a Request?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 172, 1, 1, N'Why we said the web is stateless?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 173, 1, 1, N'How many web.config files can a web application have?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 174, 1, 1, N'Please enumerate the principal http verbs when making a request to a server and its use.', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 175, 1, 1, N'Please enumerate the most common Response code statuses', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 176, 1, 1, N'In IIS what is the default port number for a web application?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 177, 1, 1, N'In IIS what is the default port number for a secured web application (TLS/SSL)', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (32, 178, 1, 1, N'In IIS what is an application pool and what is used for?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 179, 1, 1, N'What is an API controller?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 180, 1, 1, N'Why Web API is considered as a REST API?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 181, 1, 1, N'What is the base class of the API controller?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 182, 1, 1, N'Does a Web API controller inherit the same base class than the MVC controller?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 183, 1, 1, N'What is a Web API Route?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 184, 1, 1, N'How do you define a Route for a controller method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 185, 1, 1, N'What type of objects can be returned from a Web API controller method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 186, 1, 1, N'What is the use of the Response Type attribute for a controller method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 187, 1, 1, N'Please enumerate the 2 common methods of serialization used by the Web API?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 188, 1, 1, N'What is the JSON and Xml serialization?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 189, 1, 1, N'Speaking of security, what’s the difference between Authentication and Authorization?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 190, 1, 1, N'In a web project, can I implement custom Authentication and Authorization? ', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 191, 1, 1, N'If speed is critical for your web project, would you use Web API or WCF?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (33, 192, 1, 1, N'If security is critical for your web project, would you use Web API or WCF?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (34, 193, 1, 1, N'What is a MVC controller?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (34, 194, 1, 1, N'What is a MVC view?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (34, 195, 1, 1, N'What is a POCO class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (35, 196, 1, 1, N'What is a WSDL definition of a WCF project?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (35, 197, 1, 1, N'In what format messages are serialized in WCF?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (35, 198, 1, 1, N'Commonly in what part of a Soap message do you send security credentials?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (36, 199, 1, 1, N'What are the principal tags available in HTML 5?', N'')
GO
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (36, 200, 1, 1, N'What does SVG is in HTML 5?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (36, 201, 1, 1, N'What is a SPA application?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (36, 202, 1, 1, N'What is a Responsive application?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (37, 203, 1, 1, N'What is a $scope object in angular?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (37, 204, 1, 1, N'What do you need to apply to your html page to support angular?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (37, 205, 1, 1, N'What is an angular module?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (37, 206, 1, 1, N'What is an angular controller?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 207, 1, 1, N'What is the Normalization Term in SQL?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 208, 1, 1, N'Should you always have normalized schemas or may not apply in all circumstances?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 209, 1, 1, N'What are the common CRUD SQL operation statements?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 210, 1, 1, N'What is a Primary Key?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 211, 1, 1, N'What is an Index?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 212, 1, 1, N'What is the difference between a Primary Key and an Index?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 213, 1, 1, N'What is a SQL constraint?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 214, 1, 1, N'What’s the reason you may set the unique constraint on a table column?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 215, 1, 1, N'What are the primary types for columns in a data table?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 216, 1, 1, N'What is a View?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 217, 1, 1, N'What is a Trigger and when is executed?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 218, 1, 1, N'What is the difference between a SQL function and a store procedure?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 219, 1, 1, N'What is a SQL transacted operation and its common statements?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 220, 1, 1, N'When you should run SQL operations using transaction statements?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 221, 1, 1, N'When matching tables, what are the most common types of joins you can apply?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 222, 1, 1, N'When you create a database oriented project, what stack or performant framework should you use?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (38, 223, 1, 1, N'What is the recommended way to save/retrieve data, using SQL queries or call store procedures?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (39, 224, 1, 1, N'How you define an array of integers?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (39, 225, 1, 1, N'How you make sure you initialize an array of integers before being used?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (39, 226, 1, 1, N'If you define a List<string>, what returns the ToArray() method of that list?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (39, 227, 1, 1, N'If you define a string[], what returns the ToList() method of that instance?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (40, 228, 1, 1, N'Please describe the steps you must do to count the words on a text file?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (40, 229, 1, 1, N'What else should I do to also fill a dictionary of letters and its incidences?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (41, 230, 1, 1, N'What is the standard method to split a string?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (41, 231, 1, 1, N'What do I need to do to avoid retrieving empty strings when splitting a string?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (41, 232, 1, 1, N'When splitting a string, can I split the string using some specific string or some specific char?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (42, 233, 1, 1, N'Please describe the steps you must do to reverse a string?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (42, 234, 1, 1, N'Please describe the steps you must do to sort a split string by its words length?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 235, 1, 1, N'What is the difference between Unit Test and Integration Test?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 236, 1, 1, N'What is TDD?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 237, 1, 1, N'How do you ensure you code is friendlier to unit testing?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 238, 1, 1, N'What attribute you need to set to mark a class as a test class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 239, 1, 1, N'What is the purpose of using the Setup attribute on a test class method?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 240, 1, 1, N'How do you tell the testing framework you want to ignore this test class method to be ignored when running all tests?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 241, 1, 1, N'What is an assertion?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 242, 1, 1, N'What are the common methods of the Assert class (or equivalent)?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 243, 1, 1, N'What is a Fake class?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 244, 1, 1, N'Does help using interfaces in your code the unit testing process?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (43, 245, 1, 1, N'What testing frameworks have you used?', N'')
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (50, 246, 1, 1, N'Does windows store apps support reflection', NULL)
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (44, 247, 1, 1, N'What agile development frameworks have you used in your career?', NULL)
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (44, 248, 1, 1, N'What is the Scrum agile framework?', NULL)
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (44, 249, 1, 1, N'What is the Scrum master?', NULL)
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (44, 250, 1, 1, N'What is the Backlog?', NULL)
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (44, 251, 1, 1, N'What is a Sprint and its common length in days?', NULL)
INSERT [dbo].[Questions] ([AreaId], [Id], [Weight], [Level], [Value], [Name]) VALUES (44, 252, 1, 1, N'What is a feature in Scrum?', NULL)

SET IDENTITY_INSERT [dbo].[Questions] OFF
ALTER TABLE [dbo].[Areas]  WITH CHECK ADD  CONSTRAINT [FK_Areas_KnowledgeAreas] FOREIGN KEY([KnowledgeAreaId])
REFERENCES [dbo].[KnowledgeAreas] ([Id])
GO
ALTER TABLE [dbo].[Areas] CHECK CONSTRAINT [FK_Areas_KnowledgeAreas]
GO
ALTER TABLE [dbo].[KnowledgeAreas]  WITH CHECK ADD  CONSTRAINT [FK_KnowledgeAreas_Platforms] FOREIGN KEY([PlatformId])
REFERENCES [dbo].[Platforms] ([Id])
GO
ALTER TABLE [dbo].[KnowledgeAreas] CHECK CONSTRAINT [FK_KnowledgeAreas_Platforms]
GO
ALTER TABLE [dbo].[ProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_ProfileItem_Areas] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([Id])
GO
ALTER TABLE [dbo].[ProfileItem] CHECK CONSTRAINT [FK_ProfileItem_Areas]
GO
ALTER TABLE [dbo].[ProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_ProfileItem_KnowledgeAreas] FOREIGN KEY([KnowledgeAreaId])
REFERENCES [dbo].[KnowledgeAreas] ([Id])
GO
ALTER TABLE [dbo].[ProfileItem] CHECK CONSTRAINT [FK_ProfileItem_KnowledgeAreas]
GO
ALTER TABLE [dbo].[ProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_ProfileItem_Platforms] FOREIGN KEY([PlatformId])
REFERENCES [dbo].[Platforms] ([Id])
GO
ALTER TABLE [dbo].[ProfileItem] CHECK CONSTRAINT [FK_ProfileItem_Platforms]
GO
ALTER TABLE [dbo].[ProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_ProfileItem_Profiles] FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[ProfileItem] CHECK CONSTRAINT [FK_ProfileItem_Profiles]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Areas] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([Id])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Areas]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddArea]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_AddArea] 
	@KnowledgeAreaId INT,
	@Name nvarchar(150),
	@Description nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT TOP 1 Name FROM [Areas] WHERE Name = @Name)
		INSERT INTO [Areas] (KnowledgeAreaId, Name, Description) VALUES (@KnowledgeAreaId, @Name, @Description)
		
	SELECT Id FROM [Areas] WHERE Name = @Name AND KnowledgeAreaId = @KnowledgeAreaId
END

GO
/****** Object:  StoredProcedure [dbo].[usp_AddKnowledgeArea]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_AddKnowledgeArea] 
	@PlatformId INT,
	@Name nvarchar(150),
	@Description nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT TOP 1 Name FROM [KnowledgeAreas] WHERE Name = @Name)
		INSERT INTO [KnowledgeAreas] (PlatformId, Name, Description) VALUES (@PlatformId, @Name, @Description)

	SELECT Id FROM [KnowledgeAreas] WHERE Name = @Name AND PlatformId = @PlatformId
END

GO
/****** Object:  StoredProcedure [dbo].[usp_AddPlatform]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_AddPlatform] 
	@Name nvarchar(255),
	@Description nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT TOP 1 Name FROM [Platforms] WHERE Name = @Name)
		INSERT INTO [Platforms] (Name, Description) VALUES (@Name, @Description)

	SELECT Id FROM [Platforms] WHERE Name = @Name
END

GO
/****** Object:  StoredProcedure [dbo].[usp_AddQuestion]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_AddQuestion] 
	@AreaId INT,
	@Value nvarchar(max),
	@Weight INT = 1,
	@Level INT = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT TOP 1 Value FROM [Questions] WHERE Value = @Value)
		INSERT INTO [Questions] (AreaId, Value, Weight, Level) VALUES (@AreaId, @Value, @Weight, @Level) 

	SELECT Id FROM [Questions] WHERE AreaId = @AreaId AND Value = @Value 
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteArea]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeleteArea]
	@Id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Name FROM [Areas] WHERE Id = @Id)
	BEGIN
		
		DELETE [Areas] WHERE Id = @Id 
	END
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteKnowledgeArea]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeleteKnowledgeArea]
	@Id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Name FROM [KnowledgeAreas] WHERE Id = @Id)
	BEGIN
		
		DELETE [KnowledgeAreas] WHERE Id = @Id 
	END
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DeletePlatform]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeletePlatform] 
	@Id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Name FROM [Platforms] WHERE Id = @Id)
	BEGIN
		
		DELETE [Platforms] WHERE Id = @Id 
	END
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteQuestion]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeleteQuestion]
	@Id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Value FROM [Questions] WHERE Id = @Id)
	BEGIN
		
		DELETE [Questions] WHERE Id = @Id 
	END
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetInterviewerData]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetInterviewerData]
	@Platform nvarchar(255) = NULL,
	@KnowledgeArea nvarchar(150) = NULL,
	@Area nvarchar(150) = NULL,
	@Question nvarchar(max) = NULL,
	@Profile nvarchar(255) = NULL
AS
BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Platform].Id
		,[Platform].Name
		,[Platform].[Description]
	,(
		SELECT [KnowledgeArea].PlatformId
			,[KnowledgeArea].Id
			,[KnowledgeArea].Name
			,[KnowledgeArea].[Description]
		,(
			SELECT [Area].KnowledgeAreaId
				,[Area].Id
				,[Area].Name
				,[Area].[Description]
			,(
				SELECT [Question].AreaId
					,[Question].Id
					,[Question].Weight
					,[Question].Level
					,[Question].Value
				FROM [Questions] [Question]
				WHERE [question].AreaId = [Area].Id
					AND UPPER([Question].Value) LIKE IIF(@Question IS NULL, '%', '%' + UPPER(@Question) + '%')
				FOR XML AUTO, TYPE
			)
			FROM [Areas] [Area]
			WHERE [Area].KnowledgeAreaId = [KnowledgeArea].Id
				AND UPPER([Area].Name) LIKE IIF(@Area IS NULL, '%', '%' + UPPER(@Area) + '%')
			FOR XML AUTO, TYPE
		)
		FROM [KnowledgeAreas] [KnowledgeArea]
		WHERE [knowledgeArea].PlatformId = [platform].Id
			AND UPPER([KnowledgeArea].Name) LIKE IIF(@KnowledgeArea IS NULL, '%', '%' + UPPER(@KnowledgeArea) + '%')
		FOR XML AUTO, TYPE
	),
	(
		SELECT [Profile].Id
			,[Profile].Name
			,[Profile].[Description]
			,[Requirement].ProfileId
			,[Requirement].PlatformId
			,[Requirement].KnowledgeAreaId
			,[Requirement].AreaId
			,[Requirement].IsRequired
		FROM [Profiles] [Profile]
			INNER JOIN [ProfileItem] [Requirement] ON [Profile].Id = [Requirement].ProfileId			
		WHERE [Requirement].PlatformId = [Platform].Id
			AND UPPER([Profile].Name) LIKE IIF(@Profile IS NULL, '%', '%' + UPPER(@Profile) + '%')
		FOR XML AUTO, TYPE
	) 
	FROM Platforms [Platform]
	WHERE UPPER([Platform].Name) LIKE IIF(@Platform IS NULL, N'%', '%' + UPPER(@Platform) + '%')
	FOR XML AUTO, TYPE, ROOT('configuration')
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateArea]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdateArea] 
	@Id INT,
	@Name nvarchar(150),
	@Description nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Name FROM [Areas] WHERE Id = @Id)
		UPDATE [Areas] SET Name = @Name, Description = @Description WHERE Id = @Id 
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateKnowledgeArea]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdateKnowledgeArea] 
	@Id INT,
	@Name nvarchar(150),
	@Description nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Name FROM [KnowledgeAreas] WHERE Id = @Id)
		UPDATE [KnowledgeAreas] SET Name = @Name, Description = @Description WHERE Id = @Id 
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdatePlatform]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdatePlatform] 
	@Id INT,
	@Name nvarchar(255),
	@Description nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Name FROM [Platforms] WHERE Id = @Id)
		UPDATE [Platforms] SET Name = @Name, [Description] = @Description WHERE Id = @Id 
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateQuestion]    Script Date: 3/12/2016 5:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdateQuestion] 
	@Id INT,
	@Value nvarchar(max),
	@Weight INT = 1,
	@Level INT = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT TOP 1 Value FROM [Questions] WHERE Id = @Id)
		UPDATE [Questions] SET Value = @Value, Weight = @Weight, Level = @Level WHERE Id = @Id 
END

GO
USE [master]
GO
ALTER DATABASE [Interviewer] SET  READ_WRITE 
GO
