create procedure [dbo].[sp_InsertarRangoFibra]
@IdLargoFibra int output,
@Rango1 float,
@Rango2 float,
@ColorGrade Varchar(5),
@Castigo float,
@IdEstatus int,
@IdUsuarioCreacion int,
@FechaCreacion datetime
as 
begin 
set nocount on
merge [dbo].[LargosDeFibra] as target
using (select @IdLargoFibra,@Rango1,@Rango2,@ColorGrade,@Castigo,@IdEstatus,@IdUsuarioCreacion,@FechaCreacion) AS SOURCE (IdLargoFibra,Rango1,Rango2,ColorGrade,Castigo,IdEstatus,IdUsuarioCreacion,FechaCreacion)
ON (target.IdLargoFibra = SOURCE.IdLargoFibra)
WHEN MATCHED THEN
UPDATE SET Rango1 = Source.Rango1,
		   Rango2 = source.Rango2,
		   ColorGrade = Source.ColorGrade,
		   Castigo = Source.Castigo,
		   IdEstatus = source.IdEstatus,
		   IdUsuarioCreacion = source.IdUsuarioCreacion,
		   FechaCreacion = source.FechaCreacion
WHEN NOT MATCHED THEN
INSERT (Rango1,Rango2,ColorGrade,Castigo,IdEstatus,IdUsuarioCreacion,FechaCreacion)
        VALUES (source.Rango1,source.Rango2,source.ColorGrade,source.Castigo,source.IdEstatus,source.IdUsuarioCreacion,source.FechaCreacion);
		SET @IdLargoFibra = SCOPE_IDENTITY()
		END
RETURN @IdLargoFibra