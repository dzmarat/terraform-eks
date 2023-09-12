module "external_secrets_clustersecretstore_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  allow_self_assume_role                = true
  attach_external_secrets_policy        = true
  create_role                           = true
  external_secrets_secrets_manager_arns = ["arn:aws:secretsmanager:*:*:secret:test-secrets/*"]
  role_name_prefix                      = "external-secrets-platform-IRSA"

  oidc_providers = {
    ex = {
      provider_arn               = "arn:aws:iam::398767507008:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/C3A363EA8D7C4E1DC8A3E05658A02F42"
      namespace_service_accounts = ["external-secrets:external-secrets"]
    }
  }
}

module "ebs_csi_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = "ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = "arn:aws:iam::398767507008:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/C3A363EA8D7C4E1DC8A3E05658A02F42"
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

}
