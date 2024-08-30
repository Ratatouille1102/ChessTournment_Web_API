CREATE TABLE [dbo].[Subscribe] (
    [Sub_Usr_Id] INT      NOT NULL,
    [Sub_Trn_Id] INT      NOT NULL,
    [Sub_Date]   DATETIME NULL,
    [Points] FLOAT      DEFAULT 0 NOT NULL,
    [Sub_Active] BIT NOT NULL DEFAULT ((1)), 
    CONSTRAINT [PK_Sub_Id] PRIMARY KEY CLUSTERED ([Sub_Usr_Id] ASC, [Sub_Trn_Id] ASC),
    CONSTRAINT [FK_Sub_Trn_Id] FOREIGN KEY ([Sub_Trn_Id]) REFERENCES [dbo].[Tournoi] ([Trn_Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Sub_Usr_Id] FOREIGN KEY ([Sub_Usr_Id]) REFERENCES [dbo].[Users] ([Usr_Id])
);

