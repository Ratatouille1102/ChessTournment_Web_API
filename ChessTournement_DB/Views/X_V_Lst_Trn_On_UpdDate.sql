CREATE VIEW X_V_Lst_Trn_On_UpdDate
AS
SELECT TOP 10 
    Trn.[Trn_Id],
    Trn.[Trn_Name],
    Trn.[Trn_Geo],
    [dbo].[X_SF_Count_Usr_Trn_Subs](Trn.[Trn_Id]) AS [TrnV_PSubs], /*COUNT Players Subscription on Trn_Id */
    Trn.[Trn_MinUsers],
    Trn.[Trn_MaxUsers],
    dbo.X_SF_Trn_CategoriesWithSeprators(Trn.Trn_Id) as Categories,
    Trn.[Trn_MinElo],
    Trn.[Trn_MaxElo],
    Trn.[Trn_Status],
    Trn.[Trn_EndSubs],
    Trn.[Trn_Round]
FROM [dbo].[Tournoi] Trn
WHERE [Trn_Status] = 0
ORDER BY [Trn_UpdDate] DESC;