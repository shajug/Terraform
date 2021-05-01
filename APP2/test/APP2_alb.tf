################################################################################################
# APP2 TEST1 Load Balancer

################################################################################################



resource "aws_lb" "app-alb-1" {
  name               = var.app_alb1_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.app1-sg.id}"]
  subnets            = [var.subnet-1a-id,var.subnet-1b-id]
  enable_deletion_protection = false
  tags = {
    Name = "${var.app_alb1_name}"
    ApplicationName = "${var.app_name}"
    Environment = "${var.environment}"
    ResourceGroup = "Network"
   }
}

#create target group with health check
resource "aws_lb_target_group" "alb1-tgrp-1" {
  name     = var.alb1_tg_name_1
  vpc_id   = var.vpc-id
  port     = 80
  protocol = "HTTP"
  tags = {
    Name     = "${var.alb1_tg_name_1}"
    ApplicationName = "${var.app_name}"
    Environment = "${var.environment}"
    ResourceGroup = "Network"
    }
}

#target group attachment
resource "aws_lb_target_group_attachment" "alb1-tgrp-port-1" {
  target_group_arn = "${aws_lb_target_group.alb1-tgrp-1.arn}"
  target_id        = "${aws_instance.app_instance_1.id}"
  port             = 80
}

#create a listener
  resource "aws_lb_listener" "app-alb1-listener-1" {
  load_balancer_arn = "${aws_lb.app-alb-1.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
      target_group_arn = "${aws_lb_target_group.alb1-tgrp-1.arn}"
      type = "forward"
    }
}


resource "aws_security_group" "app1-sg" {
  name = "terraform-LAMP-demo-elb"

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

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/16"]
  }
}
