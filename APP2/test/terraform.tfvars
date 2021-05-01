##################################################################################
#aws_region = "eu-central-1"
sts_role_arn = "arn:aws:iam::930075689295:role/Terraform-Build-role"


# AWS Settings
aws_region     = "us-east-1"
keypair = "Shaju-app-server"
ami-id = "ami-013f17f36f8b1fefb"
#ami-id = "ami-038f1ca1bd58a5790"
root_volume = 8
app_name = "APP2"
resource_group = "Server"
os_version = "Ubuntu"
ami_backup = "DAILY"
environment = "Test"
alb1_tg_name_1 = "APP2-test-LAMP-tg"
app-alb-1 = "APP2-test-LAMP-alb"
app_alb1_name = "APP2-test-LAMP-alb"
instance_type_1 = "t2.micro"
subnet-1a-id = "subnet-c8656494"
subnet-1b-id = "subnet-970005f0"
vpc-id = "vpc-b92879c3"
