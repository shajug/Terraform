
output "alb_dns_name" {
  value       = aws_lb.app-alb-1.dns_name
  description = "The domain name of the load balancer"
}

/*
output "clb_dns_name" {
  value       = data.terraform_remote_state.Webservers.outputs.clb_dns_name
  description = "The domain name of the load balancer"
}
*/
/*
output "instance_status"  {
 value = data.aws_instance.app_instance_1.instance_state

}
*/
