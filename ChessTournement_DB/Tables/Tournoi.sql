CREATE TABLE [dbo].[Tournoi] (
    [Trn_Id]       INT            IDENTITY (1, 1) NOT NULL,
    [Trn_Name]     NVARCHAR (100) NOT NULL,
    [Trn_Geo]      NVARCHAR (100) DEFAULT (NULL) NULL,
    [Trn_MinUsers] INT            DEFAULT ((2)) NOT NULL,
    [Trn_MaxUsers] INT            DEFAULT ((32)) NOT NULL,
    [Trn_MinElo]   INT            DEFAULT ((0)) NULL,
    [Trn_MaxElo]   INT            DEFAULT ((3000)) NULL,
    [Trn_Status]   INT            DEFAULT ((0)) NOT NULL,
    [Trn_Round]    INT            DEFAULT ((0)) NOT NULL,
    [Trn_Women]    BIT            DEFAULT ((0)) NOT NULL,
    [Trn_EndSubs]  DATETIME       DEFAULT (NULL) NULL,
    [Trn_CreaDate] DATETIME       DEFAULT (getdate()) NULL,
    [Trn_UpdDate]  DATETIME       DEFAULT (getdate()) NULL,
    [Trn_Active]   BIT            DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Trn_id] PRIMARY KEY CLUSTERED ([Trn_Id] ASC),
    CONSTRAINT [CK_Round_Range] CHECK ([Trn_Round]>=(0) AND [Trn_Round]<=([Trn_MaxUsers]-(1))*(2)),
    CONSTRAINT [CK_Trn_MaxUsers] CHECK ([Trn_MaxUsers]>=(2) AND [Trn_MaxUsers]<=(32)),
    CONSTRAINT [CK_Trn_MinUsers] CHECK (([Trn_MinUsers]>=(2) AND [Trn_MinUsers]<=(32))AND([Trn_MinUsers]<=[Trn_MaxUsers])),
    CONSTRAINT [CK_Trn_MinElo] CHECK (([Trn_MinElo]>=(0) AND [Trn_MinElo]<=(3000))AND([Trn_MinElo]<=[Trn_MaxElo])),
    CONSTRAINT [CK_Trn_MaxElo] CHECK ([Trn_MaxElo]>=(0) AND [Trn_MaxElo]<=(3000)),
    CONSTRAINT [CK_Trn_Round] CHECK ([Trn_Round]>=(0) AND [Trn_Round]<=(64)),
    CONSTRAINT [CK_Trn_Women] CHECK ([Trn_Women]=(0) OR [Trn_Women]=(1)),
    CONSTRAINT [CK_Trn_Status] CHECK ([Trn_Status]>=(0) AND [Trn_Status]<=(3)),
    CONSTRAINT [CK_Trn_Endsub] CHECK ([Trn_EndSubs] > DATEADD(DAY, [Trn_MinUsers], [Trn_CreaDate]))

);





GO

CREATE TRIGGER [dbo].[TR_Trn_Status_Update]
    ON [dbo].[Tournoi]
    FOR UPDATE
    AS
    BEGIN
        IF EXISTS (SELECT 1 FROM INSERTED WHERE Trn_Status = 1)
        BEGIN
            DECLARE @Trn_Id INT;
            SELECT @Trn_Id = Trn_Id FROM INSERTED WHERE Trn_Status = 1;
            EXEC X_SP_CreatMatch @Trn_Id;
                        -- Mettre à jour la ronde courante et la date de mise à jour
                UPDATE [dbo].[Tournoi]
                SET Trn_Round = 1, Trn_UpdDate = GETDATE()
                 WHERE Trn_Id = @Trn_Id;
        END
    END;
GO

