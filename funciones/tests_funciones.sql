USE peliculas_app;

-- ------------------------ TEST FUNCIONES ----------------------------------

USE peliculas_app;

-- Pruebas para edad_actor (no tiene en cuenta si el actor fallecio)
SELECT a.id_actor, a.nombre, a.apellido, a.fecha_nac, edad_actor(a.fecha_nac) AS edad_calculada
FROM actores a
ORDER BY edad_calculada DESC;

SELECT 'Keanu Reeves' AS actor, edad_actor('1964-09-02') AS edad_keanu;

-- Pruebas para calificacion_promedio
SELECT p.id_pelicula, p.titulo, calificacion_promedio(p.id_pelicula) AS promedio
FROM peliculas p
ORDER BY (promedio IS NULL), promedio DESC, p.titulo ASC;

SELECT p.titulo, calificacion_promedio(p.id_pelicula) AS promedio
FROM peliculas p
WHERE calificacion_promedio(p.id_pelicula) IS NOT NULL
ORDER BY promedio DESC, p.titulo;

-- Pruebas para total_visualizaciones_usuario
SELECT u.id_usuario, u.nombre, total_visualizaciones_usuario(u.id_usuario) AS vistas
FROM usuarios u
ORDER BY vistas DESC, u.nombre;

SELECT total_visualizaciones_usuario(9999) AS vistas_usuario_inexistente;

-- Pruebas para cantidad_peliculas_actor
SELECT a.id_actor, CONCAT(a.nombre,' ',a.apellido) AS actor, 
       cantidad_peliculas_actor(a.id_actor) AS cantidad_peliculas
FROM actores a
ORDER BY cantidad_peliculas DESC, actor ASC;

SELECT a.id_actor, CONCAT(a.nombre,' ',a.apellido) AS actor, 
       cantidad_peliculas_actor(a.id_actor) AS cantidad_peliculas
FROM actores a
ORDER BY cantidad_peliculas DESC, actor ASC
LIMIT 5;

-- Pruebas para categoria_pelicula
SELECT p.id_pelicula, p.titulo,
       categoria_pelicula(p.id_pelicula)        AS categoria_funcion,
       c.nombre                                 AS categoria_join
FROM peliculas p
JOIN categorias c USING (id_categoria)
ORDER BY p.titulo;

SELECT p.id_pelicula, p.titulo
FROM peliculas p
WHERE categoria_pelicula(p.id_pelicula) = 'Drama'
ORDER BY p.titulo;

-- Pruebas para fecha_ultima_vista
SELECT u.id_usuario, u.nombre, fecha_ultima_vista(u.id_usuario) AS ultima_vista
FROM usuarios u
ORDER BY (ultima_vista IS NULL), ultima_vista DESC, u.nombre;

SELECT fecha_ultima_vista(9999) AS ultima_vista_usuario_inexistente;

SELECT u.id_usuario, u.nombre,
       fecha_ultima_vista(u.id_usuario) AS ultima_funcion,
       (SELECT MAX(v.fecha_vista) FROM visualizaciones v WHERE v.id_usuario = u.id_usuario) AS ultima_subquery
FROM usuarios u
ORDER BY u.id_usuario;