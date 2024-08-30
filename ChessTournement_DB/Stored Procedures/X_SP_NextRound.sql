CREATE PROCEDURE X_SP_NextRound(
    @Trn_Id INT
)
AS
BEGIN
    BEGIN TRY
        DECLARE @CurrentRound INT;
        DECLARE @UnplayedMatches INT;
        DECLARE @Trn_Status INT;

        -- Récupérer le statut du tournoi
        SELECT @Trn_Status = Trn_Status
        FROM Tournoi
        WHERE Trn_Id = @Trn_Id;

        -- Vérifier si le tournoi est actif
        IF @Trn_Status <> 1
        BEGIN
                DECLARE @MESSAGE VARCHAR(300) = 'Trn_Status ' + CAST(@Trn_Status AS VARCHAR(10)) + ' Toutes les conditions pour ajouter un Round ne sont pas respectées';
                RAISERROR (@MESSAGE, 16, 1);
                RETURN;
        END

        -- Récupérer la ronde courante du tournoi
        SELECT @CurrentRound = Trn_Round
        FROM Tournoi
        WHERE Trn_Id = @Trn_Id;

        IF @Trn_Status = 1
        BEGIN
            -- Vérifier si toutes les parties de la ronde courante ont été jouées
            SELECT @UnplayedMatches = COUNT(*)
            FROM Partie
            WHERE Trn_Id = @Trn_Id AND Trn_Round = @CurrentRound AND Par_Res = 0;

            IF @UnplayedMatches > 0
            BEGIN
                RAISERROR ('Toutes les rencontres de la ronde courante pas finies', 16, 1);
                RETURN;
            END

            -- Incrémenter la ronde courante du tournoi
            UPDATE Tournoi
            SET Trn_Round = Trn_Round + 1
            WHERE Trn_Id = @Trn_Id;

            PRINT('La ronde courante du tournoi augmente');
        END
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