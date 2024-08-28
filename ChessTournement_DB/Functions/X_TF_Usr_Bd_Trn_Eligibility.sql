/* FUNCTION RETURN AN ELIGIBILITY TABLE OF TOURNAMENTS  
FOR A USER_ID AND WHEN BIRTHDATE < DATE OF END SUBSCRIPTION */

CREATE FUNCTION X_TF_Usr_Bd_Trn_Eligibility 
(
	@Users_Id INT
)

RETURNS @Result TABLE(
	[Trn_Id]       INT NOT NULL,
    [Trn_Name]     NVARCHAR (100) NOT NULL,
    [Trn_Geo]      NVARCHAR (100) NULL,
    [Trn_MinUsers] INT            NOT NULL,
    [Trn_MaxUsers] INT            NOT NULL,
    [Trn_MinElo]   INT            NULL,
    [Trn_MaxElo]   INT            NULL,
    [Trn_Status]   INT            NOT NULL,
    [Trn_Round]    INT            NOT NULL,
    [Trn_Women]    BIT            NOT NULL,
    [Trn_EndSubs]  DATETIME       NULL,
    [Trn_CreaDate] DATETIME       NULL,
    [Trn_UpdDate]  DATETIME       NULL,
    [Trn_Active]   BIT            NULL)
AS
BEGIN
DECLARE @bd DATETIME = (SELECT Usr_Birthdate FROM Users WHERE Usr_Id=@Users_Id);
DECLARE @genre INT = (SELECT Usr_Genre FROM Users WHERE Usr_Id=@Users_Id);
DECLARE @Cat INT = ([dbo].X_SF_Usr_Cat(@Users_Id,getdate()));
DECLARE @WoMenFlag BIT = 0;


SET @WoMenFlag = (SELECT Trn_Women FROM Tournoi WHERE Trn_Women = 1);


IF ((@WoMenFlag = 1) AND (@genre > 0))
BEGIN
INSERT INTO @Result 
SELECT *
FROM Tournoi Trn
WHERE (
    (Trn_Status = 0) 
    AND (Trn_Women = 1) 
    AND (GETDATE() < Trn_EndSubs) 
    AND Trn.Trn_Id NOT IN (SELECT Sub_Trn_Id FROM Subscribe WHERE Sub_Trn_Id = Trn.Trn_Id AND Sub_Usr_Id=@Users_Id)
    AND Trn.Trn_MaxUsers > dbo.X_SF_Count_Usr_Trn_Subs(Trn.Trn_Id)
    AND Trn.Trn_Id IN (SELECT Trn_Id FROM Cat_Trn WHERE Cat_Id = [dbo].X_SF_Usr_Cat(@Users_Id,Trn.Trn_EndSubs))
    AND Trn.Trn_MaxElo > (SELECT Usr_Elo FROM Users WHERE Usr_Id = @Users_Id)
    AND Trn.Trn_MinElo < (SELECT Usr_Elo FROM Users WHERE Usr_Id = @Users_Id)
);
END
ELSE
BEGIN
INSERT INTO @Result SELECT *
FROM Tournoi Trn
WHERE (
    (Trn_Status = 0) 
    AND (Trn_Women = 0) 
    AND (GETDATE() < Trn_EndSubs) 
    AND Trn.Trn_Id NOT IN (SELECT Sub_Trn_Id FROM Subscribe WHERE Sub_Trn_Id = Trn.Trn_Id AND Sub_Usr_Id=@Users_Id)
    AND Trn.Trn_MaxUsers > dbo.X_SF_Count_Usr_Trn_Subs(Trn.Trn_Id)
    AND Trn.Trn_Id IN (SELECT Trn_Id FROM Cat_Trn WHERE Cat_Id = [dbo].X_SF_Usr_Cat(@Users_Id,Trn.Trn_EndSubs))
    AND Trn.Trn_MaxElo > (SELECT Usr_Elo FROM Users WHERE Usr_Id = @Users_Id)
    AND Trn.Trn_MinElo < (SELECT Usr_Elo FROM Users WHERE Usr_Id = @Users_Id)
);
END
RETURN
END

/* FAIRE UNE DOUBLE CONDITION 
SI TRN_ID*/