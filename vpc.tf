module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.78.0"

  name = "kub-vpc"
  cidr = "10.0.0.0/24"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets = ["10.0.0.0/27", "10.0.0.32/27", "10.0.0.64/27"]
  private_subnets = ["10.0.0.96/27", "10.0.0.128/27", "10.0.0.160/27"]

  enable_vpn_gateway = false
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
