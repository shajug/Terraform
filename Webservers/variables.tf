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

variable "webserver-keypair" {}
variable "ami-id" {}
