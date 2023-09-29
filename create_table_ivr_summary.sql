CREATE OR REPLACE TABLE `practica-keepcoding-400117.keepcoding.ivr_summary` AS
SELECT 
  d.calls_ivr_id AS ivr_id,
  d.calls_phone_number AS phone_number,
  d.calls_ivr_result AS ivr_result,
  CASE
    WHEN d.calls_vdn_label LIKE 'FRONT%' THEN 'ATC'
    WHEN d.calls_vdn_label LIKE 'TECH%' THEN 'TECH'
    WHEN d.calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
    ELSE 'RESTO'
  END AS vdn_aggregation,
  d.calls_start_date AS start_date,
  d.calls_end_date AS end_date,
  d.calls_total_duration AS total_duration,
  d.calls_customer_segment AS customer_segment,
  d.calls_ivr_language AS ivr_language,
  d.calls_steps_module AS steps_module,
  d.calls_module_aggregation AS module_aggregation,
  d.document_type,
  d.document_identification,
  d.customer_phone,
  d.billing_account_id,
  CASE
    WHEN d.module_name = 'AVERIA_MASIVA' THEN 1
    ELSE 0
  END AS masiva_lg,
  CASE
    WHEN (d.step_name = 'CUSTOMERINFOBYPHONE.TX' 
        AND NULLIF(d.step_description_error, 'NULL') IS NULL) THEN 1
    ELSE 0
  END AS info_by_phone_lg,
  CASE
    WHEN (d.step_name = 'CUSTOMERINFOBYDNI.TX'
        AND NULLIF(d.step_description_error, 'NULL') IS NULL) THEN 1
    ELSE 0
  END AS info_by_dni_lg,
IF(prev_call_date IS NOT NULL, 1, 0) AS repeated_phone_24H,
IF(next_call_date IS NOT NULL, 1, 0) AS cause_recall_phone_24H
FROM (
  SELECT
    calls_ivr_id,
    calls_phone_number,
    calls_start_date AS call_date,
    LAG(calls_start_date) OVER (PARTITION BY calls_phone_number
        ORDER BY calls_start_date) AS prev_call_date,
    LEAD(calls_start_date) OVER (PARTITION BY calls_phone_number
        ORDER BY calls_start_date) AS next_call_date
    FROM `practica-keepcoding-400117.keepcoding.ivr_detail`
) AS CallsWithTimestamp
JOIN `practica-keepcoding-400117.keepcoding.ivr_detail` AS d
ON CallsWithTimestamp.calls_ivr_id = d.calls_ivr_id;