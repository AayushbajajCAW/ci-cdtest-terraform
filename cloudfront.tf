resource "aws_cloudfront_cache_policy" "example" {
  name        = var.cache_policy_name
  default_ttl = 50
  max_ttl     = 100
  min_ttl     = 1
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
      cookies {
        items = []
      }
    }
    headers_config {
      header_behavior = "none"
      headers {
        items = []
      }
    }
    query_strings_config {
      query_string_behavior = "none"
      query_strings {
        items = []
      }
    }
  }
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = data.aws_s3_bucket.bucket_one.bucket_domain_name
    origin_id                = data.aws_s3_bucket.bucket_one.bucket_domain_name
  }
    wait_for_deployment = false
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.aws_s3_bucket.bucket_one.bucket_domain_name
    compress = true
    cache_policy_id = data.aws_cloudfront_cache_policy.cache_policy_cloudfront.id
    viewer_protocol_policy = "allow-all"
  }
  # Cache behavior with precedence 0
  ordered_cache_behavior  {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.aws_s3_bucket.bucket_one.bucket_domain_name
    cache_policy_id = aws_cloudfront_cache_policy.example.id
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }
  price_class = "PriceClass_All"
    viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  depends_on = [
    aws_s3_bucket.this,
    aws_cloudfront_cache_policy.example,
    data.aws_cloudfront_cache_policy.cache_policy_cloudfront
  ]
}



