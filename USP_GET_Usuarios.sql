 CREATE PROCEDURE [dbo].[USP_GET_Usuarios]          
            
	@nOpcion INT = 0,
    @nIdUsuario INT=0                                                                               
AS     

BEGIN
	
	IF @nOpcion = 1   --CONSULTAR TODO  --Lista de Disponibilidad->Todos
	BEGIN	                                                                                                                                                     
			SELECT 
				usr.nIdUsuario, 
				CONCAT(usr.sNombres,' ',usr.sApellidos) AS 'sNombrePersona',
				lgn.sNombreUsuario,
				rol.sNombreRol,
				IIF(usr.bEstado=1,'Activo', 'Inactivo') AS 'sEstado'
			FROM [TBL_USUARIO] usr
			INNER JOIN [TBL_LOGIN] lgn ON lgn.nIdUsuario=usr.nIdUsuario
			INNER JOIN [TBL_ROL] rol ON rol.nIdRol=usr.nRol
			ORDER BY
				usr.bEstado DESC ,
				usr.nIdUsuario
				
                                                                                 
	END;                                     
		
	ELSE IF @nOpcion = 2  --CONSULTAR POR ID 
	BEGIN
				
		BEGIN
			SELECT 
				*,
				CONVERT(VARCHAR, usr.dFechaNacimiento,23) AS 'dFechaNac'
			FROM [TBL_USUARIO] usr
			INNER JOIN [TBL_LOGIN] lgn ON lgn.nIdUsuario=usr.nIdUsuario
			WHERE usr.nIdUsuario = @nIdUsuario

		END
	END;	           	 
	
END
