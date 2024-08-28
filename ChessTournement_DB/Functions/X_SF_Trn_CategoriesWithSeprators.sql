CREATE FUNCTION X_SF_Trn_CategoriesWithSeprators
(@trn_id int)
RETURNS VARCHAR(800)
AS
BEGIN
DECLARE @SomeColumnList VARCHAR(800)
SELECT @SomeColumnList =
    COALESCE(@SomeColumnList + ', ', '') + CAST(Cat_Id AS varchar(2)) 
FROM Cat_Trn
WHERE Cat_Trn.Trn_Id=@trn_id
RETURN @SomeColumnList
END
