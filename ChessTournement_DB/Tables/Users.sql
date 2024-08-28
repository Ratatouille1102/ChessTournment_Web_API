CREATE TABLE [dbo].[Users] (
    [Usr_Id]        INT              IDENTITY (1, 1) NOT NULL,
    [Usr_Pseudo]    NVARCHAR (320)   NOT NULL,
    [Usr_Email]     NVARCHAR (320)   NOT NULL,
    [Usr_Birthdate] DATETIME         NOT NULL,
    [Usr_Genre]     SMALLINT         DEFAULT ((2)) NULL,
    [Usr_Firstname] NVARCHAR (50)    NULL,
    [Usr_Lastname]  NVARCHAR (50)    NULL,
    [Usr_Elo]       SMALLINT         DEFAULT ((1200)) NOT NULL,
    [Usr_Role]      BIT              DEFAULT ((0)) NOT NULL,
    [Usr_Password]  BINARY (64)      NULL,
    [Usr_Salt]      UNIQUEIDENTIFIER NULL,
    [Usr_InActive]  BIT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([Usr_Id] ASC),
    CONSTRAINT [CK_Email] CHECK ([Usr_Email] like '%_@__%.__%'),
    CONSTRAINT [CK_Users_Elo] CHECK ([Usr_Elo]>=(0) AND [Usr_Elo]<=(3000)),
    CONSTRAINT [CK_Users_Genre] CHECK ([Usr_Genre]>=(0) AND [Usr_Genre]<=(2)),
    CONSTRAINT [CK_Users_Role] CHECK ([Usr_Role]=(0) OR [Usr_Role]=(1)),
    CONSTRAINT [UK_Users_Email] UNIQUE NONCLUSTERED ([Usr_Email] ASC),
    CONSTRAINT [UK_Users_Pseudo] UNIQUE NONCLUSTERED ([Usr_Pseudo] ASC)
);

