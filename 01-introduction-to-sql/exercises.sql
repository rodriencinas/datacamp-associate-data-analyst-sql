-- ver todos los registros de la tabla films
SELECT *
FROM films;

-- ver solo los títulos de las películas
SELECT title
FROM films;

-- ver título y año de lanzamiento
SELECT title, release_year
FROM films;

-- ver nombre y fecha de nacimiento de personas
SELECT name, birthdate
FROM people;

-- DISTINCT países únicos en la base de datos
SELECT DISTINCT country
FROM films;

-- DISTINCT idiomas únicos
SELECT DISTINCT language
FROM films;

-- LIMIT las primeras 10 películas
SELECT *
FROM films
LIMIT 10;

-- Combinando DISTINCT y LIMIT
SELECT DISTINCT country
FROM films
LIMIT 5;

-- COUNT contar registros
SELECT COUNT(*) AS total_films
FROM films;

-- COUNT con columna específica (excluye NULL)
SELECT COUNT(birthdate) AS count_birthdates
FROM people;

-- COUNT DISTINCT: cuántos países únicos hay
SELECT COUNT(DISTINCT country) AS total_countries
FROM films;

-- AS alias para renombrar columnas en el resultado
SELECT title AS movie_title,
       release_year AS year,
       country AS origin
FROM films
LIMIT 15;
