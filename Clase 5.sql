#subconsultas
-- valors mayores al promedio
select * from productos_neptuno where preciounidad > (select avg(preciounidad) from productos_neptuno);

-- listado de clientes que hayan realizado por lo menos un pedido
select * from clientes where cod_cliente in (select codigo_cliente from pedidos);

-- listado de productos cuyo pecrio unitario sea mayor al precio mas alto de la tabla productos suspendidos.
select * from productos_neptuno where preciounidad > (select max(preciounidad) from productos_suspendidos);

-- listado de productos de productosnetuno cuyo nombre empiece con la primera letra del empleado id 8
select * from productos_neptuno where left(nombreproducto, 1) = (select left(apellidos, 1) from empleados where IdEmpleado=8);

#CASE
select idcliente, nombrecompania, ciudad, pais,
case
when pais in ('argentina','brasil','venezuela') then 'america del sur'
when pais in ('mexico','usa','canada') then 'america del norte'
else 'europa'
end as CONTINENTE 
from clientes_neptuno;

select idpedido, nombrecompania, fechapedido, cargo,
case
when cargo > 700 then 'excelente'
when cargo > 500 then 'muy bueno'
when cargo > 250 then 'bueno'
when cargo > 50 then 'regular'
else 'malo'
end as evaluacion 
from pedidos_neptuno;

#UNION (Combinación de consultas) Si quiero ver repetidas UNION ALL
select * from productos_neptuno where preciounidad > 80 
union 
select * from productos_suspendidos where PrecioUnidad > 80;

-- en caso de no querer mostrar todos los campo se especifican en ambos
select IdProducto id, NombreProducto nombre, PrecioUnidad precio from productos_neptuno where PrecioUnidad > 80
union 
select IdProducto id, NombreProducto nombre, PrecioUnidad precio from productos_suspendidos where PrecioUnidad > 80
order by nombre;

-- diferenciando la fuente de los datos
select IdProducto id, NombreProducto nombre, PrecioUnidad precio, 'a la venta' as condicion from productos_neptuno where PrecioUnidad > 80
union 
select IdProducto id, NombreProducto nombre, PrecioUnidad precio, 'discontinuado' as condicion from productos_suspendidos where PrecioUnidad > 80
order by nombre;

-- se buscan todos los bebes nacidos de madres casadas menores de edad
select * from sexo_masculino where ESTADO_CIVIL_MADRE = 'casada' and EDAD_MADRE < 18
union
select * from sexo_femenino where ESTADO_CIVIL_MADRE = 'casada' and EDAD_MADRE < 18;

-- Se buscan diferentes cosas en dos tablas diferentes
select * from productos_neptuno where NombreCategoria = 'carnes'
union
select * from productos_suspendidos where PrecioUnidad > 80;

-- con order by
select * from productos_neptuno where NombreCategoria = 'reposteria' 
union
select * from productos_suspendidos where NombreCategoria = 'reposteria'
order by NombreProducto;

-- consulta de datos anexados
insert into productos_suspendidos (IdProducto, NombreProducto, NombreContacto, NombreCategoria, PrecioUnidad, suspendido, IdProveedor)
select IdProducto, NombreProducto, NombreContacto, NombreCategoria, PrecioUnidad, Suspendido, IdProveedor
from productos_neptuno where IdProducto = '68';

-- mostrando registros duplicados
select * from productos_neptuno where NombreCategoria = 'reposteria' 
union all
select * from productos_suspendidos where NombreCategoria = 'reposteria'
order by NombreProducto;

-- eliminado el producto dulicado
set sql_safe_updates = 0;
delete from productos_suspendidos where IdProducto = '68';

#CROOS JOIN (Muestra todas las posibles combinaciones entre las filas de las tablas involucradas - producto cartesiano)
create table selecciones (equipo varchar(15) primary key);
insert into selecciones values ('argetina'),('brasil'),('colombia'),('peru'),('venezuela');
select * from selecciones;
-- posibles combinaciones
select * from selecciones l cross join selecciones v where l.equipo <> v.equipo order by l.equipo;

#INNER JOIN (consultas de union interna)
-- clientes que ha hecho almenos un pedido
select cod_cliente, empresa, numero_pedido, fecha_pedido, forma_pago from clientes inner join pedidos on clientes.cod_cliente = pedidos.codigo_cliente order by cod_cliente; 

# LEFT JOIN
select cod_cliente, empresa, numero_pedido, fecha_pedido, forma_pago from clientes left join pedidos on clientes.cod_cliente = pedidos.codigo_cliente order by cod_cliente; 
-- cliente que no efectúo ninguna compra
select cod_cliente, empresa, numero_pedido, fecha_pedido, forma_pago from clientes left join pedidos on clientes.cod_cliente = pedidos.codigo_cliente where numero_pedido is null order by cod_cliente; 
-- empleado que no hayan hecho ninguna venta
select * from empleados left join pedidos_neptuno on empleados.Apellidos = pedidos_neptuno.Apellidos where IdPedido is null;
-- listado de proveddores que no esten vendieno productos a nuestra empresa
select * from proveedores p left join productos_neptuno pn on p.IdProveedor = pn.IdProveedor where IdProducto is null;

# RIGHT JOIN
-- pedidos que no tengan cliente asociado
select cod_cliente, empresa, numero_pedido, fecha_pedido, forma_pago from clientes right join pedidos on clientes.cod_cliente = pedidos.codigo_cliente where cod_cliente is null order by cod_cliente;
-- listados productos comercializados de los cuales no se sepan quién es le proveedor 
select * from proveedores p right join productos_neptuno pn on p.IdProveedor = pn.IdProveedor where p.IdProveedor is null;












