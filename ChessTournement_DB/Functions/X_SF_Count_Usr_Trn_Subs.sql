﻿CREATE FUNCTION X_SF_Count_Usr_Trn_Subs
(
	@Trn_Id int
)
RETURNS INT
AS
BEGIN
	RETURN (SELECT COUNT(*) FROM Subscribe WHERE Sub_Trn_Id = @Trn_Id)
END