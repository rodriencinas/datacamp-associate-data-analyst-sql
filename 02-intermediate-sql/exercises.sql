-- CHAPTER 1. SELECTING DATA
-- VID 1: Consultar una base de datos
/*consultaremos una base de datos con las siguientes tablas:
* films
* people
* reviews
* roles*/

-- COUNT --> número de registros con un valor en un campo
SELECT COUNT(birthdate) AS count_birthdates
FROM people;

SELECT COUNT(name) AS count_names, COUNT(birthdate) AS count_birthdates
FROM people;

SELECT COUNT(*) --> count all records in a table 
-- * represents all fields

-- DISTINCT
SELECT DISTINCT language
FROM films;

-- DISTINCT + COUNT
SELECT COUNT(DISTINCT language) AS count_distinct_languages
FROM films;

-- VID 2: Ejecución de consulta
/*SQL is not processed inits written order
1- FROM
2- SELECT
3- LIMIT

también hemos visto depuración del código SQL (DEBUGGIN SQL), cómo entender los errores, los MÁS COMUNES SON:
* MISSPELLING
* INCORRECT CAPITALIZATION
* INCORRECT OR MISSING PUNCTUATION, ESPECIALLY COMMAS*/

-- VID 3: Estilo SQL
/*Entiendo que SQL es un lenguage de programación que no es estricto en cuanto al formato
muchas cosas que son requeridas en otros lenguages en SQL no afectan al código
como mayúsculas, sangrías, saltos de línes, etc*/
select title, release_year, country from films limit 3 --> funcinará, pero es más dificil de leer sobretodo si la query es larga

SELECT title, release_year, country
FROM films
LIMIT 3; --> más facil de leer

SELECT
  title,
  release_year,
  country
FROM films
LIMIT 3; --> más facil de leer

/*otras cosas importantes a tener en cuenta:
; --> el punto y coma al final de una oración, en POSTGRESQL no es requerido, pero es una práctica super útil, que nos ayudará a migrar de motor
no tenemos control sobre el código sql de otras personas, cuando crean nombres de campos con palabras separadas debemos hacer referencias a ella con doble "nombre campo"  */


-- CHAPTER 2. FILTERING RECORDS
-- VID 1: Filtering numbers
/*Para filtrar utilizaremos WHERE
Para ello utilizaremos operadores de comparación
>
>=
<
<=
=
<>*/
SELECT title
FROM films
WHERE release_year > 1960; --> todos los títulos de películas con año de lanzamiento mayor a 1960

SELECT title
FROM films
WHERE country = 'Japan';
-- Orden de ejecución:
/*FROM
WHERE
SELECT
LIMIT*/

-- VID 2: VARIOS CRITERIOS / MULTIPLE CRITERIA
/*a veces queremos filtrar por varios criterios distintos, lo haremos con algunas palabras claves:
* AND
* OR
* BETWEEN */
SELECT * 
FROM coats
WHERE color = 'red' OR length = 'short'; --> cuando necesitamos satisfacer al menos una condición

SELECT *
FROM coats
WHERE color = 'yellow' AND length = 'short'; --> cuando necesitamos satisfacer todas las condiciones

SELECT * 
FROM coats
WHERE buttons BETWEEN 1 AND 5;

--> debemos especificar el campo para cada condición:
SELECT title 
FROM films
WHERE release_year = 1994 OR release_year = 2000; --> correcto

-- AND, OR
SELECT title 
FROM films
WHERE (release_year = 1994 OR release_year = 1995)
  AND (certification = 'PG' OR certification = 'R'); --> con múltiples condiciones de filtrado, necesitamos encerrar las cláusulas entre paréntesis

-- BETWEEN, AND
SELECT title
FROM films
WHERE release_year >= 1994 AND release_year <= 2000; --> correcto

SELECT title
FROM films
WHERE release_year BETWEEN 1994 AND 2000; --> más fácil de leer

-- BETWEEN, AND, OR
SELECT title
FROM films
WHERE release_year BETWEEN 1994 AND 2000 AND country = 'UK';

-- VID 3: FILTERING TEXT / FILTRAR TEXTO
/*Con WHERE podemos filtrar texto exacto, pero hay mejores herramientas que hacen más versátil el filtrado por texto, a veces queremos encontrar PATRONES
* LIKE --> para encontrar patrones en texto, usamos comodines, el % y el _
* NOT LIKE
* IN
* NOT IN*/
SELECT name
FROM people
WHERE name LIKE 'Ade%';

