CREATE PROCEDURE X_SP_V_Lst_Trn_On_UpdDate
(
    @NameParam NVARCHAR(100),
    @PageParam INT ,
    @CatParam INT,
    @StatusParam INT
)
AS
BEGIN
DECLARE @Skip INT
DECLARE @Name NVARCHAR(100)
DECLARE @Cat NVARCHAR(800)
DECLARE @Status INT

select @PageParam=COALESCE(@PageParam,1) /*IF IS NULL = 1 */
SET @Skip = (@PageParam - 1) * 10; -- Assuming 10 records per page

SET @Name = @NameParam;
SET @Cat = CAST(@CatParam As NVARCHAR(800));
SET @Status = @StatusParam;

SELECT
    Trn.[Trn_Id],
    Trn.[Trn_Name],
    Trn.[Trn_Geo],
    dbo.X_SF_Count_Usr_Trn_Subs(Trn.Trn_Id) AS [TrnV_PSubs], /*COUNT Players Subscription on Trn_Id */
    Trn.[Trn_MinUsers],
    Trn.[Trn_MaxUsers],
    dbo.X_SF_Trn_CategoriesWithSeprators(Trn.Trn_Id) as [Categories],
    Trn.[Trn_MinElo],
    Trn.[Trn_MaxElo],
    Trn.[Trn_Status],
    Trn.[Trn_EndSubs],
    Trn.[Trn_Round]
FROM [dbo].[Tournoi] Trn
WHERE (@Status IS NULL OR Trn.[Trn_Status] = @Status)
  AND (@Name IS NULL OR Trn.[Trn_Name] LIKE '%' + @Name + '%')
  AND (@Cat IS NULL OR dbo.X_SF_Trn_CategoriesWithSeprators(Trn.Trn_Id) LIKE '%' + @Cat + '%')  
ORDER BY Trn.[Trn_UpdDate] DESC
OFFSET @Skip ROWS FETCH NEXT 10 ROWS ONLY;
END