resource "aws_iam_role" "eks-cluster" {
  name = "eks-cluster"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "Amazon-EKS-Cluster-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "Amazon-EBS-Cluster-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_eks_cluster" "eks" {
  name     = "eks"
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    
    subnet_ids = [
        aws_subnet.private-us-east-1a.id,
        aws_subnet.private-us-east-1b.id,
        aws_subnet.public-us-east-1a.id,
        aws_subnet.public-us-east-1b.id
    ]
  }
}

/* resource "aws_iam_openid_connect_provider" "op_connect" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = "https://oidc.eks.us-east-1.amazonaws.com/id/3ED2FB9D10B3D51561FF67A836AF772D"

  depends_on = [ aws_eks_cluster.eks ]

} */



