-- Consultas sobre una tabla
	-- Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
    select o.codigo_oficina 'Codigo de Oficiona' , o.ciudad 'Ciudad'
    from oficina o;
    
    -- Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
    select o.ciudad 'Ciudad' , o.telefono 'Telefono'
    from oficina o
    where o.pais = "España";
    
    -- Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
    select e.nombre 'Nombre' , concat(e.apellido1, " " ,  e.apellido2) 'Apellidos' , e.email 'Correo Electronico'
    from empleado e
    where e.codigo_jefe = 7;
    
    -- Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
    select e.nombre 'Nombre' , concat(e.apellido1, " " ,  e.apellido2) 'Apellidos' , e.email 'Correo Electronico' , e.puesto 'Puesto'
    from empleado e
    where e.codigo_empleado = (
		select m.codigo_empleado
        from empleado m
        where m.codigo_jefe is null
	);
    
    -- Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
    select e.nombre 'Nombre' , concat(e.apellido1, " " ,  e.apellido2) 'Apellidos' , e.email 'Correo Electronico' , e.puesto 'Puesto'
    from empleado e
    where e.puesto != "Representante ventas";
    
    -- Devuelve un listado con el nombre de los todos los clientes españoles.
    select c.nombre_cliente 'Clientes'
    from cliente c
    where c.pais = "spain";
    
    -- Devuelve un listado con los distintos estados por los que puede pasar un pedido.
    select p.estado 'Estados del pedido' 
    from pedido p
    group by p.estado;
    
    -- Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
    -- Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
		-- Utilizando la función YEAR de MySQL.
        select p.codigo_cliente 'Codigo del Cliente'
        from pago p
        where year(p.fecha_pago) = 2008
        group by p.codigo_cliente;
        
        -- Utilizando la función DATE_FORMAT de MySQL.
        select p.codigo_cliente 'Codigo del Cliente'
        from pago p
        where date_format(p.fecha_pago, '%Y') = 2008
        group by p.codigo_cliente;
        
        -- Sin utilizar ninguna de las funciones anteriores.
        select p.codigo_cliente 'Codigo del Cliente'
        from pago p
        where p.fecha_pago like '2008%'
        group by p.codigo_cliente;
        
	-- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han 
    -- sido entregados a tiempo.
    select p.codigo_pedido 'Codigo del pedido' , p.codigo_cliente 'Codigo del cliente' , p.fecha_esperada 'Fecha esperada' , p.fecha_entrega 'Fecha entrega'
    from pedido p
    where p.fecha_esperada < p.fecha_entrega or p.fecha_entrega is null and p.estado = 'En%';
    
    -- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos
    -- cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
		-- Utilizando la función ADDDATE de MySQL.
        select p.codigo_pedido 'Codigo del pedido' , p.codigo_cliente 'Codigo del cliente' , p.fecha_esperada 'Fecha esperada' , p.fecha_entrega 'Fecha entrega'
		from pedido p
        where p.fecha_entrega <= adddate(p.fecha_esperada, -2);
        
        -- Utilizando la función DATEDIFF de MySQL.
        select p.codigo_pedido 'Codigo del pedido' , p.codigo_cliente 'Codigo del cliente' , p.fecha_esperada 'Fecha esperada' , p.fecha_entrega 'Fecha entrega'
		from pedido p
        WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
        
	-- Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
    select * 
    from pedido p
    where p.estado = "rechazado" and year(p.fecha_pedido) = 2009;
    
    -- Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
    select *
    from pedido p
    where month(p.fecha_entrega) = 1 and p.estado = "Entregado";
    
    -- Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
    select *
    from pago p
    where year(p.fecha_pago) = 2008 and p.forma_pago = "Paypal"
    order by p.fecha_pago asc;
    
    -- Devuelve un listado con todas las formas de pago que aparecen en la tabla pago.
    -- Tenga en cuenta que no deben aparecer formas de pago repetidas.
    select p.forma_pago 'Formas de Pago'
    from pago p
    group by p.forma_pago;
    
    -- Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock.
    -- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
    select *
    from producto p
    where p.gama = "Ornamentales" and p.cantidad_en_stock > 100
    order by p.precio_venta desc;
    
    -- Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
    select *
    from cliente c
    where c.ciudad = "madrid" and c.codigo_empleado_rep_ventas in (11, 30);
    
