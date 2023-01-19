resource "aws_s3_bucket" "this" {
  for_each      = var.s3_bucket_names
  bucket        = each.key
  force_destroy = true
  # website {
  # index_document = "index.html"
  # error_document = "index.html"
  # }
}
resource "aws_s3_bucket_website_configuration" "example" {
  for_each = var.s3_bucket_names
  bucket   = each.key

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
  depends_on = [
    aws_s3_bucket.this
  ]
}
resource "aws_s3_bucket_policy" "this-policy" {
  for_each = var.s3_bucket_names
  bucket   = each.key
  policy   = <<POLICY
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${each.value}/*"
        }
    ]
}
POLICY
  depends_on = [
    aws_s3_bucket.this
  ]
}

resource "aws_s3_bucket_acl" "acl_policy" {
  for_each = var.s3_bucket_names
  bucket   = each.key
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "READ"
    }
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "READ_ACP"
    }
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "WRITE"
    }
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "WRITE_ACP"
    }
    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ_ACP"
    }
    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ"
    }
    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
  depends_on = [
    aws_s3_bucket.this
  ]
}