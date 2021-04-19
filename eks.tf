locals {
  cluster_name = "test"
}

data "aws_eks_cluster" "cluster" {
  name = module.test-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.test-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "test-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "15.1.0"
  cluster_name    = local.cluster_name
  cluster_version = 1.19
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name          = "worker-group-1"
      instance_type = "t3.small"
      asg_max_size  = 3
      asg_min_size  = 1
      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "propagate_at_launch" = "false"
          "value"               = "true"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/${local.cluster_name}"
          "propagate_at_launch" = "false"
          "value"               = "true"
        }
      ]
    }
  ]
}
