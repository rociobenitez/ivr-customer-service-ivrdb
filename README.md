# IVR Data Model - Advanced SQL Practice

Este proyecto consiste en modelar un **sistema de respuesta de voz interactiva (IVR) mediante SQL avanzado.** Incluye creación de tablas, generación de indicadores y una función de limpieza de datos, utilizando múltiples fuentes de entrada.

## Tecnologías utilizadas

- **Lenguaje**: SQL (sintaxis compatible con Google BigQuery y PostgreSQL)
- **Entorno de desarrollo**: Google BigQuery Console / PostgreSQL (local)
- **Editor**: Visual Studio Code con extensión SQL (opcional)
- **Base de datos simulada**: ivr (nombre del schema)

## Estructura del repositorio

- `data/`: contiene los archivos .csv simulados
- `sql/`: scripts SQL organizados por ejercicio

## Descripción de los ejercicios

### 1. Creación de la tabla `ivr_detail`

Combina tres tablas (`ivr_calls`, `ivr_modules`, `ivr_steps`) mediante `LEFT JOIN` y genera columnas derivadas con:

- `FORMAT_DATE()`, `CAST()`, `REGEXP_REPLACE()`
- Agregaciones y limpieza de campos

### 2. Creación de la tabla `ivr_summary`

Resumen por llamada con campos calculados y flags como:

- `masiva_lg`, `info_by_dni_lg`, `repeated_phone_24H`
- Agregaciones y condiciones usando `CASE`, `WHEN`, `COALESCE`

### 3. Función `clean_integer()`

Función simple que reemplaza `NULL` por `-999999`.

<br>

> ✍🏼 _Proyecto realizado como parte de una práctica formativa. El dataset y los ejercicios han sido adaptados y organizados para fines de aprendizaje individual y portfolio._
