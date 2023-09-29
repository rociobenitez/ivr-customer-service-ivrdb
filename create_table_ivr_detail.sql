CREATE OR REPLACE TABLE `practica-keepcoding-400117.keepcoding.ivr_detail` AS
SELECT
  CAST(c.ivr_id AS STRING) AS calls_ivr_id,
  REGEXP_REPLACE(c.phone_number, '==$', '') AS calls_phone_number,
  c.ivr_result AS calls_ivr_result,
  c.vdn_label AS calls_vdn_label,
  c.start_date AS calls_start_date,
  FORMAT_DATE('%Y%m%d', EXTRACT(DATE FROM c.start_date)) AS calls_start_date_id,
  c.end_date AS calls_end_date,
  FORMAT_DATE('%Y%m%d', EXTRACT(DATE FROM c.end_date)) AS calls_end_date_id,
  c.total_duration AS calls_total_duration,
  c.customer_segment AS calls_customer_segment,
  c.ivr_language AS calls_ivr_language,
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
  s.document_type,
  REGEXP_REPLACE(s.document_identification, '==$', '') AS document_identification,
  s.customer_phone,
  s.billing_account_id
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