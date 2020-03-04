# freeup

This is the Coding Challenge given to me by Free Up

### The challenge
Create a private GitHub repository containing the code and any documentation as you see fit (at least a README.md).

Part 1 - Terraform & AWS
Create a highly-available Serverless architecture on AWS using Terraform. The architecture consists of:
- Cloudfront
- API Gateway
- Lambda
- RDS (MySQL)

Part 2 - Coding
Create a Lambda function in JavaScript and host it on the above infrastructure. The function should return a simple message in JSON and a 200 HTTP status code.

### Solution

![Jodi AWS network diagram](https://user-images.githubusercontent.com/1429757/75894499-304ac580-5e2c-11ea-9128-5b0a691ddf7f.jpeg)


### Steps to use
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
9. Drawing of architecture for the readme
10. Documentation for using the lambda (which also needs fixing)
11. Readme for each module

