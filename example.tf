provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-east-1"
}

resource "aws_key_pair" "mo-key" {
  key_name   = "mo-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD1FGtYkhmvCAkcGoCagZTmblBbgOGCTMDHuCd/rd9MwvCChiaCPnD5lMKxYx8gAJgjwocQeRQTHSm+ohNptZAtoUUjFb8FVczqVKe7tS6XGyLbjrgafKHA14ApyVDfOHl5TOMQQP4EzrgNsLX6ZxlGKJAfl7pwD+DF6p4VIfoXX9kC1OwSby9jP0mYxsSEOfuFHJIxhHqVZDiFXJHVGLBXtJkwSTjGemVJygsnJfZ0xnOF0AOfVekiOeJ01BBsFxiMWndIVMMjE3ZpXfjOqxivLASoy5GnfAwGpZK0MUfh1ZgBxdjxiBYU9xl3EaSnMMYKaq9pKbvt+/hKYiqTHF0x root@ubuntu"

}


resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mo-key.key_name}"
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
   private_key = "${file("mo-key")}"
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
  key_name = "${aws_key_pair.mo-key.key_name}"
  tags {
      Name = "test_controller"
  }
}
