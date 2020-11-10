{ pkgs , ...  }:

with pkgs;

{

  packages = [
    # Cloud Tooling
    # aws-sam-cli
    awscli
    awslogs
    terraform
    terraform-ls
  ];

}
