CREATE FUNCTION X_SF_Usr_Cat
(
    @Usr_Id INT,
    @Date_Ref DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @Usr_Birthdate DATETIME;
    DECLARE @Age INT;
    DECLARE @CAT INT;

SET @Usr_Birthdate = (SELECT Usr_Birthdate FROM Users WHERE Usr_Id = @Usr_Id)

SET @Age = DATEDIFF(YEAR, @Usr_Birthdate, @Date_Ref) 
          - CASE 
              WHEN MONTH(@Usr_Birthdate) > MONTH(@Date_Ref) 
                   OR (MONTH(@Usr_Birthdate) = MONTH(@Date_Ref) 
                       AND DAY(@Usr_Birthdate) > DAY(@Date_Ref)) 
              THEN 1 
              ELSE 0 
            END


    IF @Age < 18 
    BEGIN
        SET @CAT = 0; /*Junior*/
    END
    ELSE IF @Age < 60
    BEGIN
        SET @CAT = 1; /* Senior*/
    END
    ELSE
    BEGIN
        SET @CAT = 2; /* Veteran*/
    END


    RETURN @CAT;
END

