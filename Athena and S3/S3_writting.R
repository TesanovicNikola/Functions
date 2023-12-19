#This is not a function, but rather a method to write data into and s3 bucket. 
#The reason for creating this method is because it happens in some cases when uploading a large number of small files in an S3 bucket.
#Sometimes the connection randomly times out, it is not a bug based on a corrupted file being uploaded, but rather the connection crashing in the moment.
#This method catches that crash/timeout, and tries again for the same case. 
#If it crashes 10 times then it presumes that the file is the problem rather then the connection.


#This method uses functions from the library aws.s3:
#install.packages(aws.s3)
#library(aws.s3)

#Upload method
tryCatch({
  
  #Never hard code credentials into your code, use a config file for them!
  
  k <- put_object(object = object_name,
                  file = file_name,
                  bucket = bucket_name,
                  multipart = TRUE,
                  key = access_key,
                  secret = secret_access_key,
                  region= default_region)
  
}, error = function(e) {
  
  #If there is an error, define k as false and go into a while loop to try to get the request. 
  #The sleep will increase with the break_point function, and after 10 the script will stop trying. 
  
  k <- FALSE
  break_point <- 0
  
  while (k != TRUE) {
    
    Sys.sleep(1 + break_point)
    
    k <- put_object(object = object_name,
                    file = file_name,
                    bucket = bucket_name,
                    multipart = TRUE,
                    key = access_key,
                    secret = secret_access_key,
                    region= default_region)
    
    if (k != TRUE) {
      
      k <- FALSE
      break_point <- break_point + 1
      
    }
    
    if (break_point > 10) {
      
      k <- TRUE
      
    }
    
    
  }
  
  rm(break_point)
  
})

