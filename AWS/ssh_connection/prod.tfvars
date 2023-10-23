ami_id = "ami-0e287be41e78a2fbd"
instance_type = "t2.micro"
tags          = { Name = "Test", Environment = "Prod" }
key_name      = "aws_key"
connection = [
  {
    type    = "ssh",
    user    = "centos",
    timeout = "4m"
  }
]
sg_name = "Security-Rules"
ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]