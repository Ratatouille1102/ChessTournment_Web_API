CREATE PROCEDURE X_SP_DeletePartie (@Par_Id int)
AS
BEGIN
	DELETE  FROM [dbo].[Partie] WHERE [dbo].[Partie].[Par_Id] = @Par_Id;
END