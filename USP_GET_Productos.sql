CREATE PROCEDURE [dbo].[USP_GET_Productos]          
            
	@nOpcion INT = 0,
    @nIdProducto INT=0
	
AS     

BEGIN
	
	IF @nOpcion = 1   --CONSULTAR TODO
	BEGIN	                                                                                                                                                     
			SELECT 
				prd.nIdProducto, 
				prd.sNombre,
				prd.sDescripcion,
				prd.nStock,
				prd.bEstado,
				IIF(prd.bEstado=1,'Activo', 'Inactivo') AS 'sEstado'
			FROM [TBL_PRODUCTO] prd	
			WHERE bEstado = 1
			ORDER BY
				prd.bEstado DESC ,
				prd.sNombre
				
                                                                                 
	END;                                     
		
	ELSE IF @nOpcion = 2  --CONSULTAR POR ID 
	BEGIN
				
		BEGIN
			SELECT 
				prd.nIdProducto, 
				prd.sNombre,
				prd.sDescripcion,
				prd.nStock,
				prd.bEstado
			FROM [TBL_PRODUCTO] prd	
			WHERE
				prd.nIdProducto = @nIdProducto
		END
	END;
	
END
