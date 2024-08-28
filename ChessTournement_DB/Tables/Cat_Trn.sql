CREATE TABLE [dbo].[Cat_Trn]
(
	[Cat_Id] INT NOT NULL ,
	[Trn_Id] INT NOT NULL ,
	CONSTRAINT [PK_Cat_id] PRIMARY KEY CLUSTERED ([Cat_Id] ASC, [Trn_Id] ASC),
	CONSTRAINT [FK_Cat_Trn_Id] FOREIGN KEY ([Trn_Id]) REFERENCES [dbo].[Tournoi] ([Trn_Id]) ON DELETE CASCADE,
	CONSTRAINT [CK_Trn_Cat] CHECK ([Cat_Id]>=(0) AND [Cat_Id]<=(2))
)

