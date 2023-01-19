variable "region_aws"{
    type = string
}
variable "vpc_name" {
  type = string
}
variable "vpc_cidr_block"{
    type="string"
}
variable "subnet_zones" {
  type=list(string)
}
variable "web_subnets" {
  type=list(string)
}
variable "server_type" {
  
}
variable "image_name" {
  
}
variable "public_key" {
  
}