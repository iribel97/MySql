-- a) A continuación, realizar las siguientes consultas sobre la base de datos personal:
	-- Obtener los datos completos de los empleados.
    select * from empleados;
    
    -- Obtener los datos completos de los departamentos.
    select * from departamentos;
    
    -- Listar el nombre de los departamentos.
    select d.nombre_depto 'Nombre Departamento' from departamentos d;
    
    -- Obtener el nombre y salario de todos los empleados.
    select e.nombre 'Nombre', e.sal_emp 'Salario' from empleados e;
    
    -- Listar todas las comisiones.
    select e.comision_emp 'Comisiones' from empleados e;
    
    -- Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
    select e.nombre 'Nombre' 
    from empleados e
    where e.cargo_emp like 'Secretaria';
    
    -- Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
    select * 
    from empleados e
    where e.cargo_emp like 'Vendedor'
    order by e.nombre asc;
    
    -- Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
    select e.nombre 'Nombre', e.cargo_emp 'Cargo'  
    from empleados e
    order by e.sal_emp asc;
    
    -- Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad