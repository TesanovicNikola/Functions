#When this function is sourced, it establishes a Athena connection to R that remains active for the duration of the session or until it's disconnected.
#This means you only need to run the function once to set up the connection.

#Libraries that are needed for this are noctua and DBI, to install them do:
#install.packages(DBI)
#install.packages(noctua)
#In some cases it can happen that noctua installation bugs out, use:
#install.packages(paws) and then run install.packages(noctua).

library(noctua)
library(DBI)

#There are 3 types/ways of defining credentials for this function:

#The first way is to use System variables, this is not recommended!

#Sys.setenv("AWS_ACCESS_KEY_ID" = access_key,  
#           "AWS_SECRET_ACCESS_KEY" = secret_access_key,
#           "AWS_DEFAULT_REGION" = default_region)

#The second way is to define them in the function itself using data loaded from a config file.
#Never hard code credentials into your code! Use a config file!

con <- DBI::dbConnect(noctua::athena(),
                      aws_access_key_id = access_key, 
                      aws_secret_access_key = secret_access_key,
                      region_name = default_region, 
                      s3_staging_dir= staging_dir)


#If you want to disconnect the connection then use:
#dbDisconnect(con)
