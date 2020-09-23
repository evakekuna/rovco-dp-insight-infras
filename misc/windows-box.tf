resource "aws_security_group" "vpc-35b4e45c-NICE-DCV-for-Windows--g4-graphics-instances--2019-1-AutogenByAWSMP-" {
    name        = "NICE DCV for Windows -g4 graphics instances--2019-1-AutogenByAWSMP-"
    description = "This security group was generated by AWS Marketplace and is based on recommended settings for NICE DCV for Windows (g4 graphics instances) version 2019.1 provided by Amazon Web Services"
    vpc_id      = "vpc-35b4e45c"

    ingress {
        from_port       = 8443
        to_port         = 8443
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