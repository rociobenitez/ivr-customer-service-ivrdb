-- Create the integer cleaning function in which if a null enters, the function returns the value -999999
CREATE OR REPLACE FUNCTION `ivr_data.ivr.clean_integer`(input_integer INT64) AS (
  IF(input_integer IS NULL, -999999, input_integer)
);

-- Call the function with test values
WITH test_values AS (
  SELECT 123 AS input_value UNION ALL
  SELECT NULL AS input_value UNION ALL
  SELECT 456 AS input_value
)

-- Apply the function to the test values
SELECT
  input_value,
  `ivr_data.ivr.clean_integer`(input_value) AS cleaned_value
FROM test_values;