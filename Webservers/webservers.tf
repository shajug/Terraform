
provider "aws" {
  region = "${var.aws_region}"
  assume_role {
    role_arn     = "${var.sts_role_arn}"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}


data "aws_availability_zones" "all" {}


resource "aws_autoscaling_group" "webserver-demo" {
  launch_configuration = aws_launch_configuration.webserver-demo.id
  availability_zones   = data.aws_availability_zones.all.names
 
  min_size = 1
  max_size = 2
  desired_capacity = 1
  load_balancers    = [aws_elb.webserver-demo.name]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "terraform-asg-webserver-demo"
    propagate_at_launch = true
  }
}


resource "aws_launch_configuration" "webserver-demo" {
  # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type in us-east-2
  image_id        = var.ami-id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]
  key_name = var.webserver-keypair

  user_data = <<-EOF
#!/bin/bash
yum install -y httpd*
yum install -y apache*
echo "Hi , This is a demo session" > /var/www/html/index.html
service httpd restart
              EOF



  # Whenever using a launch configuration with an auto scaling group, you must set create_before_destroy = true.
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "instance" {
  name = "terraform-webserver-demo-instance"

  # Inbound HTTP from anywhere
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}


resource "aws_elb" "webserver-demo" {
  name               = "terraform-asg-webserver-demo"
  security_groups    = [aws_security_group.elb.id]
  availability_zones = data.aws_availability_zones.all.names

  health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port           = var.elb_port
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }
}


resource "aws_security_group" "elb" {
  name = "terraform-webserver-demo-elb"

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTP from anywhere
  ingress {
    from_port   = var.elb_port
    to_port     = var.elb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
