# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

#AWS_ACCESS_KEY_ID
#AWS_SECRET_ACCESS_KEY

#variable "aws_access_key" {}
#variable "aws_secret_key" {}
#variable "aws_region" {}
variable "aws_region" {}
variable "sts_role_arn" {}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "elb_port" {
  description = "The port the ELB will use for HTTP requests"
  type        = number
  default     = 80
}

variable "keypair" {}
variable "ami-id" {}
variable "root_volume" {}
variable "app_name" {}
variable "resource_group" {}
variable "os_version" {}
variable "ami_backup" {}
variable "environment" {}
variable "alb1_tg_name_1" {}
variable "app-alb-1" {}
variable "app_alb1_name" {}
variable "instance_type_1" {}
variable "subnet-1a-id" {}
variable "subnet-1b-id" {}
variable "vpc-id" {}