SELECT name 
FROM people
WHERE name LIKE 'Ev_'

SELECT name
FROM people
WHERE name NOT LIKE 'A.%'

SELECT name 
FROM people
WHERE name LIKE '%r';

SELECT name 
FROM people
WHERE name LIKE '__t%';

SELECT title
FROM films
WHERE release_year IN (1920, 1930, 1940); --> va entre paréntesis

SELECT title
FROM films
WHERE country IN ('Germany', 'France', 'Spain'); --> podemos buscar la coincidencia de elementos como en listas

-- VID 4: NULL VALUES / VALORES NULOS
/*Vamos a ver cómo filtrar datos que incluyen valores NULL --> representa un valor faltante o desconocido
En el mundo real nuestras bases de datos probablemente tendrán campos vacíos por error humano o porque no hay información disponible*/
SELECT COUNT(*) AS count_records
FROM people; --> contamos todos los registros

--> forma rápida de ver cuántos datos fatan:
SELECT name
FROM people
WHERE birthdate IS NULL; --> verificamos qué nombres no tienen fecha de nacimiento

SELECT COUNT(*) AS no_birthdates
FROM people
WHERE birthdate IS NULL; --> recuento de registros sin fecha de nacimiento

--> a veces querremos filtrar por valores faltantes para obtener resultados que NO sean Null
SELECT COUNT(name) AS count_birthdates
FROM people
WHERE birthdate IS NOT NULL; --> IS NOT NULL filtra por registros SIN VALORES NULL

--> COUNT(field_name) vs IS NOT NULL ---> AMBOS CONTARÁN VALORES NO FALTANTES

-- CHAPTER 3. AGGREGATE FUNCTIONS
-- VID 1: Summarizing data
/*Aprenderemos a resumir datos con funciones de agregación
Una FUNCIÓN DE AGREGACIÓN/AGGREGATE FUNCTION realiza un cálculo sobre varios valores y devuelve un único valor. Aprenderemos:
AVG()/ SUM()/ MIN()/ MAX()/ COUNT()*/

-- Algunas de estas funciones las podemos usar en campos NO NUMERICOS O NON-NUMERICAL DATA
SELECT MIN(country)
FROM films; --> el string figurativamente más corto o de menor valor (A - Z)
SELECT MAX(country)
FROM films; --> el string figurativamente más largo o de mayor valor

--> En el conjunto de resultados en estos casos el nombre del campo por defecto es el nombre de la función, por lo que necesitamos ALIASING WHEN SUMMARIZING
SELECT MAX(country) AS min_country
FROM films;

-- VID 2: Summarizing subsets
/*Combinaremos nuestras habilidades de filtrado con nuestras nuevas habilidades de resumen
WHERE + AGGREGATE FUNCTIONS*/
--> a continuación el presupuesto promedio de las películas estrenadas desde 2010 inclusive en adelante
SELECT AVG(budget) AS avg_budget
FROM films
WHERE release_year >= 2010; --> WHERE clause execute before the SELECT statement

SELECT MIN(budget) AS min_budget
FROM films
WHERE release_year = 2010;

SELECT MAX(budget) AS max_budget
FROM films
WHERE release_year = 2010;

SELECT SUM(budget) AS sum_budget
FROM films
WHERE release_year = 2010;

SELECT COUNT(budget) AS count_budget
FROM films
WHERE release_year = 2010;

--> Probablemente querramos limpiar algunos de los decimales locos que puedan aparecer, lo hacemos con ROUND() function
--> ROUND(number_to_round, decimal_places) ---> 2 argumentos
SELECT ROUND(AVG(budget), 2) AS avg_budget
FROM films
WHERE release_year >= 2010;

SELECT ROUND(AVG(budget)) AS avg_budget
FROM films
WHERE release_year >= 2010; --> El segundo parámetro de ROUND es opcional, si no lo ponemos redondea a un número ENTERO

--> segundo parámetro con VALOR NEGATIVO redondea hacia la IZQUIERDA del punto decimal
SELECT ROUND(AVG(budget), -5) AS avg_budget
FROM films
WHERE release_year >= 2010;

-- VID 3: Aliasing and arithmetic
/*Aprenderemos a usar más aritmética en nuestras consultas y analizaremos más de cerca el alias con AS
Arithmetic -> + / - / * / */
SELECT (4 + 3);
SELECT (4 - 3);
SELECT (4 / 3); ---> la división da como resultado 1 porque dividimos ENTERO/ENTERO
SELECT (4.0 / 3.0)
SELECT (4 * 3);

