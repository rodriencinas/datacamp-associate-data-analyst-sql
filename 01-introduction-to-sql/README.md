# Curso 01 — Introduction to SQL

🔗 [Ver en DataCamp](https://www.datacamp.com/courses/introduction-to-sql)  
⏱️ Duración: ~2 horas  
✅ **Estado: Completado**

---

## 📖 Descripción

Aprende a crear y consultar bases de datos relacionales usando SQL. Este curso introductorio cubre los fundamentos para recuperar y filtrar datos de tablas.

---

## 📚 Contenido del Curso

### Capítulo 1 — Relational Databases
- Qué es una base de datos relacional
- Tablas, filas y columnas
- Tipos de datos en SQL

### Capítulo 2 — Querying
- `SELECT` y `FROM`
- Seleccionar múltiples columnas / todas las columnas (`*`)
- `LIMIT` para restringir resultados
- `DISTINCT` para valores únicos
- `AS` para alias / renombrar columnas
- Vistas (`CREATE VIEW`)

---

## 🗃️ Base de Datos Usada

**`films`** — Base de datos de películas con columnas como `title`, `release_year`, `country`, `duration`, `language`, `certification`, `gross`, `budget`.

---

## 💡 Conceptos Clave

```sql
-- Estructura básica de una query
SELECT column1, column2
FROM table_name;

-- Seleccionar todo
SELECT *
FROM films;

-- Limitar resultados
SELECT title
FROM films
LIMIT 10;

-- Valores únicos
SELECT DISTINCT country
FROM films;

-- Alias
SELECT title AS movie_title
FROM films;
```

---

## 📝 Notas Personales

> Completado. La base es más intuitiva de lo que esperaba. El concepto de "vista" (VIEW) fue lo más nuevo para mí.
