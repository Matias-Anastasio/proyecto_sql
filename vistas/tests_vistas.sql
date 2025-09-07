USE peliculas_app;

-- -------------------------- TEST VISTAS -----------------------------------

-- Ver todo ordenado por categoría y título
SELECT * FROM v_peliculas_categorias
ORDER BY categoria, titulo;

-- Buscar una categoría específica (ej: 'Ciencia Ficción')
SELECT * FROM v_peliculas_categorias
WHERE categoria = 'Ciencia Ficción'
ORDER BY titulo;

-- Ver reparto completo, ordenado por película y actor
SELECT * FROM v_actores_por_pelicula
ORDER BY titulo, actor;

-- Ver reparto de una película puntual (ej: 'Matrix')
SELECT * FROM v_actores_por_pelicula
WHERE titulo = 'Matrix'
ORDER BY actor;

-- Ver historial completo, ordenado por usuario y fecha desc
SELECT * FROM v_historial_visualizaciones
ORDER BY nombre, fecha_vista DESC;

-- Historial de un usuario puntual (ej: 'Ana López')
SELECT * FROM v_historial_visualizaciones
WHERE nombre = 'Ana López'
ORDER BY fecha_vista DESC;

-- Ver ranking completo (promedio desc, luego cantidad de votos desc)
SELECT * FROM v_ranking_peliculas
ORDER BY puntaje_promedio DESC, cantidad_votos DESC, titulo ASC;

-- Top 5
SELECT * FROM v_ranking_peliculas
ORDER BY puntaje_promedio DESC, cantidad_votos DESC, titulo ASC
LIMIT 5;

-- Ver actividad por usuario (cantidad vistas, última fecha, promedio)
SELECT * FROM v_actividad_usuarios
ORDER BY peliculas_vistas DESC, ultima_visualizacion DESC;

-- Usuario puntual (ej: 'Bruno Díaz')
SELECT * FROM v_actividad_usuarios
WHERE nombre = 'Bruno Díaz';

-- Ver actores por cantidad de películas (desc)
SELECT * FROM v_actores_mas_participaciones
ORDER BY cantidad_peliculas DESC, actor ASC;

-- Top 3 actores más presentes
SELECT * FROM v_actores_mas_participaciones
ORDER BY cantidad_peliculas DESC, actor ASC
LIMIT 3;

-- Películas que todavía no fueron vistas
SELECT * FROM v_peliculas_sin_visualizaciones
ORDER BY titulo;

-- Validar que 'Matrix' NO esté (porque tiene vistas)
SELECT 'Matrix' AS titulo_busqueda
WHERE 'Matrix' IN (SELECT titulo FROM v_peliculas_sin_visualizaciones);

-- Catálogo con promedio (0 cuando no hay calificaciones), orden alfabético
SELECT * FROM v_catalogo_completo
ORDER BY titulo;

-- Catálogo ordenado por mejor promedio y luego por título
SELECT * FROM v_catalogo_completo
ORDER BY puntaje_promedio DESC, titulo ASC;

-- Filtrar por categoría (ej: 'Drama')
SELECT * FROM v_catalogo_completo
WHERE categoria = 'Drama'
ORDER BY puntaje_promedio DESC, titulo ASC;
