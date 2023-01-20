resource "aws_cloudfront_distribution" "this-cdn-portal" {
  origin {
    domain_name = aws_s3_bucket.this-s3-bucket.id
    origin_id   = aws_s3_bucket.this-s3-bucket.id
  }
  wait_for_deployment = false
  enabled             = true
  is_ipv6_enabled     = true
  # default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.this-s3-bucket.id
    compress               = true
    cache_policy_id        = data.aws_cloudfront_cache_policy.cache_policy_cloudfront.id
    viewer_protocol_policy = "allow-all"
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
  tags = {
    app-role               = "Cloudfront distribution for s3"
    app-name               = "portal-cloudfront"
    security-accessibility = "Public"
  }
  depends_on = [
    aws_s3_bucket.this-s3-bucket,
    data.aws_cloudfront_cache_policy.cache_policy_cloudfront
  ]
}



