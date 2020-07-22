{ pkgs , ...  }:

with pkgs;

{

  packages = [
    # Cloud Tooling
    aws-sam-cli
    awscli2
    terraform
    terraform-ls
    terraform-lsp
  ];

}
