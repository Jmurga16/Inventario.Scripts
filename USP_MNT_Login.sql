                                   
 CREATE PROCEDURE [dbo].[USP_MNT_Login]          
            
	@sNombreUsuario VARCHAR(MAX) = '',   
	@sContrasenia VARCHAR(max)=''
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @nIdUsuario INT;
		DECLARE @nIdRol INT;	

	END
	
			
	BEGIN
			SELECT  
				ROW_NUMBER() OVER(ORDER BY lgn.nIdUsuario ASC) as 'Result',
				nRol AS 'nIdRol'
			FROM [TBL_LOGIN] lgn
			INNER JOIN [TBL_USUARIO] usr ON usr.nIdUsuario=lgn.nIdUsuario
			WHERE 
				lgn.sNombreUsuario = @sNombreUsuario AND
				lgn.sContrasenia = @sContrasenia

		END
	                            	 
	
END
