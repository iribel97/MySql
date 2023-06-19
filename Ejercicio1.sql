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
    
    -- Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real”
    select d.nombre_jefe_depto 'Jefes de Departamentos' 
    from departamentos d
    where d.ciudad like 'Ciudad Real';
    
    -- Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
    select e.nombre 'Nombre', e.cargo_emp 'Cargo' 
    from empleados e;
    
    -- Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
    select e.nombre 'Empleado', e.sal_emp 'Salario', e.comision_emp 'Comision' 
    from empleados e
    where e.id_depto = 2000 
    order by e.comision_emp asc;
    
    -- Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta de: 
    -- sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del empleado y el total a pagar, en orden alfabético.
    select e.nombre 'Nombre', (e.sal_emp + e.comision_emp + 500) 'Total a pagar'
    from empleados e
    where e.id_depto = 3000
    order by e.nombre asc;
    
    -- Muestra los empleados cuyo nombre empiece con la letra J.
    select * from empleados where nombre like 'j%';
    
    -- Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
    select e.nombre 'Empleado', e.sal_emp 'Salario', e.comision_emp 'Comision', (e.sal_emp + e.comision_emp) 'Salario Total'  
    from empleados e
    where e.comision_emp > 1000;
    
    -- Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
    select e.nombre 'Empleado', e.sal_emp 'Salario', e.comision_emp 'Comision', (e.sal_emp + e.comision_emp) 'Salario Total'  
    from empleados e
    where e.comision_emp = 0;
    
    -- Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
    select e.nombre 'Empleado', e.sal_emp 'Salario', e.comision_emp 'Comision', (e.sal_emp + e.comision_emp) 'Salario Total'  
    from empleados e
    where e.comision_emp > e.sal_emp;
    
    -- Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
    select e.nombre 'Empleado', e.sal_emp 'Salario', e.comision_emp 'Comision' 
    from empleados e
    where e.comision_emp <= (0.3 * e.sal_emp);
    
    -- Hallar los empleados cuyo nombre no contiene la cadena “MA”
    select *
    from empleados e
    where e.nombre not like '%ma%';
    
    -- Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o ‘Mantenimiento.
    select *
    from departamentos d
    where d.nombre_depto like'Ventas' or d.nombre_depto like 'Investigación' or d.nombre_depto like 'Mantenimiento';
    
    -- Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
	select *
    from departamentos d
    where d.nombre_depto not like'Ventas' and d.nombre_depto not like 'Investigación' and d.nombre_depto not like 'Mantenimiento';
    
    -- Mostrar el salario más alto de la empresa.
    select * 
    from empleados e
    order by e.sal_emp desc
    limit 1;
    
    -- Mostrar el nombre del último empleado de la lista por orden alfabético.
    select * 
    from empleados e
    order by e.nombre desc
    limit 1;
    
    -- Hallar el salario más alto, el más bajo y la diferencia entre ellos.
    select MAX(sal_emp) 'SALARIO MAXIMO', MIN(sal_emp) 'SALARIO MINIMO', MAX(sal_emp) - MIN(sal_emp) AS 'DIFERENCIA'
	from empleados;
    
    -- Hallar el salario promedio por departamento.
    select e.id_depto, round(avg(e.sal_emp), 2) 'SALARIO PROMEDIO' 
    from empleados e
    group by e.id_depto;
    
-- Consultas con Having
	-- Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
    select d.nombre_depto 'Departamento', COUNT(*) 'Numero empleados'
	from empleados e
	join departamentos d on e.id_depto = d.id_depto
	group by d.nombre_depto
	having COUNT(*) > 3;
    
    -- Hallar los departamentos que no tienen empleados
    select d.nombre_depto 'Departamento', COUNT(*) 'Numero empleados'
	from empleados e
	join departamentos d on e.id_depto = d.id_depto
	group by d.nombre_depto
	having COUNT(*) = 0;
    
-- Consulta Multitabla
	-- Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada departamento.
    select e.nombre 'Empleado' , d.nombre_depto 'Departamento', d.nombre_jefe_depto 'Jefe de Departamento'
    from empleados e
    join departamentos d on e.id_depto = d.id_depto;
    
-- Consulta con Subconsulta
	-- Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
    select e.nombre 'Empleado', e.sal_emp 'Salario', d.nombre_depto
	from empleados e
	join departamentos d on e.id_depto = d.id_depto
	where e.sal_emp >= (select avg(sal_emp) from empleados)
	order by d.nombre_depto asc;