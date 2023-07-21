resource "aws_security_group" "k8s_sg" {
    name            = "k8s_sg"
    vpc_id          = aws_vpc.vpc-k8s.id

    ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 53
    to_port         = 53
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }    

    ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }    

    ingress {
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 10248
    to_port         = 10260
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    # ingress {
    # from_port       = 10259
    # to_port         = 10259
    # protocol        = "tcp"
    # cidr_blocks     = ["0.0.0.0/0"]
    # }

    # ingress {
    # from_port       = 10257
    # to_port         = 10257
    # protocol        = "tcp"
    # cidr_blocks     = ["0.0.0.0/0"]
    # }

    ingress {
    from_port       = 2379
    to_port         = 2380
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }    

    ingress {
    from_port       = 6783
    to_port         = 6783
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 9094
    to_port         = 9094
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 5473
    to_port         = 5473
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
    from_port       = 53
    to_port         = 53
    protocol        = "udp"
    cidr_blocks     = ["0.0.0.0/0"]
    }            

    ingress {
    from_port       = 6784
    to_port         = 6784
    protocol        = "udp"
    cidr_blocks     = ["0.0.0.0/0"]
    }


    ingress {
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks = [ "0.0.0.0/0" ]

    }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
      Name = "k8s_sg"
    }
}
