USE peliculas_app;

-- Vista de la categoria de una pelicula
CREATE VIEW v_peliculas_categorias AS
    SELECT 
        p.titulo, c.nombre AS categoria
    FROM
        peliculas p
            INNER JOIN
        categorias c USING (id_categoria);

-- Vista del reparto de una pelicula
CREATE VIEW v_actores_por_pelicula AS
    SELECT 
        p.titulo, CONCAT(a.nombre, ' ', a.apellido) AS actor, pa.rol
    FROM
        peliculas p
            INNER JOIN
        peliculas_actores pa USING (id_pelicula)
            INNER JOIN
        actores a USING (id_actor);

-- Vista del historial de visualizaciones de los usuarios
CREATE VIEW v_historial_visualizaciones AS
    SELECT 
        u.nombre, p.titulo, v.fecha_vista, v.calificacion as calificacion_otorgada
    FROM
        usuarios u
            INNER JOIN
        visualizaciones v USING (id_usuario)
            INNER JOIN
        peliculas p USING (id_pelicula);
    
-- Vista del ranking de peliculas con mejor calificacion
CREATE VIEW v_ranking_peliculas AS
    SELECT 
        p.titulo,
        AVG(v.calificacion) AS puntaje_promedio,
        COUNT(v.calificacion) AS cantidad_votos
    FROM
        peliculas p
            INNER JOIN
        visualizaciones v USING (id_pelicula)
    GROUP BY p.id_pelicula,p.titulo;

-- Vista de la actividad de los usuarios
CREATE VIEW v_actividad_usuarios AS
    SELECT 
        u.nombre,
        COUNT(id_pelicula) AS peliculas_vistas,
        MAX(v.fecha_vista) AS ultima_visualizacion,
        AVG(v.calificacion) AS calificacion_promedio
    FROM
        usuarios u
            INNER JOIN
        visualizaciones v USING (id_usuario)
    GROUP BY u.id_usuario,u.nombre;

-- Vista de actores con mas participaciones en peliculas
CREATE VIEW v_actores_mas_participaciones AS
    SELECT 
        CONCAT(a.nombre, ' ', a.apellido) AS actor,
        COUNT(DISTINCT pa.id_pelicula) AS cantidad_peliculas
    FROM
        actores a
            INNER JOIN
        peliculas_actores pa USING (id_actor)
    GROUP BY a.id_actor,actor;

-- Vista de peliculas sin visualizaciones
CREATE VIEW v_peliculas_sin_visualizaciones AS
    SELECT 
        p.titulo
    FROM
        peliculas p
            LEFT JOIN
        visualizaciones v USING (id_pelicula)
    WHERE
        v.id_pelicula IS NULL;
        
-- Vista del catalogo completo
CREATE VIEW v_catalogo_completo AS
    SELECT 
        p.titulo,
        c.nombre AS categoria,
        COALESCE(AVG(v.calificacion),0) AS puntaje_promedio
    FROM
        peliculas p
            INNER JOIN
        categorias c USING (id_categoria)
            LEFT JOIN
        visualizaciones v USING (id_pelicula)
    GROUP BY p.id_pelicula,p.titulo;