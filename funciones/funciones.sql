USE peliculas_app;

-- Funcion para devolver la edad del actor
DELIMITER $$
CREATE FUNCTION edad_actor(fecha_nac DATE)
RETURNS TINYINT UNSIGNED
DETERMINISTIC
BEGIN
	DECLARE edad TINYINT UNSIGNED;
	SET edad = timestampdiff(YEAR, fecha_nac, CURDATE());
    RETURN edad;
END$$
DELIMITER ;

-- Funcion para obtener la calificacion promedio de una pelicula
DELIMITER $$
CREATE FUNCTION calificacion_promedio(f_id_pelicula INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
	DECLARE promedio DECIMAL(4,2);
    SELECT avg(calificacion) INTO promedio FROM visualizaciones WHERE id_pelicula = f_id_pelicula;
    RETURN promedio;
END$$
DELIMITER ;

-- Funcion para contar cuantas peliculas vio un usuario
DELIMITER $$
CREATE FUNCTION total_visualizaciones_usuario(f_id_usuario INT)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
	DECLARE vistas INT UNSIGNED;
    SELECT count(*) INTO vistas FROM visualizaciones WHERE id_usuario=f_id_usuario;
    RETURN vistas;
END$$
DELIMITER ;

-- Funcion para calcular la cantidad de veces que un actor aparece en una pelicula
DELIMITER $$
CREATE FUNCTION cantidad_peliculas_actor(f_id_actor INT)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
	DECLARE aparicion_actor INT UNSIGNED;
    SELECT count(*) INTO aparicion_actor FROM peliculas_actores WHERE id_actor=f_id_actor;
    RETURN aparicion_actor;
END$$
DELIMITER ;

-- Funcion para devolver la categoria de una pelicula
DELIMITER $$
CREATE FUNCTION categoria_pelicula(f_id_pelicula INT)
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
	DECLARE cat VARCHAR(40);
    SELECT c.nombre INTO cat FROM peliculas p INNER JOIN categorias c USING (id_categoria) WHERE p.id_pelicula = f_id_pelicula;
    RETURN cat;
END$$
DELIMITER ;

-- Funcion para saber el ultimo dia que un usuario vio algo
DELIMITER $$
CREATE FUNCTION fecha_ultima_vista(f_id_usuario INT)
RETURNS DATE
DETERMINISTIC
BEGIN
	DECLARE ultima_vista DATE;
	SELECT max(fecha_vista) INTO ultima_vista FROM visualizaciones WHERE id_usuario = f_id_usuario;
    RETURN ultima_vista;
END$$
DELIMITER ;