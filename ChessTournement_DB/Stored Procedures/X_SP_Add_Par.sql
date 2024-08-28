CREATE PROCEDURE X_SP_Add_Par ( 
    @Par_num      INT,
    @Usr_Id_W     INT,
    @Usr_Id_B     INT,
    @Trn_Id       INT,
    @Par_Status   INT,
    @Par_InActive BIT,
	@Par_Res	  FLOAT(5),
    @Result1	  INT OUTPUT
	)
AS
BEGIN
    SET @Result1 = -1;  
	INSERT INTO [dbo].[Partie] VALUES(@Par_num, @Usr_Id_W, @Usr_Id_B, @Trn_Id, @Par_Status, @Par_InActive, @Par_Res)      
    IF @@ROWCOUNT > 0
	    BEGIN
             SET @Result1 = SCOPE_IDENTITY(); -- Ajout réussi
        END
    ELSE
        BEGIN
            SET @Result1 = 0; -- Ajout échoué (aucune ligne affectée)
        END
END