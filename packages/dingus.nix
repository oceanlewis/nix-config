{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "dingus";
  version = "0.35.0";

  src = fetchFromGitHub {
    owner = "oceanlewis";
    repo = pname;
    rev = "c94e6b13df93d2d98125d951a090f125b88574cd";
    sha256 = "0ljqbs3k7wl1jh71ia3svhg7v9byz7mqz43ap2l22cawzx8ma2lf";
  };

  cargoSha256 = "19cf49c59bm8dd6w28dknv3d2k3kmy9jckqdx7fv1xrlb8c2insk";

  meta = with lib; {
    description = "Manage your environment variables - Rustaceously!";
    homepage = "https://github.com/oceanlewis/dingus";
    license = licenses.mit;
  };
}
