# ipython fails to build
# - https://github.com/NixOS/nixpkgs/issues/160133
self: super: {
  python3 = super.python3.override {
    packageOverrides = pySelf: pySuper: {
      ipython = pySuper.ipython.overridePythonAttrs (old: {
        disabledTests = [ "test_clipboard_get" ];
      });
    };
    self = self.python3;
  };
}