-- Consultas multitabla (Composición interna)
	-- Las consultas se deben resolver con INNER JOIN.
		-- Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
        select c.nombre_cliente 'Nombre del Cliente', concat(e.nombre, ' ' , e.apellido1 ,  ' ' , e.apellido2) 'Representante de Ventas'
        from cliente c
        inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado;
        
        -- Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
        select c.nombre_cliente 'Nombre del Cliente', concat(e.nombre, ' ' , e.apellido1 ,  ' ' , e.apellido2) 'Representante de Ventas'
        from cliente c
        inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
        inner join pago p on c.codigo_cliente = p.codigo_cliente;
        
        -- Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
        select c.nombre_cliente 'Nombre del Cliente', concat(e.nombre, ' ' , e.apellido1 ,  ' ' , e.apellido2) 'Representante de Ventas'
        from cliente c
        inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
        left join pago p on c.codigo_cliente = p.codigo_cliente
        where p.codigo_cliente is null;
        
        -- Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina 
        -- a la que pertenece el representante.
        select distinct c.codigo_cliente, c.nombre_cliente 'Nombre del Cliente', concat(e.nombre, ' ' , e.apellido1 ,  ' ' , e.apellido2) 'Representante', o.ciudad 'Ciudad'
        from cliente c
        inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
        inner join oficina o on e.codigo_oficina = o.codigo_oficina
        inner join pago p on c.codigo_cliente = p.codigo_cliente;
        
        
        -- Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad
        -- de la oficina a la que pertenece el representante.
        select distinct c.codigo_cliente, c.nombre_cliente 'Nombre del Cliente', concat(e.nombre, ' ' , e.apellido1 ,  ' ' , e.apellido2) 'Representante', o.ciudad 'Ciudad'
        from cliente c
        inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
        inner join oficina o on e.codigo_oficina = o.codigo_oficina
        left join pago p on c.codigo_cliente = p.codigo_cliente
        where p.codigo_cliente is null;
        
        -- Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
        select distinct c.codigo_cliente 'Codigo cliente', c.nombre_cliente 'Cliente', e.nombre 'Representante', o.codigo_oficina 'Oficina'
        from cliente c
        inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
        inner join oficina o on o.codigo_oficina = e.codigo_oficina
        where c.ciudad = 'fuenlabrada';
        
        -- Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
        select distinct c.nombre_cliente 'Cliente', e.nombre 'Representante en Ventas', o.ciudad 'Ciudad de Ubicacion de Oficina'
        from cliente c
        inner join empleado e on e.codigo_empleado = c.codigo_empleado_rep_ventas
        inner join oficina o on o.codigo_oficina = e.codigo_oficina;
        
        -- Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
        select e.nombre 'Empleado', jf.nombre 'Jefe'
        from empleado e
        inner join empleado jf on jf.codigo_empleado = e.codigo_jefe;
        
        -- Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
        select distinct c.nombre_cliente 'Clientes que no se les ha entregado a tiempo el pedido'
        from cliente c
        inner join pedido p on p.codigo_cliente = c.codigo_cliente
        where p.fecha_esperada < p.fecha_entrega or p.fecha_entrega is null and p.estado = 'En%';
        
        -- Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
        select distinct c.nombre_cliente 'Cliente', pr.gama 'Gama de producto'
        from cliente c
        inner join pedido p on p.codigo_cliente = c.codigo_cliente
        inner join detalle_pedido dp on dp.codigo_pedido =p.codigo_pedido
        inner join producto pr on pr.codigo_producto = dp.codigo_producto;
        
