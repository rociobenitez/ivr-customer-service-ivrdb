CREATE OR REPLACE TABLE `ivr_data.ivr.ivr_summary` AS
SELECT 
  d.calls_ivr_id AS ivr_id,
  d.calls_phone_number AS phone_number,
  MAX(d.calls_ivr_result) AS ivr_result,
  MAX(
    CASE
      WHEN d.calls_vdn_label LIKE 'FRONT%' THEN 'ATC'
      WHEN d.calls_vdn_label LIKE 'TECH%' THEN 'TECH'
      WHEN d.calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
      ELSE 'RESTO'
    END
  ) AS vdn_aggregation,
  MAX(d.calls_start_date) AS start_date,
  MAX(d.calls_end_date) AS end_date,
  SUM(d.calls_total_duration) AS total_duration,
  MAX(d.calls_customer_segment) AS customer_segment,
  MAX(d.calls_ivr_language) AS ivr_language,
  MAX(d.calls_steps_module) AS steps_module,
  MAX(d.calls_module_aggregation) AS module_aggregation,
  MAX(d.document_type) AS document_type,
  MAX(d.document_identification) AS document_identification,
  MAX(d.customer_phone) AS customer_phone,
  MAX(d.billing_account_id) AS billing_account_id,
  MAX(
    CASE
      WHEN d.module_name = 'AVERIA_MASIVA' THEN 1
      ELSE 0
    END
  ) AS masiva_lg,
  MAX(
    CASE
      WHEN (d.step_name = 'CUSTOMERINFOBYPHONE.TX' 
          AND NULLIF(d.step_description_error, 'NULL') IS NULL) THEN 1
      ELSE 0
    END
  ) AS info_by_phone_lg,
  MAX(
    CASE
      WHEN (d.step_name = 'CUSTOMERINFOBYDNI.TX'
          AND NULLIF(d.step_description_error, 'NULL') IS NULL) THEN 1
      ELSE 0
    END
  ) AS info_by_dni_lg,
  MAX(IF(prev_call_date IS NOT NULL, 1, 0)) AS repeated_phone_24H,
  MAX(IF(next_call_date IS NOT NULL, 1, 0)) AS cause_recall_phone_24H
FROM (
  SELECT
    calls_ivr_id,
    calls_phone_number,
    calls_start_date AS call_date,
    LAG(calls_start_date) OVER (PARTITION BY calls_phone_number
        ORDER BY calls_start_date) AS prev_call_date,
    LEAD(calls_start_date) OVER (PARTITION BY calls_phone_number
        ORDER BY calls_start_date) AS next_call_date
    FROM `ivr_data.ivr.ivr_detail`
) AS CallsWithTimestamp
JOIN `ivr_data.ivr.ivr_detail` AS d
ON CallsWithTimestamp.calls_ivr_id = d.calls_ivr_id
GROUP BY ivr_id, phone_number;