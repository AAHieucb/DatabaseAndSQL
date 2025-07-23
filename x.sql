Cần phải tạo script xoá sạch table rồi init table cho khách hàng mới. Mỗi khi có upgrade, cần phải update script này. Và cũng dùng cho testing.
Cần xoá index trước khi xoá table nên phải update mỗi khi thêm index.

VD: Có thể sinh ra script drop và create trong SSMS
DROP INDEX IF EXISTS [IX_NextTime] ON [Schedule] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [Schedule]
GO

Thậm chí phải init 1 vài record mặc định ban đầu nữa.

VD: 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AutomationDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RecordId] [uniqueidentifier] NOT NULL,
	[ExecutionTime] [bigint] NOT NULL,
	[Status] [int] NOT NULL,
	[EventType] [int] NOT NULL,
	[ActionDetails] [nvarchar](max) NULL,
	[ObjectName] [nvarchar](1024) NOT NULL,
	[WorkflowConditions] [nvarchar](max) NULL,
	[ObjectId] [nvarchar](255) NULL,
	[ObjectConditions] [nvarchar](max) NULL,
 CONSTRAINT [PK_AutomationDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

VD:
/****** Object:  Table [PermissionGroup]    Script Date: 6/11/2025 12:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PermissionGroup](
	[Id] [nvarchar](255) NOT NULL,
	[CreateTime] [bigint] NOT NULL,
	[LastModifyTime] [bigint] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](512) NULL,
	[ModifiedBy] [nvarchar](512) NULL,
	[IsDomainIndividual] [bit] NOT NULL,
	[IsDomainConfigured] [bit] NOT NULL,
	[CreatedByPrincipal] [nvarchar](512) NULL,
	[ModifiedByPrincipal] [nvarchar](512) NULL,
	[ExpirationTime] [bigint] NULL,
	[IsOUIndividual] [bit] NOT NULL,
	[IsOUConfigured] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_LastModifyTime]    Script Date: 6/11/2025 12:21:48 PM ******/
CREATE CLUSTERED INDEX [IX_LastModifyTime] ON [PermissionGroup]
(
	[LastModifyTime] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

VD
/****** Object:  Table [PowerAppsAction]    Script Date: 6/11/2025 12:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PowerAppsAction](
	[Id] [uniqueidentifier] NOT NULL,
	[ConnectorId] [nvarchar](255) NULL,
	[ConnectorName] [nvarchar](255) NULL,
	[ConnectionReferenceId] [nvarchar](255) NULL,
	[TenantId] [uniqueidentifier] NULL,
	[AppsId] [uniqueidentifier] NULL,
	[IconUri] [nvarchar](512) NULL,
	[OperationId] [nvarchar](255) NULL,
	[AppsName] [nvarchar](255) NULL,
	[FlowId] [uniqueidentifier] NULL,
	[FlowName] [nvarchar](255) NULL,
 CONSTRAINT [PK_PowerAppsAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PowerAppSolutionUsage]    Script Date: 6/11/2025 12:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PowerAppSolutionUsage](
	[Id] [uniqueidentifier] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[UniqueName] [nvarchar](512) NULL,
	[Version] [nvarchar](512) NULL,
	[FriendlyName] [nvarchar](512) NULL,
	[IsManaged] [bit] NOT NULL,
	[AppNames] [nvarchar](max) NULL,
	[EnvironmentId] [nvarchar](128) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

VD:
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AADGroup_DisplayName_ASC]    Script Date: 6/11/2025 12:21:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_AADGroup_DisplayName_ASC] ON [AADGroup]
(
	[DisplayName] ASC
)
INCLUDE([Mail],[Description],[ProxyAddresses],[MembershipType],[CreatedDateTime],[TeamStatus],[IsAssignableToRole],[IsSyncedFromOnPrem],[SecurityEnabled],[TenantId],[TenantDomain],[ContainerId],[Container],[GroupType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AADGroup_TeamStatus]    Script Date: 6/11/2025 12:21:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_AADGroup_TeamStatus] ON [AADGroup]
(
	[TeamStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AADUser_AccountEnabled]    Script Date: 6/11/2025 12:21:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_AADUser_AccountEnabled] ON [AADUser]
(
	[AccountEnabled] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO

VD: 
/****** Object:  FullTextIndex     Script Date: 6/11/2025 12:21:48 PM ******/
CREATE FULLTEXT INDEX ON [AADGroup](
[MemberGroupIds] LANGUAGE 'English', 
[OwnerGroupIds] LANGUAGE 'English')
KEY INDEX [PK_AADGroup]ON ([SMPAADGroup], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO

GO
ALTER TABLE [TeamsSetting]  WITH CHECK ADD  CONSTRAINT [teamssetting_FK_teams] FOREIGN KEY([TeamsId])
REFERENCES [TeamsInfo] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [TeamsSetting] CHECK CONSTRAINT [teamssetting_FK_teams]
GO

-- Insert OP Incremental AD scan schedule
INSERT INTO [Schedule]([Id],[PlanId],[Plan],[Cron],[CreateTime],[NextTime],[EndTime],[RepeatInterval],[RepeatCount],[Offset],[RunCount]) VALUES ('81B842D9-2929-4CFA-A783-04A56C9209EC','D09A1942-CC17-4FCC-884D-3A4DE4DF925A','{"Type":"Entrust.Model.SchedulePlan, Entrust.Model, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Priority":1,"PlanId":"D09A1942-CC17-4FCC-884D-3A4DE4DF925A","UserId":null,"Category":8,"Detail":null}','0 0 0,6,12,18 * * ? ',DATEDIFF_BIG(MICROSECOND, '0001-01-01 00:00:00:000', GETUTCDATE()) * 10 + DATEPART(NANOSECOND, GETUTCDATE()) % 1000 / 100, DATEDIFF_BIG(MICROSECOND, '0001-01-01 00:00:00:000', DATEADD(day, 1, GETUTCDATE())) * 10 + DATEPART(NANOSECOND, DATEADD(day, 1, GETUTCDATE())) % 1000 / 100,null,0,0,0,0)

-- insert OP wrokflow owner status schedule 
INSERT INTO [Schedule]([Id],[PlanId],[Plan],[Cron],[CreateTime],[NextTime],[EndTime],[RepeatInterval],[RepeatCount],[Offset],[RunCount]) VALUES ('B28F195A-CD0C-4EDE-A0BC-3D372C97C3B8','B28F195A-CD0C-4EDE-A0BC-3D372C97C3B8','{"StartTime":null,"Type":"Entrust.Model.SchedulePlan, Entrust.Model, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Priority":1,"PlanId":"B28F195A-CD0C-4EDE-A0BC-3D372C97C3B8","UserId":null,"Category":14,"Detail":null}','0 0 0 * * ?',DATEDIFF_BIG(MICROSECOND, '0001-01-01T00:00:00', DATEADD(HOUR, DATEPART(HOUR, GETUTCDATE()), CAST(CAST(GETUTCDATE() AS DATE) AS DATETIME2))) * 10, DATEDIFF_BIG(MICROSECOND, '0001-01-01T00:00:00', DATEADD(HOUR, DATEPART(HOUR, GETUTCDATE()), CAST(CAST(GETUTCDATE() AS DATE) AS DATETIME2))) * 10,null,0,0,0,0)
