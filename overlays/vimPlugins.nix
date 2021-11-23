self: super:

let
  inherit (super) vimUtils fetchFromGitHub;

  customPackages = {
    vim-monochrome = vimUtils.buildVimPlugin {
      name = "vim-monochrome";
      src = fetchFromGitHub {
        owner = "fxn";
        repo = "vim-monochrome";
        rev = "77017c54b0b611f0ba8f8825f125b716e65c84b9";
        sha256 = "1dzfjb4i9svc1id4d63sz4saw1hzrkf9n2zk4kmbpx2rh5r6wj9d";
      };
    };

    hara = vimUtils.buildVimPlugin {
      name = "hara";
      src = fetchFromGitHub {
        owner = "scolsen";
        repo = "hara";
        rev = "99600c585e25f71a6ba92a5862835e0be1c3303e";
        sha256 = "0i14cj7gcxmr1hlbdv1xf8642x8x5x717ybpdbxda3yjjs7l0zfx";
      };
    };
  };

in
{
  vimPlugins = super.vimPlugins // customPackages;
}
