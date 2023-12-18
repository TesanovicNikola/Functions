#This function is designed to streamline the login process while also automatically configuring the collation of the connection.


#Needs RODBC library to be loaded
#library(RODBC)


#Parameters to be defined are dsn, uid  and pwd. Encoding and collation can be modified.
#They should be predefined using odbc driver login data. 
#Make sure to take it from a config file not to type it directly into the code!


mysql_con <- function(dsn = dsn, uid = uid, pwd = pwd, encoding = "utf-8",
                      collation = "utf8mb4_general_ci") {
  
  myconn <-
    odbcConnect(
      dsn = dsn,
      uid = uid,
      pwd = pwd,
      DBMSencoding = encoding
    )
  
  invisible(sqlQuery(channel = myconn,
                     query = paste0('SET collation_connection= "',collation,'"')))
  
  
  return(myconn)
  
}


#Function can be used, if default settings are applied just as:
#myconn <- mysql_con()

#After use make sure to use:
#close(myconn)