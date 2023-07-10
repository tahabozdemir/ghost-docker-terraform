resource "aws_iam_policy" "ghost_bucket_policy" {
  name        = "ghost_web_bucket_policy"
  path        = "/"
  description = "Allows ghost_web_server access to ghost_bucket"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:PutObjectVersionAcl",
          "s3:ListBucket",
          "s3:DeleteObject",
          "s3:PutObjectAcl"
        ],
        "Resource" : [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "ghost_bucket_role" {
  name = "ghost_web_bucket_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ghost_bucket_policy_attachment" {
  policy_arn = aws_iam_policy.ghost_bucket_policy.arn
  role       = aws_iam_role.ghost_bucket_role.name
}

resource "aws_iam_instance_profile" "ghost_iam_profile" {
  name = "ghost_iam_profile"
  role = aws_iam_role.ghost_bucket_role.name
}
