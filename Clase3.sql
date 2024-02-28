SELECT * FROM CLIENTES;
SELECT COD_CLIENTE, EMPRESA, CONCAT(DIRECCION,'-',CIUDAD) UBICACION FROM CLIENTES;
SELECT COD_CLIENTE, EMPRESA, CONCAT_WS('/',DIRECCION,CIUDAD) UBICACION FROM CLIENTES;

SELECT * FROM clientes_neptuno;
SELECT IDCLIENTE, UPPER(NOMBRECOMPANIA) EMPRESA, TELEFONO FROM CLIENTES_NEPTUNO;
SELECT LOWER(IDCLIENTE) AS 'CODIGO CLIENTE', NOMBRECOMPANIA, TELEFONO FROM CLIENTES_NEPTUNO;

#PRIMEROS CARACTERES DE UNA CADENA
SELECT *, LEFT(APELLIDOS,1) INCIAL FROM EMPLEADOS;
#PRIMERA INICIAL DEL NOMBRE Y PRIMERA INCIAL DEL APELLIDO. LUEGO SE CONCATENA.
SELECT *, CONCAT(LEFT(NOMBRE,1), LEFT(APELLIDOS,1)) INCIALES FROM EMPLEADOS;

#ULTIMOS CARACTERES DE UNA CADENA
SELECT *, UPPER(CONCAT(LEFT(CARGO,1), RIGHT(CARGO,1))) CODIGO FROM EMPLEADOS;

#SUBSTRING
SELECT SEXO, FECHA, TIPO_PARTO, SEMANAS FROM NACIMIENTOS WHERE SUBSTRING(FECHA,4,2) = '10';

#LOCATE DEVUELTE LA PRIMERA POSICION DONDE APARECE EL CARACTER
SELECT IDEMPLEADO, APELLIDOS, NOMBRE, CARGO, LOCATE('VENTAS',CARGO) UBICACION FROM EMPLEADOS;

#REPLACE BUSCA Y REMPLAZA
SELECT IDEMPLEADO, APELLIDOS, NOMBRE, REPLACE(CARGO,'REPRESENTANTE DE VENTAS','VENDEDOR') PUESTO FROM EMPLEADOS;

#year
select * from pedidos_neptuno where year(fechapedido) = 1998; 

# month
select * from pedidos_neptuno where month(fechapedido) = 2 and year(fechapedido) = 1997; 

#day
select * from pedidos_neptuno where day(fechapedido) = 1 and month(fechapedido) = 4; 

#curdate
select curdate() 'dia actual';

#dayDiff (dias entre dos fechas)
select *, datediff(curdate(),fechapedido) as 'dias transcurridos' from pedidos_neptuno; 

#timeTipeDiff (Cantidad de meses o años entre dos fechas)
select*, timestampdiff(month,fechapedido,curdate()) meses from pedidos_neptuno;
select*, timestampdiff(year,fechapedido,curdate()) años from pedidos_neptuno;
select*, datediff(curdate(),fechapedido) dias, timestampdiff(month,fechapedido,curdate()) meses, timestampdiff(year,fechapedido,curdate()) años from pedidos_neptuno;

#dayname
select idpedido, nombrecompania, fechapedido, dayname(fechapedido) dia from pedidos_neptuno;

#dayofweek
select idpedido, nombrecompania, fechapedido, dayname(fechapedido) dia, dayofweek(fechapedido) 'dia semana' from pedidos_neptuno;

#day of year
select idpedido, nombrecompania, fechapedido, dayname(fechapedido) dia, dayofweek(fechapedido) 'dia semana', dayofyear(fechapedido) 'dia del año' from pedidos_neptuno;

#month day 
select idpedido, nombrecompania cliente, fechapedido as 'fecha pedido', monthname(fechapedido) 'mes pedido' from pedidos_neptuno;

#adddate
select *, adddate(fechapedido, interval 30 day) 'primer vencimiento' from pedidos_neptuno;
select *, adddate(fechapedido, interval 30 day) 'primer vencimiento', adddate(fechapedido, interval 2 month) 'segundo vencimiento' from pedidos_neptuno;
select *, adddate(fechapedido, interval 30 day) 'primer vencimiento', adddate(fechapedido, interval 2 month) 'segundo vencimiento', adddate(fechapedido, interval 1 year) 'ultimo vencimiento' from pedidos_neptuno;

#round
select idproducto, nombreproducto, preciounidad, round(preciounidad*0.21, 2) IVA, round(preciounidad*1.21, 2) 'PRECIO FINAL' from productos_neptuno;

#mod
select idproducto, nombreproducto, preciounidad, round(mod(preciounidad, 2),2) 'RESTO' from productos_neptuno;

#pow
select idproducto, nombreproducto, preciounidad, round(pow(preciounidad,2),2) 'AL CUADRADO', round(pow(preciounidad,3),2) 'AL CUBO' from productos_neptuno;

#ceil
select idproducto, nombreproducto, preciounidad, ceil(preciounidad) 'A FAVOR EMPRESA' from productos_neptuno;

#floor
select idproducto, nombreproducto, preciounidad, floor(preciounidad) 'A FAVOR EMPRESA' from productos_neptuno;

#count
select count(*) from clientes_neptuno;
select count(*) from productos_neptuno where NombreCategoria = 'BEBIDAS';
select count(*) from productos_neptuno where NombreProducto like 'C%';
select count(*) from productos_neptuno where left(NombreProducto,1) = 'M';

#sum
select round(sum(cargo),2) as facturacion from pedidos_neptuno;

#max
select max(cargo) as 'mejor venta' from pedidos_neptuno;
select max(preciounidad) from productos_neptuno;

#min
select min(cargo) from pedidos_neptuno;
select min(preciounidad) from productos_neptuno;

#avg
select round(avg(cargo),2) as promedio from pedidos_neptuno;
select round(avg(preciounidad),2) as 'precio promedio' from productos_neptuno where nombrecategoria = 'BEBIDAS';

#group by
select apellidos as empleado, round(sum(cargo),2) as facturacion from pedidos_neptuno group by empleado order by facturacion desc;
select nombrecategoria as categoria, count(*) cantidad from productos_neptuno group by categoria order by cantidad;
select apellidos as empleados, 
round(sum(cargo),2) as facturacion, 
count(*) as ventas, 
round(avg(cargo),2) as promedio, 
max(cargo) as 'mejor venta',
min(cargo) as 'peor venta'
from pedidos_neptuno
group by empleados;

#having
select apellidos as empleados, 
round(sum(cargo),2) as facturacion, 
count(*) as ventas, 
round(avg(cargo),2) as promedio, 
max(cargo) as 'mejor venta',
min(cargo) as 'peor venta'
from pedidos_neptuno
group by empleados
having facturacion > 9000;
























