CREATE FUNCTION X_SF_Trn_EndSubs
(
	@Trn_EndSubs datetime
)
RETURNS INT
AS
BEGIN
 /*   DECLARE @ConvertedDate DATETIME
    SET @ConvertedDate = CONVERT(DATETIME, @Trn_EndSubs, 120)*/
	RETURN DATEDIFF(DAY,GETDATE(),@Trn_EndSubs)
END