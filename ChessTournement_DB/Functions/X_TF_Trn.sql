CREATE FUNCTION X_TF_Trn
(
	@Trn_Id INT
)
RETURNS @returntable TABLE
(
    [Trn_Id] INT,
    [Trn_Name] NVARCHAR(100),
    [Trn_Geo] NVARCHAR(100),
    [TrnV_PSubs] INT, /*COUNT Players Subscription on Trn_Id */
    [Trn_MinUsers] INT,
    [Trn_MaxUsers] INT,
    [Cat_Id] INT, /* RECUP DE CAT*/
    [Trn_MinElo] INT,
    [Trn_MaxElo] INT,
    [Trn_Status] INT,
    [Trn_EndSubs] DATETIME,
    [Trn_Round] INT
)
AS
BEGIN
	INSERT @returntable
	SELECT
    Trn.[Trn_Id],
    Trn.[Trn_Name],
    Trn.[Trn_Geo],
    [dbo].[X_SF_Count_Usr_Trn_Subs](Trn.[Trn_Id]) AS [TrnV_PSubs], /*COUNT Players Subscription on Trn_Id */
    Trn.[Trn_MinUsers],
    Trn.[Trn_MaxUsers],
    Cat.[Cat_Id], /* RECUP DE CAT*/
    Trn.[Trn_MinElo],
    Trn.[Trn_MaxElo],
    Trn.[Trn_Status],
    Trn.[Trn_EndSubs],
    Trn.[Trn_Round]
    FROM [dbo].[Tournoi] Trn
    JOIN [dbo].[Cat_Trn] Cat ON Trn.[Trn_Id] = Cat.[Trn_Id] 
    WHERE Trn.[Trn_Id] = @Trn_Id
	RETURN
END



