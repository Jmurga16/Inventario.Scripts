
                                   
 CREATE PROCEDURE [dbo].[USP_MNT_Usuarios]          
            
	@nOpcion INT = 0,   
	@pParametro VARCHAR(max)
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @nIdUsuario INT;
		DECLARE @sContrasenia VARCHAR(MAX)
		DECLARE @sNombreUsuario VARCHAR(MAX)
		DECLARE @sNombres VARCHAR(MAX);
		DECLARE @bEstado BIT;
		DECLARE @nEstado INT;
		DECLARE @nIdRol INT;
		DECLARE @sApellidos		  VARCHAR(MAX);
		DECLARE @nTipoDoc		  INT;
		DECLARE @sNumDoc		  VARCHAR(MAX);
		DECLARE @sSexo			  VARCHAR(MAX);		
		DECLARE @sDireccion		  VARCHAR(MAX);
		DECLARE @nTelefono		  INT;
		DECLARE @dFechaNacimiento DATE;
		DECLARE @nContador INT
    

	END
	
	--VARIABLE TABLA
	BEGIN

		DECLARE @tParametro TABLE (
			id int,
			valor varchar(max)
		);

	END

	--Descontena el parametro con split
	BEGIN
		IF(LEN(LTRIM(RTRIM(@pParametro))) > 0)
			BEGIN
			    INSERT INTO @tParametro (id, valor ) SELECT id, valor FROM dbo.Split(@pParametro, '|');
			END;
	END;
        
		
  IF @nOpcion = 1  --INSERTAR  (R)                                                        
	BEGIN
		BEGIN
			SET @sNombres			= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @sApellidos			= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @nTipoDoc			= cast((SELECT valor FROM @tParametro WHERE id = 3) AS INT);
			SET @sNumDoc			= (SELECT valor FROM @tParametro WHERE id = 4);
			SET @sSexo				= (SELECT valor FROM @tParametro WHERE id = 5);			
			SET @nIdRol				= cast((SELECT valor FROM @tParametro WHERE id = 6) AS INT);
			SET @sDireccion			= (SELECT valor FROM @tParametro WHERE id = 7);
			SET @nTelefono			= (SELECT valor FROM @tParametro WHERE id = 8);
			SET @dFechaNacimiento	= (SELECT valor FROM @tParametro WHERE id = 9);
			SET @sContrasenia		= (SELECT valor FROM @tParametro WHERE id = 10);
		END	

		BEGIN

      BEGIN TRAN
			BEGIN TRY
				BEGIN

					INSERT INTO [TBL_USUARIO]
				        (sNombres,sApellidos,nTipoDoc,sNumDoc,sSexo,nRol,sDireccion,nTelefono,dFechaNacimiento,bEstado)
					VALUES(@sNombres,@sApellidos,@nTipoDoc,@sNumDoc,@sSexo,@nIdRol,@sDireccion,@nTelefono,@dFechaNacimiento,1)

			  SET @nIdUsuario = SCOPE_IDENTITY()

			  SET @sNombreUsuario = CONCAT(SUBSTRING(@sNombres,1,CHARINDEX(' ', @sNombres+' ',1)-1),'.',SUBSTRING(@sApellidos,1,CHARINDEX(' ', @sApellidos+' ',1)-1))

			  SET @nContador = (SELECT COUNT(*) FROM [TBL_USUARIO] WHERE sNombres=LOWER(@sNombres) AND sApellidos=LOWER(@sApellidos))
	
			  IF(@nContador>0)
			  BEGIN
				SET @nContador = @nContador+1
			      SET @sNombreUsuario = CONCAT(@sNombreUsuario,@nContador)
			  END
		
    
			  INSERT INTO [TBL_LOGIN]
				      (nIdUsuario, sNombreUsuario, sContrasenia)
			  VALUES(@nIdUsuario , LOWER(@sNombreUsuario),@sContrasenia)

			  SELECT CONCAT('1|','El usuario se registró con éxito');

				END
				COMMIT TRAN
			END TRY
			BEGIN CATCH
				ROLLBACK TRAN
				PRINT ERROR_MESSAGE();					
				SELECT concat('0|','Ha ocurrido un error al momento de registrar el usuario!');
			END CATCH
                
		END
		
	END
	   
	   
	ELSE IF @nOpcion = 2  -- EDITAR   (U)                                                        
	BEGIN
		BEGIN
			SET @sNombres			= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @sApellidos			= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @nTipoDoc			= cast((SELECT valor FROM @tParametro WHERE id = 3) AS INT);
			SET @sNumDoc			= (SELECT valor FROM @tParametro WHERE id = 4);
			SET @sSexo				= (SELECT valor FROM @tParametro WHERE id = 5);			
			SET @nIdRol				= cast((SELECT valor FROM @tParametro WHERE id = 6) AS INT);
			SET @sDireccion			= (SELECT valor FROM @tParametro WHERE id = 7);
			SET @nTelefono			= cast((SELECT valor FROM @tParametro WHERE id = 8) AS INT);
			SET @dFechaNacimiento	= (SELECT valor FROM @tParametro WHERE id = 9);
			SET @sContrasenia		= (SELECT valor FROM @tParametro WHERE id = 10);
			SET @nIdUsuario			= (SELECT valor FROM @tParametro WHERE id = 11);
		END	


      BEGIN TRAN
				BEGIN TRY
					BEGIN

						UPDATE [TBL_USUARIO]                           
		         SET 
			        sNombres			= @sNombres,                           
			        sApellidos			= @sApellidos,       
			        nTipoDoc			= @nTipoDoc,
			        sNumDoc				= @sNumDoc,
			        sSexo				= @sSexo,
			        nRol				= @nIdRol,
			        sDireccion			= @sDireccion,
			        nTelefono			= @nTelefono,
			        dFechaNacimiento	= @dFechaNacimiento
		         WHERE 
			        nIdUsuario = @nIdUsuario                          
		 
		         UPDATE [TBL_LOGIN]                           
		         SET 
			        sContrasenia	= @sContrasenia
		         WHERE 
			        nIdUsuario = @nIdUsuario  


					SELECT CONCAT('1|','El usuario se actualizó con éxito');

					END
					COMMIT TRAN
				END TRY
				BEGIN CATCH
					ROLLBACK TRAN
					PRINT ERROR_MESSAGE();					
					SELECT CONCAT('0|','Ha ocurrido un error al momento de actualizar el usuario!');
				END CATCH
										 
                                                       
	END;                            

                                                           
	ELSE IF @nOpcion = 3  -- ELIMINAR (D)                                                          
	BEGIN  
		BEGIN
			SET @nIdUsuario	= (SELECT valor FROM @tParametro WHERE id = 1);	
			SET @bEstado	= (SELECT valor FROM @tParametro WHERE id = 2);	
		END	

		BEGIN TRANSACTION
			BEGIN TRY
				BEGIN

					--Eliminacion Logica
					UPDATE [TBL_USUARIO]
						SET	 bEstado = @bEstado
					WHERE nIdUsuario = @nIdUsuario

					IF (@bEstado = 0)
						BEGIN
							SELECT CONCAT('1|','El usuario se eliminó con éxito');
						END
					ELSE
						BEGIN
							SELECT CONCAT('1|','El usuario se activó con éxito');
						END

				END
			COMMIT TRAN
			END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			PRINT ERROR_MESSAGE();					
			SELECT CONCAT('0|','Ha ocurrido un error al momento de actualizar el usuario!');
		END CATCH
                                               
	END;                                                        
    
END
