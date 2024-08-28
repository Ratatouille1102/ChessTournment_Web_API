   CREATE PROCEDURE X_SP_Upd_Usr ( 
    @Usr_Id		   INT,
    @Usr_Pseudo    NVARCHAR(320),
    @Usr_Email     NVARCHAR(320),
    @Usr_Birthdate DATETIME,
    @Usr_Genre     SMALLINT,
    @Usr_Firstname NVARCHAR(50),
    @Usr_Lastname  NVARCHAR(50),
    @Usr_Elo       SMALLINT,
    @Usr_Role      BIT,
    @Usr_Password  BINARY(64),
    @Usr_Salt      UNIQUEIDENTIFIER,
    @Usr_InActive  BIT,
	@Result1	   INT OUTPUT
)
AS
BEGIN
    UPDATE [dbo].[Users]
    SET
		Usr_Pseudo		= @Usr_Pseudo,
		Usr_Email		= @Usr_Email,
		Usr_Birthdate	= @Usr_Birthdate,
		Usr_Genre		= @Usr_Genre,
		Usr_Firstname	= @Usr_Firstname,
		Usr_Lastname	= @Usr_Lastname,
		Usr_Elo			= @Usr_Elo,
		Usr_Role		= @Usr_Role,
		Usr_Password	= @Usr_Password,
		Usr_Salt		= @Usr_Salt,
		Usr_InActive	= @Usr_InActive
    WHERE
        Usr_Id		= @Usr_Id
END