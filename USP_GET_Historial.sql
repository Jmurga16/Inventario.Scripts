 CREATE PROCEDURE [dbo].[USP_GET_Historial]          
            
	@nIdUsuario INT = 0,
    @nIdProducto INT = 0
	
AS     

BEGIN
	
	BEGIN	                                                                                                                                                     
			SELECT 
				hist.nIdHistorial, 
				usr.sNombres AS 'sNombreUsuario',
				prd.sNombre AS 'sNombreProducto',
				hist.sAccion,				
				prd.bEstado			
			FROM [TBL_HISTORIAL] hist
			INNER JOIN [TBL_PRODUCTO] prd	ON hist.nIdProducto = prd.nIdProducto
			INNER JOIN TBL_USUARIO usr	ON hist.nIdUsuario = usr.nIdUsuario
			WHERE
				usr.nIdUsuario = @nIdUsuario 
				AND prd.nIdProducto = @nIdProducto
			ORDER BY
				hist.dFecha DESC 
                                                                                 
	END;          
	
END
