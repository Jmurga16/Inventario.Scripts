
CREATE PROCEDURE [dbo].[USP_MNT_Menu]          
            
	@nOpcion INT
                                                                                   
AS     

BEGIN

	BEGIN
		
		DECLARE @nIdPersona     INT;

	END

		
	IF @nOpcion = 1   --CONSULTAR MENU
	BEGIN	                                                                                                                                                     
			SELECT 
				IdMenu,
				Name,
				Route,
				Icon,
				IdParent,
				Level,
				Status
			FROM [Menu] 
			ORDER BY Level ASC, Name ASC
				                                                                 
	END;          
			

END
