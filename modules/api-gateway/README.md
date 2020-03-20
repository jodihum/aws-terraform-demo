### api-gateway

This module creates an API gateway to be used to access a Lambda function.

### Inputs 

| Input                  | Description              | 
| ---------------------  |--------------------------| 
| lambda_invoke_arn      | The arn of the Lambda function that will be accessed by this API Gateway                   | 
| project                | Used for tags only - The name of the project                                               | 
| owner                  | Used for tags only - The name of the owner                                                 | 

### Outputs 

| Output                    | Description              | 
| ------------------------  |--------------------------| 
| deployment_execution_arn  | The arn of the API Gateway deployment.  It will be used to give the Gateway permission to invoke the Lambda function  | 
| invoke_url                | The URL for the API Gateway. It can be used by a Cloud Front distribution                  | 
| stage_name                | The API Gateway stage name. It will also be required by a Clout Front distribution         | 
                     
