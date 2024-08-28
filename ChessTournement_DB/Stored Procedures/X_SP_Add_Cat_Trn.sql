CREATE PROCEDURE X_SP_Add_Cat_Trn ( 
	@Cat_Id			INT ,
	@Trn_Id			INT  ,
	@Result1	  INT OUTPUT,
	@Result2	  INT OUTPUT
	)
AS
BEGIN
        SET @Result1 = -1; 
		SET @Result2 = -1; 
	INSERT INTO [dbo].[Cat_Trn] VALUES(@Cat_Id, @Trn_Id); 
	 IF @@ROWCOUNT > 0
		BEGIN
        SET @Result1 = @Cat_Id ; -- Ajout réussi
		SET @Result2 = @Trn_Id ; -- Ajout réussi
    END
    ELSE
    BEGIN
        SET @Result1 = 0; -- Ajout échoué (aucune ligne affectée)
		SET @Result2 = 0; -- Ajout échoué (aucune ligne affectée)
    END
END