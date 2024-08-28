CREATE PROCEDURE X_SP_DeleteSubs
(
@Sub_Usr_Id		INT, 
@Sub_Trn_Id		INT,
@Result1		INT OUTPUT,
@Result2		INT OUTPUT
)
AS
BEGIN
SET @Result1 = -1;
SET @Result2 = -1;
DECLARE @TEMP INT;
DECLARE @TEMP2 INT;
SELECT @TEMP = Sub_Usr_Id, @TEMP2 = Sub_Trn_Id FROM [dbo].[Subscribe] WHERE ([dbo].[Subscribe].[Sub_Usr_Id] = @Sub_Usr_Id AND [dbo].[Subscribe].[Sub_Trn_Id] = @Sub_Trn_Id);
    -- Supprimer l'enregistrement
    DELETE FROM [dbo].[Subscribe] WHERE ([dbo].[Subscribe].[Sub_Usr_Id] = @Sub_Usr_Id AND [dbo].[Subscribe].[Sub_Trn_Id] = @Sub_Trn_Id);

    -- Vérifier si la suppression a réussi
    IF @@ROWCOUNT > 0
    BEGIN
        SET @Result1 = @TEMP; -- Suppression réussie sur ID USR
		SET @Result2 = @TEMP2; -- Suppression réussie sur ID TRN
    END
    ELSE
    BEGIN
        SET @Result1 = 0; -- Suppression échouée (aucune ligne affectée)
		SET @Result2 = 0; -- Suppression échouée (aucune ligne affectée)
    END
END