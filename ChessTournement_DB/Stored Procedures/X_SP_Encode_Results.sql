CREATE PROCEDURE X_SP_EncodeResult(
    @Trn_Id INT,
    @Trn_Round INT,
    @Par_Num INT,
    @Resultat INT -- 0 = pas joué, 1 = Blanc gagnant, 2 = Noir gagnant, 3 = Egalité
)
AS
BEGIN
    BEGIN TRY
        -- Déclarer les variables pour les IDs des joueurs, les points et la ronde courante
        DECLARE @Usr_Id_W INT;
        DECLARE @Usr_Id_B INT;
        DECLARE @Points_W FLOAT = 0;
        DECLARE @Points_B FLOAT = 0;
        DECLARE @OldPoints_W FLOAT = 0;
        DECLARE @OldPoints_B FLOAT = 0;
        DECLARE @Partie_Round INT;
        DECLARE @Partie_Id INT;
        DECLARE @OldResultat INT;

        -- Récupérer le ID Partie
        SELECT @Partie_Id = Par_Id 
        FROM Partie 
        WHERE Trn_Id = @Trn_Id AND Trn_Round = @Trn_Round AND Par_num = @Par_Num;

        -- Récupérer les IDs des joueurs et la ronde de la partie
        SELECT @Usr_Id_W = Usr_Id_W, @Usr_Id_B = Usr_Id_B, @Partie_Round = Trn_Round, @OldResultat = Par_Res
        FROM Partie
        WHERE Par_Id = @Partie_Id;

        -- Vérifier si la partie fait partie de la ronde courante
        IF @Partie_Round <> @Trn_Round
        BEGIN
            RAISERROR ('La partie ne fait pas partie de la ronde courante', 16, 1);
            RETURN;
        END

        -- Calculer les anciens points en fonction du résultat précédent
        IF @OldResultat = 1
        BEGIN
            SET @OldPoints_W = 3; -- Blanc gagnant
        END
        ELSE IF @OldResultat = 2
        BEGIN
            SET @OldPoints_B = 3; -- Noir gagnant
        END
        ELSE IF @OldResultat = 3
        BEGIN
            SET @OldPoints_W = 0.5; -- Egalité
            SET @OldPoints_B = 0.5; -- Egalité
        END

        -- Soustraire les anciens points
        UPDATE Subscribe
        SET Points = Points - @OldPoints_W
        WHERE Sub_Trn_Id = @Trn_Id AND Sub_Usr_Id = @Usr_Id_W;

        UPDATE Subscribe
        SET Points = Points - @OldPoints_B
        WHERE Sub_Trn_Id = @Trn_Id AND Sub_Usr_Id = @Usr_Id_B;

        -- Calculer les nouveaux points en fonction du nouveau résultat
        IF @Resultat = 1
        BEGIN
            SET @Points_W = 3; -- Blanc gagnant
        END
        ELSE IF @Resultat = 2
        BEGIN
            SET @Points_B = 3; -- Noir gagnant
        END
        ELSE IF @Resultat = 3
        BEGIN
            SET @Points_W = 0.5; -- Egalité
            SET @Points_B = 0.5; -- Egalité
        END

        -- Mettre à jour les résultats de la partie
        UPDATE Partie
        SET Par_Res = @Resultat
        WHERE Par_Id = @Partie_Id;

        -- Ajouter les nouveaux points
        UPDATE Subscribe
        SET Points = Points + @Points_W
        WHERE Sub_Trn_Id = @Trn_Id AND Sub_Usr_Id = @Usr_Id_W;

        UPDATE Subscribe
        SET Points = Points + @Points_B
        WHERE Sub_Trn_Id = @Trn_Id AND Sub_Usr_Id = @Usr_Id_B;
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