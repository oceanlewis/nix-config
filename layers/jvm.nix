{ pkgs , ...  }:

{

  packages = with pkgs; [
    ktlint
    maven
    #openjdk8
    #kotlin
  ];

  git.ignores = [
    "**/.idea"
    "/.classpath"
    "/.project"
    "/.settings"
  ];

}
