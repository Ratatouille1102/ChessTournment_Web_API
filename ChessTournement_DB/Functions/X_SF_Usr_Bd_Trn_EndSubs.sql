CREATE   FUNCTION X_SF_Usr_Bd_Trn_EndSubs
(
	@Trn_EndSubs datetime,
	@Usr_Birthdate datetime
)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(DAY,@Trn_EndSubs,@Usr_Birthdate)
END