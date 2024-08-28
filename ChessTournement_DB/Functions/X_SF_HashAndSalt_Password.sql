CREATE FUNCTION X_SF_HashAndSalt_Password 
    (
        @Passwd NVARCHAR(64),
		@Salt UNIQUEIDENTIFIER
    )
RETURNS BINARY(64)
AS
BEGIN
	RETURN HASHBYTES('SHA2_512', CONCAT(dbo.X_SF_GetPreSalt(@Salt), @Passwd, dbo.X_SF_GetPostSalt(@Salt)));
END