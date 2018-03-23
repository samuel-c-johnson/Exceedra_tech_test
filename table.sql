CREATE DATABASE exceedra_test;

CREATE TABLE products (
  Row_ID INTEGER NOT NULL,
  Product varchar(max) NOT NULL,
  Customer varchar(max) NOT NULL,
  Measure varchar(max) NOT NULL,
  Value FLOAT NOT NULL,
  Valid_from_day DATE NOT NULL,
  Valid_to_day DATE NOT NULL
);

INSERT INTO products (Row_ID, Product, Customer, Measure, Value, Valid_from_day, Valid_to_day)
VALUES (1, 'Widgets', 'Tesco', 'Gross Sales Price', 1, '20130101', '20130401'),
       (2, 'Widgets', 'Tesco', 'Gross Sales Price', 1.5, '20130301', '20131231'),
       (3, 'Widgets', 'Tesco', 'Gross Sales Price', 2, '20130401', '20150101'),
       (4, 'Widgets', 'Tesco', 'Distribution Cost', 5, '20130101', '20130401'),
       (5, 'Widgets', 'Tesco', 'Distribution Cost', 6, '20130301', '20140401'),
       (6, 'Widgets', 'Tesco', 'Distribution Cost', 7, '20131231', '20150101'),
       (7, 'Widgets', 'Asda', 'Gross Sales Price', 100, '00000000', '99999999'),
       (8, 'Widgets', 'Asda', 'Gross Sales Price', 200, '20131231', '20150101'),
       (9, 'Widgets', 'Asda', 'Distribution Cost', 2, '20130301', '20131231'),
       (10, 'Widgets', 'Asda', 'Distribution Cost', 100, '20140401', '20150101');








 
