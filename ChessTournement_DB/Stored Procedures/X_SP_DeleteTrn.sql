CREATE PROCEDURE X_SP_DeleteTrn 
(
    @Trn_Id INT,
    @Result1 INT OUTPUT	
)
AS
BEGIN
    SET @Result1 = -3;
    DECLARE @Status INT = -1;
    SELECT @Status = Trn_Status FROM [dbo].[Tournoi] WHERE (([dbo].[Tournoi].[Trn_Id] = @Trn_Id) AND ([dbo].[Tournoi].[Trn_Status] = 0));
    IF (@Status = 0) 
        BEGIN
            -- Supprimer l'enregistrement
            DELETE FROM [dbo].[Tournoi] WHERE [dbo].[Tournoi].[Trn_Id] = @Trn_Id;
             -- Vérifier si la suppression a réussi
            IF @@ROWCOUNT > 0
                BEGIN
                  SET @Result1 = @Trn_Id; -- Suppression réussie
                END
            ELSE
                BEGIN
                    SET @Result1 = -1; -- Suppression échouée (aucune ligne supprimée)
                END
            END
    ELSE
        BEGIN
            SET @Result1 = -2; -- Tournoi commencé (aucune ligne Supprimée)
        END

   
END