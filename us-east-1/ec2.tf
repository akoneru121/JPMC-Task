

resource "aws_instance" "primary_instance" {
  provider          = aws.primary
  ami               = var.ami_id
  key_name          = "task"
  instance_type     = var.instance_type
  security_groups   = [aws_security_group.tomcat_sg.name]

}
