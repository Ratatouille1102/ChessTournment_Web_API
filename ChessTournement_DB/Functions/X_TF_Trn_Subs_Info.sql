﻿CREATE FUNCTION X_TF_Trn_Subs_Info
(
	@Sub_Trn_Id INT
)
RETURNS TABLE
AS
RETURN SELECT *
FROM Subscribe
WHERE ( Sub_Trn_Id = @Sub_Trn_Id );