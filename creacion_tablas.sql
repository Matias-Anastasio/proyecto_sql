CREATE SCHEMA IF NOT EXISTS peliculas_app;

USE peliculas_app;

CREATE TABLE IF NOT EXISTS categorias(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS peliculas(
	id_pelicula INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    anio INT NOT NULL,
    duracion INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE IF NOT EXISTS actores (
	id_actor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nac DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS peliculas_actores(
	id_pelicula INT NOT NULL,
    id_actor INT NOT NULL,
    rol VARCHAR(40) NOT NULL,
    PRIMARY KEY (id_pelicula, id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES peliculas(id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actores(id_actor)
);
    
CREATE TABLE IF NOT EXISTS usuarios(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    fecha_reg DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS visualizaciones(
	id_visualizacion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_pelicula INT NOT NULL,
    fecha_vista DATE NOT NULL,
    calificacion TINYINT,
    comentario TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_pelicula) REFERENCES peliculas(id_pelicula)
);
