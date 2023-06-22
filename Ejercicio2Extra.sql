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
    where p.fecha_esperada < p.fecha_entrega or p.fecha_entrega is null;
    
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
        select c.nombre_cliente 'Cliente'
        from cliente c
        inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
        inner join oficina o on o.codigo_oficina = e.codigo_oficina
        where o.ciudad = ;
        
        -- Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
        
        -- Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
        
        -- Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
        
        -- Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
        
-- Consultas multitabla (Composición externa)
	-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
		-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
        
        -- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
        
        -- Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
        
        -- Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
        
        -- Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
        
        -- Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
        
        -- Devuelve un listado de los productos que nunca han aparecido en un pedido.
        
        -- Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas
        -- de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
        
        -- Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.
        
        -- Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
        
-- Consultas resumen
	-- ¿Cuántos empleados hay en la compañía?
    select count(*) from empleado;
    
    -- ¿Cuántos clientes tiene cada país?
    select count(*) 
    from empleados ;
    
    -- ¿Cuál fue el pago medio en 2009?
    
    -- ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
    
    -- Calcula el precio de venta del producto más caro y más barato en una misma consulta.
    
    -- Calcula el número de clientes que tiene la empresa.
    
    -- ¿Cuántos clientes tiene la ciudad de Madrid?
    
    -- ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
    
    -- Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
    
    -- Calcula el número de clientes que no tiene asignado representante de ventas.
    
    -- Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
    -- El listado deberá mostrar el nombre y los apellidos de cada cliente.
    
    -- Calcula el número de productos diferentes que hay en cada uno de los pedidos.
    
    -- Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
    
    -- Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno.
    -- El listado deberá estar ordenado por el número total de unidades vendidas.
    
    -- La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado.
    -- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido.
    -- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
    
    -- La misma información que en la pregunta anterior, pero agrupada por código de producto.
    
    -- La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
    
    -- Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre,
    -- unidades vendidas, total facturado y total facturado con impuestos (21% IVA)
    
-- Subconsultas con operadores básicos de comparación
	-- Devuelve el nombre del cliente con mayor límite de crédito.
    
    -- Devuelve el nombre del producto que tenga el precio de venta más caro.
    
    -- Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de
    -- unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código
    -- del producto, puede obtener su nombre fácilmente.)
    
    -- Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
    
    -- Devuelve el producto que más unidades tiene en stock.
    
    -- Devuelve el producto que menos unidades tiene en stock.
    
    -- Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
    
-- Subconsultas con ALL y ANY
	-- Devuelve el nombre del cliente con mayor límite de crédito.
    
    -- Devuelve el nombre del producto que tenga el precio de venta más caro.
    
    -- Devuelve el producto que menos unidades tiene en stock.
    
-- Subconsultas con IN y NOT IN
	-- Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
    
    -- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
    
    -- Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
    
    -- Devuelve un listado de los productos que nunca han aparecido en un pedido.
    
    -- Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
    
-- Subconsultas con EXISTS y NOT EXISTS
	-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
    
    -- Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
    
    -- Devuelve un listado de los productos que nunca han aparecido en un pedido.
    
    -- Devuelve un listado de los productos que han aparecido en un pedido alguna vez.