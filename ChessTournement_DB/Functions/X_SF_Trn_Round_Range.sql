CREATE FUNCTION X_SF_Trn_Round_Range
(
	@Trn_MaxUsers int
)
RETURNS INT
AS
BEGIN
	RETURN ((@Trn_MaxUsers * 2)-1)
END