-- ============================================================
-- CURSO 02: Intermediate SQL
-- DataCamp — Associate Data Analyst in SQL
-- ============================================================
-- Base de datos: films
-- ============================================================


-- ============================================================
-- CAPÍTULO 1: Selecting Data
-- ============================================================

-- Contar total de películas en la base
SELECT COUNT(*) AS total_films
FROM films;

-- Suma de todos los presupuestos
SELECT SUM(budget) AS total_budget
FROM films;

-- Promedio de duración
SELECT AVG(duration) AS avg_duration
FROM films;

-- Película más antigua y más reciente
SELECT MIN(release_year) AS oldest,
       MAX(release_year) AS newest
FROM films;

-- ROUND: promedio de presupuesto redondeado a 2 decimales
SELECT ROUND(AVG(budget), 2) AS avg_budget
FROM films;


-- ============================================================
-- CAPÍTULO 2: Filtering Records
-- ============================================================

-- Películas del año 2000 en adelante
SELECT title, release_year
FROM films
WHERE release_year >= 2000;

-- Películas en inglés con certificación PG-13
SELECT title, certification
FROM films
WHERE language = 'English'
  AND certification = 'PG-13';

-- Películas de USA o UK
SELECT title, country
FROM films
WHERE country = 'USA'
   OR country = 'UK';

-- BETWEEN: películas entre 2000 y 2015
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 2000 AND 2015;

-- IN: múltiples países
SELECT title, country
FROM films
WHERE country IN ('USA', 'UK', 'France', 'Germany');

-- LIKE: títulos que empiezan con "The"
SELECT title
FROM films
WHERE title LIKE 'The%';

-- LIKE: títulos con exactamente un caracter antes de "at"
SELECT title
FROM films
WHERE title LIKE '_at%';

-- NOT LIKE: excluir títulos que empiezan con "A"
SELECT title
FROM films
WHERE title NOT LIKE 'A%';

-- IS NULL: películas sin presupuesto registrado
SELECT title
FROM films
WHERE budget IS NULL;

-- IS NOT NULL: películas con presupuesto registrado
SELECT title, budget
FROM films
WHERE budget IS NOT NULL
ORDER BY budget DESC
LIMIT 10;


-- ============================================================
-- CAPÍTULO 3: Aggregate Functions
-- ============================================================

-- Contar películas por año de lanzamiento
SELECT release_year,
       COUNT(*) AS films_released
FROM films
GROUP BY release_year
ORDER BY release_year;

-- Promedio de presupuesto por país
SELECT country,
       ROUND(AVG(budget), 2) AS avg_budget
FROM films
WHERE budget IS NOT NULL
GROUP BY country
ORDER BY avg_budget DESC
LIMIT 10;

-- HAVING: países con más de 500 películas
SELECT country,
       COUNT(*) AS total_films
FROM films
GROUP BY country
HAVING COUNT(*) > 500
ORDER BY total_films DESC;


-- ============================================================
-- CAPÍTULO 4: Sorting and Grouping
-- ============================================================

-- Orden descendente por ingresos brutos
SELECT title, gross
FROM films
WHERE gross IS NOT NULL
ORDER BY gross DESC
LIMIT 10;

-- Ordenar por múltiples columnas
SELECT release_year, title, gross
FROM films
WHERE gross IS NOT NULL
ORDER BY release_year DESC, gross DESC;

-- Consulta completa combinando todo
-- Top años con mejor promedio de ingresos (mínimo 10 películas)
SELECT release_year,
       COUNT(*) AS total_films,
       ROUND(AVG(gross), 2) AS avg_gross
FROM films
WHERE gross IS NOT NULL
GROUP BY release_year
HAVING COUNT(*) >= 10
ORDER BY avg_gross DESC
LIMIT 10;
