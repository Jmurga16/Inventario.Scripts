                                   
 CREATE PROCEDURE [dbo].[USP_MNT_Productos]          
            
	@nOpcion INT = 0,   
	@pParametro VARCHAR(max)
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @nIdUsuario INT;
		DECLARE @sNombreUsuario VARCHAR(MAX)
		DECLARE @nIdProducto INT;
		DECLARE @sNombre VARCHAR(MAX)
		DECLARE @sDescripcion VARCHAR(MAX)
		DECLARE @nStock		  INT;		
		DECLARE @bEstado BIT;
		DECLARE @sAccion VARCHAR(MAX)
				
		DECLARE @nValor INT

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
			SET @sNombreUsuario		= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @sNombre		= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @sDescripcion	= (SELECT valor FROM @tParametro WHERE id = 3);
			SET @nStock			= cast((SELECT valor FROM @tParametro WHERE id = 4) AS INT);
	
		END	

		BEGIN

			BEGIN TRAN
				BEGIN TRY
					BEGIN

						INSERT INTO [TBL_PRODUCTO]
					        (sNombre, sDescripcion, nStock, bEstado)
						VALUES(@sNombre,@sDescripcion,@nStock,1)

						SET @nIdProducto = SCOPE_IDENTITY()
						SET @nIdUsuario = (SELECT TOP 1 nIdUsuario FROM TBL_LOGIN WHERE sNombreUsuario = @sNombreUsuario)
			
						INSERT INTO [TBL_HISTORIAL]
									(nIdUsuario, nIdProducto, sAccion,dFecha)
						VALUES		(@nIdUsuario , @nIdProducto, 'CREAR',GETDATE())

				  SELECT CONCAT('1|','El producto se registró con éxito');

					END
					COMMIT TRAN
				END TRY
				BEGIN CATCH
					ROLLBACK TRAN
					PRINT ERROR_MESSAGE();					
					SELECT concat('0|','Ha ocurrido un error al momento de registrar el producto!');
				END CATCH
			          
			END
		
	END
	   
	   
	ELSE IF @nOpcion = 2  -- EDITAR   (U)                                                        
	BEGIN
		BEGIN
			SET @sNombreUsuario		= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @sNombre		= (SELECT valor FROM @tParametro WHERE id = 2);
			SET @sDescripcion	= (SELECT valor FROM @tParametro WHERE id = 3);
			SET @nStock			= cast((SELECT valor FROM @tParametro WHERE id = 4) AS INT);
			SET @nIdProducto		= (SELECT valor FROM @tParametro WHERE id = 5);
		END	


      BEGIN TRAN
				BEGIN TRY
					BEGIN

						SET @nIdUsuario = (SELECT TOP 1 nIdUsuario FROM TBL_LOGIN WHERE sNombreUsuario = @sNombreUsuario)
			
						UPDATE [TBL_PRODUCTO]                           
						SET 
						   sNombre			= @sNombre,                           
						   sDescripcion		= @sDescripcion    
						WHERE 
						   nIdProducto = @nIdProducto      
						
						
						INSERT INTO [TBL_HISTORIAL]
									(nIdUsuario, nIdProducto, sAccion,dFecha)
						VALUES		(@nIdUsuario , @nIdProducto, 'EDITAR', GETDATE())
		 

					SELECT CONCAT('1|','El producto se actualizó con éxito');

					END
					COMMIT TRAN
				END TRY
				BEGIN CATCH
					ROLLBACK TRAN
					PRINT ERROR_MESSAGE();					
					SELECT CONCAT('0|','Ha ocurrido un error al momento de actualizar el producto!');
				END CATCH
										 
                                                       
	END;                            

                                                           
	ELSE IF @nOpcion = 3  -- ACTUALIZAR STOCK                                                      
	BEGIN  
		BEGIN
			SET @sNombreUsuario		= (SELECT valor FROM @tParametro WHERE id = 1);
			SET @nIdProducto = (SELECT valor FROM @tParametro WHERE id = 2);	
			SET @sAccion = (SELECT valor FROM @tParametro WHERE id = 3);	
			SET @nValor = (SELECT valor FROM @tParametro WHERE id = 4);	

		END	

		BEGIN TRANSACTION
			BEGIN TRY
				BEGIN

					SET @nIdUsuario = (SELECT TOP 1 nIdUsuario FROM TBL_LOGIN WHERE sNombreUsuario = @sNombreUsuario)
										
					IF (@sAccion = 'Agregar')
						BEGIN
							UPDATE [TBL_PRODUCTO]
								SET	 nStock = nStock + @nValor
							WHERE 
								nIdProducto = @nIdProducto

							SELECT CONCAT('1|','Se agregó ', @nValor ,' unidades al producto seleccionado');
						END

					ELSE IF (@sAccion = 'Retirar')
						BEGIN
							UPDATE [TBL_PRODUCTO]
								SET	 nStock = nStock - @nValor
							WHERE 
								nIdProducto = @nIdProducto
							SELECT CONCAT('1|','Se retiró ', @nValor ,' unidades al producto seleccionado');
						END

						INSERT INTO [TBL_HISTORIAL]
								(nIdUsuario, nIdProducto, sAccion,dFecha)
						VALUES	(@nIdUsuario , @nIdProducto, CONCAT(@sAccion,' ',@nValor ), GETDATE())

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
