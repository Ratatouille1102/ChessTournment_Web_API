CREATE FUNCTION X_TF_Usr_Trn_Subs_Info
(
	@Sub_Usr_Id INT,
	@Sub_Trn_Id INT
)
RETURNS TABLE
AS
RETURN SELECT *
FROM Subscribe
WHERE ( Sub_Usr_Id = @Sub_Usr_Id AND Sub_Trn_Id = @Sub_Trn_Id);