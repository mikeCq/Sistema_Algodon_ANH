alter procedure sp_RepClientes
@IdAsociacion int 
as
IF @IdAsociacion <>  0
BEGIN
select a.IdCliente as ID,
       a.Nombre as Cliente,
	   b.Descripcion as Asociacion,
	   c.Descripcion as TipoPersona
from [dbo].[Clientes] a,
     [dbo].[Asociaciones] b,
	 [dbo].[TipoPersona] c
where b.IdAsociacion = @IdAsociacion
and   a.IdCuentaDe = b.IdAsociacion
and   a.IdTipoPersona = c.IdTipoPersona
and   a.IdEstatus = 1
END
ELSE
BEGIN
select a.IdCliente as ID,
       a.Nombre as Cliente,
	   b.Descripcion as Asociacion,
	   c.Descripcion as TipoPersona
from [dbo].[Clientes] a,
     [dbo].[Asociaciones] b,
	 [dbo].[TipoPersona] c
where a.IdEstatus = 1
and   a.IdCuentaDe = b.IdAsociacion
and   a.IdTipoPersona = c.IdTipoPersona
END    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       