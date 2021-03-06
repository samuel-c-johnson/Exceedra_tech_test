CREATE DATABASE exceedra_test;

CREATE TABLE products (
  row_ID INTEGER NOT NULL,
  product varchar(max) NOT NULL,
  customer varchar(max) NOT NULL,
  measure varchar(max) NOT NULL,
  value FLOAT NOT NULL,
  valid_from_day DATE,
  valid_to_day DATE
);

INSERT INTO products (row_ID, product, customer, measure, value, valid_from_day, valid_to_day)
VALUES (1, 'Widgets', 'Tesco', 'Gross Sales Price', 1, '20130101', '20130401'),
       (2, 'Widgets', 'Tesco', 'Gross Sales Price', 1.5, '20130301', '20131231'),
       (3, 'Widgets', 'Tesco', 'Gross Sales Price', 2, '20130401', '20150101'),
       (4, 'Widgets', 'Tesco', 'Distribution Cost', 5, '20130101', '20130401'),
       (5, 'Widgets', 'Tesco', 'Distribution Cost', 6, '20130301', '20140401'),
       (6, 'Widgets', 'Tesco', 'Distribution Cost', 7, '20131231', '20150101'),
       (7, 'Widgets', 'Asda', 'Gross Sales Price', 100, NULL, NULL),
       (8, 'Widgets', 'Asda', 'Gross Sales Price', 200, '20131231', '20150101'),
       (9, 'Widgets', 'Asda', 'Distribution Cost', 2, '20130301', '20131231'),
       (10, 'Widgets', 'Asda', 'Distribution Cost', 100, '20140401', '20150101');

-- A. Identify which pairs of rows have identical Products, Customers and Measures, and overlapping date ranges
SELECT  row_ID, product, customer, measure, valid_from_day, valid_to_day
  LEAD (product) OVER (ORDER BY row_ID) AS next_product,
  LEAD (customer) OVER (ORDER BY row_ID) AS next_customer,
  LEAD (measure) OVER (ORDER BY row_ID) AS next_measure,
  LEAD (valid_from_day) OVER (ORDER BY row_ID) AS next_valid_from_day
INTO #overlapping_dates
FROM products
WHERE product = next_product
AND customer = next_customer
AND measure = next_measure
AND valid_to_day > next_valid_from_day;

-- B. 	Of the rows identified in part A, update the rows to make the date ranges not overlap
UPDATE #overlapping_dates
SET valid_to_day = DATEADD(day, -1, next_valid_from_day)
WHERE product = next_product
AND customer = next_customer
AND measure = next_measure
AND valid_to_day > next_valid_from_day;








 
