# Exceedra tech test

## Description

Create a process which solves parts A and B below; and then answer part C. Document your work using either a flowchart, pseudo-code, a written sequence of steps, or a programming language you are familiar with. The table below is example data, but your solution should be generic and hence applicable to any data supplied in this format.

  A.	Identify which pairs of rows have identical Products, Customers and Measures, and overlapping date ranges; e.g., as per rows 1 and 2.

  B.	Of the rows identified in part A, update the rows to make the date ranges not overlap.

  C.	Document any assumptions or decisions you needed to make for your solution.

  ![table](./Images/Table1.png)

## Ideas and Assumptions

It took some time to decide on my approach for this task. By looking at the data I assume that the table is from a relational database. This is because of the unique ROW IDs in the first column. Also the format of the dates in the final two columns adheres to the format used for storing dates in a database.
Using this information I decided to use SQL to approach the task as this is a standard language for storing, (but more importantly in this case) manipulating and retrieving data from a database.

Studying the table I noticed certain relationships between the data, predominantly in the Customer and Measure columns. All the rows in the table have a unique Row ID but all have the same product 'Widgets'. I can also see that the Valid From and Valid To dates from Row ID '7' are not actual dates and I can assume that these are NULL values. I imagine that the entries are not simply left blank potentially due to a NOT NULL constraint on the column where by default a column cannot accept an empty or Null value.

To better understand and to help visualize these relationships I split the data into 4 groups. I have changed the date format slightly to make it easier to read. This provided me with a clear representation of the data, especially the overlapping dates which aided in formulating my approach.



Tesco - Gross Sales Price

| Value | Valid From Day | Valid To Day |
| :---: | :------------: | :----------: |
| 1     | 2013-01-01     | 2013-04-01   |
| 1.5   | 2013-03-01     | 2013-12-31   |
| 2     | 2013-04-01     | 2015-01-01   |


Tesco - Distribution Cost

| Value | Valid From Day | Valid To Day |
| :---: | :------------: | :----------: |
| 5 | 2013-01-01 | 2013-04-01 |
| 6 | 2013-03-01 | 2014-04-01 |
| 7 | 2013-12-31 | 2015-01-01 |


Asda - Gross Sales Price

| Value | Valid From Day | Valid To Day |
| :---: | :------------: | :----------: |
| 100 | 00000000 | 99999999 |
| 200 | 2013-12-31 | 2015-01-01 |


Asda - Distribution Cost

| Value | Valid From Day | Valid To Day |
| :---: | :------------: | :----------: |
| 2 | 2013-03-01 | 2013-12-31|
| 3 | 2014-04-01 | 2015-01-01|


## Approach

I started by creating a database 'exceedra_test' and then creating a table 'products'. The columns where then created with their titles and data types. For the product, customer and measure columns I decided on the maximum number of characters as I assumed the table was from a larger data set and therefore the potential for longer entries. The NOT NULL constraint was added to each column bar the valid_from_day and valid_to_day columns. This is because of what I perceived to be null entries in the ID 7 row. Initially I planned to have a NOT NULL constraint but I soon realised that the initial entries of '00000000' and '999999999' would not conform to the Date data type.

At first I wasn't sure how to identify which pairs of rows had identical products etc.. and overlapping dates. After some searching online I managed to find the 'LEAD' function which allows querying of more than one row. Then using a WHERE statement I could query consecutive rows and if the products, customers and measures were the same, see if the dates overlapped.
I put the queried data into a temporary table named '#overlapping_dates'.

For part B I initially planned to update the overlapping dates using a SELECT and UPDATE but after reading around I learned that this approach is not possible. After continued research I discovered the use of temporary tables and therefore created one when identifying the rows with overlapping dates. Then using this table which ONLY contains matching rows with overlapping dates I was able to update the dates. Initially I wasn't sure how to change the all the necessary dates using one formula but soon realised I could use the next_valid_from_day and simply subtract one day. I was able to do this using the DATEADD function.

At the moment the updated matching rows are stored in a temporary table. If I had more time I would use a MERGE statement to update products with the data from the temporary table #overlapping_dates.

This approach is applicable to any data supplied in this format.


What the final table would look like after being updated.

![table](./Images/Table2.png)
