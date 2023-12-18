#This function is intended for writing data into MySQL.
#The reason for using this function over the ODBC driver, it is because it's more reliable when writing data into MySQL tables (from my experience at least).
#For reading, it is recommended to utilize the ODBC driver.


#Libraries needed
#library(DBI)

#Loading MariaDB is not required, but it must be installed in R along with the MySQL or MariaDB client. 
#Additionally, setting the path for the MariaDB connector is necessary.
#library(RMariaDB)


#Parameters to be defined are username, password, host, they should be predefined using the config file. 
#Collation can be modified.
#Never type the credentials into the code directly, use a config file!
#Only parameter that needs to be set is the dbname.

mysql_con_maria <- function(username = username, password = password, 
                            host = port, dbname, collation = "utf8mb4_general_ci") {
  
  myconn <- dbConnect(RMariaDB::MariaDB(),
                      username = username, password = password,
                      host = host, dbname = dbname)
  
  invisible(dbExecute(conn = myconn,
                      statement = paste0('SET collation_connection= "',collation,'"')))
  
  
  return(myconn)
  
}


#Function can be used, if default settings are applied just as:
#myconn <- mysql_con_maria(dbname = "database")
#Disconecting the connection with DBI
#dbDisconect(myconn)