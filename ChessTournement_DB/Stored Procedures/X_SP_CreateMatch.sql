
CREATE PROCEDURE X_SP_CreatMatch(@Trn_Id INT)
AS
BEGIN
    -- Vérifier si le nombre minimum de participants est atteint et si la date de fin des inscriptions est dépassée
    DECLARE @MinUsers INT, @EndSubs DATETIME, @CurrentDate DATETIME, @NbrSub INT;
    SET @NbrSub = [dbo].X_SF_Count_Usr_Trn_Subs(@Trn_Id) 
    SET @CurrentDate = GETDATE()
    SELECT @MinUsers = Trn_MinUsers, @EndSubs = Trn_EndSubs 
    FROM [dbo].[Tournoi]
    WHERE Trn_Id = @Trn_Id;



    IF (@NbrSub) < @MinUsers 
    BEGIN
        PRINT 'Le nombre minimum de participants pas atteint.';
        RETURN;
    END

    IF [dbo].X_SF_Trn_EndSubs(@EndSubs) < 0
    BEGIN
        PRINT 'La date de fin des inscriptions est dépassée.';
        RETURN;
    END


    IF @NbrSub >= @MinUsers AND [dbo].X_SF_Trn_EndSubs(@EndSubs) >= 0
    BEGIN
        -- Déclarer une table variable pour stocker les utilisateurs
        DECLARE @TableVariable TABLE (
            Sub_Usr_Id INT
        );

        -- Insérer les résultats de la requête SELECT dans la table variable
        INSERT INTO @TableVariable (Sub_Usr_Id)
        SELECT Sub_Usr_Id
        FROM [dbo].Subscribe
        WHERE Sub_Trn_Id = @Trn_Id;

        -- Sélectionner les données de la table variable
        SELECT * FROM @TableVariable;

        -- Tester le nombre de joueurs pour déterminer s'il est pair ou impair
        DECLARE @PlayerCount INT;
        SELECT @PlayerCount = COUNT(*) FROM @TableVariable;
        PRINT 'Nombre de joueurs: ' + CAST(@PlayerCount AS NVARCHAR(10));

        DECLARE @n INT = @PlayerCount;

        -- Générer les rencontres en format Round Robin (Aller-Retour)
        DECLARE @i INT = 0;
        DECLARE @j INT;
        DECLARE @PartieNum INT = 1;
        DECLARE @RoundNum INT = 1;

        WHILE @i < @n
        BEGIN
            SET @j = @i + 1;
            WHILE @j < @n
            BEGIN
                -- Insérer les paires dans la table Partie pour l'aller
                INSERT INTO [dbo].[Partie] (Par_num, Usr_Id_W, Usr_Id_B, Trn_Id, Par_Status, Par_InActive, Par_Res)
                VALUES (@PartieNum, 
                        (SELECT Sub_Usr_Id FROM @TableVariable WHERE Sub_Usr_Id = (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @i ROWS FETCH NEXT 1 ROWS ONLY)), 
                        (SELECT Sub_Usr_Id FROM @TableVariable WHERE Sub_Usr_Id = (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @j ROWS FETCH NEXT 1 ROWS ONLY)), 
                        @Trn_Id, 0, 0, NULL);


                -- Insérer les paires dans la table Partie pour le retour
                INSERT INTO [dbo].[Partie] (Par_num, Usr_Id_W, Usr_Id_B, Trn_Id, Par_Status, Par_InActive, Par_Res)
                VALUES (@PartieNum + 1, 
                        (SELECT Sub_Usr_Id FROM @TableVariable WHERE Sub_Usr_Id = (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @j ROWS FETCH NEXT 1 ROWS ONLY)), 
                        (SELECT Sub_Usr_Id FROM @TableVariable WHERE Sub_Usr_Id = (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @i ROWS FETCH NEXT 1 ROWS ONLY)), 
                        @Trn_Id, 0, 0, NULL);

                PRINT 'Partie ' + CAST(@PartieNum AS NVARCHAR(10)) + ' = Joueur[' + CAST(@i AS NVARCHAR(10)) + '] vs Joueur[' + CAST(@j AS NVARCHAR(10)) + ']';
                PRINT 'Partie ' + CAST(@PartieNum + 1 AS NVARCHAR(10)) + ' = Joueur[' + CAST(@j AS NVARCHAR(10)) + '] vs Joueur[' + CAST(@i AS NVARCHAR(10)) + ']';
                SET @PartieNum = @PartieNum + 2;
                SET @j = @j + 1;
            END
            SET @i = @i + 1;
        END

    END
