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
      provider_arn               = "arn:aws:iam::398767507008:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/C29BE249C20A2A62BBF694EF6D04D4E7"
      namespace_service_accounts = ["external-secrets:external-secrets"]
    }
  }
}