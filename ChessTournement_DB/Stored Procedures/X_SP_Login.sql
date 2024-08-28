CREATE PROCEDURE X_SP_Login
	@Pseudo NVARCHAR(320),
	@Email NVARCHAR(320),
	@Passwd NVARCHAR(64),
	@Salt UNIQUEIDENTIFIER,
	@Result1 INT OUTPUT,
	@Result2 NVARCHAR(320) OUTPUT,
	@Result3 NVARCHAR(320) OUTPUT
AS
BEGIN	
	SELECT @Result1 = Usr_Id, @Result2 = Usr_Email, @Result3 = Usr_Pseudo FROM Users WHERE ((Usr_Email = @Email) OR (Usr_Pseudo = @Pseudo) AND Usr_Password = [dbo].X_SF_HashAndSalt_Password(@Passwd,@Salt));
END