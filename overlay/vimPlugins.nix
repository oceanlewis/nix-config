self: super:

let
  inherit (super) vimUtils fetchFromGitHub;

  customPackages = {
    vim-monochrome = vimUtils.buildVimPlugin rec {
      name = "vim-monochrome";
      pname = name;
      src = fetchFromGitHub {
        owner = "fxn";
        repo = "vim-monochrome";
        rev = "77017c54b0b611f0ba8f8825f125b716e65c84b9";
        sha256 = "1dzfjb4i9svc1id4d63sz4saw1hzrkf9n2zk4kmbpx2rh5r6wj9d";
      };
    };

    hara = vimUtils.buildVimPlugin rec {
      name = "hara";
      pname = name;
      src = fetchFromGitHub {
        owner = "scolsen";
        repo = "hara";
        rev = "99600c585e25f71a6ba92a5862835e0be1c3303e";
        sha256 = "0i14cj7gcxmr1hlbdv1xf8642x8x5x717ybpdbxda3yjjs7l0zfx";
      };
    };

    coc-elixir = vimUtils.buildVimPlugin rec {
      name = "coc-elixir";
      pname = name;
      src = fetchFromGitHub {
        owner = "elixir-lsp";
        repo = "coc-elixir";
        rev = "9a0ad5da83d1e5996b9ce44790d00d574baca788";
        sha256 = "uPQF9r1BM3yL4cPGE7kqAirN3jyY98YSWfZW9sPGvys=";
      };
    };
  };

in
{
  vimPlugins = super.vimPlugins // customPackages;
}
