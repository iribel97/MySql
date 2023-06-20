	-- Lista el nombre de todos los productos que hay en la tabla producto.
	select p.nombre from producto p;

	-- Lista los nombres y los precios de todos los productos de la tabla producto.
	select p.nombre, p.precio from producto p;

	-- Lista todas las columnas de la tabla producto.
    select * from producto;

	-- Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
    select p.nombre, round(p.precio, 2) 'Precio' from producto p;

	-- Lista el código de los fabricantes que tienen productos en la tabla producto.
    select p.nombre 'Producto', p.codigo_fabricante 'Codigo fabricante'  from producto p;

	-- Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
    select p.codigo_fabricante from producto p group by p.codigo_fabricante;
    
    -- Lista los nombres de los fabricantes ordenados de forma ascendente.
    select f.nombre
    from fabricante f
    order by f.nombre asc;
    
    -- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y 
    -- en segundo lugar por el precio de forma descendente.
    select nombre
	from producto
	order by nombre asc;
    
    select nombre
    from producto
    order by precio DESC;
    
    -- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
    select * 
    from fabricante
    limit 5;
    
    -- Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
    select p.nombre 'Producto', p.precio 'Precio'
    from producto p
    order by p.precio asc
    limit 1;
    
    -- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
    select p.nombre 'Producto', p.precio 'Precio'
    from producto p
    order by p.precio desc
    limit 1;
    
    -- Lista el nombre de los productos que tienen un precio menor o igual a $120.
    select p.nombre 'Producto'
    from producto p
    where p.precio <= 120;
    
    -- Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
    select p.nombre 'Nombre' , p.precio 'Precio'
    from producto p
    where p.precio between 60 and 200;
    
    -- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
    select p.nombre 'Producto' , p.precio 'Precio' , p.codigo_fabricante 'Fabricante'
    from producto p
    where p.codigo_fabricante in (1,3,5);
    
    -- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
    select p.nombre 'Producto' , p.precio 'Precio' 
    from producto p
    where p.nombre like 'Portatil%';
    
-- Consultas Multitabla
	-- Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, 
    -- de todos los productos de la base de datos.
    select p.codigo 'Codico Producto', p.nombre 'Producto', p.codigo_fabricante 'Codigo Fabricante', f.nombre 'Fabricante'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo;
    
    -- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
    -- Ordene el resultado por el nombre del fabricante, por orden alfabético.
    select p.codigo 'Codico Producto', p.nombre 'Producto', p.precio 'Precio' , f.nombre 'Fabricante'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo;
    
    -- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
	select p.nombre 'Producto', p.precio 'Precio' , f.nombre 'Fabricante'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo
    order by p.precio asc
    limit 1;
    
    -- Devuelve una lista de todos los productos del fabricante Lenovo.
	select p.nombre 'Producto', p.precio 'Precio' , f.nombre 'Fabricante'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo and f.nombre = "Lenovo";
    
    -- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
    select p.nombre 'Producto', p.precio 'Precio'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo and p.precio > 200 and f.nombre = "Crucial";
    
    -- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
    select p.nombre 'Producto', p.precio 'Precio'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo and f.nombre in ("Asus", "Hewlett-Packard");
    
    -- Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180.
    -- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
    select p.codigo 'Codico Producto', p.nombre 'Producto', p.precio 'Precio' , f.nombre 'Fabricante'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo and p.precio >= 180
    order by p.precio asc;
    
    select p.codigo 'Codico Producto', p.nombre 'Producto', p.precio 'Precio' , f.nombre 'Fabricante'
    from producto p, fabricante f
    where p.codigo_fabricante = f.codigo and p.precio >= 180
    order by p.precio desc;
    
	-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
		-- Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos.
		-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
        select f.codigo 'Codigo Fabricante' , f.nombre 'Fabricante' , p.nombre 'Producto' , p.precio 'Precio'
        from fabricante f
        left join producto p on f.codigo = p.codigo_fabricante;
		
		-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
        select f.codigo 'Codigo Fabricante' , f.nombre 'Fabricante' , p.nombre 'Producto' , p.precio 'Precio'
        from fabricante f
        left join producto p on f.codigo = p.codigo_fabricante
        where p.codigo_fabricante is null;
        
-- Subconsultas (En la cláusula WHERE)
	-- Con operadores básicos de comparación
		-- Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
        select p.nombre 'Producto' , p.precio 'Precio' , f.nombre 'Fabricante'
        from producto p, fabricante f
        where p.codigo_fabricante = f.codigo and f.nombre = "Lenovo";
        
        -- Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. 
        -- (Sin utilizar INNER JOIN).
        select p.codigo 'Codigo Producto', p.nombre 'Producto' , p.precio 'Precio' , f.nombre 'Fabricante'
        from producto p, fabricante f
        where p.codigo_fabricante = f.codigo 
        and p.precio = (
			select r.precio from producto r, fabricante a
			where a.nombre = "Lenovo"  and r.codigo_fabricante = a.codigo
			order by r.precio desc
			limit 1
		);
        
        -- Lista el nombre del producto más caro del fabricante Lenovo.
        select p.codigo 'Codigo Producto', p.nombre 'Producto' , p.precio 'Precio' , f.nombre 'Fabricante'
        from producto p, fabricante f
        where p.codigo_fabricante = f.codigo 
        and p.precio = (
			select max(r.precio) 
            from producto r, fabricante a 
            where r.codigo_fabricante = a.codigo and a.nombre = "Lenovo"
		);
        
        -- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
        select p.codigo 'Codigo Producto', p.nombre 'Producto' , p.precio 'Precio' , f.nombre 'Fabricante'
        from producto p, fabricante f
        where p.codigo_fabricante = f.codigo and f.nombre = "Asus"
        and p.precio > (
			select avg(r.precio) from producto r, fabricante a 
            where r.codigo_fabricante = a.codigo and a.nombre = "Asus"
        );
        
	-- Subconsultas con IN y NOT IN
		-- Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
        select nombre 'Fabricante'
		from fabricante
		where codigo in (
			select codigo_fabricante
			from producto
		);
        
        -- Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
        select nombre 'Fabricante'
		from fabricante
		where codigo not in (
			select codigo_fabricante
			from producto
		);
        
	-- Subconsultas (En la cláusula HAVING)
		-- Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
        select f.nombre 'Fabricante'
		from fabricante f
		join producto p on p.codigo_fabricante = f.codigo
		group by f.nombre
		having count(*) = (
			select count(*)
			from producto r, fabricante a
			where r.codigo_fabricante = a.codigo and a.nombre = "Lenovo"
			group by codigo_fabricante
		);