-- Consultas multitabla (Composición externa)
	-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
		-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
        select distinct c.codigo_cliente 'Codigo Ciente', c.nombre_cliente 'Cliente que no han realizado pagos'
        from cliente c
        left join pago p on p.codigo_cliente = c.codigo_cliente
        where p.codigo_cliente is null;
        
        -- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
        select distinct c.nombre_cliente 'Clientes que no realizaron pedidos'
        from cliente c
        left join pedido p on p.codigo_cliente = c.codigo_cliente
        where p.codigo_cliente is null;
        
        -- Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
        select distinct c.codigo_cliente 'Codigo cliente', c.nombre_cliente 'Cliente' -- ,  p.codigo_cliente 'Pedido', pe.codigo_cliente 'Pedido'
        from cliente c
        left join pago p on p.codigo_cliente = c.codigo_cliente
        left join pedido pe on pe.codigo_cliente = c.codigo_cliente
        where p.codigo_cliente is null and pe.codigo_cliente is null;
        
        -- Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
        select concat(e.nombre, ' ' , e.apellido1 ,  ' ' , e.apellido2) 'Empleado'
        from empleado e
        left join oficina o on o.codigo_oficina = e.codigo_oficina
        where o.codigo_oficina is null;
        
        -- Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
        select distinct concat(e.nombre, ' ' , e.apellido1 ,  ' ' , e.apellido2) 'Empleados que no tienen un cliente asociado'
        from empleado e
        left join cliente c on c.codigo_empleado_rep_ventas = e.codigo_empleado
        where c.codigo_cliente is null;
        
        -- Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
        select distinct e.nombre 'Empleados' -- , o.codigo_oficina 'Oficina', c.codigo_cliente 'Cliente' 
        from empleado e
        left join oficina o on o.codigo_oficina = e.codigo_oficina
        left join cliente c on c.codigo_empleado_rep_ventas = e.codigo_empleado
        where o.codigo_oficina is null and c.codigo_cliente is null;
        
        -- Devuelve un listado de los productos que nunca han aparecido en un pedido.
        select distinct p.nombre 'Productos que no aparecen en pedidos' -- , p.codigo_producto 'Codigo producto', pe.codigo_pedido 'Pedido'
        from producto p
        left join detalle_pedido dp on dp.codigo_producto = p.codigo_producto
        left join pedido pe on pe.codigo_pedido = dp.codigo_pedido
        where pe.codigo_pedido is null;
        
        -- Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas
        -- de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
        select distinct o.codigo_oficina 'Oficina', o.ciudad 'Ciudad', o.pais 'Pais'
			/* , e.nombre 'Empleado', e.puesto 'Puesto del empleado', c.nombre_cliente 'Cliente'
			, dp.codigo_pedido 'Pedido', dp.codigo_producto 'Producto', pr.gama 'Gama'*/
        from oficina o
        left join empleado e on e.codigo_oficina = o.codigo_oficina
        left join cliente c on c.codigo_empleado_rep_ventas = e.codigo_empleado
        left join pedido p on p.codigo_cliente = c.codigo_cliente
        left join detalle_pedido dp on dp.codigo_pedido = p.codigo_pedido
        left join producto pr on pr.codigo_producto = dp.codigo_producto 
        where pr.gama not like 'Fruta%';
        
        -- Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.
        select distinct c.codigo_cliente 'Codigo del Cliente', c.nombre_cliente 'Cliente', p.codigo_pedido 'Pedido', pa.id_transaccion 'Pago'
        from cliente c
        right join pedido p on p.codigo_cliente = c.codigo_cliente
        left join pago pa on pa.codigo_cliente = c.codigo_cliente
        where pa.id_transaccion is null;
        
        -- Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
        select distinct e.nombre 'Empleado', c.codigo_cliente 'Codigo cliente', e.codigo_jefe 'Codigo de jefe', jf.nombre 'Jefe'
        from empleado e
        left join cliente c on c.codigo_empleado_rep_ventas = e.codigo_empleado
        inner join empleado jf on jf.codigo_empleado = e.codigo_jefe
        where c.codigo_cliente is null;
        
