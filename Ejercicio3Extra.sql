-- 1. Mostrar el nombre de todos los pokemon.
	select nombre from pokemon;

-- 2. Mostrar los pokemon que pesen menos de 10k.
	select * 
    from pokemon p
    where p.peso < 10;
    
-- 3. Mostrar los pokemon de tipo agua.
	select p.nombre
    from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    where pt.id_tipo = 1;
    
-- 4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo.
	select *
    from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    where pt.id_tipo in ( 1, 6, 13);
    
-- 5. Mostrar los pokemon que son de tipo fuego y volador.
	select distinct p.numero_pokedex, p.nombre
    from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    where pt.id_tipo in (6,15) 
    group by p.nombre, p.numero_pokedex
    having count(distinct pt.id_tipo) = 2;
	    
    /*
    select distinct p.numero_pokedex, p.nombre
    from pokemon p
    where p.nombre IN (
    select p.nombre 
    from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    where pt.id_tipo=6)
    and p.nombre IN(
    select p.nombre 
    from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    where pt.id_tipo=15);
    */
    
-- 6. Mostrar los pokemon con una estadística base de ps mayor que 200.
	select p.nombre 'Pokemon', p.numero_pokedex 'Numero en Pokedex', eb.ps 'PS'
    from pokemon p
    join estadisticas_base eb on eb.numero_pokedex = p.numero_pokedex
    where eb.ps > 200;
    
-- 7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.
	select p.nombre 'Pokemon', p.peso 'Peso', p.altura 'Altura'
    from pokemon p
    join evoluciona_de ed on ed.pokemon_origen = p.numero_pokedex
    join pokemon pk on pk.numero_pokedex = ed.pokemon_evolucionado
    where pk.nombre = 'Arbok';
    
-- 8. Mostrar aquellos pokemon que evolucionan por intercambio.
	select p.numero_pokedex 'Numero de Pokedex', p.nombre 'Pokemon', fe.tipo_evolucion 'Tipo de Evolucion'
    from pokemon p
    join pokemon_forma_evolucion pfv on pfv.numero_pokedex = p.numero_pokedex
    join forma_evolucion fe on fe.id_forma_evolucion = pfv.id_forma_evolucion
    where fe.tipo_evolucion = 3;
    
-- 9. Mostrar el nombre del movimiento con más prioridad.
	select * 
    from movimiento m
    where m.prioridad = (
    select max(prioridad) 
    from movimiento
    );
    
-- 10. Mostrar el pokemon más pesado.
	select *
    from pokemon p
    order by p.peso desc
    limit 1;
    
-- 11. Mostrar el nombre y tipo del ataque con más potencia.
	select ta.tipo 'Tipo de Ataque', m.nombre 'Nombre'
    from tipo_ataque ta
    join tipo t on t.id_tipo_ataque = ta.id_tipo_ataque
    join movimiento m on m.id_tipo = t.id_tipo 
    order by m.potencia desc
    limit 1; 
    
-- 12. Mostrar el número de movimientos de cada tipo.
	select m.id_tipo 'Id Tipo', t.nombre 'Nombre', count(*) 'Cantidad de movimientos'
    from movimiento m
    join tipo t on t.id_tipo = m.id_tipo
    group by m.id_tipo;
    
-- 13. Mostrar todos los movimientos que puedan envenenar.
	select m.id_tipo 'Id Tipo', m.nombre 'Nombre'
    from movimiento m
    join tipo t on t.id_tipo = m.id_tipo
    where t.nombre like 'Ven%'
    group by m.id_tipo, m.nombre;
    
-- 14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre.
	select m.id_tipo 'Id Tipo', t.nombre 'Nombre'
    from movimiento m
    join tipo t on t.id_tipo = m.id_tipo
    where m.descripcion like '%causa daño%'
	group by m.id_tipo, m.descripcion;

-- 15. Mostrar todos los movimientos que aprende pikachu.
	select m.id_movimiento, m.nombre
    from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    join movimiento m on m.id_tipo = pt.id_tipo
    where p.nombre = 'pikachu';
	
-- 16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje).
	select m.id_movimiento, m.nombre 'Movimiento', fa.id_forma_aprendizaje
    from movimiento m
    join pokemon_movimiento_forma pmf on pmf.id_movimiento = m.id_movimiento
    join forma_aprendizaje fa on fa.id_forma_aprendizaje = pmf.id_forma_aprendizaje
    where pmf.numero_pokedex = 25 and fa.id_tipo_aprendizaje = 1;
 
-- 17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel.
	select m.id_movimiento, m.nombre 'Movimiento', fa.id_forma_aprendizaje
    from movimiento m
    join pokemon_movimiento_forma pmf on pmf.id_movimiento = m.id_movimiento
    join forma_aprendizaje fa on fa.id_forma_aprendizaje = pmf.id_forma_aprendizaje
    join tipo t on t.id_tipo = m.id_tipo
    where pmf.numero_pokedex = 25 and fa.id_tipo_aprendizaje = 3 and t.nombre like 'normal';
    
-- 18. Mostrar todos los movimientos de efecto secundario cuya probabilidad sea mayor al 30%.
	select m.nombre 'Movimiento', es.efecto_secundario 'Efecto secundario', mes.probabilidad 'Probabilidad'
    from movimiento m
    join movimiento_efecto_secundario mes on mes.id_movimiento = m.id_movimiento
    join efecto_secundario es on es.id_efecto_secundario = mes.id_efecto_secundario
    where mes.probabilidad > 30;
    
-- 19. Mostrar todos los pokemon que evolucionan por piedra.
	select distinct p.numero_pokedex 'Pokedex', p.nombre 'Pokemones'
    from pokemon p
    join pokemon_forma_evolucion pfe on pfe.numero_pokedex = p.numero_pokedex
    join forma_evolucion fe on fe.id_forma_evolucion = pfe.id_forma_evolucion
    join piedra pie on pie.id_forma_evolucion = fe.id_forma_evolucion
    join tipo_piedra tp on tp.id_tipo_piedra = pie.id_tipo_piedra;
    
-- 20. Mostrar todos los pokemon que no pueden evolucionar.
	select *
    from pokemon p
    left join evoluciona_de ed on ed.pokemon_origen = p.numero_pokedex
    where ed.pokemon_origen is null;
    
-- 21. Mostrar la cantidad de los pokemon de cada tipo.
	select t.nombre 'Tipo', count(pt.numero_pokedex)
    from pokemon p
    join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
    join tipo t on t.id_tipo = pt.id_tipo
    group by pt.id_tipo;