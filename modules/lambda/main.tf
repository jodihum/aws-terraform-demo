resource "aws_lambda_function" "hello_world" {
   function_name = "hello_world_function"
   filename =  "${path.module}/helloworld.js.zip"  

   handler = "helloworld.handler"
   runtime = "nodejs12.x"

   role = aws_iam_role.lambda_role.arn
}


