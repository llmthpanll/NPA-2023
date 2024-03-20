variable "bucket_name" {
  description = "The name of the S3 bucket to create. Must be Unique."
  type        = string
  
}

variable "tags" {
  description = "A map of tags to add to the S3 bucket"
  type        = map(string)
  default = {}
}