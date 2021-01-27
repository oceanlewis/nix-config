{ pkgs , ...  }:

with pkgs;

{

  packages = [
    # Cloud Tooling
    aws-sam-cli
    awscli2
    awslogs
    terraform
    terraform-ls
  ];

}
