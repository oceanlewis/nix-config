{ pkgs , ...  }: {

  packages = with pkgs; [
    # aws-sam-cli
    # awscli2
    # awslogs

    terraform
    terraform-ls
  ];

}
