CREATE PROCEDURE X_SP_DeleteUsers (
    @Usr_Id INT,
    @Result1 INT OUTPUT	
)
AS
BEGIN
DECLARE @TEMP INT;
SELECT @TEMP = Usr_Id FROM [dbo].[Users] WHERE [dbo].[Users].[Usr_Id] = @Usr_Id;
    -- Supprimer l'enregistrement
    DELETE FROM [dbo].[Users] WHERE [dbo].[Users].[Usr_Id] = @Usr_Id;

    -- Vérifier si la suppression a réussi
    IF @@ROWCOUNT > 0
    BEGIN
        SET @Result1 = @TEMP; -- Suppression réussie
    END
    ELSE
    BEGIN
        SET @Result1 = 0; -- Suppression échouée (aucune ligne affectée)
    END
END