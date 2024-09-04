CREATE TABLE [dbo].[Subscribe] (
    [Sub_Usr_Id] INT      NOT NULL,
    [Sub_Trn_Id] INT      NOT NULL,
    [Sub_Date]   DATETIME NULL,
    [Sub_Active] BIT      DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Sub_Id] PRIMARY KEY CLUSTERED ([Sub_Usr_Id] ASC, [Sub_Trn_Id] ASC),
    CONSTRAINT [FK_Sub_Trn_Id] FOREIGN KEY ([Sub_Trn_Id]) REFERENCES [dbo].[Tournoi] ([Trn_Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Sub_Usr_Id] FOREIGN KEY ([Sub_Usr_Id]) REFERENCES [dbo].[Users] ([Usr_Id])
);

