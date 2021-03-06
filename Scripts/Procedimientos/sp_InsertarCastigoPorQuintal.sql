create proc [dbo].[sp_InsertarCastigoPorQuintal]
@IdMicro int output,
@Rango1 decimal(6,2),
@Rango2 decimal(6,2),
@Castigo decimal(6,2),
@IdEstatus int,
@IdUsuarioCreacion int,
@FechaCreacion datetime
as
begin
set nocount on
merge [dbo].[Micros] as target
using (select @IdMicro,@Rango1,@Rango2,@Castigo,@IdEstatus,@IdUsuarioCreacion,@FechaCreacion) as source (IdMicro,Rango1,Rango2,Castigo,IdEstatus,IdUsuarioCreacion,FechaCreacion)
ON (target.IdMicro = source.IdMicro)
WHEN MATCHED THEN
UPDATE SET Rango1 = source.Rango1,
		   Rango2 = source.Rango2,
		   Castigo = source.Castigo,
		   IdEstatus = source.IdEstatus,
		   IdUsuarioCreacion = source.IdUsuarioCreacion,
		   FechaCreacion = source.FechaCreacion
WHEN NOT MATCHED THEN
INSERT (Rango1,Rango2,Castigo,IdEstatus,IdUsuarioCreacion,FechaCreacion)
VALUES (source.Rango1,source.Rango2,source.Castigo,source.IdEstatus,source.IdUsuarioCreacion,source.FechaCreacion);
SET @IdMicro = SCOPE_IDENTITY()
END
RETURN @IdMicro