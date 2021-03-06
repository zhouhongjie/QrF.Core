USE [CMS]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 2019-02-28 14:33:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Summary] [nvarchar](255) NULL,
	[MetaKeyWords] [nvarchar](255) NULL,
	[MetaDescription] [nvarchar](255) NULL,
	[Counter] [int] NULL,
	[ArticleTypeID] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[ArticleContent] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[ImageThumbUrl] [nvarchar](255) NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[IsPublish] [bit] NOT NULL,
	[PublishDate] [datetime] NULL,
	[Url] [nvarchar](100) NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreatebyName] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[LastUpdateByName] [nvarchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleType]    Script Date: 2019-02-28 14:33:33 ******/

CREATE TABLE [dbo].[ArticleType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[ParentID] [int] NULL,
	[Url] [nvarchar](100) NULL,
	[Status] [int] NULL,
	[SEOTitle] [nvarchar](100) NULL,
	[SEOKeyWord] [nvarchar](100) NULL,
	[SEODescription] [nvarchar](300) NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreatebyName] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[LastUpdateByName] [nvarchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_ArticleType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CMS_Media]    Script Date: 2019-02-28 14:33:33 ******/

CREATE TABLE [dbo].[CMS_Media](
	[ID] [nvarchar](50) NOT NULL,
	[ParentID] [nvarchar](50) NULL,
	[Title] [nvarchar](50) NULL,
	[MediaType] [int] NULL,
	[Url] [nvarchar](100) NULL,
	[Status] [int] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreatebyName] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[LastUpdateByName] [nvarchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_CMS_Media] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Navigation]    Script Date: 2019-02-28 14:33:33 ******/

CREATE TABLE [dbo].[Navigation](
	[ID] [nvarchar](100) NOT NULL,
	[ParentId] [nvarchar](100) NULL,
	[Url] [nvarchar](255) NULL,
	[Title] [nvarchar](200) NULL,
	[IsMobile] [bit] NULL,
	[Html] [nvarchar](max) NULL,
	[Description] [nvarchar](500) NULL,
	[Status] [int] NULL,
	[DisplayOrder] [int] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreatebyName] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[LastUpdateByName] [nvarchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Navigation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_ArticleCategory] FOREIGN KEY([ArticleTypeID])
REFERENCES [dbo].[ArticleType] ([ID])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_ArticleCategory]
GO

/****** Object:  Table [dbo].[AdvClass]    Script Date: 2019-02-28 14:33:33 ******/

CREATE TABLE [dbo].[AdvClass](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[Flag] [nvarchar](50) NULL,
	[Width] [int] NULL default 0,
	[Height] [int] NULL default 0,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreatebyName] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[LastUpdateByName] [nvarchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_AdvClass] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[AdvList]    Script Date: 2019-02-28 14:33:33 ******/

CREATE TABLE [dbo].[AdvList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NOT NULL,
	[Types] [int] NOT NULL default 1,
	[ImgUrl] [nvarchar](255) NULL,
	[LinkUrl] [nvarchar](255) NULL,
	[LinkSummary] [nvarchar](255) NULL,
	[Target] [nvarchar](255) NULL default '_blank',
	[IsTimeLimit] [bit] NOT NULL DEFAULT 0,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Hits] [int] NOT NULL DEFAULT 0,
	[Sort] [int] NOT NULL DEFAULT 0,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreatebyName] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[LastUpdateByName] [nvarchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_AdvList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2019-02-28 16:32:41 ******/

CREATE TABLE [dbo].[Users](
	[UserID] [nvarchar](50) NOT NULL,
	[PassWord] [nvarchar](255) NULL,
	[ApiLoginToken] [nvarchar](255) NULL,
	[LastLoginDate] [datetime] NULL,
	[LoginIP] [nvarchar](50) NULL,
	[PhotoUrl] [nvarchar](255) NULL,
	[Timestamp] [bigint] NULL,
	[UserName] [nvarchar](100) NULL,
	[UserTypeCD] [int] NULL,
	[Address] [nvarchar](255) NULL,
	[Age] [int] NULL,
	[Birthday] [datetime] NULL,
	[Birthplace] [nvarchar](255) NULL,
	[Email] [nvarchar](100) NULL,
	[EnglishName] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[Hobby] [nvarchar](100) NULL,
	[LastName] [nvarchar](50) NULL,
	[MaritalStatus] [int] NULL,
	[MobilePhone] [nvarchar](50) NULL,
	[NickName] [nvarchar](50) NULL,
	[Profession] [nvarchar](50) NULL,
	[QQ] [nvarchar](50) NULL,
	[School] [nvarchar](50) NULL,
	[Sex] [int] NULL,
	[Telephone] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](50) NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreatebyName] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[LastUpdateByName] [nvarchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
	[Status] [int] NULL,
	[Description] [nvarchar](500) NULL,
	[ResetToken] [nvarchar](50) NULL,
	[ResetTokenDate] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Users] ([UserID], [PassWord], [ApiLoginToken], [LastLoginDate], [LoginIP], [PhotoUrl], [Timestamp], [UserName], [UserTypeCD], [Address], [Age], [Birthday], [Birthplace], [Email], [EnglishName], [FirstName], [Hobby], [LastName], [MaritalStatus], [MobilePhone], [NickName], [Profession], [QQ], [School], [Sex], [Telephone], [ZipCode], [CreateBy], [CreatebyName], [CreateDate], [LastUpdateBy], [LastUpdateByName], [LastUpdateDate], [Status], [Description], [ResetToken], [ResetTokenDate]) VALUES (N'admin', N'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'6bb997a4310d367a223f59951ab1fd57', CAST(N'2019-02-28T14:10:18.510' AS DateTime), N'::1', N'~/images/head.png', 0, N'ZKEASOFT', 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, N'Admin', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, N'admin', N'Admin', CAST(N'2019-02-28T14:10:18.573' AS DateTime), 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[AdvClass] ON 
GO
INSERT [dbo].[AdvClass] ([ID], [ParentId], [Flag], [Width], [Height], [Title], [Description], [Status], [CreateBy], [CreatebyName], [CreateDate], [LastUpdateBy], [LastUpdateByName], [LastUpdateDate]) VALUES (1, NULL, N'1', 1920, 600, N'Banner图', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[AdvClass] ([ID], [ParentId], [Flag], [Width], [Height], [Title], [Description], [Status], [CreateBy], [CreatebyName], [CreateDate], [LastUpdateBy], [LastUpdateByName], [LastUpdateDate]) VALUES (2, NULL, N'2', 0, 0, N'友情链接', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[AdvClass] OFF
GO