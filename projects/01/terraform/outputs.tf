output "website_url" {
  description = "URL pública do site hospedado no S3"
  value       = aws_s3_bucket_website_configuration.site.website_endpoint
}

output "bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = aws_s3_bucket.site.id
}

output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.site.arn
}
