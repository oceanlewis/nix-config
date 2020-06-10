{ pkgs, config, ... }:

import ./machines/thinkpad.nix {
  config = config;
  pkgs = pkgs;
}
