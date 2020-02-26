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

### Assumptions
1. I am assuming that you do not think it is sufficient to use an edge optimized API Gateway, and you want me to create my own Cloud Front distribution as per this article: https://aws.amazon.com/premiumsupport/knowledge-center/api-gateway-cloudfront-distribution/

2. I am assuming for HA it is sufficient to use Multi-AZ RDS, and that I don't need to have another copy in a different region.

3. I am assuming it is OK to use Lambda Proxy Integration.  It seems sufficient for my purposes, and easier.

