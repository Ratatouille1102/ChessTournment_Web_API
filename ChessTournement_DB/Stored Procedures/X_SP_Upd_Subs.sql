CREATE PROCEDURE X_SP_Upd_Subs ( 
    @Sub_Usr_Id INT,
    @Sub_Trn_Id INT,
    @Sub_Date   DATETIME,
    @Sub_Active BIT
)
AS
BEGIN
    UPDATE [dbo].[Subscribe]
    SET
    Sub_Usr_Id = @Sub_Usr_Id,
    Sub_Trn_Id = @Sub_Trn_Id,
    Sub_Date = @Sub_Date,
    Sub_Active = @Sub_Active
    WHERE
        ((Sub_Usr_Id  = @Sub_Usr_Id) OR (Sub_Trn_Id  = @Sub_Trn_Id))
END