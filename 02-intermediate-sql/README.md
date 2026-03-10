# Curso 02 — Intermediate SQL

🔗 [Ver en DataCamp](https://www.datacamp.com/courses/intermediate-sql)  
⏱️ Duración: ~4 horas  
🔄 **Estado: En progreso**

---

## 📖 Descripción

Este curso cubre todo lo necesario para analizar datos con SQL: filtrado avanzado, agregaciones, ordenamiento y manejo de valores NULL. Se trabaja con bases de datos reales.

---

## 📚 Contenido del Curso

### Capítulo 1 — Selecting Data
- `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- Redondeo con `ROUND()`

### Capítulo 2 — Filtering Records
- `WHERE` con operadores de comparación
- `WHERE` con `AND`, `OR`, `BETWEEN`, `IN`
- `LIKE`, `NOT LIKE` y comodines (`%`, `_`)
- Filtrar `NULL` con `IS NULL` / `IS NOT NULL`

### Capítulo 3 — Aggregate Functions
- `GROUP BY` para agrupar resultados
- `HAVING` para filtrar grupos

### Capítulo 4 — Sorting and Grouping
- `ORDER BY` (ASC / DESC)
- Combinar `GROUP BY`, `HAVING` y `ORDER BY`

---

## 🗃️ Base de Datos Usada

**`films`** — Base de datos de películas con información de ingresos, presupuesto, duración, géneros, países y más.

---

## 💡 Conceptos Clave

```sql
-- Funciones de agregación
SELECT AVG(budget) AS avg_budget,
       MAX(gross) AS max_gross,
       MIN(release_year) AS oldest_film
FROM films;

-- ROUND: redondear a 2 decimales
SELECT ROUND(AVG(budget), 2) AS avg_budget
FROM films;

-- WHERE con múltiples condiciones
SELECT title, release_year
FROM films
WHERE release_year >= 2000
  AND language = 'English';

-- BETWEEN (inclusivo en ambos extremos)
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 2000 AND 2010;

-- IN: equivale a varios OR
SELECT title
FROM films
WHERE country IN ('USA', 'UK', 'Australia');

-- LIKE: búsqueda de patrones
-- % = cualquier cantidad de caracteres
-- _ = exactamente un caracter
SELECT title
FROM films
WHERE title LIKE 'Star%';

-- IS NULL / IS NOT NULL
SELECT title
FROM films
WHERE budget IS NOT NULL;

-- GROUP BY + agregación
SELECT release_year,
       COUNT(*) AS films_per_year
FROM films
GROUP BY release_year
ORDER BY release_year DESC;

-- HAVING: filtra después de agrupar
SELECT release_year,
       AVG(budget) AS avg_budget
FROM films
GROUP BY release_year
HAVING AVG(budget) > 60000000
ORDER BY avg_budget DESC;
```

---

## 📝 Notas Personales

> En progreso. La diferencia entre WHERE (filtra filas) y HAVING (filtra grupos) fue clave.
> Vamos avanzando a paso firme, con buena base teórica y práctica. Se completó un 50% del curso y hubieron muchísimas palabras claves nuevas, filtrado con distintos tipos de datos aplicando varias técnicas.
