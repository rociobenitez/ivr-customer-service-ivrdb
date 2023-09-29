# Modelo de Datos para IVR de Atención al Cliente 🗣️

Este proyecto muestra tres ejercicios relacionados con la creación de tablas y una función en SQL para el modelo de datos de un IVR (Interactive Voice Response) de atención al cliente. El objetivo principal es trabajar con los archivos `ivr_calls`, `ivr_modules`, e `ivr_steps` para crear tablas en una base de datos llamada `keepcoding`.

## Ejercicio 1: Creación de la Tabla ivr_detail 🧾

En este ejercicio, se crea una tabla llamada `ivr_detail` que forma parte del modelo de datos del IVR. Se utilizan una serie de campos y funciones SQL para realizar esta tarea. Las funciones utilizadas incluyen `CAST()`, `FORMAT_DATE('%Y%m%d', EXTRACT(DATE FROM c.start_date))` para trabajar con fechas y `REGEXP_REPLACE(s.document_identification, '==$', '')` para eliminar la cadena '==' que a menudo se añade cuando se codifica un tipo de dato. Las tres tablas, `ivr_calls`, `ivr_modules`, e `ivr_steps`, se unen mediante dos LEFT JOIN para completar el ejercicio.

## Ejercicio 2: Creación de la Tabla ivr_summary 🧾

En este ejercicio, se crea la tabla `ivr_summary`, que actúa como un resumen de la llamada y contiene los indicadores más importantes de cada llamada. Esta tabla está diseñada para tener un único registro por llamada.

## Ejercicio 3: Creación de una Función de Limpieza de Enteros 🧼

En el último ejercicio, se desarrolla una función de limpieza de enteros que, cuando se le pasa un valor NULL, devuelve el valor -999999. Esto puede ser útil para garantizar la integridad de los datos en la base de datos.

## Requisitos ✅

- Sistema de Gestión de Base de Datos (DBMS) compatible con SQL.
- Acceso a los archivos `ivr_calls`, `ivr_modules`, e `ivr_steps` para cargar los datos.

## Skills Adquiridas 🚀

Durante el desarrollo de este proyecto, se han adquirido y aplicado varias habilidades y funciones de SQL, incluyendo:

- [CASE WHEN](https://cloud.google.com/bigquery/docs/reference/standard-sql/conditional_expressions#case)
- [COALESCE](https://cloud.google.com/bigquery/docs/reference/standard-sql/conditional_expressions#coalesce)
- [LAG()](https://cloud.google.com/bigquery/docs/reference/standard-sql/analytic-function-syntax#lag)
- [LEAD()](https://cloud.google.com/bigquery/docs/reference/standard-sql/analytic-function-syntax#lead)
- [REGEXP_REPLACE()](https://cloud.google.com/bigquery/docs/reference/standard-sql/string_functions#regexp_replace)
- [EXTRACT(DATE FROM)](https://cloud.google.com/bigquery/docs/reference/standard-sql/date_functions#extract)
- [CAST()](https://cloud.google.com/bigquery/docs/reference/standard-sql/conversion_functions#cast)

---

Hecho con :heart: por Rocío
