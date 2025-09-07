USE peliculas_app;

-- Trigger para verificar antes de insertar en la tabla visualizaciones que la calificacion sea entre 1 y 10
DELIMITER $$
CREATE TRIGGER before_insert_visualizaciones
BEFORE INSERT ON visualizaciones
FOR EACH ROW
BEGIN
	IF NEW.calificacion IS NOT NULL AND (NEW.calificacion < 1 OR NEW.calificacion > 10) THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'La calificación debe estar entre 1 y 10';
	END IF;
END$$
DELIMITER ;

-- Trigger para verificar que al actualizar, la calificacion siga estando entre 1 y 10
DELIMITER $$
CREATE TRIGGER before_update_visualizaciones
BEFORE UPDATE ON visualizaciones
FOR EACH ROW
BEGIN
    IF NEW.calificacion IS NOT NULL 
       AND (NEW.calificacion < 1 OR NEW.calificacion > 10) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La calificación debe estar entre 1 y 10';
    END IF;
END$$
DELIMITER ;

-- Trigger para verificar que no se inserten visualizaciones en el futuro
DELIMITER $$
CREATE TRIGGER before_insert_visualizaciones_fecha
BEFORE INSERT ON visualizaciones
FOR EACH ROW
BEGIN
    IF NEW.fecha_vista > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La fecha de visualización no puede estar en el futuro';
    END IF;
END$$
DELIMITER ;

-- Trigger para verificar que no se actualicen visualizaciones en el futuro
DELIMITER $$
CREATE TRIGGER before_update_visualizaciones_fecha
BEFORE UPDATE ON visualizaciones
FOR EACH ROW
BEGIN
    IF NEW.fecha_vista > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La fecha de visualización no puede estar en el futuro';
    END IF;
END$$
DELIMITER ;

-- Trigger para verificar que no se inserten peliculas sin nombre o solo con espacios
DELIMITER $$
CREATE TRIGGER before_insert_peliculas_titulo
BEFORE INSERT ON peliculas
FOR EACH ROW
BEGIN
    IF TRIM(NEW.titulo) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El título de la película no puede estar vacío';
    END IF;
END$$
DELIMITER ;

-- Trigger para verificar que no se actualicen peliculas sin nombre o solo con espacios
DELIMITER $$
CREATE TRIGGER before_update_peliculas_titulo
BEFORE UPDATE ON peliculas
FOR EACH ROW
BEGIN
    IF TRIM(NEW.titulo) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El título de la película no puede estar vacío';
    END IF;
END$$
DELIMITER ;

-- Trigger para evitar que se borren actores con participaciones en peliculas
DELIMITER $$
CREATE TRIGGER before_delete_actores
BEFORE DELETE ON actores
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM peliculas_actores WHERE id_actor = OLD.id_actor) > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar un actor con participaciones en películas';
    END IF;
END$$
DELIMITER ;

-- Trigger para evitar que se borren peliculas que tienen visualizaciones
DELIMITER $$
CREATE TRIGGER before_delete_peliculas
BEFORE DELETE ON peliculas
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM visualizaciones WHERE id_pelicula = OLD.id_pelicula) > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar una película con visualizaciones registradas';
    END IF;
END$$
DELIMITER ;


-- Trigger para evitar que se borren categorias que tienen peliculas asociadas
DELIMITER $$
CREATE TRIGGER before_delete_categorias
BEFORE DELETE ON categorias
FOR EACH ROW
BEGIN
	IF (SELECT count(*) FROM peliculas WHERE id_categoria = OLD.id_categoria) > 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No se puede borrar la categoría: tiene peliculas asociadas';
	END IF;
END$$
DELIMITER ;