END;

















/*

CREATE PROCEDURE X_SP_CreatMatch(@Trn_Id INT)
AS
BEGIN
    -- Déclarer une table variable pour stocker les utilisateurs
    DECLARE @TableVariable TABLE (
        Sub_Usr_Id INT
    );

    -- Insérer les résultats de la requête SELECT dans la table variable
    INSERT INTO @TableVariable (Sub_Usr_Id)
    SELECT Sub_Usr_Id
    FROM [dbo].Subscribe
    WHERE Sub_Trn_Id = @Trn_Id;

    -- Sélectionner les données de la table variable
    SELECT * FROM @TableVariable;

    -- Tester le nombre de joueurs pour déterminer s'il est pair ou impair
    DECLARE @PlayerCount INT;
    SELECT @PlayerCount = COUNT(*) FROM @TableVariable;
    PRINT 'Nombre de joueurs: ' + CAST(@PlayerCount AS NVARCHAR(10));

    DECLARE @n INT = @PlayerCount;
    DECLARE @Parties INT;

    IF @PlayerCount % 2 != 0
    BEGIN
        -- Si le nombre de joueurs est impair, ajouter un joueur fictif
        SET @n = @PlayerCount + 1;
        INSERT INTO @TableVariable (Sub_Usr_Id) VALUES (NULL); -- Joueur fictif
    END

    PRINT 'Nombre de joueurs après ajout fictif (si nécessaire): ' + CAST(@n AS NVARCHAR(10));

    -- Calculer le nombre de parties
    SET @Parties = (@n * (@n - 1)) / 2;
    PRINT 'Nombre de parties: ' + CAST(@Parties AS NVARCHAR(10));

    -- Fixer le premier joueur à l'index 0
    DECLARE @i INT = 0;
    DECLARE @j INT;
    DECLARE @PartieNum INT = 1;

    WHILE @i < @n
    BEGIN
        SET @j = @i + 1;
        WHILE @j < @n
        BEGIN
            -- Insérer les paires dans la table Partie
            INSERT INTO [dbo].[Partie] (Par_num, Usr_Id_W, Usr_Id_B, Trn_Id)
            VALUES (@PartieNum, 
                    (SELECT Sub_Usr_Id FROM @TableVariable WHERE Sub_Usr_Id = (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @i ROWS FETCH NEXT 1 ROWS ONLY)), 
                    (SELECT Sub_Usr_Id FROM @TableVariable WHERE Sub_Usr_Id = (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @j ROWS FETCH NEXT 1 ROWS ONLY)), 
                    @Trn_Id);

            PRINT 'Partie ' + CAST(@PartieNum AS NVARCHAR(10)) + ' = Joueur[' + CAST(@i AS NVARCHAR(10)) + '] vs Joueur[' + CAST(@j AS NVARCHAR(10)) + ']';
            SET @PartieNum = @PartieNum + 1;
            SET @j = @j + 1;
        END
        SET @i = @i + 1;
    END

    -- Décaler toutes les équipes d'une place dans le tableau, sauf le dernier qu'on met en deuxième place
    -- (Cette partie nécessite une logique supplémentaire pour gérer le décalage des équipes)
        -- Sélectionner les données de la table variable
    SELECT * FROM Partie;
END;
*/
