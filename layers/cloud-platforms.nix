{ pkgs , ...  }: {

  packages = with pkgs; [
    # Cloud Tooling
    aws-sam-cli
    awscli2
    awslogs
    terraform
    terraform-ls
  ];

}
