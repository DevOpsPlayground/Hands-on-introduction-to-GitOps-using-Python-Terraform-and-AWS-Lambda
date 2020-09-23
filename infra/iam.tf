
resource "aws_iam_role" "lambda_list_role" {
  name = "${local.prefix}-lambda-list-role"

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

data "aws_iam_policy_document" "lambda_list_policy" {
  statement {
    actions = [
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive",
      "kms:DescribeCustomKeyStores"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "dynamodb:BatchGet*",
      "dynamodb:DescribeStream",
      "dynamodb:DescribeTable",
      "dynamodb:Get*",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWrite*",
      "dynamodb:CreateTable",
      "dynamodb:Delete*",
      "dynamodb:Update*",
      "dynamodb:PutItem"
    ]
    resources = ["${aws_dynamodb_table.todolist_table.arn}"]
  }

  statement {
    actions = [
      "kms:GetPublicKey",
      "kms:GetKeyPolicy",
      "kms:ListResourceTags",
      "kms:GetParametersForImport",
      "kms:GetKeyRotationStatus",
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
    resources = ["${aws_kms_key.dynamodb_key.arn}"]
  }
}

resource "aws_iam_policy" "lambda_list_policy" {
  name   = "${local.prefix}-lambda-list-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_list_policy.json
}


resource "aws_iam_role_policy_attachment" "lambda_list_role_attachment" {
  role       = aws_iam_role.lambda_list_role.name
  policy_arn = aws_iam_policy.lambda_list_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_list_role_attachment_logging" {
  role       = aws_iam_role.lambda_list_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

