CREATE PROCEDURE X_SP_Upd_Par ( 
    @Par_Id		  INT,
	@Par_num      INT,
    @Usr_Id_W     INT,
    @Usr_Id_B     INT,
    @Trn_Id       INT,
    @Par_Status   INT,
    @Par_InActive BIT,
	@Par_Res	  FLOAT
)
AS
BEGIN
    UPDATE [dbo].[Partie]
    SET
		Par_num			= @Par_num,
        Usr_Id_W		= @Usr_Id_W,
        Usr_Id_B		= @Usr_Id_B,
        Trn_Id			= @Trn_Id,
        Par_Status		= @Par_Status, 
        Par_InActive	= @Par_InActive,
		Par_Res			= @Par_Res
    WHERE
        Par_Id = @Par_Id
END