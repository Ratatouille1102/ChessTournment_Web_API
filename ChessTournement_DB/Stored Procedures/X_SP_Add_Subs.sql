CREATE PROCEDURE X_SP_Add_Subs ( 
    @Sub_Usr_Id INT,				/*2*/
    @Sub_Trn_Id INT,				/*1*/
    @Sub_Date   DATETIME,
    @Sub_Active BIT,
	@Result1	  INT OUTPUT,
	@Result2	  INT OUTPUT
	)
AS
BEGIN
        SET @Result1 = -1; 
		SET @Result2 = -1; 
	INSERT INTO [dbo].[Subscribe] VALUES(@Sub_Usr_Id, @Sub_Trn_Id, @Sub_Date, @Sub_Active); 
	 IF @@ROWCOUNT > 0
		BEGIN
        SET @Result1 = @Sub_Usr_Id ; -- Ajout réussi
		SET @Result2 = @Sub_Trn_Id ; -- Ajout réussi
    END
    ELSE
    BEGIN
        SET @Result1 = 0; -- Ajout échoué (aucune ligne affectée)
		SET @Result2 = 0; -- Ajout échoué (aucune ligne affectée)
    END
END