ALTER procedure [dbo].[sp_InsertarClasificacionPacas]
@IdCalculoClasificacion int,
@IdPaqueteEncabezado int,
@IdHviDetalle int,
@BaleId int,
@Mic float,
@ColorGrade varchar(4),
@TrashId int,
@Clase varchar(4),
@UHML float,
@Strength float,
@SCI int
as 
begin 
set nocount on
merge [dbo].[CalculoClasificacion] as target
using (select @IdCalculoClasificacion,@IdPaqueteEncabezado,@IdHviDetalle,@BaleId,@Mic,@ColorGrade,@TrashId,@Clase,@UHML,@Strength,@SCI) AS SOURCE (IdCalculoClasificacion,IdPaqueteEncabezado,IdHviDetalle,BaleId,Mic,ColorGrade,TrashId,Clase,UHML,Strength,SCI)
ON (target.BaleId = SOURCE.BaleId)
WHEN MATCHED THEN
UPDATE SET Mic = Source.Mic,
		   ColorGrade = source.ColorGrade,
		   clase = source.clase,
		   TrashId = source.TrashId,
		   UHML = source.UHML,
		   Strength = source.Strength
WHEN NOT MATCHED THEN
INSERT (IdPaqueteEncabezado,IdHviDetalle,BaleId,Mic,ColorGrade,TrashId,Clase,UHML,Strength,SCI)
        VALUES (source.IdPaqueteEncabezado,source.IdHviDetalle,source.BaleId,source.Mic,source.ColorGrade,source.TrashId,source.Clase,source.UHML,source.Strength,source.SCI);		
END