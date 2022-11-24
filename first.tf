provider "aws" {

     region = "ap-south-1"

     profile = "default"

}
# For Launching Master Node

resource "aws_instance" "MyInstance1" {

      ami = "ami-074dc0a6f6c764218"

      instance_type = "t2.micro"      

      key_name = "verma108" 
      availability_zone="ap-south-1a"
      security_groups=["launch-wizard-3"]
      
      
      

      tags = {

           Name = "master"
      }

}
 #For Launching Slave Node1
resource "aws_instance" "MyInstance2" {

      ami = "ami-074dc0a6f6c764218"

      instance_type = "t2.micro"

      key_name = "verma108" 
      availability_zone="ap-south-1a"
      security_groups=["launch-wizard-3"]
      

      tags = {

           Name = "slave1"
	   worker="slave"
      }

}
 #For Launching Slave Node2
resource "aws_instance" "MyInstance3" {

      ami = "ami-074dc0a6f6c764218"

      instance_type = "t2.micro"
      availability_zone="ap-south-1a"
      security_groups=["launch-wizard-3"]

      key_name = "verma108"  
	
      

      tags = {

           Name = "slave2"
           worker= "slave"
      }

}
