variable "awsprops" {
    type = map(string)
    default = {
      region = "us-east-1"
      vpc = "vpc-0936a4d6be1abd3a5"
      ami = "ami-09d56f8956ab235b3"
      itype = "t2.micro"
      subnet = "subnet-0f15aa74031f99096"
      publicip = true
      keyname = "myseckey"
      secgroupname = "IAC-Sec-Group-3"
    }
}

resource "aws_instance" "jenkins" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  //key_name = lookup(var.awsprops, "keyname")

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
