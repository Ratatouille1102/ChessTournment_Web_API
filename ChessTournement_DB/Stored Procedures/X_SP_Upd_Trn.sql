CREATE PROCEDURE X_SP_Upd_Trn ( 
	@Trn_Id		  INT,
    @Trn_Name     NVARCHAR,
    @Trn_Geo      NVARCHAR,
    @Trn_MinUsers INT,
    @Trn_MaxUsers INT,
    @Trn_MinElo   INT,
    @Trn_MaxElo   INT,
    @Trn_Status   INT,
    @Trn_Round    INT,
    @Trn_Women    BIT,
    @Trn_EndSubs  DATETIME,
    @Trn_CreaDate DATETIME,
    @Trn_UpdDate  DATETIME,
    @Trn_Active   BIT
)
AS
BEGIN
         
        UPDATE [dbo].[Tournoi]
            SET
            Trn_Name		= @Trn_Name,
            Trn_Geo			= @Trn_Geo,
            Trn_MinUsers	= @Trn_MinUsers,
            Trn_MaxUsers	= @Trn_MaxUsers,
            Trn_MinElo		= @Trn_MinElo,
            Trn_MaxElo		= @Trn_MaxElo,
            Trn_Status		= @Trn_Status, /* 0 = Wait 1=Started 2=Finish 3=Not Defined*/
            Trn_Round		= @Trn_Round,
            Trn_Women		= @Trn_Women,
            Trn_EndSubs		= @Trn_EndSubs,
            Trn_CreaDate	= @Trn_CreaDate,
            Trn_UpdDate		= @Trn_UpdDate,
            Trn_Active		= @Trn_Active
            WHERE
                Trn_Id		= @Trn_Id

END