CREATE TYPE [dbo].[TypesT_Users] AS TABLE (
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
    [Usr_InActive]  BIT              DEFAULT ((0)) NOT NULL);

