"BOOKING_FK",
"ORDER_FK",
"CUSTOMER_PK",
"CUSTOMER_ID",
"LOAD_DATE",
"RECORD_SOURCE",
"CUSTOMER_DOB",
"CUSTOMER_NAME",
"NATIONALITY",
"PHONE",
"TEST_COLUMN_2",
"TEST_COLUMN_3",
"TEST_COLUMN_4",
"TEST_COLUMN_5",
"TEST_COLUMN_6",
"TEST_COLUMN_7",
"TEST_COLUMN_8",
"TEST_COLUMN_9",
"BOOKING_DATE",
CONCAT(
    CUSTOMER_NAME, '||',
    CUSTOMER_DOB, '||',
    PHONE
) AS "CUSTOMER_DETAILS",
'STG_BOOKING' AS "SOURCE",
LOAD_DATE AS "EFFECTIVE_FROM"