USE peliculas_app;

-- ------------------------- TEST TRIGGERS ----------------------------------

-- 1) Calificación válida / inválida en INSERT
INSERT INTO visualizaciones (id_usuario, id_pelicula, fecha_vista, calificacion, comentario)
VALUES (1, 6, CURDATE(), 9, 'OK'); -- OK

-- Debe fallar (calificación fuera de rango)
INSERT INTO visualizaciones (id_usuario, id_pelicula, fecha_vista, calificacion, comentario)
VALUES (1, 6, CURDATE(), 15, 'Error esperado');

-- 2) Fecha futura en INSERT
-- Debe fallar (fecha en el futuro)
INSERT INTO visualizaciones (id_usuario, id_pelicula, fecha_vista, calificacion, comentario)
VALUES (1, 7, DATE_ADD(CURDATE(), INTERVAL 1 DAY), 8, 'Error esperado');

-- 3) Calificación válida / inválida en UPDATE
-- Crear registro de prueba
INSERT INTO visualizaciones (id_usuario, id_pelicula, fecha_vista, calificacion, comentario)
VALUES (2, 7, CURDATE(), 7, 'Prueba update');

-- Debe fallar (calificación fuera de rango)
UPDATE visualizaciones SET calificacion = 0
WHERE id_usuario = 2 AND id_pelicula = 7 AND comentario = 'Prueba update';

-- 4) Fecha futura en UPDATE
-- Debe fallar (fecha en el futuro)
UPDATE visualizaciones SET fecha_vista = DATE_ADD(CURDATE(), INTERVAL 2 DAY)
WHERE id_usuario = 2 AND id_pelicula = 7 AND comentario = 'Prueba update';

-- Limpieza registro de prueba
DELETE FROM visualizaciones
WHERE id_usuario = 2 AND id_pelicula = 7 AND comentario = 'Prueba update';

-- 5) Título vacío en INSERT
-- Debe fallar (título vacío)
INSERT INTO peliculas (titulo, anio, duracion, id_categoria)
VALUES ('   ', 2024, 100, 1);

-- 6) Título vacío en UPDATE
-- Crear película temporal
INSERT INTO peliculas (titulo, anio, duracion, id_categoria)
VALUES ('Temporal OK', 2024, 100, 1);

-- Debe fallar (título vacío en update)
UPDATE peliculas SET titulo = '   '
WHERE titulo = 'Temporal OK' LIMIT 1;

-- Limpieza película temporal
DELETE FROM peliculas WHERE titulo = 'Temporal OK' LIMIT 1;

-- 7) Bloquear eliminación de actor con participaciones
-- Debe fallar (actor con participaciones, ej. Keanu Reeves)
DELETE FROM actores WHERE nombre = 'Keanu' AND apellido = 'Reeves' LIMIT 1;

-- 8) Permitir eliminación de actor sin participaciones
INSERT INTO actores (nombre, apellido, fecha_nac) VALUES ('Actor', 'SinUso', '1980-01-01');
DELETE FROM actores WHERE nombre = 'Actor' AND apellido = 'SinUso' LIMIT 1;

-- 9) Bloquear eliminación de película con visualizaciones
-- Debe fallar (película con visualizaciones, ej. 'Matrix')
DELETE FROM peliculas WHERE titulo = 'Matrix' LIMIT 1;

-- 10) Permitir eliminación de película sin visualizaciones
INSERT INTO peliculas (titulo, anio, duracion, id_categoria) VALUES ('PeliSinVistas', 2025, 90, 1);
DELETE FROM peliculas WHERE titulo = 'PeliSinVistas' LIMIT 1;

-- 11) Bloquear eliminación de categoría con películas asociadas
-- Debe fallar (ej. 'Ciencia Ficción')
DELETE FROM categorias WHERE nombre = 'Ciencia Ficción' LIMIT 1;

-- 12) Permitir eliminación de categoría sin películas asociadas
INSERT INTO categorias (nombre) VALUES ('CategoriaTemporal');
DELETE FROM categorias WHERE nombre = 'CategoriaTemporal' LIMIT 1;