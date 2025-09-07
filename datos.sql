USE peliculas_app;

INSERT INTO categorias (nombre) VALUES
('Acción'),
('Comedia'),
('Drama'),
('Ciencia Ficción'),
('Terror');

INSERT INTO peliculas (titulo, anio, duracion, id_categoria) VALUES
('Matrix', 1999, 136, 4),
('El Padrino', 1972, 175, 3),
('Mi pobre angelito', 1990, 103, 2),
('Alien', 1979, 117, 5),
('Duro de matar', 1988, 132, 1),
('Matrix Reloaded', 2003, 138, 4),
('Blade Runner', 1982, 117, 4),
('Star Wars: A New Hope', 1977, 121, 4),
('Se7en', 1995, 127, 3),
('El Padrino II', 1974, 202, 3),
('El Exorcista', 1973, 122, 5),
('Duro de matar 2', 1990, 124, 1),
('Los Cazafantasmas', 1984, 105, 2);


INSERT INTO actores (nombre, apellido, fecha_nac) VALUES
('Keanu', 'Reeves', '1964-09-02'),
('Marlon', 'Brando', '1924-04-03'),
('Macaulay', 'Culkin', '1980-08-26'),
('Sigourney', 'Weaver', '1949-10-08'),
('Bruce', 'Willis', '1955-03-19'),
('Laurence', 'Fishburne', '1961-07-30'),
('Carrie-Anne', 'Moss', '1967-08-21'),
('Robert', 'De Niro', '1943-08-17'),
('Al', 'Pacino', '1940-04-25'),
('Tom', 'Skerritt', '1933-08-25'),
('Alan', 'Rickman', '1946-02-21'),
('Bonnie', 'Bedelia', '1948-03-25'),
('Harrison', 'Ford', '1942-07-13'),
('Rutger', 'Hauer', '1944-01-23'),
('Carrie', 'Fisher', '1956-10-21'),
('Mark', 'Hamill', '1951-09-25'),
('Brad', 'Pitt', '1963-12-18'),
('Morgan', 'Freeman', '1937-06-01'),
('Linda', 'Blair', '1959-01-22'),
('Bill', 'Murray', '1950-09-21'),
('Dan', 'Aykroyd', '1952-07-01'),
('Joe', 'Pantoliano', '1951-09-12'),
('Max', 'von Sydow', '1929-04-10');


INSERT INTO peliculas_actores (id_pelicula, id_actor, rol) VALUES
(1, 1, 'Neo'),            -- Keanu en Matrix
(2, 2, 'Vito Corleone'),  -- Marlon en El Padrino
(3, 3, 'Kevin'),          -- Macaulay en Mi Pobre Angelito
(4, 4, 'Ripley'),         -- Sigourney en Alien
(5, 5, 'John McClane'),   -- Bruce en Duro de Matar
(1, 6,  'Morpheus'),        -- Matrix: Laurence Fishburne
(1, 7,  'Trinity'),         -- Matrix: Carrie-Anne Moss
(1, 22, 'Cypher'),          -- Matrix: Joe Pantoliano
(2, 9,  'Michael Corleone'),-- El Padrino: Al Pacino
(4, 10, 'Dallas'),          -- Alien: Tom Skerritt
(5, 11, 'Hans Gruber'),     -- Duro de matar: Alan Rickman
(5, 12, 'Holly Gennero'),   -- Duro de matar: Bonnie Bedelia
(6, 1,  'Neo'),             -- Matrix Reloaded: Keanu Reeves
(6, 6,  'Morpheus'),
(6, 7,  'Trinity'),
(7, 13, 'Rick Deckard'),    -- Blade Runner
(7, 14, 'Roy Batty'),
(8, 13, 'Han Solo'),        -- Star Wars: A New Hope
(8, 15, 'Leia Organa'),
(8, 16, 'Luke Skywalker'),
(9, 17, 'Detective Mills'), -- Se7en
(9, 18, 'Detective Somerset'),
(10, 9, 'Michael Corleone'),         -- El Padrino II
(10, 8, 'Vito Corleone (joven)'),    
(11, 19, 'Regan'),          -- El Exorcista
(11, 23, 'Padre Merrin'),
(12, 5,  'John McClane'),   -- Duro de matar 2
(12, 12, 'Holly Gennero'),
(13, 20, 'Peter Venkman'),  -- Los Cazafantasmas
(13, 21, 'Ray Stantz'),
(13, 4,  'Dana Barrett');

INSERT INTO usuarios (email, nombre, fecha_reg) VALUES
('ana@mail.com', 'Ana López', '2025-08-01'),
('bruno@mail.com', 'Bruno Díaz', '2025-08-02'),
('clara@mail.com', 'Clara Martínez', '2025-08-03'),
('diego@mail.com', 'Diego Pérez', '2025-08-06'),
('eva@mail.com',   'Eva Gómez',   '2025-08-07');

INSERT INTO visualizaciones (id_usuario, id_pelicula, fecha_vista, calificacion, comentario) VALUES
(1, 1, '2025-08-03', 9, 'Increíble historia y efectos'),
(1, 2, '2025-08-04', 10, 'Obra maestra'),
(2, 3, '2025-08-04', 7, 'Divertida y nostálgica'),
(3, 4, '2025-08-05', 8, 'Muy buena atmósfera'),
(2, 5, '2025-08-05', 9, 'Acción sin parar'),
(1, 6, '2025-08-06', 8, 'Secuela sólida'),
(2, 7, '2025-08-06', 9, 'Clásico del sci-fi'),
(3, 8, '2025-08-07', 9, 'Mítica'),
(4, 9, '2025-08-08', 8, 'Oscura y potente'),
(5,10, '2025-08-08',10, 'A la altura de la primera'),
(1,11, '2025-08-09', 7, 'Muy tensa'),
(2,12, '2025-08-09', 8, 'Buena acción'),
(3,13, '2025-08-10', 8, 'Divertidísima'),
(4, 7, '2025-08-10', 9, 'Visión futurista increíble'),
(5, 6, '2025-08-11', 7, 'Entretenida');

-- SELECT p.titulo,a.nombre,a.apellido,pa.rol FROM peliculas_actores pa JOIN actores a ON a.id_actor = pa.id_actor JOIN peliculas p ON pa.id_pelicula = p.id_pelicula;