-- Consultas resumen
	-- ¿Cuántos empleados hay en la compañía?
    select count(*) 'Cantidad de empleados' from empleado;
    
    -- ¿Cuántos clientes tiene cada país?
    select c.pais 'Pais', count(*) 'Cantidad de clientes' 
    from cliente c 
    group by c.pais;
    
    -- ¿Cuál fue el pago medio en 2009?
    select round(avg(p.total),2) 'Pago medio'
    from pago p
    where Year(p.fecha_pago) = 2009;
    
    -- ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
    select p.estado 'Estado', count(*)
    from pedido p
    group by p.estado;
    
    -- Calcula el precio de venta del producto más caro y más barato en una misma consulta.
    select max(p.precio_venta) 'Precio Venta Maximo', min(p.precio_venta) 'Precio Venta Minimo'
		, (max(p.precio_venta) + min(p.precio_venta)) 'Total'
    from producto p;
    
    -- Calcula el número de clientes que tiene la empresa.
    select count(*) 'Clientes totales'
    from cliente;
    
    -- ¿Cuántos clientes tiene la ciudad de Madrid?
    select c.ciudad, count(*) 'Total clientes'
    from cliente c
    where c.ciudad like 'Madrid'
    group by c.ciudad;
    
    -- ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
    select count(*) 'Cantidad de clientes de ciudades que empiezan por M'
    from cliente c
    where c.ciudad like 'M%';
    
    -- Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
    select e.nombre 'Empleados RV', count(c.codigo_empleado_rep_ventas) 'Cantidad de Clientes'
    from empleado e
    join cliente c on c.codigo_empleado_rep_ventas = e.codigo_empleado
    group by  e.nombre, c.codigo_empleado_rep_ventas, e.codigo_empleado;
    
    -- Calcula el número de clientes que no tiene asignado representante de ventas.
    select count(c.nombre_cliente) 'Cantidad de clientes sin representante de ventas'
    from cliente c
    left join empleado e on e.codigo_empleado = c.codigo_empleado_rep_ventas
    where c.codigo_empleado_rep_ventas is null
    group by c.codigo_empleado_rep_ventas;
    
    -- Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
    -- El listado deberá mostrar el nombre y los apellidos de cada cliente.
    select c.codigo_cliente, c.nombre_cliente 'Cliente', min(p.fecha_pago) 'Primer pago', max(p.fecha_pago) 'Ultimo pago'
	from cliente c
	right join pago p on c.codigo_cliente = p.codigo_cliente
	group by c.codigo_cliente;
    
    -- Calcula el número de productos diferentes que hay en cada uno de los pedidos.
    select dp.codigo_pedido 'Numero de Pedido', count(dp.codigo_producto) 'Cantidad de productos diferentes'
    from detalle_pedido dp
    group by dp.codigo_pedido;
    
    -- Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
    select dp.codigo_pedido 'Numero de Pedido', sum(dp.cantidad) 'Cantidad de productos'
    from detalle_pedido dp
    group by dp.codigo_pedido;
    
    -- Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno.
    -- El listado deberá estar ordenado por el número total de unidades vendidas.
    select dp.codigo_producto 'Codigo del Producto', sum(dp.cantidad) as Total
    from detalle_pedido dp
    group by dp.codigo_producto
    order by Total desc
    limit 20;
    
    -- La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado.
    -- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido.
    -- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
    select sum(d.cantidad * d.precio_unidad) 'Base Imponible', 
       (sum(d.cantidad * d.precio_unidad) * 0.21) 'IVA', 
       (sum(d.cantidad * d.precio_unidad) + (sum(d.cantidad * d.precio_unidad) * 0.21)) 'Total'
	from detalle_pedido d;
    
    -- La misma información que en la pregunta anterior, pero agrupada por código de producto.
    select d.codigo_producto 'Codigo producto', sum(d.cantidad * d.precio_unidad) 'Base Imponible', 
       (sum(d.cantidad * d.precio_unidad) * 0.21) 'IVA', 
       (sum(d.cantidad * d.precio_unidad) + (sum(d.cantidad * d.precio_unidad) * 0.21)) 'Total'
	from detalle_pedido d
    group by d.codigo_producto;
    
    -- La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
    select d.codigo_producto 'Codigo producto', sum(d.cantidad * d.precio_unidad) 'Base Imponible', 
       (sum(d.cantidad * d.precio_unidad) * 0.21) 'IVA', 
       (sum(d.cantidad * d.precio_unidad) + (sum(d.cantidad * d.precio_unidad) * 0.21)) 'Total'
	from detalle_pedido d
    where d.codigo_producto like 'or%'
    group by d.codigo_producto;
    
    -- Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre,
    -- unidades vendidas, total facturado y total facturado con impuestos (21% IVA)
    select d.codigo_producto 'Codigo producto', p.nombre 'Nombre del Producto',
		sum(d.cantidad) 'Unidades Vendidas',
		sum(d.cantidad * d.precio_unidad) 'Base Imponible', 
       (sum(d.cantidad * d.precio_unidad) * 0.21) 'IVA', 
       (sum(d.cantidad * d.precio_unidad) + (sum(d.cantidad * d.precio_unidad) * 0.21)) as Total
	from detalle_pedido d
	join producto p on p.codigo_producto = d.codigo_producto
    group by d.codigo_producto, p.codigo_producto
    having Total > 3000;
    
