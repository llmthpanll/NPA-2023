##################################################################################
# RESOURCES
##################################################################################


#Random ID
resource "random_integer" "rand" {
  min = 100
  max = 99999
}

module "s3_bucket" {
  source          = "./modules"
  bucket_name     = "pan-npa2024-pj9gtdtrp"
  tags = merge(local.default_tags,{Name = "${var.default_name}-S3-Bucket"})
}

module "s3-bucket_object" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/object"
  version = "4.1.1"
  bucket = "pan-npa2024-pj9gtdtrp"
  tags = merge(local.default_tags,{Name = "${var.default_name}-S3-Bucket"})
  key = "1.jpg"
  file_source = "./images/1.png"
}

# resource "aws_s3_object" "image" {
#   count = 2
#   bucket = module.s3_bucket.id
#   key    = "${count.index + 1}.jpg"
#   source = "./images/${count.index + 1}.png" 
# }