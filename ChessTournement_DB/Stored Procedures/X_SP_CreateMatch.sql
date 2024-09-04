CREATE PROCEDURE X_SP_CreatMatch(@Trn_Id INT)
AS
BEGIN


-- Vérifier et mettre à jour le statut du tournoi

DECLARE @PlayerCount INT;
DECLARE @Trn_MinUsers INT;
DECLARE @Trn_MaxUsers INT;
DECLARE @Trn_EndSubs DATETIME;

-- Compter le nombre de joueurs inscrits
SELECT @PlayerCount = COUNT(*)
FROM Subscribe
WHERE Sub_Trn_Id = @Trn_Id;

-- Obtenir le nombre minimum et maximum de joueurs requis
SELECT @Trn_MinUsers = Trn_MinUsers, @Trn_MaxUsers = Trn_MaxUsers, @Trn_EndSubs = Trn_EndSubs
FROM Tournoi
WHERE Trn_Id = @Trn_Id;

-- Vérifier si le nombre de joueurs inscrits est suffisant
IF @PlayerCount < @Trn_MinUsers AND @PlayerCount > @Trn_MaxUsers AND [dbo].X_SF_Trn_EndSubs(@Trn_EndSubs) < 0 
BEGIN
    PRINT 'Toutes les conditions pour demarrer un tournoi ne sont pas respectees';
END
ELSE
BEGIN

            -- Ajouter le joueur fictif si le nombre de joueurs est impair et que Trn_MaxUsers est bien < ou = à Trn_Maxusers diminué de 1
            IF (@PlayerCount % 2 <> 0) AND (@PlayerCount <= (@Trn_MaxUsers-1))
            BEGIN
                INSERT INTO Subscribe (Sub_Usr_Id, Sub_Trn_Id, Sub_Date, Sub_Active)
                VALUES (1, @Trn_Id, GETDATE(), 1);
                SET @PlayerCount = @PlayerCount + 1;
            END
            ELSE
            BEGIN
                PRINT 'Toutes les conditions pour ajouter un utilisateur fictif ne sont pas respectees';
            END


            -- Insérer les parties pour les matchs aller
            DECLARE @Player1_Id INT;
            DECLARE @Player2_Id INT;
            DECLARE @Round INT = 1;
            DECLARE @PartieNum INT = 1;

            DECLARE PlayerCursor CURSOR FOR
            SELECT Sub_Usr_Id
            FROM Subscribe
            WHERE Sub_Trn_Id = @Trn_Id;

            OPEN PlayerCursor;
            FETCH NEXT FROM PlayerCursor INTO @Player1_Id;

            WHILE @@FETCH_STATUS = 0
            BEGIN
                DECLARE InnerCursor CURSOR FOR
                SELECT Sub_Usr_Id
                FROM Subscribe
                WHERE Sub_Trn_Id = @Trn_Id AND Sub_Usr_Id > @Player1_Id;

                OPEN InnerCursor;
                FETCH NEXT FROM InnerCursor INTO @Player2_Id;

                WHILE @@FETCH_STATUS = 0
                BEGIN
                    -- Vérifier que les joueurs ne se rencontrent pas eux-mêmes
                    IF @Player1_Id <> @Player2_Id
                    BEGIN
                        -- Insérer la partie pour le match aller
                        INSERT INTO Partie (Trn_Id, Usr_Id_W, Usr_Id_B, Trn_Round, Par_num)
                        VALUES (@Trn_Id, @Player1_Id, @Player2_Id, @Round, @PartieNum);

                        -- Incrémenter le numéro de partie pour le prochain match
                        SET @PartieNum = @PartieNum + 1;
                    END

                    FETCH NEXT FROM InnerCursor INTO @Player2_Id;
                END;

                CLOSE InnerCursor;
                DEALLOCATE InnerCursor;

                -- Passer à la prochaine ronde
                SET @Round = @Round + 1;

                FETCH NEXT FROM PlayerCursor INTO @Player1_Id;
            END;

            CLOSE PlayerCursor;
            DEALLOCATE PlayerCursor;

            -- Réinitialiser les variables pour les matchs retour
            SET @Round = 1;

            -- Insérer les parties pour les matchs retour
            OPEN PlayerCursor;
            FETCH NEXT FROM PlayerCursor INTO @Player1_Id;

            WHILE @@FETCH_STATUS = 0
            BEGIN
                DECLARE InnerCursor CURSOR FOR
                SELECT Sub_Usr_Id
                FROM Subscribe
                WHERE Sub_Trn_Id = @Trn_Id AND Sub_Usr_Id > @Player1_Id;

                OPEN InnerCursor;
                FETCH NEXT FROM InnerCursor INTO @Player2_Id;

                WHILE @@FETCH_STATUS = 0
                BEGIN
                    -- Vérifier que les joueurs ne se rencontrent pas eux-mêmes
                    IF @Player1_Id <> @Player2_Id
                    BEGIN
                        -- Insérer la partie pour le match retour
                        INSERT INTO Partie (Trn_Id, Usr_Id_W, Usr_Id_B, Trn_Round, Par_num)
                        VALUES (@Trn_Id, @Player2_Id, @Player1_Id, @Round + @PlayerCount - 1, @PartieNum);

                        -- Incrémenter le numéro de partie pour le prochain match
                        SET @PartieNum = @PartieNum + 1;
                    END

                    FETCH NEXT FROM InnerCursor INTO @Player2_Id;
                END;

                CLOSE InnerCursor;
                DEALLOCATE InnerCursor;

                -- Passer à la prochaine ronde
                SET @Round = @Round + 1;

                FETCH NEXT FROM PlayerCursor INTO @Player1_Id;
            END;

            CLOSE PlayerCursor;
            DEALLOCATE PlayerCursor;
