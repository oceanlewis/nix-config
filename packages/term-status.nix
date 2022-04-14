{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "term-status";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "davidarmstronglewis";
    repo = pname;
    rev = "a72f98771402261814c4d68f3f60bece7caf0842";
    sha256 = lib.fakeSha256; #"0ljqbs3k7wl1jh71ia3svhg7v9byz7mqz43ap2l22cawzx8ma2lf";
  };

  cargoSha256 = lib.fakeSha256;# "19cf49c59bm8dd6w28dknv3d2k3kmy9jckqdx7fv1xrlb8c2insk";

  meta = with lib; {
    description = "Replace my silly shell prompt with a silly rust program that does the same thing!";
    homepage = "https://github.com/davidarmstronglewis/term-status";
    license = licenses.mit;
  };
}
