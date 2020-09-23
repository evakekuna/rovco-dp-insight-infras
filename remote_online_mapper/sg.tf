resource "aws_security_group" "vpc-0e42d89e7ba6d73c5-RemoteOnlineMapperALB" {
    name        = "RemoteOnlineMapperALB"
    description = "RemoteOnlineMapperALB"
    vpc_id      = "vpc-0e42d89e7ba6d73c5"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks     = ["::/0"]
    }

    ingress {
        from_port       = 8443
        to_port         = 8444
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks     = ["::/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}