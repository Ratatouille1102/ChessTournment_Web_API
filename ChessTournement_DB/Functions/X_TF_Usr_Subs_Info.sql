CREATE FUNCTION X_TF_Usr_Subs_Info
(
	@Sub_Usr_Id INT
)
RETURNS TABLE
AS
RETURN SELECT *
FROM Subscribe
WHERE ( Sub_Usr_Id = @Sub_Usr_Id );