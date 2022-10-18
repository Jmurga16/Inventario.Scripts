--POBLACION DE DATOS

--TABLA DOCUMENTOS
INSERT INTO TBL_DOCUMENTO(sNombreDoc)
	VALUES('DNI')
INSERT INTO TBL_DOCUMENTO(sNombreDoc)
	VALUES('CARNET EXT.')
GO

--TABLA ROLES
INSERT INTO TBL_ROL(sNombreRol)
	VALUES('Administrador')
INSERT INTO TBL_ROL(sNombreRol)
	VALUES('Supervisor')
INSERT INTO TBL_ROL(sNombreRol)
	VALUES('Asistente')
GO

--TABLA USUARIOS
INSERT INTO TBL_USUARIO
		(sNombres,sApellidos,nTipoDoc,sNumDoc,sSexo,nRol,sDireccion,nTelefono,dFechaNacimiento,bEstado)
VALUES('Administrador',null,1,'80808080','M',1,'Calle Satipo 1', 989898989,'1990-1-1',1)
GO

INSERT INTO TBL_USUARIO
		(sNombres,sApellidos,nTipoDoc,sNumDoc,sSexo,nRol,sDireccion,nTelefono,dFechaNacimiento,bEstado)
VALUES('Jose','Murga',1,'70862638','M',2,'Calle Salaverry 1', 992692389,'1997-2-16',1)
GO

--TABLA LOGIN
INSERT INTO TBL_LOGIN(nIdUsuario,sNombreUsuario,sContrasenia)
	VALUES(1,'admin','123456')
GO
INSERT INTO TBL_LOGIN(nIdUsuario,sNombreUsuario,sContrasenia)
	VALUES(2,'jose.murga','123456')
GO

--TABLA PRODUCTO

INSERT INTO TBL_PRODUCTO(sNombre, sDescripcion, nStock, bEstado)
	VALUES('Café Orgánico AmazonFresh','Café peruano tostado medio fragante', 10, 1)
GO

INSERT INTO TBL_PRODUCTO(sNombre, sDescripcion, nStock, bEstado)
	VALUES('Chips artesanales de kale Luz Vital','Chips de kale', 5, 1)
GO


--HISTORIAL

INSERT INTO TBL_HISTORIAL(nIdUsuario, nIdProducto, sAccion, dFecha)
	VALUES(1, 1 , 'Crear', GETDATE())
GO
INSERT INTO TBL_HISTORIAL(nIdUsuario, nIdProducto, sAccion, dFecha)
	VALUES(1, 1 , 'Agregar 10', GETDATE())
GO

INSERT INTO TBL_HISTORIAL(nIdUsuario, nIdProducto, sAccion, dFecha)
	VALUES(1, 2 , 'Crear', GETDATE())
GO
INSERT INTO TBL_HISTORIAL(nIdUsuario, nIdProducto, sAccion, dFecha)
	VALUES(1, 2 , 'Agregar 5', GETDATE())
GO