/* RETOURNE LES CHAMPS USERS AVEC AGE CALCULE ET CATEGORIE CALCULEE SUR BASE DE DATE NAISSANCE */
CREATE VIEW UserView
AS
SELECT *, [dbo].[X_SF_Usr_Age]([dbo].[users].[Usr_Birthdate]) AS UsrV_Age, [dbo].[X_SF_Usr_Cat]([dbo].[users].[Usr_Id], getdate()) AS UsrV_Cat
FROM [dbo].[Users]