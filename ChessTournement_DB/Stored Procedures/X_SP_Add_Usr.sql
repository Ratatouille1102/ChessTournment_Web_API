CREATE PROCEDURE [dbo].[X_SP_Add_Usr] ( 
    @Usr_Pseudo    NVARCHAR(320),
    @Usr_Email     NVARCHAR(320),
    @Usr_Birthdate DATETIME, /*CHECK (Trn_EndSubs = CONVERT(DATETIME, CONVERT(VARCHAR, Trn_EndSubs, 120), 120))*/
    @Usr_Genre     SMALLINT,
    @Usr_Firstname NVARCHAR(50),
    @Usr_Lastname  NVARCHAR(50),
    @Usr_Elo       SMALLINT,
    @Usr_Role      BIT,
    @Usr_Password  NVARCHAR(64),
    @Usr_Salt      UNIQUEIDENTIFIER,
    @Usr_InActive  BIT,
	@Result1	   INT OUTPUT
	)
AS
BEGIN
	SET @Result1 = -1;


	INSERT INTO [dbo].[Users] VALUES(@Usr_Pseudo, @Usr_Email, @Usr_Birthdate, @Usr_Genre, @Usr_Firstname, @Usr_Lastname, @Usr_Elo, @Usr_Role, dbo.X_SF_HashAndSalt_Password(@Usr_Password,@Usr_Salt), @Usr_Salt, @Usr_InActive)      
	
	IF @@ROWCOUNT > 0
    BEGIN
		SET @Result1 = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        SET @Result1 = 0; -- Ajout échoué (aucune ligne affectée)
    END
	
	
END