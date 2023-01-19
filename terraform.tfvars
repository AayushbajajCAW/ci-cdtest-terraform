region_aws = "ap-south-1"
vpc_name = "DevOps Test_vpc"
vpc_cidr_block = "10.0.0.0/16"
subnet_zones =["ap-south-1a", "ap-south-1b"]
web_subnets= "10.0.10.0/24"

server_type = "t2.micro"
image_name="ami-0vfj343vsfv" //demo name
public_key = "/home/cawdevops/.ssh/test_rsa.pub"