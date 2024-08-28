CREATE FUNCTION X_SF_Genre
(
	@Usr_Genre INT,
	@Trn_Women INT
)
RETURNS BIT
AS
BEGIN
DECLARE @Genre BIT;
	/* SI 1 OU 2 ET TRN_WOMEN = 1 */
	IF ( @Usr_Genre > 0 AND @Trn_Women = 1)
        SET @Genre = 1;
	

    RETURN @Genre;
END




