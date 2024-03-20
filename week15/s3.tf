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
  bucket_name     = "pan-npa2024-${random_integer.rand.result}"
  tags = merge(local.default_tags,{Name = "${var.default_name}-S3-Bucket"})
}

resource "aws_s3_object" "image" {
  count = 2
  bucket = module.s3_bucket.id
  key    = "${count.index + 1}.jpg"
  source = "./images/${count.index + 1}.png" 
}