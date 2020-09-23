resource "aws_security_group" "vpc-0a51ecbad8773c03d-ssh-tunnel-k8s-prod" {
    name        = "ssh-tunnel-k8s-prod"
    description = "ssh-tunnel security group for k8s ddp-fsaas application"
    vpc_id      = "vpc-0a51ecbad8773c03d"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["185.220.12.36/32", "82.44.80.176/32", "82.37.116.138/32"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "vpc-0e42d89e7ba6d73c5-Postgres-from-office" {
    name        = "Postgres from office"
    description = "Postgres Access from office"
    vpc_id      = "vpc-0e42d89e7ba6d73c5"

    ingress {
        from_port       = 5432
        to_port         = 5432
        protocol        = "tcp"
        cidr_blocks     = ["185.220.12.36/32"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}