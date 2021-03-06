create proc [dbo].[sp_InsertarRendimientos]
@IdRendimiento int output,
@Pluma int,
@Semilla int,
@IdEstatus int,
@IdUsuarioCreacion int,
@FechaCreacion datetime
as
begin
set nocount on
merge [dbo].[Rendimientos] as target
using (select @IdRendimiento,@Pluma,@Semilla,@IdEstatus,@IdUsuarioCreacion,@FechaCreacion) as source (IdRendimiento,Pluma,Semilla,IdEstatus,IdUsuarioCreacion,FechaCreacion)
ON (target.IdRendimiento = source.IdRendimiento)
WHEN MATCHED THEN
UPDATE SET Pluma = source.Pluma,
		   Semilla = source.Semilla,
		   IdEstatus = source.IdEstatus,
		   IdUsuarioCreacion = source.IdUsuarioCreacion,
		   FechaCreacion = source.FechaCreacion
WHEN NOT MATCHED THEN
INSERT (Pluma,Semilla,IdEstatus,IdUsuarioCreacion,FechaCreacion)
VALUES (source.Pluma,source.Semilla, source.IdEstatus,source.IdUsuarioCreacion,source.FechaCreacion);
SET @IdRendimiento = SCOPE_IDENTITY()
END
RETURN @IdRendimiento