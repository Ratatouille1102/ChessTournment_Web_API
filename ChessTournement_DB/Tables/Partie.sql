CREATE TABLE [dbo].[Partie] (
    [Par_Id]       INT  IDENTITY (1, 1) NOT NULL,
    [Par_num]      INT  NULL,
    [Usr_Id_W]     INT  NOT NULL,
    [Usr_Id_B]     INT  NOT NULL,
    [Trn_Id]       INT  NOT NULL,
    [Par_Status]   INT  NULL, /* 0=not played  1= W  2= B  3= Draw */
    [Par_InActive] BIT  DEFAULT ((0)) NULL,
    [Par_Res]      REAL DEFAULT (NULL) NULL,
    CONSTRAINT [PK_Par_Id] PRIMARY KEY CLUSTERED ([Par_Id] ASC),
    CONSTRAINT [FK_Par_Trn_Id] FOREIGN KEY ([Trn_Id]) REFERENCES [dbo].[Tournoi] ([Trn_Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Par_Usr_Id_B] FOREIGN KEY ([Usr_Id_B]) REFERENCES [dbo].[Users] ([Usr_Id]),
    CONSTRAINT [FK_Par_Usr_Id_W] FOREIGN KEY ([Usr_Id_W]) REFERENCES [dbo].[Users] ([Usr_Id])
);

