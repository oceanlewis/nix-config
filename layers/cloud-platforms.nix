{ pkgs , ...  }:

with pkgs;

{

  packages = [
    # Cloud Tooling
    #aws-sam-cli # broken
    awscli
    terraform
    terraform-ls
    terraform-lsp
  ];

}
