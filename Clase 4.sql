#consultas de accion: creacion, actualización, eliminación y datos anexados.

#CREATE
create table sexo_masculino select * from nacimientos where sexo = 'MASCULINO';
create table sexo_femenino select * from nacimientos where sexo = 'FEMENINO';
create table sexo_indeterminado select * from nacimientos where sexo = 'INDETERMINADO';
drop table nacimientos;

#UPDATE
set sql_safe_updates = 0;
update clientes_neptuno set pais = 'UK' where pais = 'REINO UNIDO';
update productos_neptuno set preciounidad = round(preciounidad*1.1,2);
-- modifico el tipo de dato luego incorporo información nueva--
alter table clientes modify telefono varchar(20);
update clientes set telefono = concat('+34-',telefono);
select * from clientes;

-- creo una columna nueva e incorporo información nueva--
select * from productos;
alter table productos add fecha date;
update productos set fecha = concat(ano,'-',mes,'-',dia);
-- elimino las columnas, ano, mes, dia.
alter table productos drop dia, drop mes, drop ano;

-- actualizar dos valores con un solo update--
select * from productos_neptuno;
alter table productos_neptuno modify suspendido varchar(20);
update productos_neptuno set suspendido = if(suspendido = '0', 'NO', 'SI');

-- crear tabla a partir de otra actualizada -- 
create table productos_suspendidos select * from productos_neptuno where Suspendido = 'SI';

-- actualizar un campo en base a otro campo --
update productos_neptuno set suspendido = 'SI' where idproveedor = 1;

#INSERT
insert into productos_suspendidos (IdProducto, NombreProducto, NombreContacto, NombreCategoria, PrecioUnidad, suspendido, IdProveedor)
select (IdProducto, NombreProducto, NombreContacto, NombreCategoria, PrecioUnidad, suspendido, IdProveedor) from productos_neptuno
where suspendido = 'SI';

#DELETE elimina registro exceptop autoincrement
delete from productos_neptuno where suspendido = 'SI';

#TRUNCATE: Elimina todos los registro incluyendo AUTOINCREMENT. No acepta where. 
truncate productos_neptuno;















