# Proyecto SQL – Sistema de Gestión de Películas 🎬

## Descripción

Este proyecto consiste en el diseño e implementación de una base de datos relacional para la gestión de películas, actores, usuarios y visualizaciones.  
El objetivo es simular una plataforma de streaming, permitiendo almacenar información organizada y realizar consultas complejas para obtener estadísticas, rankings y reportes.

## Contenido del repositorio

- **`creacion_tablas.sql`** → Script con la creación del esquema `peliculas_app` y todas las tablas con sus claves primarias y foráneas.  
- **`datos.sql`** → Script con datos de prueba (categorías, películas, actores, usuarios, visualizaciones).  
- **`vistas/`** → Conjunto de vistas creadas para consultas frecuentes (ranking de películas, actividad de usuarios, catálogo, etc.).  
- **`funciones/`** → Funciones personalizadas (edad de actor, promedio de calificación, total de vistas por usuario, etc.).  
- **`stored_procedures/`** → Procedimientos almacenados para inserciones y búsquedas (ej. cargar visualización, top de películas, historial por usuario).  
- **`triggers/`** → Validaciones y restricciones automáticas (ej. evitar calificaciones fuera de rango, impedir borrado de actores en uso).  
- **`peliculas_anastasio.pdf`** → Documento con la descripción del proyecto, diagrama entidad–relación, listado de tablas y entregas.

## Modelo entidad–relación

El modelo diseñado contempla:

- **Películas** (con título, duración, año y categoría).  
- **Categorías** (acción, drama, comedia, etc.).  
- **Actores** (nombre, apellido, fecha de nacimiento).  
- **Usuarios** (nombre, email, fecha de registro).  
- **Visualizaciones** (qué película vio un usuario, cuándo, calificación y comentario).  
- **Tabla intermedia `peliculas_actores`** para modelar la relación muchos a muchos.

## Entregas

### Entrega 1
- Introducción y objetivos del proyecto.  
- Diagrama entidad–relación.  
- Listado de tablas con campos, claves y tipos de datos.  
- Script SQL con creación del esquema y tablas.  

### Entrega 2
- Vistas con su descripción y objetivo de uso.  
- Funciones personalizadas.  
- Stored Procedures para operaciones frecuentes.  
- Triggers de validación e integridad.  
- Scripts de prueba para validar cada objeto de la base de datos.

## Cómo ejecutar

1. Crear la base de datos ejecutando el script:
   ```sql
   source creacion_tablas.sql;
   ```

2. Cargar datos de prueba:
   ```sql
   source datos.sql;
   ```

3. Crear vistas, funciones, stored procedures y triggers desde sus carpetas respectivas.

4. Ejecutar los scripts de prueba (`SELECT` y `CALL`) para verificar el funcionamiento.

## Autor

- **Matías Anastasio**  
  Proyecto Final – Curso de SQL  
