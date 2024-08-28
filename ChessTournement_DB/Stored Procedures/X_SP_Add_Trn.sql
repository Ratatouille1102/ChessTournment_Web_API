CREATE PROCEDURE [dbo].[X_SP_Add_Trn] ( 
    @Trn_Name     NVARCHAR(100),
    @Trn_Geo      NVARCHAR(100),
    @Trn_MinUsers INT,
    @Trn_MaxUsers INT,
    @Trn_MinElo   INT,
    @Trn_MaxElo   INT,
    @Trn_Status   INT,
    @Trn_Round    INT,
    @Trn_Women    BIT,
    @Trn_EndSubs  DATETIME,   /*CHECK (Trn_EndSubs = CONVERT(DATETIME, CONVERT(VARCHAR, Trn_EndSubs, 120), 120))*/
    @Trn_CreaDate DATETIME,
    @Trn_UpdDate  DATETIME,
    @Trn_Active   BIT,
	@Result1	  INT OUTPUT
	)
AS
BEGIN
	SET @Result1 = -1;
	INSERT INTO [dbo].[Tournoi] VALUES(@Trn_Name, @Trn_Geo, @Trn_MinUsers, @Trn_MaxUsers, @Trn_MinElo, @Trn_MaxElo, @Trn_Status, @Trn_Round, @Trn_Women, @Trn_EndSubs, @Trn_CreaDate, @Trn_UpdDate, @Trn_Active);      
	IF @@ROWCOUNT > 0
    BEGIN
			SET @Result1 = SCOPE_IDENTITY(); -- Ajout Réussi.
	END
    ELSE
    BEGIN
        SET @Result1 = 0; -- Ajout échoué (aucune ligne affectée)
    END
    
END