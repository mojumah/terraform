provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-east-1"
}

resource "aws_key_pair" "name" {
  key_name   = "name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGFdPaRslZb+SiFj0fqaBDNCdceLoXiIVUJYiTax+TZSHx3sYZ+cgCaYyNkLygFhrxVmkYV49UbD5AuH8V78Utdtq+VdI9dYk+GOlrrs2vTSYDcRXsA2pb9mIOgVlSUemv1wqeAGCHvAbPT1q7foni7dZ9/vDUXmXn8B0Q8qru/RPIA0ybI1tDneLvuSjyfTgFwHMjun6jNKa3iNjmkZl8m9imHyUy0Y2XJyYQkQr+j+ML8sJjgs2zcxhXglkLO06fMCsycdZmW68UJ7VKUByxq3jDYSvsaqhEgp7FRVeDQUWCJRLb4C89Rc5xkzm1i4NIgluQWClOngt0COWEw0H5 root@yasmin"


}


resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  subnet_id = "012fbb93379b42e1d"
  key_name = "${aws_key_pair.ssh_name.key_name}"
  tags {
      Name = "test_target"
  }
#  provisioner "file" {
#    source      = "script.sh"
#    destination = "/tmp/script.sh"
#}
  provisioner "remote-exec" {
  connection {
   type = "ssh"
   user = "ubuntu"
   private_key = "${file("name_key")}"
   agent = false
}
    inline = [
      "sudo apt-get upgrade -y",
      "sudo apt-get update -y"
    ]
  }
}
resource "aws_instance" "example_two" {
  ami           = "ami-2757f631"
  instance_type = "t2.small"
  key_name = "${aws_key_pair.ssh_private.key_name}"
  tags {
      Name = "test_controller"
  }
}
