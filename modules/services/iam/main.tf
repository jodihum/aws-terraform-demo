#TODO - give lambda access to RDS
#IAM role which dictates what other AWS services the Lambda function may access
resource "aws_iam_role" "lambda_role" {
   name = "LambdaRDSRole"

   assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {
         "Service": "lambda.amazonaws.com"
       },
       "Effect": "Allow",
       "Sid": ""
     }
   ]
}
 EOF

}