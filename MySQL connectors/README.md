# MySQL connectors

The aim behind creating these functions was to streamline the process of connecting to MySQL, simplifying the code wherever feasible.<br>

## mysql_con
This function relies on the RODBC library and utilizes the configured ODBC driver on the user's machine. Its primary purpose is to automate collation settings and streamline the application of code within extensive scripts.

## mysql_con_maria
This function relies on the DBI library and incorporates credentials defined within the function itself. Its primary function is to automate collation settings within the proces.<br>

## Summary
Both functions serve distinct purposes: mysql_con() is recommended for data retrieval, whereas mysql_con_maria() is advised for writing data into a MySQL table.<br> 
This division stems from my personal experience with these libraries. ODBC tends to be faster but less reliable when writing into a table, whereas the MariaDB driver is slower but significantly more stable and reliable for writing data into tables.