# Output variable definitions
output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "id" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
}