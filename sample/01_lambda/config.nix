{
  terraform = {
    required_version = ">= 1.0";
    required_providers.aws = {
      source = "hashicorp/aws";
      version = "~> 5.0";
    };
  };

  provider.aws.region = "ap-northeast-1";

  variable = {
    aws_region = {
      description = "AWS region";
      type = "string";
      default = "ap-northeast-1";
    };
    function_name = {
      description = "Lambda function name";
      type = "string";
      default = "terraform-manager-sample-function";
    };
  };

  data.archive_file.lambda_zip = {
    type = "zip";
    output_path = "\${path.module}/lambda_function.zip";
    source = [{
      content = ''
        def lambda_handler(event, context):
            return {
                'statusCode': 200,
                'body': 'Hello from terraform-manager!'
            }
      '';
      filename = "lambda_function.py";
    }];
  };

  resource.aws_iam_role.lambda_role = {
    name = "\${var.function_name}-role";
    assume_role_policy = builtins.toJSON {
      Version = "2012-10-17";
      Statement = [{
        Action = "sts:AssumeRole";
        Effect = "Allow";
        Principal = {
          Service = "lambda.amazonaws.com";
        };
      }];
    };
  };

  resource.aws_iam_role_policy_attachment.lambda_basic = {
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole";
    role = "\${aws_iam_role.lambda_role.name}";
  };

  resource.aws_lambda_function.sample_function = {
    filename = "\${data.archive_file.lambda_zip.output_path}";
    function_name = "\${var.function_name}";
    role = "\${aws_iam_role.lambda_role.arn}";
    handler = "lambda_function.lambda_handler";
    source_code_hash = "\${data.archive_file.lambda_zip.output_base64sha256}";
    runtime = "python3.12";
    timeout = 10;
    memory_size = 128;
  };

  output = {
    function_name = {
      description = "Lambda function name";
      value = "\${aws_lambda_function.sample_function.function_name}";
    };
    function_arn = {
      description = "Lambda function ARN";
      value = "\${aws_lambda_function.sample_function.arn}";
    };
  };
}
