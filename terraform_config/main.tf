variable "awsprops" {
    type = map(string)
    default = {
      region = "us-east-1"
      vpc = "vpc-057af0781b005d441"
      ami = "ami-09d56f8956ab235b3"
      itype = "t2.micro"
      subnet = "subnet-04991c5f40412f759"
      publicip = true
      keyname = "aws_key"
      secgroupname = "IAC-Sec-Group-4"
    }
}

resource "aws_instance" "jenkins" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
  vpc_security_group_ids = [aws_security_group.main.id]

  root_block_device {
    delete_on_termination = true
    //iops = 150
    volume_size = 50
    volume_type = "gp2"
  }

  tags = {
    Name ="JENKINS"
    Environment = "BUILD"
    OS = "UBUNTU"
    Managed = "IAC"
  }

}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks = ["0.0.0.0/0", ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    }
  ]
  ingress = [
    {
      cidr_blocks = ["0.0.0.0/0", ]
      description = ""
      from_port = 22
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self = false
      to_port = 22
    },
    {
      cidr_blocks = ["0.0.0.0/0", ]
      description = ""
      from_port = 8080 
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self = false
      to_port = 8080 
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuXESjClwL2gAvsFK2dEeAAz6RvIw3BY1dYLniceG16ZnZrXnXXRxdPOyEXdNnqHuhfr5vq6ZDVYjmOATaOUsYlKjLaRNldON0G90BA7V98DP4ZhQTHOK9m+4oQnMxj18z/1q+pfEEYou2mi/HurFzFnLLGSWAH8eMm4qi+TAEyH558zlI2hDkUpqQi+hnZA2vlg0FE9vKt/f76olKUa+srcmQyaoUMHrJ+LW4cemzGCZ+Y0P7Ac+OL3AL2IL9/PDz3UcdgWObw9Ljodb+BPhWTHEtyb61iCwrMUhb3waqdDNMEYVhLdtbq3J7iV+bHzzsCArSOKi8LSqMghilBlYD nikhilshankarku@ip-172-31-23-250"
} 
