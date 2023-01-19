resource "aws_ssm_parameter" "this_param" {
  for_each = var.param_names
  name     = each.value[0]
  type     = each.value[1]
  value    = each.value[2]
}