data "aws_canonical_user_id" "current" {}
data "aws_cloudfront_cache_policy" "cache_policy_cloudfront" {
  name = var.cache_policy_name_cloudfront
}