{ pkgs , ...  }:

with pkgs;

{

  packages = [
    # Cloud Tooling
    aws-sam-cli
    awscli
    terraform
    terraform-ls
    terraform-lsp
  ];

}
