CREATE PROCEDURE X_SP_GetScoreboard(
    @Trn_Id INT,
    @Trn_Round INT
)
AS
BEGIN
    BEGIN TRY
        SELECT 
            S.Sub_Usr_Id AS JoueurID,
            U.Usr_Lastname AS LastName,
            U.Usr_Firstname AS Firstname,
            COUNT(DISTINCT P.Par_Id) AS RencontresJouees,
            SUM(CASE WHEN P.Par_Res = 1 AND P.Usr_Id_W = S.Sub_Usr_Id THEN 1 ELSE 0 END) AS Victoires,
            SUM(CASE WHEN P.Par_Res = 2 AND P.Usr_Id_B = S.Sub_Usr_Id THEN 1 ELSE 0 END) AS Defaites,
            SUM(CASE WHEN P.Par_Res = 3 THEN 1 ELSE 0 END) AS Egalites,
            SUM(CASE WHEN P.Par_Res = 1 AND P.Usr_Id_W = S.Sub_Usr_Id THEN 1 
                     WHEN P.Par_Res = 2 AND P.Usr_Id_B = S.Sub_Usr_Id THEN 1 
                     WHEN P.Par_Res = 3 THEN 0.5 ELSE 0 END) AS Score
        FROM 
            Subscribe S
        JOIN 
            Users U ON S.Sub_Usr_Id = U.Usr_Id
        LEFT JOIN 
            Partie P ON S.Sub_Trn_Id = P.Trn_Id AND (S.Sub_Usr_Id = P.Usr_Id_W OR S.Sub_Usr_Id = P.Usr_Id_B)
        WHERE 
            S.Sub_Trn_Id = @Trn_Id AND P.Trn_Round = @Trn_Round AND P.Par_Res != 0
        GROUP BY 
            S.Sub_Usr_Id, U.Usr_Lastname, U.Usr_Firstname
        ORDER BY 
            Score DESC;
    END TRY
    BEGIN CATCH
        -- Gérer les erreurs
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
