# Athena and S3

This repository contains tools for working with Amazon Athena and S3.<br>

## Noctua connector
This script simplifies connecting to Athena in R to just one line. It's designed for easy connection without the need for much thought, as it loads the necessary libraries and the connector.<br>

## S3_writting
This file contains a method to write data into an S3 bucket. It addresses an issue I faced while writing numerous small files to an S3 bucket. Occasionally, a random timeout interrupted the connection during script execution, leading to crashes or, worse, skipping to the upload entirely. This method aims to handle such timeouts by attempting to upload the file again. It includes a small delay that increases gradually by a second with each attempt. If it tries ten times without success, the script stops that specific case and proceeds to the next file.<br>