CREATE OR REPLACE TABLE `practica-keepcoding-400117.keepcoding.ivr_detail` AS
SELECT
  c.ivr_id AS calls_ivr_id,
  REGEXP_REPLACE(c.phone_number, '==$', '') AS calls_phone_number,
  c.ivr_result AS calls_ivr_result,
  c.vdn_label AS calls_vdn_label,
  c.start_date AS calls_start_date,
  CAST(FORMAT_DATE('%Y%m%d', EXTRACT(DATE FROM c.start_date)) AS INT64) AS calls_start_date_id,
  c.end_date AS calls_end_date,
  CAST(FORMAT_DATE('%Y%m%d', EXTRACT(DATE FROM c.end_date)) AS INT64) AS calls_end_date_id,
  c.total_duration AS calls_total_duration,
  c.customer_segment AS calls_customer_segment,
  CASE
    WHEN c.ivr_language = 'CAT' THEN 'Catalán'
    WHEN c.ivr_language = 'STANDARD' THEN 'Estándar'
    WHEN c.ivr_language = 'ESP' THEN 'Español'
    WHEN c.ivr_language = 'ENG' THEN 'Inglés'
    ELSE 'Desconocido'
  END AS calls_ivr_language,
  c.steps_module AS calls_steps_module,
  c.module_aggregation AS calls_module_aggregation,
  m.module_sequece AS module_sequence,
  m.module_name,
  m.module_duration,
  m.module_result,
  s.step_sequence,
  s.step_name,
  s.step_result,
  s.step_description_error,
  COALESCE(NULLIF(s.document_type, 'NULL'), 'DESCONOCIDO') AS document_type,
  CASE
    WHEN s.document_identification = 'NULL' THEN 'DESCONOCIDO'
    ELSE REGEXP_REPLACE(s.document_identification, '==$', '')
  END AS document_identification,
  COALESCE(NULLIF(s.customer_phone, 'NULL'), 'DESCONOCIDO') AS customer_phone,
  COALESCE(NULLIF(s.billing_account_id, 'NULL'), 'DESCONOCIDO') AS billing_account_id

FROM
  `practica-keepcoding-400117.keepcoding.ivr_calls` AS c
LEFT JOIN
  `practica-keepcoding-400117.keepcoding.ivr_modules` AS m
ON
  c.ivr_id = m.ivr_id
LEFT JOIN
  `practica-keepcoding-400117.keepcoding.ivr_steps` AS s
ON
  m.ivr_id = s.ivr_id AND m.module_sequece = s.module_sequece;