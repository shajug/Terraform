
#################################################################################
#EC2                                                                            #
#################################################################################
provider "aws" {
  region = "${var.aws_region}"
  assume_role {
    role_arn     = "${var.sts_role_arn}"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}



terraform {
  backend "s3" {
    bucket = "shajug-terraform"
    key    = "APP2/terraform.tfstate"
    encrypt = true
    region     = "us-east-1"
  }
}

data "terraform_remote_state"  "Webservers" {
        backend = "s3"
        config = {
          bucket = "shajug-terraform"
          key = "Webservers/terraform.tfstate"
          region = "us-east-1"
        }

 }



resource "aws_instance" "app_instance_1" {
  ami           = "${var.ami-id}"
  instance_type = "${var.instance_type_1}"
  key_name      = "${var.keypair}"
#  disable_api_termination = "true"
  subnet_id   = var.subnet-1a-id
  vpc_security_group_ids = ["${aws_security_group.app1-sg.id}"]
#  user_data              = file("APP2_user_data.sh")
  #ROOT VOLUME SIZE
  root_block_device {
    volume_size           = "${var.root_volume}"
    delete_on_termination = "true"
   }
   tags = {
    Name = "TLAPP002"
    ApplicationName = "${var.app_name}"
    Environment = "${var.environment}"
    ResourceGroup = "${var.resource_group}"
    AMIBACKUP = "${var.ami_backup}"
    OSVersion = "${var.os_version}"
  }


 provisioner "remote-exec" {
    inline = ["echo 'Hello Waiting for SSH connection'"]
#    on_failure = "continue"
    
    connection {
        type        = "ssh"
        user        = "ubuntu"
        host        = "${self.private_ip}"
        private_key = file("/data/Shaju-app-server.pem")
    }
 }

 provisioner "local-exec" {

   command = "sleep 60;  ANSIBLE_HOST_KEY_CHECKING=False  ansible-playbook -u ubuntu -i '${self.private_ip},'  --private-key /data/Shaju-app-server.pem  playbook.yml"
 }

}

/*
data "aws_instance" "app_instance_1" {

  filter {
    name   = "tag:Name"
    values = ["TLAPP002"]
  }
}
*/
