output "clb_dns_name" {
  value       = aws_elb.webserver-demo.dns_name
  description = "The domain name of the load balancer"
}
