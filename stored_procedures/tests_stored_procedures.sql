USE peliculas_app;

-- -------------------- TEST STORED PROCEDURES ------------------------------

-- 1) insertar_visualizacion(u_id, p_id, calif, comentario)
-- Casos OK
CALL insertar_visualizacion(1, 6, 9, 'Muy buena secuela');
CALL insertar_visualizacion(2, 7, 8, 'Me gustó');

-- Caso ERROR (calificación fuera de rango)
-- Debe fallar con: 'La calificación debe estar entre 1 y 10'
CALL insertar_visualizacion(1, 6, 15, 'Fuera de rango');

-- 2) peliculas_por_usuario(u_id)
-- Historial de un usuario existente (Ana = id 1)
CALL peliculas_por_usuario(1);

-- Usuario sin historial (usar un id inexistente)
CALL peliculas_por_usuario(9999);

-- 3) top_peliculas(limit_n, minimo_votos)
-- Top 5 con mínimo 1 voto
CALL top_peliculas(5, 1);

-- Top 3 con mínimo 2 votos
CALL top_peliculas(3, 2);

-- Caso ERROR (parámetros inválidos)
CALL top_peliculas(0, 1);
CALL top_peliculas(3, 0);

-- 4) buscar_peliculas(termino, categoria_opc)
-- Por título solamente
CALL buscar_peliculas('Matrix', NULL);

-- Por categoría solamente
CALL buscar_peliculas('', 'Drama');

-- Combinado: título + categoría (coincidencia parcial)
CALL buscar_peliculas('Star', 'Ficción');

-- 5) actor_en_peliculas(a_id)
-- Actor existente (Keanu Reeves = id 1)
CALL actor_en_peliculas(1);

-- Actor inexistente
CALL actor_en_peliculas(9999);
