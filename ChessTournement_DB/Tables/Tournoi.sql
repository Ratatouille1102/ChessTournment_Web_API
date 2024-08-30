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
AFTER UPDATE
AS
BEGIN
    DECLARE @Trn_Id INT;
    DECLARE @Old_Trn_Status INT;
    DECLARE @New_Trn_Status INT;

    -- Récupérer l'ID du tournoi mis à jour
    SELECT @Trn_Id = INSERTED.Trn_Id FROM INSERTED;

    -- Récupérer les anciennes et nouvelles valeurs de Trn_Status
    SELECT @Old_Trn_Status = DELETED.Trn_Status, @New_Trn_Status = INSERTED.Trn_Status
    FROM INSERTED
    JOIN DELETED ON INSERTED.Trn_Id = DELETED.Trn_Id;

    -- Si le statut est passé de 0 à 1
    IF @Old_Trn_Status = 0 AND @New_Trn_Status = 1
    BEGIN
        -- Appeler la procédure pour créer les matchs
        EXEC X_SP_CreatMatch @Trn_Id;

        -- Incrémenter la ronde courante du tournoi
        UPDATE [dbo].[Tournoi]
        SET Trn_Round = Trn_Round + 1, Trn_UpdDate = GETDATE()
        WHERE Trn_Id = @Trn_Id;
    END
    -- Si le statut est déjà à 1
    ELSE IF @New_Trn_Status = 1
    BEGIN
        -- Appeler la procédure pour passer à la ronde suivante
        EXEC X_SP_NextRound @Trn_Id;

        -- Mettre à jour la date de mise à jour
        UPDATE [dbo].[Tournoi]
        SET Trn_UpdDate = GETDATE()
        WHERE Trn_Id = @Trn_Id;
    END
END;
GO


