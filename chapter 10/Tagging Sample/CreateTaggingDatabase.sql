USE [AjaxTaggingSample]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImageTags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ImageID] [int] NULL,
	[TagName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO

USE [AjaxTaggingSample]
GO

Insert into ImageTags (ImageID, TagName)
select 1, 'Kids'
union all
select 2, 'Hockey'
union all
select 3, 'Gotha!'
union all
select 3, 'Cheesy'
union all
select 4, 'Prowler'

GO


SET ANSI_PADDING OFF