-- Aggregate functions vs arithmetic 
/*AGGREGATE FUNCTIONS --> REALIZAN OPERACIONES VERTICALMENTE, ES DECIR EN EL CAMPO O COLUMNA
ARITHMETIC --> SUMA REGISTROS HORIZONTALMENTE*/
SELECT (gross - budget) AS profit
FROM films; ---> recaudación - presupuesto = cantidad de beneficio (operación horizontal)

---> Resulta importante colocar ALIAS en las funciones que utilicemos
SELECT MAX(budget) AS max_budget,
    MAX(duration) AS max_duration
FROM films;

-- CHAPTER 4. SORTING AND GROUPING
-- VID 1: Sorting results
/*Aprenderemos a agrupar y ordenar resultados para obtener más información*/
---> Sorting results significa que queremos poner nuestros datos en un orden específico usando ORDER BY
SELECT title, budget
FROM films
ORDER BY budget; ---> de manera predeterminada orderna los valores de la columna indicada en orden ASCENDENTE

SELECT title, budget
FROM films
ORDER BY title;

SELECT title, budget
FROM films
ORDER BY budget ASC; ---> mismo resultado que por defecto, pero MÁS LEGIBLE

SELECT title, budget
FROM films
ORDER BY budget DESC; ---> DESC ordenará los resultados en orden DESCENDENTE

SELECT title, budget
FROM films
WHERE budget IS NOT NULL
ORDER BY budget DESC; ---> filtramos registros con valores NO NULOS

---> ORDER BY multiple fields --> ORDER BY field_one, field_two
SELECT title, budget
FROM films
ORDER BY budget DESC, title ASC

SELECT title, wins
FROM films
ORDER BY wins DESC; ---> Aquí seguramente obtendremos un EMPATE, por lo que sería útil utilizar un campo más para desempatar

SELECT title, wins, imdb_score
FROM films
ORDER BY wins DESC, imdb_score DESC

-- VID 2: Grouping data
/*Aprendimos a ordenar nuestros datos, veremos cómo agruparlos
En el mundo real a menudo necesitaremos resumir nuestros datos para un grupo particular de resultados
SQL nos permite agrupar con la cláusula GROUP BY*/
SELECT certification, COUNT(title) AS title_count
FROM films
GROUP BY certification; ---> GROUP BY colapsa las filas, por lo que es necesario aplicarles uns función de agregación

--> Podemos agrupar en múltiples campos
SELECT certification, language, COUNT(title) AS title_count
FROM films
ORDER BY certification, language;

--> GROUP BY + ORDER BY --> podemos agrupar nuestros resultados, hacer un cálculo y luego ordenar nuestros resultados
SELECT 
  certification,
  COUNT(title) AS title_count
FROM films
GROUP BY certification
ORDER BY title_count DESC; ---> observamos que podemos usar el ALIAS del campo ya que se ejecuta primero y luego el ORDER BY

-- VID 3: Filtering grouped data
/*Combinaremos FILTRADO + AGRUPACIÓN
En SQL NO podemos filtrar funciones agregadas con cláusulas WHERE
Los GRUPOS TIENEN SU PROPIA PALABRA ESPECIAL PARA FILTRADO ---> HAVING*/
SELECT 
  release_year,
  COUNT(title) AS title_count
FROM films
GROUP BY release_year
HAVING COUNT(title) > 10; ---> muestra solo aqullos años en los que se estrenaron más de diez películas

/*La razón por la que los grupos tiene su propia palabra clave para filtrar se reduce al ORDEN DE EJECUCIÓN*/
SELECT --> 5
  certification,
  COUNT(title) AS title_count
FROM films --> 1
WHERE certification IN ("G", "PG", "PG-13") --> 2
GROUP BY certification --> 3
HAVING COUNT(title) > 500 --> 4
ORDER BY title_count DESC --> 6
LIMIT 3; --> 7

--> en qué año la duración media de una película fue superior a dos horas?
SELECT release_year, AVG(duration) AS avg_duration
FROM films
GROUP BY release_year
HAVING AVG(duration) > 120
ORDER BY release_year ASC;

SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
-- Order the results from highest to lowest average gross and limit to one
ORDER BY avg_gross DESC
LIMIT 1;