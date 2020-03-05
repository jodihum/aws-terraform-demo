# freeup

### What this code does

Terraform & AWS
1. Create a highly-available Serverless architecture on AWS using Terraform. The architecture consists of:
- Cloudfront
- API Gateway
- Lambda
- RDS (MySQL)

2. Create a Lambda function in JavaScript and host it on the above infrastructure. The function returns a simple message in JSON and a 200 HTTP status code.

### Architecture

![Jodi AWS network diagram](https://user-images.githubusercontent.com/1429757/75953389-24511900-5ea9-11ea-925d-a0e890af273a.jpeg)

### Steps to use this
1. Make sure you have access to AWS via your Access Key ID and Secret Access Key.
2. Go to the staging folder and do `terraform init` and then `terraform apply`.

### Things that are missing that should be added, or bad that should be fixed
1. Encryption on RDS
2. A more clever way of handling the admin password for RDS
3. Allowing more that 2 AZs
4. Setting up the database schema without using the Lambda
5. Tests
6. More tags
7. Better descriptions of variables
8. More consistant naming
9. Documentation for using the lambda
10. Readme for each module