-- Subconsultas con operadores básicos de comparación
	-- Devuelve el nombre del cliente con mayor límite de crédito.
    select c.nombre_cliente 'Cliente'
    from cliente c
    where c.limite_credito = (
		select max(l.limite_credito)
		from cliente l
    );
    
    -- Devuelve el nombre del producto que tenga el precio de venta más caro.
    select p.nombre 'Producto mas caro'
    from producto p
    where p.precio_venta = (
		select max(r.precio_venta)
        from producto r
    );
    
    -- Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de
    -- unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código
	-- del producto, puede obtener su nombre fácilmente.)
    select * 
    from producto p
    where p.codigo_producto = (
		select dp.codigo_producto
        from detalle_pedido dp
        group by dp.codigo_producto
        order by count(*) desc
        limit 1
    );
    
    -- Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
    select *
    from cliente c
    where c.limite_credito > (
		select sum(p.total)
        from pago p
        where p.codigo_cliente = c.codigo_cliente
    );
    
    -- Devuelve el producto que más unidades tiene en stock.
	select *
    from producto p
    where p.cantidad_en_stock = (
		select max(r.cantidad_en_stock)
        from producto r
    );
    
    -- Devuelve el producto que menos unidades tiene en stock.
    select *
    from producto p
    where p.cantidad_en_stock = (
		select min(r.cantidad_en_stock)
        from producto r
    );
    
    -- Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
    select *
    from empleado e
    where e.codigo_jefe = (
		select jf.codigo_empleado
        from empleado jf
        where jf.nombre like 'Alberto' and jf.apellido1 like 'Soria'
    );
    
-- Subconsultas con ALL y ANY
	-- Devuelve el nombre del cliente con mayor límite de crédito.
    select c.nombre_cliente
	from cliente c
	where c.limite_credito >= all (
		select limite_credito
		from cliente
		where limite_credito is not null
	);
    
    -- Devuelve el nombre del producto que tenga el precio de venta más caro.
    select *
    from producto p
    where p.precio_venta >= all (
		select r.precio_venta
        from producto r 
    );
    
    -- Devuelve el producto que menos unidades tiene en stock.
    select *
    from producto p
    where p.cantidad_en_stock <= all (
		select r.cantidad_en_stock
        from producto r
    );
    
-- Subconsultas con IN y NOT IN
	-- Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
    select e.nombre 'Nombre', e.apellido1 'Apellido', e.puesto 'Cargo', c.codigo_empleado_rep_ventas
    from empleado e
    where e.codigo_empleado not in (
		select c.codigo_empleado_rep_ventas
        from cliente c
    );
    
    -- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
    select *
    from cliente c
    where c.codigo_cliente not in (
		select p.codigo_cliente
        from pago p
    );
    
    -- Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
    select *
    from cliente c
    where c.codigo_cliente in (
		select p.codigo_cliente
        from pago p
    );
    
    -- Devuelve un listado de los productos que nunca han aparecido en un pedido.
    select *
    from producto p
    where p.codigo_producto not in (
		select de.codigo_producto
        from detalle_pedido de
    );
    
    -- Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
    select e.nombre 'Nombre Empleado', concat(e.apellido1 , ' ' ,e.apellido2) 'Apellidos Empleado', e.puesto 'Cargo', e.codigo_oficina 'Oficina'
    from empleado e
    where e.codigo_empleado not in (
		select c.codigo_empleado_rep_ventas
        from cliente c
    );
    
-- Subconsultas con EXISTS y NOT EXISTS
	-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
    select *
	from cliente c
	where not exists (
		select p.codigo_cliente
		from pago p
		where p.codigo_cliente = c.codigo_cliente
	);
    
    -- Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
    select *
	from cliente c
	where exists (
		select p.codigo_cliente
		from pago p
		where p.codigo_cliente = c.codigo_cliente
	);
    
    -- Devuelve un listado de los productos que nunca han aparecido en un pedido.
    select *
    from producto p
    where not exists (
		select *
        from detalle_pedido dp
        where dp.codigo_producto = p.codigo_producto
    );
    
    -- Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
	select *
    from producto p
    where exists (
		select *
        from detalle_pedido dp
        where dp.codigo_producto = p.codigo_producto
    );