END  /*FIN DU IF DES CONDITIONS*/
END;








/*CREATE PROCEDURE X_SP_CreatMatch(@Trn_Id INT)
AS
BEGIN
    DECLARE @MinUsers INT, @EndSubs DATETIME, @CurrentDate DATETIME, @NbrSub INT;
    SET @NbrSub = [dbo].X_SF_Count_Usr_Trn_Subs(@Trn_Id);
    SET @CurrentDate = GETDATE();
    SELECT @MinUsers = Trn_MinUsers, @EndSubs = Trn_EndSubs 
    FROM [dbo].[Tournoi]
    WHERE Trn_Id = @Trn_Id;

    IF (@NbrSub < @MinUsers)
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
        DECLARE @TableVariable TABLE (Sub_Usr_Id INT);
        INSERT INTO @TableVariable (Sub_Usr_Id)
        SELECT Sub_Usr_Id
        FROM [dbo].Subscribe
        WHERE Sub_Trn_Id = @Trn_Id;

        DECLARE @PlayerCount INT;
        SELECT @PlayerCount = COUNT(*) FROM @TableVariable;
        IF @PlayerCount % 2 <> 0
        BEGIN
            DECLARE @i INT = 0;
            WHILE @i < @PlayerCount
            BEGIN
                DECLARE @Usr_Id INT = 0;
                DECLARE @TrnId INT = @Trn_Id;
                DECLARE @Sub_Date DATETIME = GETDATE();
                DECLARE @Sub_Active BIT = 1;
                DECLARE @Result1 INT;
                DECLARE @Result2 INT;

                EXEC [dbo].[X_SP_Add_Subs] 
                    @Usr_Id,
                    @TrnId,
                    @Sub_Date,
                    @Sub_Active,
                    @Result1 = @Result1 OUTPUT,
                    @Result2 = @Result2 OUTPUT;

                SET @i = @i + 1;
            END
            INSERT INTO @TableVariable (Sub_Usr_Id) VALUES (1); -- 1 représente le joueur fictif
            SET @PlayerCount = @PlayerCount + 1;
        END

        PRINT 'Nombre de joueurs: ' + CAST(@PlayerCount AS NVARCHAR(10));

        DECLARE @n INT = @PlayerCount;
       
        DECLARE @j INT;
        DECLARE @PartieNum INT = 1;
        DECLARE @RoundNum INT = 1;

        WHILE @RoundNum <= @n - 1
        BEGIN
            SET @i = 0;
            WHILE @i < @n / 2
            BEGIN
                SET @j = (@RoundNum + @i) % (@n - 1);
                IF @j = 0 SET @j = @n - 1;

                IF @i <> @j 
                BEGIN
                    INSERT INTO [dbo].[Partie] (Par_num, Usr_Id_W, Usr_Id_B, Trn_Id, Trn_Round, Par_Res, Par_InActive)
                    VALUES (@PartieNum, 
                            (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @i ROWS FETCH NEXT 1 ROWS ONLY), 
                            (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @j ROWS FETCH NEXT 1 ROWS ONLY), 
                            @Trn_Id, @RoundNum, 0, 0);

                    PRINT 'Aller - Round ' + CAST(@RoundNum AS NVARCHAR(10)) + ': Partie ' + CAST(@PartieNum AS NVARCHAR(10)) + ' = Joueur[' + CAST(@i AS NVARCHAR(10)) + '] vs Joueur[' + CAST(@j AS NVARCHAR(10)) + ']';
                    SET @PartieNum = @PartieNum + 1;
                END
                SET @i = @i + 1;
            END
            SET @RoundNum = @RoundNum + 1;
        END

        SET @RoundNum = 1;
        WHILE @RoundNum <= @n - 1
        BEGIN
            SET @i = 0;
            WHILE @i < @n / 2
            BEGIN
                SET @j = (@RoundNum + @i) % (@n - 1);
                IF @j = 0 SET @j = @n - 1;

                IF @i <> @j
                BEGIN
                    INSERT INTO [dbo].[Partie] (Par_num, Usr_Id_W, Usr_Id_B, Trn_Id, Trn_Round, Par_Res, Par_InActive)
                    VALUES (@PartieNum, 
                            (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @j ROWS FETCH NEXT 1 ROWS ONLY), 
                            (SELECT Sub_Usr_Id FROM @TableVariable ORDER BY Sub_Usr_Id OFFSET @i ROWS FETCH NEXT 1 ROWS ONLY), 
                            @Trn_Id, @RoundNum + @n - 1, 0, 0);

                    PRINT 'Retour - Round ' + CAST(@RoundNum + @n - 1 AS NVARCHAR(10)) + ': Partie ' + CAST(@PartieNum AS NVARCHAR(10)) + ' = Joueur[' + CAST(@j AS NVARCHAR(10)) + '] vs Joueur[' + CAST(@i AS NVARCHAR(10)) + ']';
                    SET @PartieNum = @PartieNum + 1;
                END
                SET @i = @i + 1;
            END
            SET @RoundNum = @RoundNum + 1;
        END
    END
END*/