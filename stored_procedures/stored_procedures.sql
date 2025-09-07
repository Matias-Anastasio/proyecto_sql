USE peliculas_app;

-- Procedimiento para cargar una visualizacion
DELIMITER $$
CREATE PROCEDURE insertar_visualizacion(
	IN u_id INT,
    IN p_id INT,
    IN calif TINYINT,
    IN comentario TEXT
)
BEGIN
	IF calif < 1 OR calif > 10 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'La calificación debe estar entre 1 y 10';
	END IF;
    
    INSERT INTO visualizaciones(id_usuario,id_pelicula, calificacion,comentario)
    VALUES (u_id,p_id,calif,comentario);
END$$
DELIMITER ;

-- Procedimiento que devuelve las peliculas vistas por un usuario
DELIMITER $$
CREATE PROCEDURE peliculas_por_usuario(IN u_id INT)
BEGIN
	SELECT p.titulo, v.fecha_vista, coalesce(cast(v.calificacion AS CHAR), 'Sin calificar') AS calificacion, coalesce(v.comentario,'Sin comentario') AS comentario FROM visualizaciones v INNER JOIN peliculas p USING (id_pelicula) WHERE id_usuario = u_id ORDER BY fecha_vista DESC;
END$$
DELIMITER ;

-- Procedimiento que devuelve las N mejores peliculas por promedio de votos
DELIMITER $$
CREATE PROCEDURE top_peliculas(IN limit_n INT, IN minimo_votos INT)
BEGIN
	IF limit_n < 1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'El limite de peliculas debe ser al menos igual a 1';
	END IF;
	IF minimo_votos < 1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'El minimo de votos debe ser al menos igual a 1';
	END IF;
	SELECT p.id_pelicula,p.titulo, round(avg(v.calificacion), 1) AS calificacion_promedio, count(v.calificacion) AS cantidad_votos FROM visualizaciones v INNER JOIN peliculas p USING (id_pelicula) GROUP BY p.id_pelicula,p.titulo HAVING cantidad_votos >= minimo_votos ORDER BY calificacion_promedio DESC, cantidad_votos DESC LIMIT limit_n;
END $$
DELIMITER ;

-- Procedimiento que busque peliculas por titulo y opcional por categoria
DELIMITER $$
CREATE PROCEDURE buscar_peliculas(
	IN termino VARCHAR(100),
    IN categoria_opc VARCHAR(40)
)
BEGIN
	SELECT p.id_pelicula, p.titulo, c.nombre FROM peliculas p INNER JOIN categorias c USING (id_categoria) WHERE p.titulo LIKE CONCAT('%',termino,'%') AND (categoria_opc IS NULL OR c.nombre LIKE concat('%',categoria_opc,'%')) ORDER BY p.titulo;
END $$
DELIMITER ;

-- Procedimento que devuelve las peliculas en las que aparecio un actor
DELIMITER $$
CREATE PROCEDURE actor_en_peliculas(IN a_id INT)
BEGIN
	SELECT p.id_pelicula,p.titulo,a.id_actor,CONCAT(a.nombre,' ',a.apellido) AS actor, pa.rol,p.anio FROM peliculas p INNER JOIN peliculas_actores pa USING(id_pelicula) INNER JOIN actores a USING (id_actor) WHERE id_actor = a_id ORDER BY p.anio DESC;
END $$
DELIMITER ;
