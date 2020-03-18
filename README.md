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

Once the database is created, the database schema is set up using a second lambda function:

![database schema lambda](https://user-images.githubusercontent.com/1429757/76953207-3e0d4a00-6906-11ea-931c-c9a20b131f80.jpeg)

### Steps to use this
1. Make sure you have access to AWS via your Access Key ID and Secret Access Key.
2. Go to the staging folder and do `terraform init` and then `terraform apply`.

### Things that are missing that should be added
1. Encryption on RDS
2. A more clever way of handling the admin password for RDS
3. Allowing more than 2 AZs
4. Tests
5. Better descriptions of variables
6. More consistent naming
7. Documentation for using the lambda
8. Readme for each module


