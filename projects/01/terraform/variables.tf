variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome único global do bucket S3 (deve ser único em toda a AWS)"
  type        = string
}
