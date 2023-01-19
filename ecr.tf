resource "aws_ecr_repository" "this_repository" {
  for_each             = var.ecr_repo_fields
  name                 = each.value[0]
  image_tag_mutability = each.value[1]

  image_scanning_configuration {
    scan_on_push = each.value[2]
  }
}