
--TABLA Menu
CREATE TABLE Menu(
    IdMenu INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
    Name VARCHAR(20),
	Route VARCHAR(MAX),
	Icon VARCHAR(MAX),
	IdParent INT,
	Level INT,
	Status BIT NOT NULL DEFAULT 1
)
GO

INSERT INTO Menu(Name,Route,Icon,IdParent,Level, Status)
	VALUES('Usuarios', 'users/list', 'groups', 0, 1, 1)

INSERT INTO Menu(Name,Route,Icon,IdParent,Level, Status)
	VALUES('Inventario', 'inventory/list', 'inventory_2', 0, 1, 1)

	
